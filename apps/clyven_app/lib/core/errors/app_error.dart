enum AppErrorCode {
  accountAndPasswordRequired,
  invalidCredentials,
  emailRequired,
  passwordRequired,
  emailVerificationRequired,
  invalidEmail,
  verificationCodeRequired,
  usernameRequired,
  displayNameRequired,
  passwordTooShort6,
  passwordTooShort8,
  registrationNotStarted,
  invalidVerificationCode,
  registrationEmailRequired,
  emailVerificationPending,
  usernameTaken,
  registrationFailed,
  authOperationFailed,
  notLoggedIn,
  videoNotFound,
  uploadFileMissing,
  uploadFileEmpty,
  uploadDescriptionFailed,
  uploadFailed,
  uploadVerificationFailed,
  videoUrlUnavailable,
  videoDurationUnreadable,
  commentEmpty,
  replyEmpty,
  commentNotFound,
  replyNotFound,
}

class AppException implements Exception {
  final AppErrorCode code;
  final String? technicalDetails;

  const AppException(
    this.code, {
    this.technicalDetails,
  });

  @override
  String toString() {
    if (technicalDetails == null || technicalDetails!.isEmpty) {
      return 'AppException(${code.name})';
    }

    return 'AppException(${code.name}): $technicalDetails';
  }
}
