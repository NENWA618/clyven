import 'package:clyven_app/core/errors/app_error.dart';
import 'package:clyven_app/l10n/app_localizations.dart';

String localizedErrorMessage(
  AppLocalizations l10n,
  Object? error,
) {
  if (error is! AppException) {
    return l10n.unexpectedError;
  }

  return switch (error.code) {
    AppErrorCode.accountAndPasswordRequired =>
      l10n.loginAccountAndPasswordRequired,
    AppErrorCode.invalidCredentials => l10n.invalidAccountOrPassword,
    AppErrorCode.emailRequired => l10n.emailRequired,
    AppErrorCode.passwordRequired => l10n.passwordRequiredError,
    AppErrorCode.emailVerificationRequired => l10n.emailVerificationRequired,
    AppErrorCode.invalidEmail => l10n.invalidEmail,
    AppErrorCode.verificationCodeRequired => l10n.verificationCodeRequired,
    AppErrorCode.usernameRequired => l10n.usernameRequired,
    AppErrorCode.displayNameRequired => l10n.displayNameRequired,
    AppErrorCode.passwordTooShort6 => l10n.passwordMin6Validation,
    AppErrorCode.passwordTooShort8 => l10n.passwordMin8Validation,
    AppErrorCode.registrationNotStarted => l10n.registrationNotStarted,
    AppErrorCode.invalidVerificationCode => l10n.invalidVerificationCode,
    AppErrorCode.registrationEmailRequired => l10n.registrationEmailRequired,
    AppErrorCode.emailVerificationPending => l10n.emailVerificationPending,
    AppErrorCode.usernameTaken => l10n.usernameTaken,
    AppErrorCode.registrationFailed => l10n.registrationFailed,
    AppErrorCode.authOperationFailed => l10n.authOperationFailed,
    AppErrorCode.notLoggedIn => l10n.loginRequired,
    AppErrorCode.videoNotFound => l10n.videoNotFound,
    AppErrorCode.uploadFileMissing => l10n.uploadFileMissing,
    AppErrorCode.uploadFileEmpty => l10n.uploadFileEmpty,
    AppErrorCode.uploadDescriptionFailed => l10n.uploadDescriptionFailed,
    AppErrorCode.uploadFailed => l10n.uploadFailed,
    AppErrorCode.uploadVerificationFailed => l10n.uploadVerificationFailed,
    AppErrorCode.videoUrlUnavailable => l10n.videoUrlUnavailable,
    AppErrorCode.videoDurationUnreadable => l10n.videoDurationUnreadable,
    AppErrorCode.videoNormalizeFailed => l10n.videoNormalizeFailed,
    AppErrorCode.normalizedVideoMissing => l10n.normalizedVideoMissing,
    AppErrorCode.coverGenerationFailed => l10n.coverGenerationFailed,
    AppErrorCode.generatedCoverMissing => l10n.generatedCoverMissing,
    AppErrorCode.generatedCoverEmpty => l10n.generatedCoverEmpty,
    AppErrorCode.commentEmpty => l10n.commentEmpty,
    AppErrorCode.replyEmpty => l10n.replyEmpty,
    AppErrorCode.commentNotFound => l10n.commentNotFound,
    AppErrorCode.replyNotFound => l10n.replyNotFound,
  };
}
