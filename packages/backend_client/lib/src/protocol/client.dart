/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'dart:typed_data' as _i5;
import 'package:glyphora_backend_client/src/protocol/asr_job.dart' as _i6;
import 'package:glyphora_backend_client/src/protocol/asr_job_status.dart'
    as _i7;
import 'package:glyphora_backend_client/src/protocol/video.dart' as _i8;
import 'package:glyphora_backend_client/src/protocol/subtitle_track.dart'
    as _i9;
import 'package:glyphora_backend_client/src/protocol/admin_workspace.dart'
    as _i10;
import 'package:glyphora_backend_client/src/protocol/admin_member.dart' as _i11;
import 'package:glyphora_backend_client/src/protocol/admin_role.dart' as _i12;
import 'package:glyphora_backend_client/src/protocol/admin_permission.dart'
    as _i13;
import 'package:glyphora_backend_client/src/protocol/admin_role_permission.dart'
    as _i14;
import 'package:glyphora_backend_client/src/protocol/comment_page_dto.dart'
    as _i15;
import 'package:glyphora_backend_client/src/protocol/video_comment_dto.dart'
    as _i16;
import 'package:glyphora_backend_client/src/protocol/comment_reply_dto.dart'
    as _i17;
import 'package:glyphora_backend_client/src/protocol/dictionary_entry_detail.dart'
    as _i18;
import 'package:glyphora_backend_client/src/protocol/dictionary_import_profile.dart'
    as _i19;
import 'package:glyphora_backend_client/src/protocol/dictionary_import_profile_detail.dart'
    as _i20;
import 'package:glyphora_backend_client/src/protocol/dictionary_import_preview.dart'
    as _i21;
import 'package:glyphora_backend_client/src/protocol/dictionary_import_commit_result.dart'
    as _i22;
import 'package:glyphora_backend_client/src/protocol/entry_knowledge_state.dart'
    as _i23;
import 'package:glyphora_backend_client/src/protocol/knowledge_state_result.dart'
    as _i24;
import 'package:glyphora_backend_client/src/protocol/knowledge_state_query.dart'
    as _i25;
import 'package:glyphora_backend_client/src/protocol/app_notification.dart'
    as _i26;
import 'package:glyphora_backend_client/src/protocol/notification_settings.dart'
    as _i27;
import 'package:glyphora_backend_client/src/protocol/privacy_settings.dart'
    as _i28;
import 'package:glyphora_backend_client/src/protocol/subtitle_review_dashboard.dart'
    as _i29;
import 'package:glyphora_backend_client/src/protocol/subtitle_review_task_detail.dart'
    as _i30;
import 'package:glyphora_backend_client/src/protocol/subtitle_review_task.dart'
    as _i31;
import 'package:glyphora_backend_client/src/protocol/script_conversion_profile.dart'
    as _i32;
import 'package:glyphora_backend_client/src/protocol/script_conversion_entry.dart'
    as _i33;
import 'package:glyphora_backend_client/src/protocol/script_conversion_import_preview.dart'
    as _i34;
import 'package:glyphora_backend_client/src/protocol/script_conversion_commit_result.dart'
    as _i35;
import 'package:glyphora_backend_client/src/protocol/profile_stats.dart'
    as _i36;
import 'package:glyphora_backend_client/src/protocol/watch_history.dart'
    as _i37;
import 'package:glyphora_backend_client/src/protocol/subtitle_search_result.dart'
    as _i38;
import 'package:glyphora_backend_client/src/protocol/subtitle_cue_detail.dart'
    as _i39;
import 'package:glyphora_backend_client/src/protocol/subtitle_publish_status.dart'
    as _i40;
import 'package:glyphora_backend_client/src/protocol/subtitle_srt_preview.dart'
    as _i41;
import 'package:glyphora_backend_client/src/protocol/subtitle_cue.dart' as _i42;
import 'package:glyphora_backend_client/src/protocol/subtitle_cue_text.dart'
    as _i43;
import 'package:glyphora_backend_client/src/protocol/subtitle_karaoke_segment.dart'
    as _i44;
import 'package:glyphora_backend_client/src/protocol/subtitle_karaoke_segment_input.dart'
    as _i45;
import 'package:glyphora_backend_client/src/protocol/video_content_type.dart'
    as _i46;
import 'package:glyphora_backend_client/src/protocol/video_series.dart' as _i47;
import 'package:glyphora_backend_client/src/protocol/word_list.dart' as _i48;
import 'package:glyphora_backend_client/src/protocol/word_list_detail.dart'
    as _i49;
import 'package:glyphora_backend_client/src/protocol/greetings/greeting.dart'
    as _i50;
