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

import 'package:serverpod/serverpod.dart' as _i1;
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../auth/user_profile_edit_endpoint.dart' as _i4;
import '../endpoints/admin_endpoint.dart' as _i5;
import '../endpoints/admin_membership_endpoint.dart' as _i6;
import '../endpoints/comment_endpoint.dart' as _i7;
import '../endpoints/dictionary_endpoint.dart' as _i8;
import '../endpoints/dictionary_import_endpoint.dart' as _i9;
import '../endpoints/known_entry_endpoint.dart' as _i10;
import '../endpoints/notification_endpoint.dart' as _i11;
import '../endpoints/notification_settings_endpoint.dart' as _i12;
import '../endpoints/privacy_settings_endpoint.dart' as _i13;
import '../endpoints/push_device_endpoint.dart' as _i14;
import '../endpoints/review_endpoint.dart' as _i15;
import '../endpoints/script_conversion_endpoint.dart' as _i16;
import '../endpoints/social_endpoint.dart' as _i17;
import '../endpoints/subtitle_endpoint.dart' as _i18;
import '../endpoints/video_endpoint.dart' as _i19;
import '../endpoints/word_list_endpoint.dart' as _i20;
import '../greetings/greeting_endpoint.dart' as _i21;
import 'dart:typed_data' as _i22;
import 'package:glyphora_backend_server/src/generated/asr_job_status.dart'
    as _i23;
import 'package:glyphora_backend_server/src/generated/knowledge_state_query.dart'
    as _i24;
import 'package:glyphora_backend_server/src/generated/subtitle_karaoke_segment_input.dart'
    as _i25;
