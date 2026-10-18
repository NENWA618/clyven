import 'dart:io';
import 'dart:async';

import 'package:serverpod_cloud_storage_r2/serverpod_cloud_storage_r2.dart'
    as r2;

import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/services/admin_membership_service.dart';
import 'src/services/video_deletion_service.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/root.dart';
import 'package:serverpod_cloud_storage_gcp/serverpod_cloud_storage_gcp.dart'
    as gcp;

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  // 现在是不是数据库维护 / migration 模式
  final isMaintenance = args.any(
    (arg) => arg == 'maintenance' || arg == '--role=maintenance',
  );

  // R2 is enabled only when all public storage settings are supplied.
  // Keep GCS as a temporary fallback until existing uploads have been copied.
  // Never silently select a partially configured R2 bucket.
  if (!isMaintenance) {
    final accountId = Platform.environment['CLOUDFLARE_ACCOUNT_ID']?.trim();
    final bucket = Platform.environment['CLOUDFLARE_R2_BUCKET']?.trim();
    final publicHost = Platform.environment['CLOUDFLARE_R2_PUBLIC_HOST']
        ?.trim();
    final usingR2 =
        accountId != null &&
        accountId.isNotEmpty &&
        bucket != null &&
        bucket.isNotEmpty &&
        publicHost != null &&
        publicHost.isNotEmpty;

    if (!usingR2 &&
        Platform.environment['GLYPHORA_REQUIRE_CLOUDFLARE'] == 'true') {
      throw StateError(
        'Cloudflare deployment requires all R2 settings. '
        'Refusing to fall back to Google Cloud Storage.',
      );
    }

    if (usingR2) {
      pod.addCloudStorage(
        r2.R2CloudStorage(
          serverpod: pod,
          storageId: 'public',
          public: true,
          accountId: accountId,
          bucket: bucket,
          publicHost: publicHost,
        ),
      );
      print('[Glyphora Storage] Public uploads use Cloudflare R2.');
    } else {
      pod.addCloudStorage(
        gcp.GoogleCloudStorage(
          serverpod: pod,
          storageId: 'public',
          public: true,
          region: 'auto',
          bucket: 'glyphora-video-storage-11129163384',
        ),
      );
      print('[Glyphora Storage] Legacy GCS active; R2 not fully configured.');
    }
  }

  // 正常启动服务器时才需要登录认证系统
  if (!isMaintenance) {
    pod.initializeAuthServices(
      tokenManagerBuilders: [
        JwtConfigFromPasswords(),
      ],
      identityProviderBuilders: [
        EmailIdpConfigFromPasswords(
          sendRegistrationVerificationCode: _sendRegistrationCode,
          sendPasswordResetVerificationCode: _sendPasswordResetCode,
        ),
      ],
    );
  }

  pod.webServer.addRoute(
    RootRoute(),
    '/',
  );

  pod.webServer.addRoute(
    RootRoute(),
    '/index.html',
  );

  final root = Directory(
    Uri(
      path: 'web/static',
    ).toFilePath(),
  );

  pod.webServer.addRoute(
    StaticRoute.directory(root),
  );

  pod.webServer.addRoute(
    AppConfigRoute(
      apiConfig: pod.config.apiServer,
    ),
    '/app/assets/assets/config.json',
  );

  final appDir = Directory(
    Uri(
      path: 'web/app',
    ).toFilePath(),
  );

  if (appDir.existsSync()) {
    pod.webServer.addRoute(
      FlutterRoute(
        Directory(
          Uri(
            path: 'web/app',
          ).toFilePath(),
        ),
      ),
      '/app',
    );
  } else {
    pod.webServer.addRoute(
      StaticRoute.file(
        File(
          Uri(
            path: 'web/pages/build_flutter_app.html',
          ).toFilePath(),
        ),
      ),
      '/app/**',
    );
  }

  // Capture startup duration and failure stage without printing credentials.
  final startupTimer = Stopwatch()..start();
  print('[Glyphora Startup] Serverpod startup begin.');
  try {
    await pod.start();
    print(
      '[Glyphora Startup] Serverpod startup completed '
      'in ${startupTimer.elapsedMilliseconds} ms.',
    );
  } catch (error) {
    print(
      '[Glyphora Startup] Serverpod startup failed after '
      '${startupTimer.elapsedMilliseconds} ms '
      '(error type: ${error.runtimeType}).',
    );
    rethrow;
  } finally {
    startupTimer.stop();
  }

  if (!isMaintenance) {
    // Persistent tombstones allow cleanup to resume after container restarts.
    unawaited(VideoDeletionService.sweep());
    Timer.periodic(const Duration(minutes: 2), (_) {
      unawaited(VideoDeletionService.sweep());
    });
  }

  if (!isMaintenance) {
    await _ensureConfiguredAdminAccess();
  }
}