import 'protocol.dart' as _i51;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i3.Future<_i2.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i3.Future<String> verifyRegistrationCode({
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i3.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i3.Future<_i2.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i3.Future<String> verifyPasswordResetCode({
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _i3.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// {@category Endpoint}
class EndpointUserProfileEdit extends _i4.EndpointUserProfileEditBase {
  EndpointUserProfileEdit(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userProfileEdit';

  /// Removes the user's uploaded image, setting it to null.
  ///
  /// The client should handle displaying a placeholder for users without images.
  @override
  _i3.Future<_i4.UserProfileModel> removeUserImage() =>
      caller.callServerEndpoint<_i4.UserProfileModel>(
        'userProfileEdit',
        'removeUserImage',
        {},
      );

  /// Sets a new user image for the signed in user.
  @override
  _i3.Future<_i4.UserProfileModel> setUserImage(_i5.ByteData image) =>
      caller.callServerEndpoint<_i4.UserProfileModel>(
        'userProfileEdit',
        'setUserImage',
        {'image': image},
      );

  /// Changes the name of a user.
  @override
  _i3.Future<_i4.UserProfileModel> changeUserName(String? userName) =>
      caller.callServerEndpoint<_i4.UserProfileModel>(
        'userProfileEdit',
        'changeUserName',
        {'userName': userName},
      );

  /// Changes the full name of a user.
  @override
  _i3.Future<_i4.UserProfileModel> changeFullName(String? fullName) =>
      caller.callServerEndpoint<_i4.UserProfileModel>(
        'userProfileEdit',
        'changeFullName',
        {'fullName': fullName},
      );

  /// Returns the user profile of the current user.
  @override
  _i3.Future<_i4.UserProfileModel> get() =>
      caller.callServerEndpoint<_i4.UserProfileModel>(
        'userProfileEdit',
        'get',
        {},
      );
}

/// {@category Endpoint}
class EndpointAdmin extends _i2.EndpointRef {
  EndpointAdmin(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _i3.Future<bool> ping() => caller.callServerEndpoint<bool>(
    'admin',
    'ping',
    {},
  );

  _i3.Future<Map<String, String>> getUserEmails() =>
      caller.callServerEndpoint<Map<String, String>>(
        'admin',
        'getUserEmails',
        {},
      );

  _i3.Future<List<_i6.AsrJob>> getAsrJobs({_i7.AsrJobStatus? status}) =>
      caller.callServerEndpoint<List<_i6.AsrJob>>(
        'admin',
        'getAsrJobs',
        {'status': status},
      );

  _i3.Future<_i6.AsrJob> retryVideoAsr({
    required int videoId,
    required String languageCode,
  }) => caller.callServerEndpoint<_i6.AsrJob>(
    'admin',
    'retryVideoAsr',
    {
      'videoId': videoId,
      'languageCode': languageCode,
    },
  );

  _i3.Future<List<_i8.Video>> getAllVideos() =>
      caller.callServerEndpoint<List<_i8.Video>>(
        'admin',
        'getAllVideos',
        {},
      );

  _i3.Future<List<_i8.Video>> getVideosWithSubtitles() =>
      caller.callServerEndpoint<List<_i8.Video>>(
        'admin',
        'getVideosWithSubtitles',
        {},
      );

  _i3.Future<List<_i9.SubtitleTrack>> getSubtitleTracks({
    required int videoId,
  }) => caller.callServerEndpoint<List<_i9.SubtitleTrack>>(
    'admin',
    'getSubtitleTracks',
    {'videoId': videoId},
  );
}

/// {@category Endpoint}
class EndpointAdminMembership extends _i2.EndpointRef {
  EndpointAdminMembership(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminMembership';

  _i3.Future<_i10.AdminWorkspace> getWorkspace() =>
      caller.callServerEndpoint<_i10.AdminWorkspace>(
        'adminMembership',
        'getWorkspace',
        {},
      );

  _i3.Future<List<_i11.AdminMember>> listMembers() =>
      caller.callServerEndpoint<List<_i11.AdminMember>>(
        'adminMembership',
        'listMembers',
        {},
      );

  _i3.Future<List<_i12.AdminRole>> listRoles() =>
      caller.callServerEndpoint<List<_i12.AdminRole>>(
        'adminMembership',
        'listRoles',
        {},
      );

  _i3.Future<List<_i13.AdminPermission>> listPermissions() =>
      caller.callServerEndpoint<List<_i13.AdminPermission>>(
        'adminMembership',
        'listPermissions',
        {},
      );

  _i3.Future<List<_i14.AdminRolePermission>> listRolePermissions({
    required int roleId,
  }) => caller.callServerEndpoint<List<_i14.AdminRolePermission>>(
    'adminMembership',
    'listRolePermissions',
    {'roleId': roleId},
  );

  _i3.Future<_i11.AdminMember> addMemberByEmail({
    required String email,
    required int roleId,
  }) => caller.callServerEndpoint<_i11.AdminMember>(
    'adminMembership',
    'addMemberByEmail',
    {
      'email': email,
      'roleId': roleId,
    },
  );

  _i3.Future<_i11.AdminMember> updateMemberRole({
    required int memberId,
    required int roleId,
  }) => caller.callServerEndpoint<_i11.AdminMember>(
    'adminMembership',
    'updateMemberRole',
    {
      'memberId': memberId,
      'roleId': roleId,
    },
  );

  _i3.Future<bool> removeMember({required int memberId}) =>
      caller.callServerEndpoint<bool>(
        'adminMembership',
        'removeMember',
        {'memberId': memberId},
      );

  _i3.Future<_i10.AdminWorkspace> transferOwnership({
    required int newOwnerMemberId,
  }) => caller.callServerEndpoint<_i10.AdminWorkspace>(
    'adminMembership',
    'transferOwnership',
    {'newOwnerMemberId': newOwnerMemberId},
  );

  _i3.Future<bool> setRolePermissions({
    required int roleId,
    required List<String> permissionCodes,
  }) => caller.callServerEndpoint<bool>(
    'adminMembership',
    'setRolePermissions',
    {
      'roleId': roleId,
      'permissionCodes': permissionCodes,
    },
  );
}

/// {@category Endpoint}
class EndpointComment extends _i2.EndpointRef {
  EndpointComment(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'comment';

  _i3.Future<_i15.CommentPageDto> loadComments({
    required int videoId,
    required int page,
    required int limit,
  }) => caller.callServerEndpoint<_i15.CommentPageDto>(
    'comment',
    'loadComments',
    {
      'videoId': videoId,
      'page': page,
      'limit': limit,
    },
  );

  _i3.Future<_i16.VideoCommentDto> createComment({
    required int videoId,
    required String userName,
    required String content,
  }) => caller.callServerEndpoint<_i16.VideoCommentDto>(
    'comment',
    'createComment',
    {
      'videoId': videoId,
      'userName': userName,
      'content': content,
    },
  );

  _i3.Future<_i17.CommentReplyDto> createReply({
    required int videoId,
    required int commentId,
    required String userName,
    required String content,
  }) => caller.callServerEndpoint<_i17.CommentReplyDto>(
    'comment',
    'createReply',
    {
      'videoId': videoId,
      'commentId': commentId,
      'userName': userName,
      'content': content,
    },
  );

  _i3.Future<_i16.VideoCommentDto> toggleCommentLike({
    required int videoId,
    required int commentId,
  }) => caller.callServerEndpoint<_i16.VideoCommentDto>(
    'comment',
    'toggleCommentLike',
    {
      'videoId': videoId,
      'commentId': commentId,
    },
  );

  _i3.Future<_i17.CommentReplyDto> toggleReplyLike({
    required int videoId,
    required int commentId,
    required int replyId,
  }) => caller.callServerEndpoint<_i17.CommentReplyDto>(
    'comment',
    'toggleReplyLike',
    {
      'videoId': videoId,
      'commentId': commentId,
      'replyId': replyId,
    },
  );

  _i3.Future<void> deleteManagedComment({
    required int videoId,
    required int commentId,
  }) => caller.callServerEndpoint<void>(
    'comment',
    'deleteManagedComment',
    {
      'videoId': videoId,
      'commentId': commentId,
    },
  );

  _i3.Future<void> deleteManagedReply({
    required int videoId,
    required int commentId,
    required int replyId,
  }) => caller.callServerEndpoint<void>(
    'comment',
    'deleteManagedReply',
    {
      'videoId': videoId,
      'commentId': commentId,
      'replyId': replyId,
    },
  );
}

/// {@category Endpoint}
class EndpointDictionary extends _i2.EndpointRef {
  EndpointDictionary(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dictionary';

  _i3.Future<_i18.DictionaryEntryDetail?> lookup({
    required String languageCode,
    required String normalizedText,
    required String entryType,
    required String explanationLanguageCode,
  }) => caller.callServerEndpoint<_i18.DictionaryEntryDetail?>(
    'dictionary',
    'lookup',
    {
      'languageCode': languageCode,
      'normalizedText': normalizedText,
      'entryType': entryType,
      'explanationLanguageCode': explanationLanguageCode,
    },
  );

  _i3.Future<_i18.DictionaryEntryDetail?> getById({
    required int entryId,
    required String explanationLanguageCode,
  }) => caller.callServerEndpoint<_i18.DictionaryEntryDetail?>(
    'dictionary',
    'getById',
    {
      'entryId': entryId,
      'explanationLanguageCode': explanationLanguageCode,
    },
  );

  _i3.Future<List<_i18.DictionaryEntryDetail>> listEntries({
    required String languageCode,
    required int offset,
    required int limit,
  }) => caller.callServerEndpoint<List<_i18.DictionaryEntryDetail>>(
    'dictionary',
    'listEntries',
    {
      'languageCode': languageCode,
      'offset': offset,
      'limit': limit,
    },
  );

  _i3.Future<void> updateEntryRow({
    required int entryId,
    required String headword,
    required String nomText,
    required String chineseGloss,
    required String partOfSpeech,
    required String vietnameseExample,
    required String nomExample,
    required String chineseExample,
  }) => caller.callServerEndpoint<void>(
    'dictionary',
    'updateEntryRow',
    {
      'entryId': entryId,
      'headword': headword,
      'nomText': nomText,
      'chineseGloss': chineseGloss,
      'partOfSpeech': partOfSpeech,
      'vietnameseExample': vietnameseExample,
      'nomExample': nomExample,
      'chineseExample': chineseExample,
    },
  );
}

/// {@category Endpoint}
class EndpointDictionaryImport extends _i2.EndpointRef {
  EndpointDictionaryImport(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dictionaryImport';

  _i3.Future<List<_i19.DictionaryImportProfile>> getProfiles({
    String? languageCode,
  }) => caller.callServerEndpoint<List<_i19.DictionaryImportProfile>>(
    'dictionaryImport',
    'getProfiles',
    {'languageCode': languageCode},
  );

  _i3.Future<_i20.DictionaryImportProfileDetail?> getProfile({
    required int profileId,
  }) => caller.callServerEndpoint<_i20.DictionaryImportProfileDetail?>(
    'dictionaryImport',
    'getProfile',
    {'profileId': profileId},
  );

  _i3.Future<_i20.DictionaryImportProfileDetail>
  createVietnameseVocabularyProfile() =>
      caller.callServerEndpoint<_i20.DictionaryImportProfileDetail>(
        'dictionaryImport',
        'createVietnameseVocabularyProfile',
        {},
      );

  _i3.Future<_i21.DictionaryImportPreview?> previewRows({
    required int profileId,
    required List<String> rowsJson,
  }) => caller.callServerEndpoint<_i21.DictionaryImportPreview?>(
    'dictionaryImport',
    'previewRows',
    {
      'profileId': profileId,
      'rowsJson': rowsJson,
    },
  );

  _i3.Future<_i21.DictionaryImportPreview?> previewExcelBase64({
    required int profileId,
    required String excelBase64,
  }) => caller.callServerEndpoint<_i21.DictionaryImportPreview?>(
    'dictionaryImport',
    'previewExcelBase64',
    {
      'profileId': profileId,
      'excelBase64': excelBase64,
    },
  );

  _i3.Future<_i22.DictionaryImportCommitResult> commitExcelBase64({
    required int profileId,
    required String excelBase64,
  }) => caller.callServerEndpoint<_i22.DictionaryImportCommitResult>(
    'dictionaryImport',
    'commitExcelBase64',
    {
      'profileId': profileId,
      'excelBase64': excelBase64,
    },
  );
}

/// {@category Endpoint}
class EndpointKnownEntry extends _i2.EndpointRef {
  EndpointKnownEntry(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'knownEntry';

  _i3.Future<List<int>> getKnownEntryIds({required List<int> entryIds}) =>
      caller.callServerEndpoint<List<int>>(
        'knownEntry',
        'getKnownEntryIds',
        {'entryIds': entryIds},
      );

  _i3.Future<bool> setKnown({
    required int entryId,
    required bool known,
  }) => caller.callServerEndpoint<bool>(
    'knownEntry',
    'setKnown',
    {
      'entryId': entryId,
      'known': known,
    },
  );

  _i3.Future<List<_i23.EntryKnowledgeState>> getKnowledgeStatesByEntryIds({
    required List<int> entryIds,
  }) => caller.callServerEndpoint<List<_i23.EntryKnowledgeState>>(
    'knownEntry',
    'getKnowledgeStatesByEntryIds',
    {'entryIds': entryIds},
  );

  _i3.Future<String> getKnowledgeState({
    required String languageCode,
    required String normalizedText,
    required String entryType,
  }) => caller.callServerEndpoint<String>(
    'knownEntry',
    'getKnowledgeState',
    {
      'languageCode': languageCode,
      'normalizedText': normalizedText,
      'entryType': entryType,
    },
  );

  _i3.Future<List<_i24.KnowledgeStateResult>> getKnowledgeStates({
    required List<_i25.KnowledgeStateQuery> queries,
  }) => caller.callServerEndpoint<List<_i24.KnowledgeStateResult>>(
    'knownEntry',
    'getKnowledgeStates',
    {'queries': queries},
  );
}

/// {@category Endpoint}
class EndpointNotification extends _i2.EndpointRef {
  EndpointNotification(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notification';

  _i3.Future<List<_i26.AppNotification>> list() =>
      caller.callServerEndpoint<List<_i26.AppNotification>>(
        'notification',
        'list',
        {},
      );

  _i3.Future<void> markAsRead(int notificationId) =>
      caller.callServerEndpoint<void>(
        'notification',
        'markAsRead',
        {'notificationId': notificationId},
      );

  _i3.Future<void> markAllAsRead() => caller.callServerEndpoint<void>(
    'notification',
    'markAllAsRead',
    {},
  );
}

/// {@category Endpoint}
class EndpointNotificationSettings extends _i2.EndpointRef {
  EndpointNotificationSettings(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notificationSettings';

  _i3.Future<_i27.NotificationSettings> get() =>
      caller.callServerEndpoint<_i27.NotificationSettings>(
        'notificationSettings',
        'get',
        {},
      );

  _i3.Future<_i27.NotificationSettings> update({
    bool? pushEnabled,
    bool? likeEnabled,
    bool? commentEnabled,
    bool? followEnabled,
  }) => caller.callServerEndpoint<_i27.NotificationSettings>(
    'notificationSettings',
    'update',
    {
      'pushEnabled': pushEnabled,
      'likeEnabled': likeEnabled,
      'commentEnabled': commentEnabled,
      'followEnabled': followEnabled,
    },
  );
}

/// {@category Endpoint}
class EndpointPrivacySettings extends _i2.EndpointRef {
  EndpointPrivacySettings(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'privacySettings';

  _i3.Future<_i28.PrivacySettings> get() =>
      caller.callServerEndpoint<_i28.PrivacySettings>(
        'privacySettings',
        'get',
        {},
      );

  _i3.Future<_i28.PrivacySettings> update({
    bool? privateAccount,
    bool? allowComments,
    bool? showActivityStatus,
  }) => caller.callServerEndpoint<_i28.PrivacySettings>(
    'privacySettings',
    'update',
    {
      'privateAccount': privateAccount,
      'allowComments': allowComments,
      'showActivityStatus': showActivityStatus,
    },
  );
}

/// Registers the caller's FCM device token so the server can push to it.
/// {@category Endpoint}
class EndpointPushDevice extends _i2.EndpointRef {
  EndpointPushDevice(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pushDevice';

  /// Binds [token] to the current user. A token belongs to exactly one user,
  /// so it is re-assigned when someone else signs in on the same device.
  _i3.Future<void> register({
    required String token,
    required String platform,
    required String languageCode,
  }) => caller.callServerEndpoint<void>(
    'pushDevice',
    'register',
    {
      'token': token,
      'platform': platform,
      'languageCode': languageCode,
    },
  );

  /// Removes [token], e.g. on sign-out, so the device stops receiving pushes.
  _i3.Future<void> unregister({required String token}) =>
      caller.callServerEndpoint<void>(
        'pushDevice',
        'unregister',
        {'token': token},
      );
}

/// {@category Endpoint}
class EndpointReview extends _i2.EndpointRef {
  EndpointReview(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'review';

  _i3.Future<_i29.SubtitleReviewDashboard> getDashboard() =>
      caller.callServerEndpoint<_i29.SubtitleReviewDashboard>(
        'review',
        'getDashboard',
        {},
      );

  _i3.Future<_i30.SubtitleReviewTaskDetail> getTaskDetail({
    required int taskId,
  }) => caller.callServerEndpoint<_i30.SubtitleReviewTaskDetail>(
    'review',
    'getTaskDetail',
    {'taskId': taskId},
  );

  _i3.Future<_i31.SubtitleReviewTask> generateVietnameseNomDraft({
    required int trackId,
  }) => caller.callServerEndpoint<_i31.SubtitleReviewTask>(
    'review',
    'generateVietnameseNomDraft',
    {'trackId': trackId},
  );

  _i3.Future<_i31.SubtitleReviewTask> claimTask({required int taskId}) =>
      caller.callServerEndpoint<_i31.SubtitleReviewTask>(
        'review',
        'claimTask',
        {'taskId': taskId},
      );

  _i3.Future<_i31.SubtitleReviewTask> startTask({required int taskId}) =>
      caller.callServerEndpoint<_i31.SubtitleReviewTask>(
        'review',
        'startTask',
        {'taskId': taskId},
      );

  _i3.Future<_i31.SubtitleReviewTask> submitTask({required int taskId}) =>
      caller.callServerEndpoint<_i31.SubtitleReviewTask>(
        'review',
        'submitTask',
        {'taskId': taskId},
      );

  _i3.Future<_i31.SubtitleReviewTask> returnTask({
    required int taskId,
    String? note,
  }) => caller.callServerEndpoint<_i31.SubtitleReviewTask>(
    'review',
    'returnTask',
    {
      'taskId': taskId,
      'note': note,
    },
  );

  _i3.Future<_i31.SubtitleReviewTask> approveAndPublish({
    required int taskId,
  }) => caller.callServerEndpoint<_i31.SubtitleReviewTask>(
    'review',
    'approveAndPublish',
    {'taskId': taskId},
  );
}

/// {@category Endpoint}
class EndpointScriptConversion extends _i2.EndpointRef {
  EndpointScriptConversion(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'scriptConversion';

  _i3.Future<List<_i32.ScriptConversionProfile>> listProfiles() =>
      caller.callServerEndpoint<List<_i32.ScriptConversionProfile>>(
        'scriptConversion',
        'listProfiles',
        {},
      );

  _i3.Future<_i32.ScriptConversionProfile> createProfile({
    required String name,
    required String languageCode,
    required String sourceScriptCode,
    required String targetScriptCode,
    required String sourceColumn,
    required String targetColumn,
    String? sheetName,
    String? priorityColumn,
    String? noteColumn,
    required String conversionMode,
    String? typeColumn,
    String? description,
  }) => caller.callServerEndpoint<_i32.ScriptConversionProfile>(
    'scriptConversion',
    'createProfile',
    {
      'name': name,
      'languageCode': languageCode,
      'sourceScriptCode': sourceScriptCode,
      'targetScriptCode': targetScriptCode,
      'sourceColumn': sourceColumn,
      'targetColumn': targetColumn,
      'sheetName': sheetName,
      'priorityColumn': priorityColumn,
      'noteColumn': noteColumn,
      'conversionMode': conversionMode,
      'typeColumn': typeColumn,
      'description': description,
    },
  );

  _i3.Future<_i32.ScriptConversionProfile> updateProfile({
    required int profileId,
    required String name,
    required String languageCode,
    required String sourceScriptCode,
    required String targetScriptCode,
    required String sourceColumn,
    required String targetColumn,
    String? sheetName,
    String? priorityColumn,
    String? noteColumn,
    required String conversionMode,
    String? typeColumn,
    String? description,
  }) => caller.callServerEndpoint<_i32.ScriptConversionProfile>(
    'scriptConversion',
    'updateProfile',
    {
      'profileId': profileId,
      'name': name,
      'languageCode': languageCode,
      'sourceScriptCode': sourceScriptCode,
      'targetScriptCode': targetScriptCode,
      'sourceColumn': sourceColumn,
      'targetColumn': targetColumn,
      'sheetName': sheetName,
      'priorityColumn': priorityColumn,
      'noteColumn': noteColumn,
      'conversionMode': conversionMode,
      'typeColumn': typeColumn,
      'description': description,
    },
  );

  _i3.Future<bool> deleteProfile({required int profileId}) =>
      caller.callServerEndpoint<bool>(
        'scriptConversion',
        'deleteProfile',
        {'profileId': profileId},
      );

  _i3.Future<List<_i33.ScriptConversionEntry>> listEntries({
    required int profileId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i33.ScriptConversionEntry>>(
    'scriptConversion',
    'listEntries',
    {
      'profileId': profileId,
      'limit': limit,
    },
  );

  _i3.Future<_i33.ScriptConversionEntry> updateEntry({
    required int entryId,
    required String sourceText,
    required String targetText,
    required int priority,
    String? note,
    String? entryType,
  }) => caller.callServerEndpoint<_i33.ScriptConversionEntry>(
    'scriptConversion',
    'updateEntry',
    {
      'entryId': entryId,
      'sourceText': sourceText,
      'targetText': targetText,
      'priority': priority,
      'note': note,
      'entryType': entryType,
    },
  );

  _i3.Future<bool> deleteEntry({required int entryId}) =>
      caller.callServerEndpoint<bool>(
        'scriptConversion',
        'deleteEntry',
        {'entryId': entryId},
      );

  _i3.Future<_i34.ScriptConversionImportPreview> previewExcelBase64({
    required int profileId,
    required String excelBase64,
  }) => caller.callServerEndpoint<_i34.ScriptConversionImportPreview>(
    'scriptConversion',
    'previewExcelBase64',
    {
      'profileId': profileId,
      'excelBase64': excelBase64,
    },
  );

  _i3.Future<_i35.ScriptConversionCommitResult> commitExcelBase64({
    required int profileId,
    required String excelBase64,
  }) => caller.callServerEndpoint<_i35.ScriptConversionCommitResult>(
    'scriptConversion',
    'commitExcelBase64',
    {
      'profileId': profileId,
      'excelBase64': excelBase64,
    },
  );

  _i3.Future<String> testConvert({
    required int profileId,
    required String text,
    required bool reverse,
  }) => caller.callServerEndpoint<String>(
    'scriptConversion',
    'testConvert',
    {
      'profileId': profileId,
      'text': text,
      'reverse': reverse,
    },
  );
}

/// {@category Endpoint}
class EndpointSocial extends _i2.EndpointRef {
  EndpointSocial(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'social';

  _i3.Future<_i36.ProfileStats> getMyProfileStats() =>
      caller.callServerEndpoint<_i36.ProfileStats>(
        'social',
        'getMyProfileStats',
        {},
      );

  _i3.Future<_i36.ProfileStats> getProfileStats(String creatorId) =>
      caller.callServerEndpoint<_i36.ProfileStats>(
        'social',
        'getProfileStats',
        {'creatorId': creatorId},
      );

  _i3.Future<String> updateBio(String bio) => caller.callServerEndpoint<String>(
    'social',
    'updateBio',
    {'bio': bio},
  );

  _i3.Future<bool> isFollowing(String creatorId) =>
      caller.callServerEndpoint<bool>(
        'social',
        'isFollowing',
        {'creatorId': creatorId},
      );

  _i3.Future<bool> toggleFollow(
    String creatorId, {
    required String actorName,
  }) => caller.callServerEndpoint<bool>(
    'social',
    'toggleFollow',
    {
      'creatorId': creatorId,
      'actorName': actorName,
    },
  );

  _i3.Future<List<String>> getFollowingCreatorIds() =>
      caller.callServerEndpoint<List<String>>(
        'social',
        'getFollowingCreatorIds',
        {},
      );

  _i3.Future<List<String>> getFollowerIds() =>
      caller.callServerEndpoint<List<String>>(
        'social',
        'getFollowerIds',
        {},
      );

  _i3.Future<bool> toggleFavorite(int videoId) =>
      caller.callServerEndpoint<bool>(
        'social',
        'toggleFavorite',
        {'videoId': videoId},
      );

  _i3.Future<List<int>> getFavoriteVideoIds() =>
      caller.callServerEndpoint<List<int>>(
        'social',
        'getFavoriteVideoIds',
        {},
      );

  _i3.Future<bool> toggleLike(
    int videoId, {
    required String actorName,
  }) => caller.callServerEndpoint<bool>(
    'social',
    'toggleLike',
    {
      'videoId': videoId,
      'actorName': actorName,
    },
  );

  _i3.Future<List<int>> getLikedVideoIds() =>
      caller.callServerEndpoint<List<int>>(
        'social',
        'getLikedVideoIds',
        {},
      );

  _i3.Future<List<_i37.WatchHistory>> getWatchHistory() =>
      caller.callServerEndpoint<List<_i37.WatchHistory>>(
        'social',
        'getWatchHistory',
        {},
      );

  _i3.Future<_i37.WatchHistory> saveWatchProgress(
    int videoId,
    int positionSeconds,
  ) => caller.callServerEndpoint<_i37.WatchHistory>(
    'social',
    'saveWatchProgress',
    {
      'videoId': videoId,
      'positionSeconds': positionSeconds,
    },
  );

  _i3.Future<void> removeWatchHistory(int videoId) =>
      caller.callServerEndpoint<void>(
        'social',
        'removeWatchHistory',
        {'videoId': videoId},
      );

  _i3.Future<void> clearWatchHistory() => caller.callServerEndpoint<void>(
    'social',
    'clearWatchHistory',
    {},
  );

  _i3.Future<List<Map<String, String>>> searchExistingUserProfiles(
    String query, {
    required int limit,
  }) => caller.callServerEndpoint<List<Map<String, String>>>(
    'social',
    'searchExistingUserProfiles',
    {
      'query': query,
      'limit': limit,
    },
  );

  _i3.Future<Map<String, String>?> getExistingUserProfile(String userId) =>
      caller.callServerEndpoint<Map<String, String>?>(
        'social',
        'getExistingUserProfile',
        {'userId': userId},
      );
}

/// {@category Endpoint}
class EndpointSubtitle extends _i2.EndpointRef {
  EndpointSubtitle(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'subtitle';

  /// Searches subtitle cues that are safe for public discovery.
  ///
  /// Rules:
  /// - only public + published videos are searchable;
  /// - when a subtitle track has a published snapshot, search that snapshot;
  /// - tracks without a publish-state row follow the existing legacy behavior
  ///   and use their current live cues;
  /// - draft edits are never substituted for an existing published snapshot.
  ///
  /// This first implementation intentionally reuses the existing subtitle
  /// publication model. It does not create independent clip media files.
  _i3.Future<List<_i38.SubtitleSearchResult>> searchPublishedCues({
    required String query,
    required int limit,
  }) => caller.callServerEndpoint<List<_i38.SubtitleSearchResult>>(
    'subtitle',
    'searchPublishedCues',
    {
      'query': query,
      'limit': limit,
    },
  );

  _i3.Future<List<_i39.SubtitleCueDetail>> getCueDetails({
    required int videoId,
    required String languageCode,
    String? scriptCode,
  }) => caller.callServerEndpoint<List<_i39.SubtitleCueDetail>>(
    'subtitle',
    'getCueDetails',
    {
      'videoId': videoId,
      'languageCode': languageCode,
      'scriptCode': scriptCode,
    },
  );

  _i3.Future<List<_i39.SubtitleCueDetail>> getPublishedCueDetails({
    required int videoId,
    required String languageCode,
    String? scriptCode,
  }) => caller.callServerEndpoint<List<_i39.SubtitleCueDetail>>(
    'subtitle',
    'getPublishedCueDetails',
    {
      'videoId': videoId,
      'languageCode': languageCode,
      'scriptCode': scriptCode,
    },
  );

  _i3.Future<List<_i9.SubtitleTrack>> getPublishedAvailableTracks({
    required int videoId,
  }) => caller.callServerEndpoint<List<_i9.SubtitleTrack>>(
    'subtitle',
    'getPublishedAvailableTracks',
    {'videoId': videoId},
  );

  _i3.Future<_i40.SubtitlePublishStatus> getSubtitlePublishStatus({
    required int videoId,
    required String languageCode,
  }) => caller.callServerEndpoint<_i40.SubtitlePublishStatus>(
    'subtitle',
    'getSubtitlePublishStatus',
    {
      'videoId': videoId,
      'languageCode': languageCode,
    },
  );

  _i3.Future<_i40.SubtitlePublishStatus> publishSubtitleTrack({
    required int videoId,
    required String languageCode,
  }) => caller.callServerEndpoint<_i40.SubtitlePublishStatus>(
    'subtitle',
    'publishSubtitleTrack',
    {
      'videoId': videoId,
      'languageCode': languageCode,
    },
  );

  _i3.Future<List<_i9.SubtitleTrack>> getAvailableTracks({
    required int videoId,
  }) => caller.callServerEndpoint<List<_i9.SubtitleTrack>>(
    'subtitle',
    'getAvailableTracks',
    {'videoId': videoId},
  );

  _i3.Future<_i41.SubtitleSrtPreview> previewSrtImport({
    required int videoId,
    required String languageCode,
    required String content,
  }) => caller.callServerEndpoint<_i41.SubtitleSrtPreview>(
    'subtitle',
    'previewSrtImport',
    {
      'videoId': videoId,
      'languageCode': languageCode,
      'content': content,
    },
  );

  _i3.Future<int> confirmReplaceSrtImport({
    required int videoId,
    required String languageCode,
    required String content,
    String? scriptCode,
  }) => caller.callServerEndpoint<int>(
    'subtitle',
    'confirmReplaceSrtImport',
    {
      'videoId': videoId,
      'languageCode': languageCode,
      'content': content,
      'scriptCode': scriptCode,
    },
  );

  _i3.Future<String> exportSrt({
    required int videoId,
    required String languageCode,
  }) => caller.callServerEndpoint<String>(
    'subtitle',
    'exportSrt',
    {
      'videoId': videoId,
      'languageCode': languageCode,
    },
  );

  _i3.Future<_i42.SubtitleCue> updateCueText({
    required int cueId,
    required String text,
    String? scriptCode,
  }) => caller.callServerEndpoint<_i42.SubtitleCue>(
    'subtitle',
    'updateCueText',
    {
      'cueId': cueId,
      'text': text,
      'scriptCode': scriptCode,
    },
  );

  _i3.Future<_i43.SubtitleCueText> upsertCueScriptText({
    required int cueId,
    required String scriptCode,
    required String text,
    required bool isPrimary,
  }) => caller.callServerEndpoint<_i43.SubtitleCueText>(
    'subtitle',
    'upsertCueScriptText',
    {
      'cueId': cueId,
      'scriptCode': scriptCode,
      'text': text,
      'isPrimary': isPrimary,
    },
  );

  _i3.Future<_i42.SubtitleCue> updateCueTiming({
    required int cueId,
    required int startMs,
    required int endMs,
  }) => caller.callServerEndpoint<_i42.SubtitleCue>(
    'subtitle',
    'updateCueTiming',
    {
      'cueId': cueId,
      'startMs': startMs,
      'endMs': endMs,
    },
  );

  _i3.Future<_i42.SubtitleCue> createCue({
    required int videoId,
    required String languageCode,
    required int startMs,
    required int endMs,
    required String text,
    String? scriptCode,
  }) => caller.callServerEndpoint<_i42.SubtitleCue>(
    'subtitle',
    'createCue',
    {
      'videoId': videoId,
      'languageCode': languageCode,
      'startMs': startMs,
      'endMs': endMs,
      'text': text,
      'scriptCode': scriptCode,
    },
  );

  _i3.Future<void> deleteCue({required int cueId}) =>
      caller.callServerEndpoint<void>(
        'subtitle',
        'deleteCue',
        {'cueId': cueId},
      );

  _i3.Future<List<_i44.SubtitleKaraokeSegment>> replaceKaraokeSegments({
    required int cueId,
    required List<_i45.SubtitleKaraokeSegmentInput> segments,
    String? scriptCode,
  }) => caller.callServerEndpoint<List<_i44.SubtitleKaraokeSegment>>(
    'subtitle',
    'replaceKaraokeSegments',
    {
      'cueId': cueId,
      'segments': segments,
      'scriptCode': scriptCode,
    },
  );
}

/// {@category Endpoint}
class EndpointVideo extends _i2.EndpointRef {
  EndpointVideo(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'video';

  _i3.Future<String> getCurrentUserId() => caller.callServerEndpoint<String>(
    'video',
    'getCurrentUserId',
    {},
  );

  _i3.Future<_i8.Video> create({
    required String authorId,
    required String authorName,
    required String title,
    required String description,
    String? seriesTitle,
    required String category,
    required _i46.VideoContentType contentType,
    required String languageCode,
    required List<String> tags,
    required String videoStorageKey,
    String? coverStorageKey,
    required int durationSeconds,
    required bool isPublic,
  }) => caller.callServerEndpoint<_i8.Video>(
    'video',
    'create',
    {
      'authorId': authorId,
      'authorName': authorName,
      'title': title,
      'description': description,
      'seriesTitle': seriesTitle,
      'category': category,
      'contentType': contentType,
      'languageCode': languageCode,
      'tags': tags,
      'videoStorageKey': videoStorageKey,
      'coverStorageKey': coverStorageKey,
      'durationSeconds': durationSeconds,
      'isPublic': isPublic,
    },
  );

  _i3.Future<List<_i8.Video>> getVideos({_i46.VideoContentType? contentType}) =>
      caller.callServerEndpoint<List<_i8.Video>>(
        'video',
        'getVideos',
        {'contentType': contentType},
      );

  _i3.Future<List<_i8.Video>> getMyVideos() =>
      caller.callServerEndpoint<List<_i8.Video>>(
        'video',
        'getMyVideos',
        {},
      );

  _i3.Future<_i8.Video?> getVideo(int id) =>
      caller.callServerEndpoint<_i8.Video?>(
        'video',
        'getVideo',
        {'id': id},
      );

  _i3.Future<_i47.VideoSeries> createSeries({
    required String title,
    required String description,
    String? coverStorageKey,
    String? languageCode,
    required String category,
  }) => caller.callServerEndpoint<_i47.VideoSeries>(
    'video',
    'createSeries',
    {
      'title': title,
      'description': description,
      'coverStorageKey': coverStorageKey,
      'languageCode': languageCode,
      'category': category,
    },
  );

  _i3.Future<List<_i47.VideoSeries>> getCreatorSeries({
    required String creatorId,
  }) => caller.callServerEndpoint<List<_i47.VideoSeries>>(
    'video',
    'getCreatorSeries',
    {'creatorId': creatorId},
  );

  _i3.Future<_i47.VideoSeries?> getSeries({required int seriesId}) =>
      caller.callServerEndpoint<_i47.VideoSeries?>(
        'video',
        'getSeries',
        {'seriesId': seriesId},
      );

  _i3.Future<List<_i8.Video>> getSeriesVideos({required int seriesId}) =>
      caller.callServerEndpoint<List<_i8.Video>>(
        'video',
        'getSeriesVideos',
        {'seriesId': seriesId},
      );

  _i3.Future<_i8.Video> setSeriesById({
    required int videoId,
    required int seriesId,
  }) => caller.callServerEndpoint<_i8.Video>(
    'video',
    'setSeriesById',
    {
      'videoId': videoId,
      'seriesId': seriesId,
    },
  );

  _i3.Future<int> recordView({required int videoId}) =>
      caller.callServerEndpoint<int>(
        'video',
        'recordView',
        {'videoId': videoId},
      );

  _i3.Future<int> recordEngagedView({required int videoId}) =>
      caller.callServerEndpoint<int>(
        'video',
        'recordEngagedView',
        {'videoId': videoId},
      );

  _i3.Future<_i8.Video> setSeries({
    required int videoId,
    String? seriesTitle,
  }) => caller.callServerEndpoint<_i8.Video>(
    'video',
    'setSeries',
    {
      'videoId': videoId,
      'seriesTitle': seriesTitle,
    },
  );

  _i3.Future<void> reorderSeriesVideos({
    required int seriesId,
    required List<int> videoIds,
  }) => caller.callServerEndpoint<void>(
    'video',
    'reorderSeriesVideos',
    {
      'seriesId': seriesId,
      'videoIds': videoIds,
    },
  );

  _i3.Future<_i8.Video> updateMetadata({
    required int videoId,
    required String title,
    required String description,
    required String category,
    required String languageCode,
    required List<String> tags,
    required bool isPublic,
  }) => caller.callServerEndpoint<_i8.Video>(
    'video',
    'updateMetadata',
    {
      'videoId': videoId,
      'title': title,
      'description': description,
      'category': category,
      'languageCode': languageCode,
      'tags': tags,
      'isPublic': isPublic,
    },
  );

  _i3.Future<_i8.Video> setVisibility({
    required int videoId,
    required bool isPublic,
  }) => caller.callServerEndpoint<_i8.Video>(
    'video',
    'setVisibility',
    {
      'videoId': videoId,
      'isPublic': isPublic,
    },
  );

  _i3.Future<void> deleteVideo({required int videoId}) =>
      caller.callServerEndpoint<void>(
        'video',
        'deleteVideo',
        {'videoId': videoId},
      );

  _i3.Future<String?> createUploadDescription({
    required String path,
    required int fileSize,
  }) => caller.callServerEndpoint<String?>(
    'video',
    'createUploadDescription',
    {
      'path': path,
      'fileSize': fileSize,
    },
  );

  _i3.Future<bool> verifyUpload({required String path}) =>
      caller.callServerEndpoint<bool>(
        'video',
        'verifyUpload',
        {'path': path},
      );

  _i3.Future<String?> getVideoUrl({required String path}) =>
      caller.callServerEndpoint<String?>(
        'video',
        'getVideoUrl',
        {'path': path},
      );

  _i3.Future<String?> getPlaybackManifestUrl({required int videoId}) =>
      caller.callServerEndpoint<String?>(
        'video',
        'getPlaybackManifestUrl',
        {'videoId': videoId},
      );
}

/// {@category Endpoint}
class EndpointWordList extends _i2.EndpointRef {
  EndpointWordList(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'wordList';

  _i3.Future<List<_i48.WordList>> getLists() =>
      caller.callServerEndpoint<List<_i48.WordList>>(
        'wordList',
        'getLists',
        {},
      );

  _i3.Future<_i49.WordListDetail?> getListDetail({
    required int listId,
    required String explanationLanguageCode,
  }) => caller.callServerEndpoint<_i49.WordListDetail?>(
    'wordList',
    'getListDetail',
    {
      'listId': listId,
      'explanationLanguageCode': explanationLanguageCode,
    },
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i2.EndpointRef {
  EndpointGreeting(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i3.Future<_i50.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i50.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i1.Caller(client);
    serverpod_auth_core = _i4.Caller(client);
  }

  late final _i1.Caller serverpod_auth_idp;

  late final _i4.Caller serverpod_auth_core;
}

class Client extends _i2.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i2.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i2.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i51.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    userProfileEdit = EndpointUserProfileEdit(this);
    admin = EndpointAdmin(this);
    adminMembership = EndpointAdminMembership(this);
    comment = EndpointComment(this);
    dictionary = EndpointDictionary(this);
    dictionaryImport = EndpointDictionaryImport(this);
    knownEntry = EndpointKnownEntry(this);
    notification = EndpointNotification(this);
    notificationSettings = EndpointNotificationSettings(this);
    privacySettings = EndpointPrivacySettings(this);
    pushDevice = EndpointPushDevice(this);
    review = EndpointReview(this);
    scriptConversion = EndpointScriptConversion(this);
    social = EndpointSocial(this);
    subtitle = EndpointSubtitle(this);
    video = EndpointVideo(this);
    wordList = EndpointWordList(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointUserProfileEdit userProfileEdit;

  late final EndpointAdmin admin;

  late final EndpointAdminMembership adminMembership;

  late final EndpointComment comment;

  late final EndpointDictionary dictionary;

  late final EndpointDictionaryImport dictionaryImport;

  late final EndpointKnownEntry knownEntry;

  late final EndpointNotification notification;

  late final EndpointNotificationSettings notificationSettings;

  late final EndpointPrivacySettings privacySettings;

  late final EndpointPushDevice pushDevice;

  late final EndpointReview review;

  late final EndpointScriptConversion scriptConversion;

  late final EndpointSocial social;

  late final EndpointSubtitle subtitle;

  late final EndpointVideo video;

  late final EndpointWordList wordList;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'userProfileEdit': userProfileEdit,
    'admin': admin,
    'adminMembership': adminMembership,
    'comment': comment,
    'dictionary': dictionary,
    'dictionaryImport': dictionaryImport,
    'knownEntry': knownEntry,
    'notification': notification,
    'notificationSettings': notificationSettings,
    'privacySettings': privacySettings,
    'pushDevice': pushDevice,
    'review': review,
    'scriptConversion': scriptConversion,
    'social': social,
    'subtitle': subtitle,
    'video': video,
    'wordList': wordList,
    'greeting': greeting,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
