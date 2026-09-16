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
import '../endpoints/dictionary_endpoint.dart' as _i5;
import '../endpoints/dictionary_import_endpoint.dart' as _i6;
import '../endpoints/known_entry_endpoint.dart' as _i7;
import '../endpoints/subtitle_endpoint.dart' as _i8;
import '../endpoints/video_endpoint.dart' as _i9;
import '../endpoints/word_list_endpoint.dart' as _i10;
import '../greetings/greeting_endpoint.dart' as _i11;
import 'dart:typed_data' as _i12;
import 'package:clyven_backend_server/src/generated/knowledge_state_query.dart'
    as _i13;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i14;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i15;

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
      'dictionary': _i5.DictionaryEndpoint()
        ..initialize(
          server,
          'dictionary',
          null,
        ),
      'dictionaryImport': _i6.DictionaryImportEndpoint()
        ..initialize(
          server,
          'dictionaryImport',
          null,
        ),
      'knownEntry': _i7.KnownEntryEndpoint()
        ..initialize(
          server,
          'knownEntry',
          null,
        ),
      'subtitle': _i8.SubtitleEndpoint()
        ..initialize(
          server,
          'subtitle',
          null,
        ),
      'video': _i9.VideoEndpoint()
        ..initialize(
          server,
          'video',
          null,
        ),
      'wordList': _i10.WordListEndpoint()
        ..initialize(
          server,
          'wordList',
          null,
        ),
      'greeting': _i11.GreetingEndpoint()
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
              type: _i1.getType<_i12.ByteData>(),
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
                  (endpoints['dictionary'] as _i5.DictionaryEndpoint).lookup(
                    session,
                    languageCode: params['languageCode'],
                    normalizedText: params['normalizedText'],
                    entryType: params['entryType'],
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
              ) async => (endpoints['dictionary'] as _i5.DictionaryEndpoint)
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
              ) async => (endpoints['dictionary'] as _i5.DictionaryEndpoint)
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
                          as _i6.DictionaryImportEndpoint)
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
                          as _i6.DictionaryImportEndpoint)
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
                          as _i6.DictionaryImportEndpoint)
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
                          as _i6.DictionaryImportEndpoint)
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
                          as _i6.DictionaryImportEndpoint)
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
                          as _i6.DictionaryImportEndpoint)
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
              ) async => (endpoints['knownEntry'] as _i7.KnownEntryEndpoint)
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
                  (endpoints['knownEntry'] as _i7.KnownEntryEndpoint).setKnown(
                    session,
                    entryId: params['entryId'],
                    known: params['known'],
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
              ) async => (endpoints['knownEntry'] as _i7.KnownEntryEndpoint)
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
              type: _i1.getType<List<_i13.KnowledgeStateQuery>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['knownEntry'] as _i7.KnownEntryEndpoint)
                  .getKnowledgeStates(
                    session,
                    queries: params['queries'],
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['subtitle'] as _i8.SubtitleEndpoint).getCueDetails(
                    session,
                    videoId: params['videoId'],
                    languageCode: params['languageCode'],
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
              ) async => (endpoints['subtitle'] as _i8.SubtitleEndpoint)
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['subtitle'] as _i8.SubtitleEndpoint)
                  .confirmReplaceSrtImport(
                    session,
                    videoId: params['videoId'],
                    languageCode: params['languageCode'],
                    content: params['content'],
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
                  (endpoints['subtitle'] as _i8.SubtitleEndpoint).exportSrt(
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['subtitle'] as _i8.SubtitleEndpoint).updateCueText(
                    session,
                    cueId: params['cueId'],
                    text: params['text'],
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
              ) async => (endpoints['subtitle'] as _i8.SubtitleEndpoint)
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['subtitle'] as _i8.SubtitleEndpoint).createCue(
                    session,
                    videoId: params['videoId'],
                    languageCode: params['languageCode'],
                    startMs: params['startMs'],
                    endMs: params['endMs'],
                    text: params['text'],
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
                  (endpoints['subtitle'] as _i8.SubtitleEndpoint).deleteCue(
                    session,
                    cueId: params['cueId'],
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
              ) async => (endpoints['video'] as _i9.VideoEndpoint).create(
                session,
                authorId: params['authorId'],
                authorName: params['authorName'],
                title: params['title'],
                description: params['description'],
                category: params['category'],
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
                  (endpoints['video'] as _i9.VideoEndpoint).getVideos(session),
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
              ) async => (endpoints['video'] as _i9.VideoEndpoint).getVideo(
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
              ) async => (endpoints['video'] as _i9.VideoEndpoint)
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
              ) async => (endpoints['video'] as _i9.VideoEndpoint).verifyUpload(
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
              ) async => (endpoints['video'] as _i9.VideoEndpoint).getVideoUrl(
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
              ) async => (endpoints['wordList'] as _i10.WordListEndpoint)
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
              ) async => (endpoints['wordList'] as _i10.WordListEndpoint)
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
              ) async => (endpoints['greeting'] as _i11.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i14.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i15.Endpoints()
      ..initializeEndpoints(server);
  }
}