Future<void> _ensureConfiguredAdminAccess() async {
  final configuredEmail = Platform.environment['GLYPHORA_ADMIN_EMAIL']
      ?.trim()
      .toLowerCase();

  if (configuredEmail == null || configuredEmail.isEmpty) {
    print(
      '[Glyphora Admin] GLYPHORA_ADMIN_EMAIL is not configured; '
      'admin bootstrap skipped.',
    );
    return;
  }

  print('[Glyphora Admin] Bootstrap start for $configuredEmail.');

  Session? session;

  try {
    print('[Glyphora Admin] Creating bootstrap session...');
    session = await Serverpod.instance.createSession().timeout(
      const Duration(seconds: 15),
    );
    print('[Glyphora Admin] Bootstrap session ready.');

    print('[Glyphora Admin] Looking up email account...');
    final emailAccount = await AuthServices.instance.emailIdp.admin
        .findAccount(
          session,
          email: configuredEmail,
        )
        .timeout(const Duration(seconds: 15));

    if (emailAccount == null) {
      print(
        '[Glyphora Admin] No existing Glyphora email account found for '
        '$configuredEmail.',
      );
      return;
    }

    print(
      '[Glyphora Admin] Email account found: ${emailAccount.authUserId}.',
    );

    print('[Glyphora Admin] Ensuring Scope.admin...');
    final authUser = await AuthServices.instance.authUsers
        .get(
          session,
          authUserId: emailAccount.authUserId,
        )
        .timeout(const Duration(seconds: 15));

    if (authUser.scopes.contains(Scope.admin)) {
      print(
        '[Glyphora Admin] Admin scope already present for $configuredEmail.',
      );
    } else {
      await AuthServices.instance.authUsers
          .update(
            session,
            authUserId: emailAccount.authUserId,
            scopes: {
              ...authUser.scopes,
              Scope.admin,
            },
          )
          .timeout(const Duration(seconds: 15));

      print('[Glyphora Admin] Granted Scope.admin to $configuredEmail.');
    }

    print('[Glyphora Admin] Ensuring membership workspace...');
    final workspace = await AdminMembershipService.ensureBootstrapOwner(
      session,
      userId: emailAccount.authUserId.toString(),
      email: configuredEmail,
    ).timeout(const Duration(seconds: 30));

    print(
      '[Glyphora Admin] Membership workspace ready: '
      '${workspace.name} (#${workspace.id}).',
    );

    print('[Glyphora Admin] Bootstrap complete for $configuredEmail.');
  } catch (e, st) {
    print('[Glyphora Admin] Bootstrap failed: $e');
    print(st);
  } finally {
    if (session != null) {
      await session.close();
    }
  }
}

Future<void> _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) async {
  await _sendVerificationEmail(
    email: email,
    subject: 'Glyphora verification code / Glyphora 注册验证码',
    title: 'Welcome to Glyphora / 欢迎加入 Glyphora',
    verificationCode: verificationCode,
  );
}

Future<void> _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) async {
  await _sendVerificationEmail(
    email: email,
    subject: 'Glyphora password reset code / Glyphora 密码重置验证码',
    title: 'Reset your Glyphora password / 重置你的 Glyphora 密码',
    verificationCode: verificationCode,
  );
}

Future<void> _sendVerificationEmail({
  required String email,
  required String subject,
  required String title,
  required String verificationCode,
}) async {
  final smtpEmail = Platform.environment['SMTP_EMAIL'];

  final smtpPassword = Platform.environment['SMTP_APP_PASSWORD'];

  if (smtpEmail == null || smtpEmail.isEmpty) {
    throw StateError(
      'SMTP_EMAIL is not configured',
    );
  }

  if (smtpPassword == null || smtpPassword.isEmpty) {
    throw StateError(
      'SMTP_APP_PASSWORD is not configured',
    );
  }

  final smtpServer = gmail(
    smtpEmail,
    smtpPassword,
  );

  final message = mailer.Message()
    ..from = mailer.Address(
      smtpEmail,
      'Glyphora',
    )
    ..recipients.add(email)
    ..subject = subject
    ..text =
        '''
$title

Your verification code is / 你的验证码是：

$verificationCode

This code is only for this request. / 验证码仅用于本次操作。

If this wasn't you, you can ignore this email. / 如果这不是你的操作，请忽略这封邮件。

Glyphora
''';

  await mailer.send(
    message,
    smtpServer,
  );
}
