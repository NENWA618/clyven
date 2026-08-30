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

  pod.addCloudStorage(
    gcp.GoogleCloudStorage(
      serverpod: pod,
      storageId: 'public',
      public: true,
      region: 'auto',
      bucket: 'glyphora-video-storage-11129163384',
    ),
  );

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
    subject: 'Glyphora 注册验证码',
    title: '欢迎加入 Glyphora',
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
    subject: 'Glyphora 密码重置验证码',
    title: '重置你的 Glyphora 密码',
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
      '没有配置 SMTP_EMAIL',
    );
  }

  if (smtpPassword == null || smtpPassword.isEmpty) {
    throw StateError(
      '没有配置 SMTP_APP_PASSWORD',
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

你的验证码是：

$verificationCode

验证码仅用于本次操作。

如果这不是你的操作，请忽略这封邮件。

Glyphora
''';

  await mailer.send(
    message,
    smtpServer,
  );
}
