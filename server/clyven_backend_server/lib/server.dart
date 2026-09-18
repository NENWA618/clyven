import 'dart:io';

import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
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

  // 正常启动服务器时才需要 GCP Storage
  if (!isMaintenance) {
    pod.addCloudStorage(
      gcp.GoogleCloudStorage(
        serverpod: pod,
        storageId: 'public',
        public: true,
        region: 'auto',
        bucket: 'glyphora-video-storage-11129163384',
      ),
    );
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

  await pod.start();
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
    subject: 'Clyven verification code / Clyven 注册验证码',
    title: 'Welcome to Clyven / 欢迎加入 Clyven',
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
    subject: 'Clyven password reset code / Clyven 密码重置验证码',
    title: 'Reset your Clyven password / 重置你的 Clyven 密码',
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
      'Clyven',
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

Clyven
''';

  await mailer.send(
    message,
    smtpServer,
  );
}
