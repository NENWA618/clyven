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
import '../endpoints/comment_endpoint.dart' as _i6;
import '../endpoints/dictionary_endpoint.dart' as _i7;
import '../endpoints/dictionary_import_endpoint.dart' as _i8;
import '../endpoints/known_entry_endpoint.dart' as _i9;
import '../endpoints/review_endpoint.dart' as _i10;
import '../endpoints/subtitle_endpoint.dart' as _i11;
import '../endpoints/video_endpoint.dart' as _i12;
import '../endpoints/word_list_endpoint.dart' as _i13;
import '../greetings/greeting_endpoint.dart' as _i14;
import 'dart:typed_data' as _i15;
import 'package:clyven_backend_server/src/generated/asr_job_status.dart'
    as _i16;
import 'package:clyven_backend_server/src/generated/knowledge_state_query.dart'
    as _i17;
import 'package:clyven_backend_server/src/generated/subtitle_karaoke_segment_input.dart'
    as _i18;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i19;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i20;

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
      'comment': _i6.CommentEndpoint()
        ..initialize(
          server,
          'comment',
          null,
        ),
      'dictionary': _i7.DictionaryEndpoint()
        ..initialize(
          server,
          'dictionary',
          null,
        ),
      'dictionaryImport': _i8.DictionaryImportEndpoint()
        ..initialize(
          server,
          'dictionaryImport',
          null,
        ),
      'knownEntry': _i9.KnownEntryEndpoint()
        ..initialize(
          server,
          'knownEntry',
          null,
        ),
      'review': _i10.ReviewEndpoint()
        ..initialize(
          server,
          'review',
          null,
        ),
      'subtitle': _i11.SubtitleEndpoint()
        ..initialize(
          server,
          'subtitle',
          null,
        ),
      'video': _i12.VideoEndpoint()
        ..initialize(
          server,
          'video',
          null,
        ),
      'wordList': _i13.WordListEndpoint()
        ..initialize(
          server,
          'wordList',
          null,
        ),
      'greeting': _i14.GreetingEndpoint()
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
              type: _i1.getType<_i15.ByteData>(),
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
              type: _i1.getType<_i16.AsrJobStatus?>(),
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
                  (endpoints['comment'] as _i6.CommentEndpoint).loadComments(
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
                  (endpoints['comment'] as _i6.CommentEndpoint).createComment(
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
                  (endpoints['comment'] as _i6.CommentEndpoint).createReply(
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
              ) async => (endpoints['comment'] as _i6.CommentEndpoint)
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
                  (endpoints['comment'] as _i6.CommentEndpoint).toggleReplyLike(
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
                  (endpoints['dictionary'] as _i7.DictionaryEndpoint).lookup(
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
                  (endpoints['dictionary'] as _i7.DictionaryEndpoint).getById(
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
              ) async => (endpoints['dictionary'] as _i7.DictionaryEndpoint)
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
              ) async => (endpoints['dictionary'] as _i7.DictionaryEndpoint)
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
                          as _i8.DictionaryImportEndpoint)
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
                          as _i8.DictionaryImportEndpoint)
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
                          as _i8.DictionaryImportEndpoint)
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
                          as _i8.DictionaryImportEndpoint)
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
                          as _i8.DictionaryImportEndpoint)
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
                          as _i8.DictionaryImportEndpoint)
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
              ) async => (endpoints['knownEntry'] as _i9.KnownEntryEndpoint)
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
                  (endpoints['knownEntry'] as _i9.KnownEntryEndpoint).setKnown(
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
              ) async => (endpoints['knownEntry'] as _i9.KnownEntryEndpoint)
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
              ) async => (endpoints['knownEntry'] as _i9.KnownEntryEndpoint)
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
              type: _i1.getType<List<_i17.KnowledgeStateQuery>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['knownEntry'] as _i9.KnownEntryEndpoint)
                  .getKnowledgeStates(
                    session,
                    queries: params['queries'],
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
              ) async => (endpoints['review'] as _i10.ReviewEndpoint)
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
                  (endpoints['review'] as _i10.ReviewEndpoint).getTaskDetail(
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
              ) async => (endpoints['review'] as _i10.ReviewEndpoint)
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
              ) async => (endpoints['review'] as _i10.ReviewEndpoint).claimTask(
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
              ) async => (endpoints['review'] as _i10.ReviewEndpoint).startTask(
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
                  (endpoints['review'] as _i10.ReviewEndpoint).submitTask(
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
                  (endpoints['review'] as _i10.ReviewEndpoint).returnTask(
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
              ) async => (endpoints['review'] as _i10.ReviewEndpoint)
                  .approveAndPublish(
                    session,
                    taskId: params['taskId'],
                  ),
        ),
      },
    );
    connectors['subtitle'] = _i1.EndpointConnector(
      name: 'subtitle',
      endpoint: endpoints['subtitle']!,
      methodConnectors: {
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
              ) async => (endpoints['subtitle'] as _i11.SubtitleEndpoint)
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
              ) async => (endpoints['subtitle'] as _i11.SubtitleEndpoint)
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
              ) async => (endpoints['subtitle'] as _i11.SubtitleEndpoint)
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
              ) async => (endpoints['subtitle'] as _i11.SubtitleEndpoint)
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
              ) async => (endpoints['subtitle'] as _i11.SubtitleEndpoint)
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
              ) async => (endpoints['subtitle'] as _i11.SubtitleEndpoint)
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
              ) async => (endpoints['subtitle'] as _i11.SubtitleEndpoint)
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
              ) async => (endpoints['subtitle'] as _i11.SubtitleEndpoint)
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
                  (endpoints['subtitle'] as _i11.SubtitleEndpoint).exportSrt(
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
              ) async => (endpoints['subtitle'] as _i11.SubtitleEndpoint)
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
              ) async => (endpoints['subtitle'] as _i11.SubtitleEndpoint)
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
              ) async => (endpoints['subtitle'] as _i11.SubtitleEndpoint)
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
                  (endpoints['subtitle'] as _i11.SubtitleEndpoint).createCue(
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
                  (endpoints['subtitle'] as _i11.SubtitleEndpoint).deleteCue(
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
              type: _i1.getType<List<_i18.SubtitleKaraokeSegmentInput>>(),
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
              ) async => (endpoints['subtitle'] as _i11.SubtitleEndpoint)
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['video'] as _i12.VideoEndpoint).create(
                session,
                authorId: params['authorId'],
                authorName: params['authorName'],
                title: params['title'],
                description: params['description'],
                category: params['category'],
                languageCode: params['languageCode'],
                tags: params['tags'],
                videoStorageKey: params['videoStorageKey'],
                coverStorageKey: params['coverStorageKey'],
                durationSeconds: params['durationSeconds'],
              ),
        ),
        'getVideos': _i1.MethodConnector(
          name: 'getVideos',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['video'] as _i12.VideoEndpoint).getVideos(session),
        ),
        'getMyVideos': _i1.MethodConnector(
          name: 'getMyVideos',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['video'] as _i12.VideoEndpoint).getMyVideos(
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
              ) async => (endpoints['video'] as _i12.VideoEndpoint).getVideo(
                session,
                params['id'],
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
              ) async => (endpoints['video'] as _i12.VideoEndpoint)
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
                  (endpoints['video'] as _i12.VideoEndpoint).verifyUpload(
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
              ) async => (endpoints['video'] as _i12.VideoEndpoint).getVideoUrl(
                session,
                path: params['path'],
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
              ) async => (endpoints['wordList'] as _i13.WordListEndpoint)
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
              ) async => (endpoints['wordList'] as _i13.WordListEndpoint)
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
              ) async => (endpoints['greeting'] as _i14.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i19.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i20.Endpoints()
      ..initializeEndpoints(server);
  }
}