import 'package:glyphora_backend_server/src/generated/video_content_type.dart'
    as _i26;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i27;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i28;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'userProfileEdit': _i4.UserProfileEditEndpoint()
        ..initialize(
          server,
          'userProfileEdit',
          null,
        ),
      'admin': _i5.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'adminMembership': _i6.AdminMembershipEndpoint()
        ..initialize(
          server,
          'adminMembership',
          null,
        ),
      'comment': _i7.CommentEndpoint()
        ..initialize(
          server,
          'comment',
          null,
        ),
      'dictionary': _i8.DictionaryEndpoint()
        ..initialize(
          server,
          'dictionary',
          null,
        ),
      'dictionaryImport': _i9.DictionaryImportEndpoint()
        ..initialize(
          server,
          'dictionaryImport',
          null,
        ),
      'knownEntry': _i10.KnownEntryEndpoint()
        ..initialize(
          server,
          'knownEntry',
          null,
        ),
      'notification': _i11.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'notificationSettings': _i12.NotificationSettingsEndpoint()
        ..initialize(
          server,
          'notificationSettings',
          null,
        ),
      'privacySettings': _i13.PrivacySettingsEndpoint()
        ..initialize(
          server,
          'privacySettings',
          null,
        ),
      'pushDevice': _i14.PushDeviceEndpoint()
        ..initialize(
          server,
          'pushDevice',
          null,
        ),
      'review': _i15.ReviewEndpoint()
        ..initialize(
          server,
          'review',
          null,
        ),
      'scriptConversion': _i16.ScriptConversionEndpoint()
        ..initialize(
          server,
          'scriptConversion',
          null,
        ),
      'social': _i17.SocialEndpoint()
        ..initialize(
          server,
          'social',
          null,
        ),
      'subtitle': _i18.SubtitleEndpoint()
        ..initialize(
          server,
          'subtitle',
          null,
        ),
      'video': _i19.VideoEndpoint()
        ..initialize(
          server,
          'video',
          null,
        ),
      'wordList': _i20.WordListEndpoint()
        ..initialize(
          server,
          'wordList',
          null,
        ),
      'greeting': _i21.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['userProfileEdit'] = _i1.EndpointConnector(
      name: 'userProfileEdit',
      endpoint: endpoints['userProfileEdit']!,
      methodConnectors: {
        'removeUserImage': _i1.MethodConnector(
          name: 'removeUserImage',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileEdit'] as _i4.UserProfileEditEndpoint)
                      .removeUserImage(session),
        ),
        'setUserImage': _i1.MethodConnector(
          name: 'setUserImage',
          params: {
            'image': _i1.ParameterDescription(
              name: 'image',
              type: _i1.getType<_i22.ByteData>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileEdit'] as _i4.UserProfileEditEndpoint)
                      .setUserImage(
                        session,
                        params['image'],
                      ),
        ),
        'changeUserName': _i1.MethodConnector(
          name: 'changeUserName',
          params: {
            'userName': _i1.ParameterDescription(
              name: 'userName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileEdit'] as _i4.UserProfileEditEndpoint)
                      .changeUserName(
                        session,
                        params['userName'],
                      ),
        ),
        'changeFullName': _i1.MethodConnector(
          name: 'changeFullName',
          params: {
            'fullName': _i1.ParameterDescription(
              name: 'fullName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileEdit'] as _i4.UserProfileEditEndpoint)
                      .changeFullName(
                        session,
                        params['fullName'],
                      ),
        ),
        'get': _i1.MethodConnector(
          name: 'get',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfileEdit'] as _i4.UserProfileEditEndpoint)
                      .get(session),
        ),
      },
    );
    connectors['admin'] = _i1.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'ping': _i1.MethodConnector(
          name: 'ping',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i5.AdminEndpoint).ping(session),
        ),
        'getUserEmails': _i1.MethodConnector(
          name: 'getUserEmails',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i5.AdminEndpoint)
                  .getUserEmails(session),
        ),
        'getAsrJobs': _i1.MethodConnector(
          name: 'getAsrJobs',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i23.AsrJobStatus?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i5.AdminEndpoint).getAsrJobs(
                session,
                status: params['status'],
              ),
        ),
        'retryVideoAsr': _i1.MethodConnector(
          name: 'retryVideoAsr',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i5.AdminEndpoint).retryVideoAsr(
                    session,
                    videoId: params['videoId'],
                    languageCode: params['languageCode'],
                  ),
        ),
        'getAllVideos': _i1.MethodConnector(
          name: 'getAllVideos',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i5.AdminEndpoint).getAllVideos(
                session,
              ),
        ),
        'getVideosWithSubtitles': _i1.MethodConnector(
          name: 'getVideosWithSubtitles',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i5.AdminEndpoint)
                  .getVideosWithSubtitles(session),
        ),
        'getSubtitleTracks': _i1.MethodConnector(
          name: 'getSubtitleTracks',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i5.AdminEndpoint).getSubtitleTracks(
                    session,
                    videoId: params['videoId'],
                  ),
        ),
      },
    );
    connectors['adminMembership'] = _i1.EndpointConnector(
      name: 'adminMembership',
      endpoint: endpoints['adminMembership']!,
      methodConnectors: {
        'getWorkspace': _i1.MethodConnector(
          name: 'getWorkspace',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminMembership'] as _i6.AdminMembershipEndpoint)
                      .getWorkspace(session),
        ),
        'listMembers': _i1.MethodConnector(
          name: 'listMembers',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminMembership'] as _i6.AdminMembershipEndpoint)
                      .listMembers(session),
        ),
        'listRoles': _i1.MethodConnector(
          name: 'listRoles',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminMembership'] as _i6.AdminMembershipEndpoint)
                      .listRoles(session),
        ),
        'listPermissions': _i1.MethodConnector(
          name: 'listPermissions',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminMembership'] as _i6.AdminMembershipEndpoint)
                      .listPermissions(session),
        ),
        'listRolePermissions': _i1.MethodConnector(
          name: 'listRolePermissions',
          params: {
            'roleId': _i1.ParameterDescription(
              name: 'roleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminMembership'] as _i6.AdminMembershipEndpoint)
                      .listRolePermissions(
                        session,
                        roleId: params['roleId'],
                      ),
        ),
        'addMemberByEmail': _i1.MethodConnector(
          name: 'addMemberByEmail',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'roleId': _i1.ParameterDescription(
              name: 'roleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminMembership'] as _i6.AdminMembershipEndpoint)
                      .addMemberByEmail(
                        session,
                        email: params['email'],
                        roleId: params['roleId'],
                      ),
        ),
        'updateMemberRole': _i1.MethodConnector(
          name: 'updateMemberRole',
          params: {
            'memberId': _i1.ParameterDescription(
              name: 'memberId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'roleId': _i1.ParameterDescription(
              name: 'roleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminMembership'] as _i6.AdminMembershipEndpoint)
                      .updateMemberRole(
                        session,
                        memberId: params['memberId'],
                        roleId: params['roleId'],
                      ),
        ),
        'removeMember': _i1.MethodConnector(
          name: 'removeMember',
          params: {
            'memberId': _i1.ParameterDescription(
              name: 'memberId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminMembership'] as _i6.AdminMembershipEndpoint)
                      .removeMember(
                        session,
                        memberId: params['memberId'],
                      ),
        ),
        'transferOwnership': _i1.MethodConnector(
          name: 'transferOwnership',
          params: {
            'newOwnerMemberId': _i1.ParameterDescription(
              name: 'newOwnerMemberId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminMembership'] as _i6.AdminMembershipEndpoint)
                      .transferOwnership(
                        session,
                        newOwnerMemberId: params['newOwnerMemberId'],
                      ),
        ),
        'setRolePermissions': _i1.MethodConnector(
          name: 'setRolePermissions',
          params: {
            'roleId': _i1.ParameterDescription(
              name: 'roleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'permissionCodes': _i1.ParameterDescription(
              name: 'permissionCodes',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminMembership'] as _i6.AdminMembershipEndpoint)
                      .setRolePermissions(
                        session,
                        roleId: params['roleId'],
                        permissionCodes: params['permissionCodes'],
                      ),
        ),
      },
    );
    connectors['comment'] = _i1.EndpointConnector(
      name: 'comment',
      endpoint: endpoints['comment']!,
      methodConnectors: {
        'loadComments': _i1.MethodConnector(
          name: 'loadComments',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['comment'] as _i7.CommentEndpoint).loadComments(
                    session,
                    videoId: params['videoId'],
                    page: params['page'],
                    limit: params['limit'],
                  ),
        ),
        'createComment': _i1.MethodConnector(
          name: 'createComment',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userName': _i1.ParameterDescription(
              name: 'userName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['comment'] as _i7.CommentEndpoint).createComment(
                    session,
                    videoId: params['videoId'],
                    userName: params['userName'],
                    content: params['content'],
                  ),
        ),
        'createReply': _i1.MethodConnector(
          name: 'createReply',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'commentId': _i1.ParameterDescription(
              name: 'commentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userName': _i1.ParameterDescription(
              name: 'userName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['comment'] as _i7.CommentEndpoint).createReply(
                    session,
                    videoId: params['videoId'],
                    commentId: params['commentId'],
                    userName: params['userName'],
                    content: params['content'],
                  ),
        ),
        'toggleCommentLike': _i1.MethodConnector(
          name: 'toggleCommentLike',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'commentId': _i1.ParameterDescription(
              name: 'commentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['comment'] as _i7.CommentEndpoint)
                  .toggleCommentLike(
                    session,
                    videoId: params['videoId'],
                    commentId: params['commentId'],
                  ),
        ),
        'toggleReplyLike': _i1.MethodConnector(
          name: 'toggleReplyLike',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'commentId': _i1.ParameterDescription(
              name: 'commentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'replyId': _i1.ParameterDescription(
              name: 'replyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['comment'] as _i7.CommentEndpoint).toggleReplyLike(
                    session,
                    videoId: params['videoId'],
                    commentId: params['commentId'],
                    replyId: params['replyId'],
                  ),
        ),
        'deleteManagedComment': _i1.MethodConnector(
          name: 'deleteManagedComment',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'commentId': _i1.ParameterDescription(
              name: 'commentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['comment'] as _i7.CommentEndpoint)
                  .deleteManagedComment(
                    session,
                    videoId: params['videoId'],
                    commentId: params['commentId'],
                  ),
        ),
        'deleteManagedReply': _i1.MethodConnector(
          name: 'deleteManagedReply',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'commentId': _i1.ParameterDescription(
              name: 'commentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'replyId': _i1.ParameterDescription(
              name: 'replyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['comment'] as _i7.CommentEndpoint)
                  .deleteManagedReply(
                    session,
                    videoId: params['videoId'],
                    commentId: params['commentId'],
                    replyId: params['replyId'],
                  ),
        ),
      },
    );
    connectors['dictionary'] = _i1.EndpointConnector(
      name: 'dictionary',
      endpoint: endpoints['dictionary']!,
      methodConnectors: {
        'lookup': _i1.MethodConnector(
          name: 'lookup',
          params: {
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'normalizedText': _i1.ParameterDescription(
              name: 'normalizedText',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'entryType': _i1.ParameterDescription(
              name: 'entryType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'explanationLanguageCode': _i1.ParameterDescription(
              name: 'explanationLanguageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dictionary'] as _i8.DictionaryEndpoint).lookup(
                    session,
                    languageCode: params['languageCode'],
                    normalizedText: params['normalizedText'],
                    entryType: params['entryType'],
                    explanationLanguageCode: params['explanationLanguageCode'],
                  ),
        ),
        'getById': _i1.MethodConnector(
          name: 'getById',
          params: {
            'entryId': _i1.ParameterDescription(
              name: 'entryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'explanationLanguageCode': _i1.ParameterDescription(
              name: 'explanationLanguageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dictionary'] as _i8.DictionaryEndpoint).getById(
                    session,
                    entryId: params['entryId'],
                    explanationLanguageCode: params['explanationLanguageCode'],
                  ),
        ),
        'listEntries': _i1.MethodConnector(
          name: 'listEntries',
          params: {
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dictionary'] as _i8.DictionaryEndpoint)
                  .listEntries(
                    session,
                    languageCode: params['languageCode'],
                    offset: params['offset'],
                    limit: params['limit'],
                  ),
        ),
        'updateEntryRow': _i1.MethodConnector(
          name: 'updateEntryRow',
          params: {
            'entryId': _i1.ParameterDescription(
              name: 'entryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'headword': _i1.ParameterDescription(
              name: 'headword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'nomText': _i1.ParameterDescription(
              name: 'nomText',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'chineseGloss': _i1.ParameterDescription(
              name: 'chineseGloss',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'partOfSpeech': _i1.ParameterDescription(
              name: 'partOfSpeech',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'vietnameseExample': _i1.ParameterDescription(
              name: 'vietnameseExample',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'nomExample': _i1.ParameterDescription(
              name: 'nomExample',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'chineseExample': _i1.ParameterDescription(
              name: 'chineseExample',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dictionary'] as _i8.DictionaryEndpoint)
                  .updateEntryRow(
                    session,
                    entryId: params['entryId'],
                    headword: params['headword'],
                    nomText: params['nomText'],
                    chineseGloss: params['chineseGloss'],
                    partOfSpeech: params['partOfSpeech'],
                    vietnameseExample: params['vietnameseExample'],
                    nomExample: params['nomExample'],
                    chineseExample: params['chineseExample'],
                  ),
        ),
      },
    );
    connectors['dictionaryImport'] = _i1.EndpointConnector(
      name: 'dictionaryImport',
      endpoint: endpoints['dictionaryImport']!,
      methodConnectors: {
        'getProfiles': _i1.MethodConnector(
          name: 'getProfiles',
          params: {
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dictionaryImport']
                          as _i9.DictionaryImportEndpoint)
                      .getProfiles(
                        session,
                        languageCode: params['languageCode'],
                      ),
        ),
        'getProfile': _i1.MethodConnector(
          name: 'getProfile',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dictionaryImport']
                          as _i9.DictionaryImportEndpoint)
                      .getProfile(
                        session,
                        profileId: params['profileId'],
                      ),
        ),
        'createVietnameseVocabularyProfile': _i1.MethodConnector(
          name: 'createVietnameseVocabularyProfile',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dictionaryImport']
                          as _i9.DictionaryImportEndpoint)
                      .createVietnameseVocabularyProfile(session),
        ),
        'previewRows': _i1.MethodConnector(
          name: 'previewRows',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'rowsJson': _i1.ParameterDescription(
              name: 'rowsJson',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dictionaryImport']
                          as _i9.DictionaryImportEndpoint)
                      .previewRows(
                        session,
                        profileId: params['profileId'],
                        rowsJson: params['rowsJson'],
                      ),
        ),
        'previewExcelBase64': _i1.MethodConnector(
          name: 'previewExcelBase64',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'excelBase64': _i1.ParameterDescription(
              name: 'excelBase64',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dictionaryImport']
                          as _i9.DictionaryImportEndpoint)
                      .previewExcelBase64(
                        session,
                        profileId: params['profileId'],
                        excelBase64: params['excelBase64'],
                      ),
        ),
        'commitExcelBase64': _i1.MethodConnector(
          name: 'commitExcelBase64',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'excelBase64': _i1.ParameterDescription(
              name: 'excelBase64',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dictionaryImport']
                          as _i9.DictionaryImportEndpoint)
                      .commitExcelBase64(
                        session,
                        profileId: params['profileId'],
                        excelBase64: params['excelBase64'],
                      ),
        ),
      },
    );
    connectors['knownEntry'] = _i1.EndpointConnector(
      name: 'knownEntry',
      endpoint: endpoints['knownEntry']!,
      methodConnectors: {
        'getKnownEntryIds': _i1.MethodConnector(
          name: 'getKnownEntryIds',
          params: {
            'entryIds': _i1.ParameterDescription(
              name: 'entryIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['knownEntry'] as _i10.KnownEntryEndpoint)
                  .getKnownEntryIds(
                    session,
                    entryIds: params['entryIds'],
                  ),
        ),
        'setKnown': _i1.MethodConnector(
          name: 'setKnown',
          params: {
            'entryId': _i1.ParameterDescription(
              name: 'entryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'known': _i1.ParameterDescription(
              name: 'known',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['knownEntry'] as _i10.KnownEntryEndpoint).setKnown(
                    session,
                    entryId: params['entryId'],
                    known: params['known'],
                  ),
        ),
        'getKnowledgeStatesByEntryIds': _i1.MethodConnector(
          name: 'getKnowledgeStatesByEntryIds',
          params: {
            'entryIds': _i1.ParameterDescription(
              name: 'entryIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['knownEntry'] as _i10.KnownEntryEndpoint)
                  .getKnowledgeStatesByEntryIds(
                    session,
                    entryIds: params['entryIds'],
                  ),
        ),
        'getKnowledgeState': _i1.MethodConnector(
          name: 'getKnowledgeState',
          params: {
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'normalizedText': _i1.ParameterDescription(
              name: 'normalizedText',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'entryType': _i1.ParameterDescription(
              name: 'entryType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['knownEntry'] as _i10.KnownEntryEndpoint)
                  .getKnowledgeState(
                    session,
                    languageCode: params['languageCode'],
                    normalizedText: params['normalizedText'],
                    entryType: params['entryType'],
                  ),
        ),
        'getKnowledgeStates': _i1.MethodConnector(
          name: 'getKnowledgeStates',
          params: {
            'queries': _i1.ParameterDescription(
              name: 'queries',
              type: _i1.getType<List<_i24.KnowledgeStateQuery>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['knownEntry'] as _i10.KnownEntryEndpoint)
                  .getKnowledgeStates(
                    session,
                    queries: params['queries'],
                  ),
        ),
      },
    );
    connectors['notification'] = _i1.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
        'list': _i1.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i11.NotificationEndpoint).list(
                    session,
                  ),
        ),
        'markAsRead': _i1.MethodConnector(
          name: 'markAsRead',
          params: {
            'notificationId': _i1.ParameterDescription(
              name: 'notificationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i11.NotificationEndpoint)
                      .markAsRead(
                        session,
                        params['notificationId'],
                      ),
        ),
        'markAllAsRead': _i1.MethodConnector(
          name: 'markAllAsRead',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notification'] as _i11.NotificationEndpoint)
                      .markAllAsRead(session),
        ),
      },
    );
    connectors['notificationSettings'] = _i1.EndpointConnector(
      name: 'notificationSettings',
      endpoint: endpoints['notificationSettings']!,
      methodConnectors: {
        'get': _i1.MethodConnector(
          name: 'get',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationSettings']
                          as _i12.NotificationSettingsEndpoint)
                      .get(session),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'pushEnabled': _i1.ParameterDescription(
              name: 'pushEnabled',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'likeEnabled': _i1.ParameterDescription(
              name: 'likeEnabled',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'commentEnabled': _i1.ParameterDescription(
              name: 'commentEnabled',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'followEnabled': _i1.ParameterDescription(
              name: 'followEnabled',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['notificationSettings']
                          as _i12.NotificationSettingsEndpoint)
                      .update(
                        session,
                        pushEnabled: params['pushEnabled'],
                        likeEnabled: params['likeEnabled'],
                        commentEnabled: params['commentEnabled'],
                        followEnabled: params['followEnabled'],
                      ),
        ),
      },
    );
    connectors['privacySettings'] = _i1.EndpointConnector(
      name: 'privacySettings',
      endpoint: endpoints['privacySettings']!,
      methodConnectors: {
        'get': _i1.MethodConnector(
          name: 'get',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['privacySettings'] as _i13.PrivacySettingsEndpoint)
                      .get(session),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'privateAccount': _i1.ParameterDescription(
              name: 'privateAccount',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'allowComments': _i1.ParameterDescription(
              name: 'allowComments',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'showActivityStatus': _i1.ParameterDescription(
              name: 'showActivityStatus',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['privacySettings'] as _i13.PrivacySettingsEndpoint)
                      .update(
                        session,
                        privateAccount: params['privateAccount'],
                        allowComments: params['allowComments'],
                        showActivityStatus: params['showActivityStatus'],
                      ),
        ),
      },
    );
    connectors['pushDevice'] = _i1.EndpointConnector(
      name: 'pushDevice',
      endpoint: endpoints['pushDevice']!,
      methodConnectors: {
        'register': _i1.MethodConnector(
          name: 'register',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'platform': _i1.ParameterDescription(
              name: 'platform',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['pushDevice'] as _i14.PushDeviceEndpoint).register(
                    session,
                    token: params['token'],
                    platform: params['platform'],
                    languageCode: params['languageCode'],
                  ),
        ),
        'unregister': _i1.MethodConnector(
          name: 'unregister',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['pushDevice'] as _i14.PushDeviceEndpoint)
                  .unregister(
                    session,
                    token: params['token'],
                  ),
        ),
      },
    );
    connectors['review'] = _i1.EndpointConnector(
      name: 'review',
      endpoint: endpoints['review']!,
      methodConnectors: {
        'getDashboard': _i1.MethodConnector(
          name: 'getDashboard',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['review'] as _i15.ReviewEndpoint)
                  .getDashboard(session),
        ),
        'getTaskDetail': _i1.MethodConnector(
          name: 'getTaskDetail',
          params: {
            'taskId': _i1.ParameterDescription(
              name: 'taskId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['review'] as _i15.ReviewEndpoint).getTaskDetail(
                    session,
                    taskId: params['taskId'],
                  ),
        ),
        'generateVietnameseNomDraft': _i1.MethodConnector(
          name: 'generateVietnameseNomDraft',
          params: {
            'trackId': _i1.ParameterDescription(
              name: 'trackId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['review'] as _i15.ReviewEndpoint)
                  .generateVietnameseNomDraft(
                    session,
                    trackId: params['trackId'],
                  ),
        ),
        'claimTask': _i1.MethodConnector(
          name: 'claimTask',
          params: {
            'taskId': _i1.ParameterDescription(
              name: 'taskId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['review'] as _i15.ReviewEndpoint).claimTask(
                session,
                taskId: params['taskId'],
              ),
        ),
        'startTask': _i1.MethodConnector(
          name: 'startTask',
          params: {
            'taskId': _i1.ParameterDescription(
              name: 'taskId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['review'] as _i15.ReviewEndpoint).startTask(
                session,
                taskId: params['taskId'],
              ),
        ),
        'submitTask': _i1.MethodConnector(
          name: 'submitTask',
          params: {
            'taskId': _i1.ParameterDescription(
              name: 'taskId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['review'] as _i15.ReviewEndpoint).submitTask(
                    session,
                    taskId: params['taskId'],
                  ),
        ),
        'returnTask': _i1.MethodConnector(
          name: 'returnTask',
          params: {
            'taskId': _i1.ParameterDescription(
              name: 'taskId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'note': _i1.ParameterDescription(
              name: 'note',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['review'] as _i15.ReviewEndpoint).returnTask(
                    session,
                    taskId: params['taskId'],
                    note: params['note'],
                  ),
        ),
        'approveAndPublish': _i1.MethodConnector(
          name: 'approveAndPublish',
          params: {
            'taskId': _i1.ParameterDescription(
              name: 'taskId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['review'] as _i15.ReviewEndpoint)
                  .approveAndPublish(
                    session,
                    taskId: params['taskId'],
                  ),
        ),
      },
    );
    connectors['scriptConversion'] = _i1.EndpointConnector(
      name: 'scriptConversion',
      endpoint: endpoints['scriptConversion']!,
      methodConnectors: {
        'listProfiles': _i1.MethodConnector(
          name: 'listProfiles',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scriptConversion']
                          as _i16.ScriptConversionEndpoint)
                      .listProfiles(session),
        ),
        'createProfile': _i1.MethodConnector(
          name: 'createProfile',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'sourceScriptCode': _i1.ParameterDescription(
              name: 'sourceScriptCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetScriptCode': _i1.ParameterDescription(
              name: 'targetScriptCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'sourceColumn': _i1.ParameterDescription(
              name: 'sourceColumn',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetColumn': _i1.ParameterDescription(
              name: 'targetColumn',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'sheetName': _i1.ParameterDescription(
              name: 'sheetName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'priorityColumn': _i1.ParameterDescription(
              name: 'priorityColumn',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'noteColumn': _i1.ParameterDescription(
              name: 'noteColumn',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'conversionMode': _i1.ParameterDescription(
              name: 'conversionMode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'typeColumn': _i1.ParameterDescription(
              name: 'typeColumn',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scriptConversion']
                          as _i16.ScriptConversionEndpoint)
                      .createProfile(
                        session,
                        name: params['name'],
                        languageCode: params['languageCode'],
                        sourceScriptCode: params['sourceScriptCode'],
                        targetScriptCode: params['targetScriptCode'],
                        sourceColumn: params['sourceColumn'],
                        targetColumn: params['targetColumn'],
                        sheetName: params['sheetName'],
                        priorityColumn: params['priorityColumn'],
                        noteColumn: params['noteColumn'],
                        conversionMode: params['conversionMode'],
                        typeColumn: params['typeColumn'],
                        description: params['description'],
                      ),
        ),
        'updateProfile': _i1.MethodConnector(
          name: 'updateProfile',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'sourceScriptCode': _i1.ParameterDescription(
              name: 'sourceScriptCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetScriptCode': _i1.ParameterDescription(
              name: 'targetScriptCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'sourceColumn': _i1.ParameterDescription(
              name: 'sourceColumn',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetColumn': _i1.ParameterDescription(
              name: 'targetColumn',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'sheetName': _i1.ParameterDescription(
              name: 'sheetName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'priorityColumn': _i1.ParameterDescription(
              name: 'priorityColumn',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'noteColumn': _i1.ParameterDescription(
              name: 'noteColumn',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'conversionMode': _i1.ParameterDescription(
              name: 'conversionMode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'typeColumn': _i1.ParameterDescription(
              name: 'typeColumn',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scriptConversion']
                          as _i16.ScriptConversionEndpoint)
                      .updateProfile(
                        session,
                        profileId: params['profileId'],
                        name: params['name'],
                        languageCode: params['languageCode'],
                        sourceScriptCode: params['sourceScriptCode'],
                        targetScriptCode: params['targetScriptCode'],
                        sourceColumn: params['sourceColumn'],
                        targetColumn: params['targetColumn'],
                        sheetName: params['sheetName'],
                        priorityColumn: params['priorityColumn'],
                        noteColumn: params['noteColumn'],
                        conversionMode: params['conversionMode'],
                        typeColumn: params['typeColumn'],
                        description: params['description'],
                      ),
        ),
        'deleteProfile': _i1.MethodConnector(
          name: 'deleteProfile',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scriptConversion']
                          as _i16.ScriptConversionEndpoint)
                      .deleteProfile(
                        session,
                        profileId: params['profileId'],
                      ),
        ),
        'listEntries': _i1.MethodConnector(
          name: 'listEntries',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scriptConversion']
                          as _i16.ScriptConversionEndpoint)
                      .listEntries(
                        session,
                        profileId: params['profileId'],
                        limit: params['limit'],
                      ),
        ),
        'updateEntry': _i1.MethodConnector(
          name: 'updateEntry',
          params: {
            'entryId': _i1.ParameterDescription(
              name: 'entryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'sourceText': _i1.ParameterDescription(
              name: 'sourceText',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetText': _i1.ParameterDescription(
              name: 'targetText',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'priority': _i1.ParameterDescription(
              name: 'priority',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'note': _i1.ParameterDescription(
              name: 'note',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'entryType': _i1.ParameterDescription(
              name: 'entryType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scriptConversion']
                          as _i16.ScriptConversionEndpoint)
                      .updateEntry(
                        session,
                        entryId: params['entryId'],
                        sourceText: params['sourceText'],
                        targetText: params['targetText'],
                        priority: params['priority'],
                        note: params['note'],
                        entryType: params['entryType'],
                      ),
        ),
        'deleteEntry': _i1.MethodConnector(
          name: 'deleteEntry',
          params: {
            'entryId': _i1.ParameterDescription(
              name: 'entryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scriptConversion']
                          as _i16.ScriptConversionEndpoint)
                      .deleteEntry(
                        session,
                        entryId: params['entryId'],
                      ),
        ),
        'previewExcelBase64': _i1.MethodConnector(
          name: 'previewExcelBase64',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'excelBase64': _i1.ParameterDescription(
              name: 'excelBase64',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scriptConversion']
                          as _i16.ScriptConversionEndpoint)
                      .previewExcelBase64(
                        session,
                        profileId: params['profileId'],
                        excelBase64: params['excelBase64'],
                      ),
        ),
        'commitExcelBase64': _i1.MethodConnector(
          name: 'commitExcelBase64',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'excelBase64': _i1.ParameterDescription(
              name: 'excelBase64',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scriptConversion']
                          as _i16.ScriptConversionEndpoint)
                      .commitExcelBase64(
                        session,
                        profileId: params['profileId'],
                        excelBase64: params['excelBase64'],
                      ),
        ),
        'testConvert': _i1.MethodConnector(
          name: 'testConvert',
          params: {
            'profileId': _i1.ParameterDescription(
              name: 'profileId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'text': _i1.ParameterDescription(
              name: 'text',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'reverse': _i1.ParameterDescription(
              name: 'reverse',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scriptConversion']
                          as _i16.ScriptConversionEndpoint)
                      .testConvert(
                        session,
                        profileId: params['profileId'],
                        text: params['text'],
                        reverse: params['reverse'],
                      ),
        ),
      },
    );
    connectors['social'] = _i1.EndpointConnector(
      name: 'social',
      endpoint: endpoints['social']!,
      methodConnectors: {
        'getMyProfileStats': _i1.MethodConnector(
          name: 'getMyProfileStats',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['social'] as _i17.SocialEndpoint)
                  .getMyProfileStats(session),
        ),
        'getProfileStats': _i1.MethodConnector(
          name: 'getProfileStats',
          params: {
            'creatorId': _i1.ParameterDescription(
              name: 'creatorId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['social'] as _i17.SocialEndpoint).getProfileStats(
                    session,
                    params['creatorId'],
                  ),
        ),
        'updateBio': _i1.MethodConnector(
          name: 'updateBio',
          params: {
            'bio': _i1.ParameterDescription(
              name: 'bio',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['social'] as _i17.SocialEndpoint).updateBio(
                session,
                params['bio'],
              ),
        ),
        'isFollowing': _i1.MethodConnector(
          name: 'isFollowing',
          params: {
            'creatorId': _i1.ParameterDescription(
              name: 'creatorId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['social'] as _i17.SocialEndpoint).isFollowing(
                    session,
                    params['creatorId'],
                  ),
        ),
        'toggleFollow': _i1.MethodConnector(
          name: 'toggleFollow',
          params: {
            'creatorId': _i1.ParameterDescription(
              name: 'creatorId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'actorName': _i1.ParameterDescription(
              name: 'actorName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['social'] as _i17.SocialEndpoint).toggleFollow(
                    session,
                    params['creatorId'],
                    actorName: params['actorName'],
                  ),
        ),
        'getFollowingCreatorIds': _i1.MethodConnector(
          name: 'getFollowingCreatorIds',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['social'] as _i17.SocialEndpoint)
                  .getFollowingCreatorIds(session),
        ),
        'getFollowerIds': _i1.MethodConnector(
          name: 'getFollowerIds',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['social'] as _i17.SocialEndpoint)
                  .getFollowerIds(session),
        ),
        'toggleFavorite': _i1.MethodConnector(
          name: 'toggleFavorite',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['social'] as _i17.SocialEndpoint).toggleFavorite(
                    session,
                    params['videoId'],
                  ),
        ),
        'getFavoriteVideoIds': _i1.MethodConnector(
          name: 'getFavoriteVideoIds',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['social'] as _i17.SocialEndpoint)
                  .getFavoriteVideoIds(session),
        ),
        'toggleLike': _i1.MethodConnector(
          name: 'toggleLike',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'actorName': _i1.ParameterDescription(
              name: 'actorName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['social'] as _i17.SocialEndpoint).toggleLike(
                    session,
                    params['videoId'],
                    actorName: params['actorName'],
                  ),
        ),
        'getLikedVideoIds': _i1.MethodConnector(
          name: 'getLikedVideoIds',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['social'] as _i17.SocialEndpoint)
                  .getLikedVideoIds(session),
        ),
        'getWatchHistory': _i1.MethodConnector(
          name: 'getWatchHistory',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['social'] as _i17.SocialEndpoint)
                  .getWatchHistory(session),
        ),
        'saveWatchProgress': _i1.MethodConnector(
          name: 'saveWatchProgress',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'positionSeconds': _i1.ParameterDescription(
              name: 'positionSeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['social'] as _i17.SocialEndpoint)
                  .saveWatchProgress(
                    session,
                    params['videoId'],
                    params['positionSeconds'],
                  ),
        ),
        'removeWatchHistory': _i1.MethodConnector(
          name: 'removeWatchHistory',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['social'] as _i17.SocialEndpoint)
                  .removeWatchHistory(
                    session,
                    params['videoId'],
                  ),
        ),
        'clearWatchHistory': _i1.MethodConnector(
          name: 'clearWatchHistory',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['social'] as _i17.SocialEndpoint)
                  .clearWatchHistory(session),
        ),
        'searchExistingUserProfiles': _i1.MethodConnector(
          name: 'searchExistingUserProfiles',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['social'] as _i17.SocialEndpoint)
                  .searchExistingUserProfiles(
                    session,
                    params['query'],
                    limit: params['limit'],
                  ),
        ),
        'getExistingUserProfile': _i1.MethodConnector(
          name: 'getExistingUserProfile',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['social'] as _i17.SocialEndpoint)
                  .getExistingUserProfile(
                    session,
                    params['userId'],
                  ),
        ),
      },
    );
    connectors['subtitle'] = _i1.EndpointConnector(
      name: 'subtitle',
      endpoint: endpoints['subtitle']!,
      methodConnectors: {
        'searchPublishedCues': _i1.MethodConnector(
          name: 'searchPublishedCues',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtitle'] as _i18.SubtitleEndpoint)
                  .searchPublishedCues(
                    session,
                    query: params['query'],
                    limit: params['limit'],
                  ),
        ),
        'getCueDetails': _i1.MethodConnector(
          name: 'getCueDetails',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'scriptCode': _i1.ParameterDescription(
              name: 'scriptCode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtitle'] as _i18.SubtitleEndpoint)
                  .getCueDetails(
                    session,
                    videoId: params['videoId'],
                    languageCode: params['languageCode'],
                    scriptCode: params['scriptCode'],
                  ),
        ),
        'getPublishedCueDetails': _i1.MethodConnector(
          name: 'getPublishedCueDetails',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'scriptCode': _i1.ParameterDescription(
              name: 'scriptCode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtitle'] as _i18.SubtitleEndpoint)
                  .getPublishedCueDetails(
                    session,
                    videoId: params['videoId'],
                    languageCode: params['languageCode'],
                    scriptCode: params['scriptCode'],
                  ),
        ),
        'getPublishedAvailableTracks': _i1.MethodConnector(
          name: 'getPublishedAvailableTracks',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtitle'] as _i18.SubtitleEndpoint)
                  .getPublishedAvailableTracks(
                    session,
                    videoId: params['videoId'],
                  ),
        ),
        'getSubtitlePublishStatus': _i1.MethodConnector(
          name: 'getSubtitlePublishStatus',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtitle'] as _i18.SubtitleEndpoint)
                  .getSubtitlePublishStatus(
                    session,
                    videoId: params['videoId'],
                    languageCode: params['languageCode'],
                  ),
        ),
        'publishSubtitleTrack': _i1.MethodConnector(
          name: 'publishSubtitleTrack',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtitle'] as _i18.SubtitleEndpoint)
                  .publishSubtitleTrack(
                    session,
                    videoId: params['videoId'],
                    languageCode: params['languageCode'],
                  ),
        ),
        'getAvailableTracks': _i1.MethodConnector(
          name: 'getAvailableTracks',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtitle'] as _i18.SubtitleEndpoint)
                  .getAvailableTracks(
                    session,
                    videoId: params['videoId'],
                  ),
        ),
        'previewSrtImport': _i1.MethodConnector(
          name: 'previewSrtImport',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtitle'] as _i18.SubtitleEndpoint)
                  .previewSrtImport(
                    session,
                    videoId: params['videoId'],
                    languageCode: params['languageCode'],
                    content: params['content'],
                  ),
        ),
        'confirmReplaceSrtImport': _i1.MethodConnector(
          name: 'confirmReplaceSrtImport',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'scriptCode': _i1.ParameterDescription(
              name: 'scriptCode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtitle'] as _i18.SubtitleEndpoint)
                  .confirmReplaceSrtImport(
                    session,
                    videoId: params['videoId'],
                    languageCode: params['languageCode'],
                    content: params['content'],
                    scriptCode: params['scriptCode'],
                  ),
        ),
        'exportSrt': _i1.MethodConnector(
          name: 'exportSrt',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['subtitle'] as _i18.SubtitleEndpoint).exportSrt(
                    session,
                    videoId: params['videoId'],
                    languageCode: params['languageCode'],
                  ),
        ),
        'updateCueText': _i1.MethodConnector(
          name: 'updateCueText',
          params: {
            'cueId': _i1.ParameterDescription(
              name: 'cueId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'text': _i1.ParameterDescription(
              name: 'text',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'scriptCode': _i1.ParameterDescription(
              name: 'scriptCode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtitle'] as _i18.SubtitleEndpoint)
                  .updateCueText(
                    session,
                    cueId: params['cueId'],
                    text: params['text'],
                    scriptCode: params['scriptCode'],
                  ),
        ),
        'upsertCueScriptText': _i1.MethodConnector(
          name: 'upsertCueScriptText',
          params: {
            'cueId': _i1.ParameterDescription(
              name: 'cueId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'scriptCode': _i1.ParameterDescription(
              name: 'scriptCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'text': _i1.ParameterDescription(
              name: 'text',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isPrimary': _i1.ParameterDescription(
              name: 'isPrimary',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtitle'] as _i18.SubtitleEndpoint)
                  .upsertCueScriptText(
                    session,
                    cueId: params['cueId'],
                    scriptCode: params['scriptCode'],
                    text: params['text'],
                    isPrimary: params['isPrimary'],
                  ),
        ),
        'updateCueTiming': _i1.MethodConnector(
          name: 'updateCueTiming',
          params: {
            'cueId': _i1.ParameterDescription(
              name: 'cueId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'startMs': _i1.ParameterDescription(
              name: 'startMs',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'endMs': _i1.ParameterDescription(
              name: 'endMs',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtitle'] as _i18.SubtitleEndpoint)
                  .updateCueTiming(
                    session,
                    cueId: params['cueId'],
                    startMs: params['startMs'],
                    endMs: params['endMs'],
                  ),
        ),
        'createCue': _i1.MethodConnector(
          name: 'createCue',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'startMs': _i1.ParameterDescription(
              name: 'startMs',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'endMs': _i1.ParameterDescription(
              name: 'endMs',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'text': _i1.ParameterDescription(
              name: 'text',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'scriptCode': _i1.ParameterDescription(
              name: 'scriptCode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['subtitle'] as _i18.SubtitleEndpoint).createCue(
                    session,
                    videoId: params['videoId'],
                    languageCode: params['languageCode'],
                    startMs: params['startMs'],
                    endMs: params['endMs'],
                    text: params['text'],
                    scriptCode: params['scriptCode'],
                  ),
        ),
        'deleteCue': _i1.MethodConnector(
          name: 'deleteCue',
          params: {
            'cueId': _i1.ParameterDescription(
              name: 'cueId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['subtitle'] as _i18.SubtitleEndpoint).deleteCue(
                    session,
                    cueId: params['cueId'],
                  ),
        ),
        'replaceKaraokeSegments': _i1.MethodConnector(
          name: 'replaceKaraokeSegments',
          params: {
            'cueId': _i1.ParameterDescription(
              name: 'cueId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'segments': _i1.ParameterDescription(
              name: 'segments',
              type: _i1.getType<List<_i25.SubtitleKaraokeSegmentInput>>(),
              nullable: false,
            ),
            'scriptCode': _i1.ParameterDescription(
              name: 'scriptCode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtitle'] as _i18.SubtitleEndpoint)
                  .replaceKaraokeSegments(
                    session,
                    cueId: params['cueId'],
                    segments: params['segments'],
                    scriptCode: params['scriptCode'],
                  ),
        ),
      },
    );
    connectors['video'] = _i1.EndpointConnector(
      name: 'video',
      endpoint: endpoints['video']!,
      methodConnectors: {
        'getCurrentUserId': _i1.MethodConnector(
          name: 'getCurrentUserId',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['video'] as _i19.VideoEndpoint)
                  .getCurrentUserId(session),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'authorId': _i1.ParameterDescription(
              name: 'authorId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'authorName': _i1.ParameterDescription(
              name: 'authorName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'seriesTitle': _i1.ParameterDescription(
              name: 'seriesTitle',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'contentType': _i1.ParameterDescription(
              name: 'contentType',
              type: _i1.getType<_i26.VideoContentType>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'tags': _i1.ParameterDescription(
              name: 'tags',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
            'videoStorageKey': _i1.ParameterDescription(
              name: 'videoStorageKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'coverStorageKey': _i1.ParameterDescription(
              name: 'coverStorageKey',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'durationSeconds': _i1.ParameterDescription(
              name: 'durationSeconds',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isPublic': _i1.ParameterDescription(
              name: 'isPublic',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['video'] as _i19.VideoEndpoint).create(
                session,
                authorId: params['authorId'],
                authorName: params['authorName'],
                title: params['title'],
                description: params['description'],
                seriesTitle: params['seriesTitle'],
                category: params['category'],
                contentType: params['contentType'],
                languageCode: params['languageCode'],
                tags: params['tags'],
                videoStorageKey: params['videoStorageKey'],
                coverStorageKey: params['coverStorageKey'],
                durationSeconds: params['durationSeconds'],
                isPublic: params['isPublic'],
              ),
        ),
        'getVideos': _i1.MethodConnector(
          name: 'getVideos',
          params: {
            'contentType': _i1.ParameterDescription(
              name: 'contentType',
              type: _i1.getType<_i26.VideoContentType?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['video'] as _i19.VideoEndpoint).getVideos(
                session,
                contentType: params['contentType'],
              ),
        ),
        'getMyVideos': _i1.MethodConnector(
          name: 'getMyVideos',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['video'] as _i19.VideoEndpoint).getMyVideos(
                session,
              ),
        ),
        'getVideo': _i1.MethodConnector(
          name: 'getVideo',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['video'] as _i19.VideoEndpoint).getVideo(
                session,
                params['id'],
              ),
        ),
        'createSeries': _i1.MethodConnector(
          name: 'createSeries',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'coverStorageKey': _i1.ParameterDescription(
              name: 'coverStorageKey',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['video'] as _i19.VideoEndpoint).createSeries(
                    session,
                    title: params['title'],
                    description: params['description'],
                    coverStorageKey: params['coverStorageKey'],
                    languageCode: params['languageCode'],
                    category: params['category'],
                  ),
        ),
        'getCreatorSeries': _i1.MethodConnector(
          name: 'getCreatorSeries',
          params: {
            'creatorId': _i1.ParameterDescription(
              name: 'creatorId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['video'] as _i19.VideoEndpoint).getCreatorSeries(
                    session,
                    creatorId: params['creatorId'],
                  ),
        ),
        'getSeries': _i1.MethodConnector(
          name: 'getSeries',
          params: {
            'seriesId': _i1.ParameterDescription(
              name: 'seriesId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['video'] as _i19.VideoEndpoint).getSeries(
                session,
                seriesId: params['seriesId'],
              ),
        ),
        'getSeriesVideos': _i1.MethodConnector(
          name: 'getSeriesVideos',
          params: {
            'seriesId': _i1.ParameterDescription(
              name: 'seriesId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['video'] as _i19.VideoEndpoint).getSeriesVideos(
                    session,
                    seriesId: params['seriesId'],
                  ),
        ),
        'setSeriesById': _i1.MethodConnector(
          name: 'setSeriesById',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'seriesId': _i1.ParameterDescription(
              name: 'seriesId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['video'] as _i19.VideoEndpoint).setSeriesById(
                    session,
                    videoId: params['videoId'],
                    seriesId: params['seriesId'],
                  ),
        ),
        'recordView': _i1.MethodConnector(
          name: 'recordView',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['video'] as _i19.VideoEndpoint).recordView(
                session,
                videoId: params['videoId'],
              ),
        ),
        'recordEngagedView': _i1.MethodConnector(
          name: 'recordEngagedView',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['video'] as _i19.VideoEndpoint).recordEngagedView(
                    session,
                    videoId: params['videoId'],
                  ),
        ),
        'setSeries': _i1.MethodConnector(
          name: 'setSeries',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'seriesTitle': _i1.ParameterDescription(
              name: 'seriesTitle',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['video'] as _i19.VideoEndpoint).setSeries(
                session,
                videoId: params['videoId'],
                seriesTitle: params['seriesTitle'],
              ),
        ),
        'reorderSeriesVideos': _i1.MethodConnector(
          name: 'reorderSeriesVideos',
          params: {
            'seriesId': _i1.ParameterDescription(
              name: 'seriesId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'videoIds': _i1.ParameterDescription(
              name: 'videoIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['video'] as _i19.VideoEndpoint)
                  .reorderSeriesVideos(
                    session,
                    seriesId: params['seriesId'],
                    videoIds: params['videoIds'],
                  ),
        ),
        'updateMetadata': _i1.MethodConnector(
          name: 'updateMetadata',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'languageCode': _i1.ParameterDescription(
              name: 'languageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'tags': _i1.ParameterDescription(
              name: 'tags',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
            'isPublic': _i1.ParameterDescription(
              name: 'isPublic',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['video'] as _i19.VideoEndpoint).updateMetadata(
                    session,
                    videoId: params['videoId'],
                    title: params['title'],
                    description: params['description'],
                    category: params['category'],
                    languageCode: params['languageCode'],
                    tags: params['tags'],
                    isPublic: params['isPublic'],
                  ),
        ),
        'setVisibility': _i1.MethodConnector(
          name: 'setVisibility',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isPublic': _i1.ParameterDescription(
              name: 'isPublic',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['video'] as _i19.VideoEndpoint).setVisibility(
                    session,
                    videoId: params['videoId'],
                    isPublic: params['isPublic'],
                  ),
        ),
        'deleteVideo': _i1.MethodConnector(
          name: 'deleteVideo',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['video'] as _i19.VideoEndpoint).deleteVideo(
                session,
                videoId: params['videoId'],
              ),
        ),
        'createUploadDescription': _i1.MethodConnector(
          name: 'createUploadDescription',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'fileSize': _i1.ParameterDescription(
              name: 'fileSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['video'] as _i19.VideoEndpoint)
                  .createUploadDescription(
                    session,
                    path: params['path'],
                    fileSize: params['fileSize'],
                  ),
        ),
        'verifyUpload': _i1.MethodConnector(
          name: 'verifyUpload',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['video'] as _i19.VideoEndpoint).verifyUpload(
                    session,
                    path: params['path'],
                  ),
        ),
        'getVideoUrl': _i1.MethodConnector(
          name: 'getVideoUrl',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['video'] as _i19.VideoEndpoint).getVideoUrl(
                session,
                path: params['path'],
              ),
        ),
        'getPlaybackManifestUrl': _i1.MethodConnector(
          name: 'getPlaybackManifestUrl',
          params: {
            'videoId': _i1.ParameterDescription(
              name: 'videoId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['video'] as _i19.VideoEndpoint)
                  .getPlaybackManifestUrl(
                    session,
                    videoId: params['videoId'],
                  ),
        ),
      },
    );
    connectors['wordList'] = _i1.EndpointConnector(
      name: 'wordList',
      endpoint: endpoints['wordList']!,
      methodConnectors: {
        'getLists': _i1.MethodConnector(
          name: 'getLists',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['wordList'] as _i20.WordListEndpoint)
                  .getLists(session),
        ),
        'getListDetail': _i1.MethodConnector(
          name: 'getListDetail',
          params: {
            'listId': _i1.ParameterDescription(
              name: 'listId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'explanationLanguageCode': _i1.ParameterDescription(
              name: 'explanationLanguageCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['wordList'] as _i20.WordListEndpoint)
                  .getListDetail(
                    session,
                    listId: params['listId'],
                    explanationLanguageCode: params['explanationLanguageCode'],
                  ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i21.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i27.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i28.Endpoints()
      ..initializeEndpoints(server);
  }
}
