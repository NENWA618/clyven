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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'app_notification.dart' as _i5;
import 'app_profile.dart' as _i6;
import 'asr_job.dart' as _i7;
import 'asr_job_status.dart' as _i8;
import 'comment_like.dart' as _i9;
import 'comment_page_dto.dart' as _i10;
import 'comment_reply_dto.dart' as _i11;
import 'comment_reply_like.dart' as _i12;
import 'comment_reply_row.dart' as _i13;
import 'creator_follow.dart' as _i14;
import 'dictionary_definition.dart' as _i15;
import 'dictionary_entry.dart' as _i16;
import 'dictionary_entry_detail.dart' as _i17;
import 'dictionary_example.dart' as _i18;
import 'dictionary_example_detail.dart' as _i19;
import 'dictionary_example_text.dart' as _i20;
import 'dictionary_form.dart' as _i21;
import 'dictionary_import_commit_result.dart' as _i22;
import 'dictionary_import_mapping.dart' as _i23;
import 'dictionary_import_preview.dart' as _i24;
import 'dictionary_import_preview_row.dart' as _i25;
import 'dictionary_import_profile.dart' as _i26;
import 'dictionary_import_profile_detail.dart' as _i27;
import 'dictionary_relation.dart' as _i28;
import 'dictionary_relation_detail.dart' as _i29;
import 'entry_knowledge_state.dart' as _i30;
import 'greetings/greeting.dart' as _i31;
import 'knowledge_state_query.dart' as _i32;
import 'knowledge_state_result.dart' as _i33;
import 'notification_settings.dart' as _i34;
import 'notification_type.dart' as _i35;
import 'privacy_settings.dart' as _i36;
import 'profile_stats.dart' as _i37;
import 'script_conversion_commit_result.dart' as _i38;
import 'script_conversion_entry.dart' as _i39;
import 'script_conversion_import_preview.dart' as _i40;
import 'script_conversion_import_preview_row.dart' as _i41;
import 'script_conversion_profile.dart' as _i42;
import 'subtitle_cue.dart' as _i43;
import 'subtitle_cue_detail.dart' as _i44;
import 'subtitle_cue_text.dart' as _i45;
import 'subtitle_karaoke_segment.dart' as _i46;
import 'subtitle_karaoke_segment_input.dart' as _i47;
import 'subtitle_phrase.dart' as _i48;
import 'subtitle_publish_state.dart' as _i49;
import 'subtitle_publish_status.dart' as _i50;
import 'subtitle_review_dashboard.dart' as _i51;
import 'subtitle_review_event.dart' as _i52;
import 'subtitle_review_queue_item.dart' as _i53;
import 'subtitle_review_task.dart' as _i54;
import 'subtitle_review_task_detail.dart' as _i55;
import 'subtitle_review_task_status.dart' as _i56;
import 'subtitle_srt_preview.dart' as _i57;
import 'subtitle_token.dart' as _i58;
import 'subtitle_track.dart' as _i59;
import 'user_known_entry.dart' as _i60;
import 'video.dart' as _i61;
import 'video_comment_dto.dart' as _i62;
import 'video_comment_row.dart' as _i63;
import 'video_content_type.dart' as _i64;
import 'video_favorite.dart' as _i65;
import 'video_like.dart' as _i66;
import 'video_series.dart' as _i67;
import 'video_status.dart' as _i68;
import 'watch_history.dart' as _i69;
import 'word_list.dart' as _i70;
import 'word_list_detail.dart' as _i71;
import 'word_list_item.dart' as _i72;
import 'word_list_item_detail.dart' as _i73;
import 'package:clyven_backend_server/src/generated/asr_job.dart' as _i74;
import 'package:clyven_backend_server/src/generated/video.dart' as _i75;
import 'package:clyven_backend_server/src/generated/subtitle_track.dart'
    as _i76;
import 'package:clyven_backend_server/src/generated/dictionary_entry_detail.dart'
    as _i77;
import 'package:clyven_backend_server/src/generated/dictionary_import_profile.dart'
    as _i78;
import 'package:clyven_backend_server/src/generated/entry_knowledge_state.dart'
    as _i79;
import 'package:clyven_backend_server/src/generated/knowledge_state_result.dart'
    as _i80;
import 'package:clyven_backend_server/src/generated/knowledge_state_query.dart'
    as _i81;
import 'package:clyven_backend_server/src/generated/app_notification.dart'
    as _i82;
import 'package:clyven_backend_server/src/generated/script_conversion_profile.dart'
    as _i83;
import 'package:clyven_backend_server/src/generated/script_conversion_entry.dart'
    as _i84;
import 'package:clyven_backend_server/src/generated/watch_history.dart' as _i85;
import 'package:clyven_backend_server/src/generated/subtitle_cue_detail.dart'
    as _i86;
import 'package:clyven_backend_server/src/generated/subtitle_karaoke_segment.dart'
    as _i87;
import 'package:clyven_backend_server/src/generated/subtitle_karaoke_segment_input.dart'
    as _i88;
import 'package:clyven_backend_server/src/generated/video_series.dart' as _i89;
import 'package:clyven_backend_server/src/generated/word_list.dart' as _i90;
export 'app_notification.dart';
export 'app_profile.dart';
export 'asr_job.dart';
export 'asr_job_status.dart';
export 'comment_like.dart';
export 'comment_page_dto.dart';
export 'comment_reply_dto.dart';
export 'comment_reply_like.dart';
export 'comment_reply_row.dart';
export 'creator_follow.dart';
export 'dictionary_definition.dart';
export 'dictionary_entry.dart';
export 'dictionary_entry_detail.dart';
export 'dictionary_example.dart';
export 'dictionary_example_detail.dart';
export 'dictionary_example_text.dart';
export 'dictionary_form.dart';
export 'dictionary_import_commit_result.dart';
export 'dictionary_import_mapping.dart';
export 'dictionary_import_preview.dart';
export 'dictionary_import_preview_row.dart';
export 'dictionary_import_profile.dart';
export 'dictionary_import_profile_detail.dart';
export 'dictionary_relation.dart';
export 'dictionary_relation_detail.dart';
export 'entry_knowledge_state.dart';
export 'greetings/greeting.dart';
export 'knowledge_state_query.dart';
export 'knowledge_state_result.dart';
export 'notification_settings.dart';
export 'notification_type.dart';
export 'privacy_settings.dart';
export 'profile_stats.dart';
export 'script_conversion_commit_result.dart';
export 'script_conversion_entry.dart';
export 'script_conversion_import_preview.dart';
export 'script_conversion_import_preview_row.dart';
export 'script_conversion_profile.dart';
export 'subtitle_cue.dart';
export 'subtitle_cue_detail.dart';
export 'subtitle_cue_text.dart';
export 'subtitle_karaoke_segment.dart';
export 'subtitle_karaoke_segment_input.dart';
export 'subtitle_phrase.dart';
export 'subtitle_publish_state.dart';
export 'subtitle_publish_status.dart';
export 'subtitle_review_dashboard.dart';
export 'subtitle_review_event.dart';
export 'subtitle_review_queue_item.dart';
export 'subtitle_review_task.dart';
export 'subtitle_review_task_detail.dart';
export 'subtitle_review_task_status.dart';
export 'subtitle_srt_preview.dart';
export 'subtitle_token.dart';
export 'subtitle_track.dart';
export 'user_known_entry.dart';
export 'video.dart';
export 'video_comment_dto.dart';
export 'video_comment_row.dart';
export 'video_content_type.dart';
export 'video_favorite.dart';
export 'video_like.dart';
export 'video_series.dart';
export 'video_status.dart';
export 'watch_history.dart';
export 'word_list.dart';
export 'word_list_detail.dart';
export 'word_list_item.dart';
export 'word_list_item_detail.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'app_profile',
      dartName: 'AppProfile',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'app_profile_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'bio',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'app_profile_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'app_profile_user_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'asr_job',
      dartName: 'AsrJob',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'asr_job_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'videoId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'requestedLanguageCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'detectedLanguageCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'provider',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AsrJobStatus',
          columnDefault: '\'queued\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'trackId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'errorMessage',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'asr_job_fk_0',
          columns: ['videoId'],
          referenceTable: 'video',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'asr_job_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'asr_job_video_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'videoId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'comment_like',
      dartName: 'CommentLike',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'comment_like_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'commentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'comment_like_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'comment_like_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'commentId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'comment_reply',
      dartName: 'CommentReplyRow',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'comment_reply_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'commentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'userName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'content',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'likeCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'comment_reply_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'comment_reply_comment_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'commentId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'comment_reply_like',
      dartName: 'CommentReplyLike',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'comment_reply_like_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'replyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'comment_reply_like_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'comment_reply_like_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'replyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'creator_follow',
      dartName: 'CreatorFollow',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'creator_follow_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'followerId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'creatorId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'creator_follow_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'creator_follow_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'followerId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'creatorId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'dictionary_definition',
      dartName: 'DictionaryDefinition',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'dictionary_definition_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'entryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'explanationLanguageCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'gloss',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'definition',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'dictionary_definition_fk_0',
          columns: ['entryId'],
          referenceTable: 'dictionary_entry',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'dictionary_definition_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'dictionary_entry',
      dartName: 'DictionaryEntry',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'dictionary_entry_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'languageCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'normalizedText',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'entryType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'primaryScriptCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'partOfSpeech',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'dictionary_entry_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'dictionary_example',
      dartName: 'DictionaryExample',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'dictionary_example_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'entryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'position',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'dictionary_example_fk_0',
          columns: ['entryId'],
          referenceTable: 'dictionary_entry',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'dictionary_example_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'dictionary_example_text',
      dartName: 'DictionaryExampleText',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'dictionary_example_text_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'exampleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'languageCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'scriptCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'dictionary_example_text_fk_0',
          columns: ['exampleId'],
          referenceTable: 'dictionary_example',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'dictionary_example_text_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'dictionary_example_text_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'exampleId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'languageCode',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'scriptCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'dictionary_form',
      dartName: 'DictionaryForm',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'dictionary_form_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'entryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'scriptCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'normalizedText',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isPrimary',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'dictionary_form_fk_0',
          columns: ['entryId'],
          referenceTable: 'dictionary_entry',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'dictionary_form_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'dictionary_form_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'entryId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'scriptCode',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'text',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'dictionary_import_mapping',
      dartName: 'DictionaryImportMapping',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'dictionary_import_mapping_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'profileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sourceColumn',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetField',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'languageCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'scriptCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'relationType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'groupKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'transformType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'transformConfig',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'position',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'required',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'dictionary_import_mapping_fk_0',
          columns: ['profileId'],
          referenceTable: 'dictionary_import_profile',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'dictionary_import_mapping_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'dictionary_import_profile',
      dartName: 'DictionaryImportProfile',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'dictionary_import_profile_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'languageCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'sheetName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'defaultEntryType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'primaryScriptCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'dictionary_import_profile_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'dictionary_relation',
      dartName: 'DictionaryRelation',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'dictionary_relation_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'sourceEntryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'targetEntryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'relationType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'position',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'dictionary_relation_fk_0',
          columns: ['sourceEntryId'],
          referenceTable: 'dictionary_entry',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'dictionary_relation_fk_1',
          columns: ['targetEntryId'],
          referenceTable: 'dictionary_entry',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'dictionary_relation_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'notification',
      dartName: 'AppNotification',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'notification_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'recipientId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'actorId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'actorName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:NotificationType',
        ),
        _i2.ColumnDefinition(
          name: 'videoId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'commentPreview',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isRead',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'notification_fk_0',
          columns: ['videoId'],
          referenceTable: 'video',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'notification_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'notification_recipient_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'recipientId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'notification_settings',
      dartName: 'NotificationSettings',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'notification_settings_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'pushEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'likeEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'commentEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'followEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'notification_settings_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'notification_settings_user_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'privacy_settings',
      dartName: 'PrivacySettings',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'privacy_settings_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'privateAccount',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'allowComments',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'showActivityStatus',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'privacy_settings_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'privacy_settings_user_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'script_conversion_entry',
      dartName: 'ScriptConversionEntry',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'script_conversion_entry_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'profileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sourceText',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetText',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'priority',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'note',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'metadataJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'entryType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'script_conversion_entry_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'script_conversion_profile',
      dartName: 'ScriptConversionProfile',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'script_conversion_profile_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'languageCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'sourceScriptCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetScriptCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'sheetName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceColumn',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetColumn',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'priorityColumn',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'noteColumn',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'conversionMode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'typeColumn',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'script_conversion_profile_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subtitle_cue',
      dartName: 'SubtitleCue',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subtitle_cue_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'trackId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'startMs',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'endMs',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subtitle_cue_fk_0',
          columns: ['trackId'],
          referenceTable: 'subtitle_track',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subtitle_cue_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subtitle_cue_text',
      dartName: 'SubtitleCueText',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subtitle_cue_text_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'cueId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'scriptCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'normalizedText',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isPrimary',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subtitle_cue_text_fk_0',
          columns: ['cueId'],
          referenceTable: 'subtitle_cue',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subtitle_cue_text_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'subtitle_cue_text_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'cueId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'scriptCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subtitle_karaoke_segment',
      dartName: 'SubtitleKaraokeSegment',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'subtitle_karaoke_segment_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'cueId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'scriptCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'position',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'startOffsetMs',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'endOffsetMs',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subtitle_karaoke_segment_fk_0',
          columns: ['cueId'],
          referenceTable: 'subtitle_cue',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subtitle_karaoke_segment_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subtitle_phrase',
      dartName: 'SubtitlePhrase',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subtitle_phrase_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'cueId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'scriptCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'normalizedText',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'entryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'startPosition',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'endPosition',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subtitle_phrase_fk_0',
          columns: ['cueId'],
          referenceTable: 'subtitle_cue',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'subtitle_phrase_fk_1',
          columns: ['entryId'],
          referenceTable: 'dictionary_entry',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subtitle_phrase_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subtitle_publish_state',
      dartName: 'SubtitlePublishState',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subtitle_publish_state_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'trackId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'publishedPayload',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'publishedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'draftRevision',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'publishedRevision',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subtitle_publish_state_fk_0',
          columns: ['trackId'],
          referenceTable: 'subtitle_track',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subtitle_publish_state_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'subtitle_publish_state_track_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'trackId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subtitle_review_event',
      dartName: 'SubtitleReviewEvent',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subtitle_review_event_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'taskId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'actorUserId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'actorDisplayName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'action',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'note',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subtitle_review_event_fk_0',
          columns: ['taskId'],
          referenceTable: 'subtitle_review_task',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subtitle_review_event_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'subtitle_review_event_task_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'taskId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subtitle_review_task',
      dartName: 'SubtitleReviewTask',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subtitle_review_task_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'videoId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'trackId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'languageCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'scriptCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:SubtitleReviewTaskStatus',
          columnDefault: '\'readyForReview\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'priority',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'assignedUserId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'assignedDisplayName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'editedByUserId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'editedByDisplayName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'reviewedByUserId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'reviewedByDisplayName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'approvedByUserId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'approvedByDisplayName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'claimedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'submittedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'reviewedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'publishedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subtitle_review_task_fk_0',
          columns: ['videoId'],
          referenceTable: 'video',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'subtitle_review_task_fk_1',
          columns: ['trackId'],
          referenceTable: 'subtitle_track',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subtitle_review_task_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'subtitle_review_task_track_script_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'trackId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'scriptCode',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'subtitle_review_task_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'subtitle_review_task_assigned_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'assignedUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subtitle_token',
      dartName: 'SubtitleToken',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subtitle_token_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'cueId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'scriptCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'normalizedText',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'entryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'startMs',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'endMs',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'position',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subtitle_token_fk_0',
          columns: ['cueId'],
          referenceTable: 'subtitle_cue',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'subtitle_token_fk_1',
          columns: ['entryId'],
          referenceTable: 'dictionary_entry',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subtitle_token_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subtitle_track',
      dartName: 'SubtitleTrack',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subtitle_track_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'videoId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'languageCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'variantCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'label',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'defaultScriptCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isDefault',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subtitle_track_fk_0',
          columns: ['videoId'],
          referenceTable: 'video',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subtitle_track_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_known_entry',
      dartName: 'UserKnownEntry',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_known_entry_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'entryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_known_entry_fk_0',
          columns: ['entryId'],
          referenceTable: 'dictionary_entry',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_known_entry_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_known_entry_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'entryId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'video',
      dartName: 'Video',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'video_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'authorId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'authorName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'seriesTitle',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'seriesId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'seriesPosition',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'contentType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:VideoContentType',
          columnDefault: '\'video\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'languageCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'tags',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _i2.ColumnDefinition(
          name: 'videoStorageKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'coverStorageKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'hlsManifestStorageKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'transcoderJobName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'transcodeState',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'durationSeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'viewCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'engagedViewCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'likeCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'favoriteCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'commentCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:VideoStatus',
          columnDefault: '\'uploading\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'isPublic',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'publishedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'video_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'video_comment',
      dartName: 'VideoCommentRow',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'video_comment_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'videoId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'userName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'content',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'likeCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'video_comment_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'video_comment_video_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'videoId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'video_favorite',
      dartName: 'VideoFavorite',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'video_favorite_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'videoId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'video_favorite_fk_0',
          columns: ['videoId'],
          referenceTable: 'video',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'video_favorite_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'video_favorite_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'videoId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'video_like',
      dartName: 'VideoLike',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'video_like_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'videoId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'video_like_fk_0',
          columns: ['videoId'],
          referenceTable: 'video',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'video_like_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'video_like_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'videoId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'video_series',
      dartName: 'VideoSeries',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'video_series_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'creatorId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'coverStorageKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'languageCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'video_series_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'watch_history',
      dartName: 'WatchHistory',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'watch_history_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'videoId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'positionSeconds',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'watchedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'watch_history_fk_0',
          columns: ['videoId'],
          referenceTable: 'video',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'watch_history_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'watch_history_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'videoId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'word_list',
      dartName: 'WordList',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'word_list_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'languageCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'word_list_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'word_list_item',
      dartName: 'WordListItem',
      schema: 'public',
      module: 'clyven_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'word_list_item_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'listId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'entryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'position',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'word_list_item_fk_0',
          columns: ['listId'],
          referenceTable: 'word_list',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'word_list_item_fk_1',
          columns: ['entryId'],
          referenceTable: 'dictionary_entry',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'word_list_item_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'word_list_item_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'listId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'entryId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.AppNotification) {
      return _i5.AppNotification.fromJson(data) as T;
    }
    if (t == _i6.AppProfile) {
      return _i6.AppProfile.fromJson(data) as T;
    }
    if (t == _i7.AsrJob) {
      return _i7.AsrJob.fromJson(data) as T;
    }
    if (t == _i8.AsrJobStatus) {
      return _i8.AsrJobStatus.fromJson(data) as T;
    }
    if (t == _i9.CommentLike) {
      return _i9.CommentLike.fromJson(data) as T;
    }
    if (t == _i10.CommentPageDto) {
      return _i10.CommentPageDto.fromJson(data) as T;
    }
    if (t == _i11.CommentReplyDto) {
      return _i11.CommentReplyDto.fromJson(data) as T;
    }
    if (t == _i12.CommentReplyLike) {
      return _i12.CommentReplyLike.fromJson(data) as T;
    }
    if (t == _i13.CommentReplyRow) {
      return _i13.CommentReplyRow.fromJson(data) as T;
    }
    if (t == _i14.CreatorFollow) {
      return _i14.CreatorFollow.fromJson(data) as T;
    }
    if (t == _i15.DictionaryDefinition) {
      return _i15.DictionaryDefinition.fromJson(data) as T;
    }
    if (t == _i16.DictionaryEntry) {
      return _i16.DictionaryEntry.fromJson(data) as T;
    }
    if (t == _i17.DictionaryEntryDetail) {
      return _i17.DictionaryEntryDetail.fromJson(data) as T;
    }
    if (t == _i18.DictionaryExample) {
      return _i18.DictionaryExample.fromJson(data) as T;
    }
    if (t == _i19.DictionaryExampleDetail) {
      return _i19.DictionaryExampleDetail.fromJson(data) as T;
    }
    if (t == _i20.DictionaryExampleText) {
      return _i20.DictionaryExampleText.fromJson(data) as T;
    }
    if (t == _i21.DictionaryForm) {
      return _i21.DictionaryForm.fromJson(data) as T;
    }
    if (t == _i22.DictionaryImportCommitResult) {
      return _i22.DictionaryImportCommitResult.fromJson(data) as T;
    }
    if (t == _i23.DictionaryImportMapping) {
      return _i23.DictionaryImportMapping.fromJson(data) as T;
    }
    if (t == _i24.DictionaryImportPreview) {
      return _i24.DictionaryImportPreview.fromJson(data) as T;
    }
    if (t == _i25.DictionaryImportPreviewRow) {
      return _i25.DictionaryImportPreviewRow.fromJson(data) as T;
    }
    if (t == _i26.DictionaryImportProfile) {
      return _i26.DictionaryImportProfile.fromJson(data) as T;
    }
    if (t == _i27.DictionaryImportProfileDetail) {
      return _i27.DictionaryImportProfileDetail.fromJson(data) as T;
    }
    if (t == _i28.DictionaryRelation) {
      return _i28.DictionaryRelation.fromJson(data) as T;
    }
    if (t == _i29.DictionaryRelationDetail) {
      return _i29.DictionaryRelationDetail.fromJson(data) as T;
    }
    if (t == _i30.EntryKnowledgeState) {
      return _i30.EntryKnowledgeState.fromJson(data) as T;
    }
    if (t == _i31.Greeting) {
      return _i31.Greeting.fromJson(data) as T;
    }
    if (t == _i32.KnowledgeStateQuery) {
      return _i32.KnowledgeStateQuery.fromJson(data) as T;
    }
    if (t == _i33.KnowledgeStateResult) {
      return _i33.KnowledgeStateResult.fromJson(data) as T;
    }
    if (t == _i34.NotificationSettings) {
      return _i34.NotificationSettings.fromJson(data) as T;
    }
    if (t == _i35.NotificationType) {
      return _i35.NotificationType.fromJson(data) as T;
    }
    if (t == _i36.PrivacySettings) {
      return _i36.PrivacySettings.fromJson(data) as T;
    }
    if (t == _i37.ProfileStats) {
      return _i37.ProfileStats.fromJson(data) as T;
    }
    if (t == _i38.ScriptConversionCommitResult) {
      return _i38.ScriptConversionCommitResult.fromJson(data) as T;
    }
    if (t == _i39.ScriptConversionEntry) {
      return _i39.ScriptConversionEntry.fromJson(data) as T;
    }
    if (t == _i40.ScriptConversionImportPreview) {
      return _i40.ScriptConversionImportPreview.fromJson(data) as T;
    }
    if (t == _i41.ScriptConversionImportPreviewRow) {
      return _i41.ScriptConversionImportPreviewRow.fromJson(data) as T;
    }
    if (t == _i42.ScriptConversionProfile) {
      return _i42.ScriptConversionProfile.fromJson(data) as T;
    }
    if (t == _i43.SubtitleCue) {
      return _i43.SubtitleCue.fromJson(data) as T;
    }
    if (t == _i44.SubtitleCueDetail) {
      return _i44.SubtitleCueDetail.fromJson(data) as T;
    }
    if (t == _i45.SubtitleCueText) {
      return _i45.SubtitleCueText.fromJson(data) as T;
    }
    if (t == _i46.SubtitleKaraokeSegment) {
      return _i46.SubtitleKaraokeSegment.fromJson(data) as T;
    }
    if (t == _i47.SubtitleKaraokeSegmentInput) {
      return _i47.SubtitleKaraokeSegmentInput.fromJson(data) as T;
    }
    if (t == _i48.SubtitlePhrase) {
      return _i48.SubtitlePhrase.fromJson(data) as T;
    }
    if (t == _i49.SubtitlePublishState) {
      return _i49.SubtitlePublishState.fromJson(data) as T;
    }
    if (t == _i50.SubtitlePublishStatus) {
      return _i50.SubtitlePublishStatus.fromJson(data) as T;
    }
    if (t == _i51.SubtitleReviewDashboard) {
      return _i51.SubtitleReviewDashboard.fromJson(data) as T;
    }
    if (t == _i52.SubtitleReviewEvent) {
      return _i52.SubtitleReviewEvent.fromJson(data) as T;
    }
    if (t == _i53.SubtitleReviewQueueItem) {
      return _i53.SubtitleReviewQueueItem.fromJson(data) as T;
    }
    if (t == _i54.SubtitleReviewTask) {
      return _i54.SubtitleReviewTask.fromJson(data) as T;
    }
    if (t == _i55.SubtitleReviewTaskDetail) {
      return _i55.SubtitleReviewTaskDetail.fromJson(data) as T;
    }
    if (t == _i56.SubtitleReviewTaskStatus) {
      return _i56.SubtitleReviewTaskStatus.fromJson(data) as T;
    }
    if (t == _i57.SubtitleSrtPreview) {
      return _i57.SubtitleSrtPreview.fromJson(data) as T;
    }
    if (t == _i58.SubtitleToken) {
      return _i58.SubtitleToken.fromJson(data) as T;
    }
    if (t == _i59.SubtitleTrack) {
      return _i59.SubtitleTrack.fromJson(data) as T;
    }
    if (t == _i60.UserKnownEntry) {
      return _i60.UserKnownEntry.fromJson(data) as T;
    }
    if (t == _i61.Video) {
      return _i61.Video.fromJson(data) as T;
    }
    if (t == _i62.VideoCommentDto) {
      return _i62.VideoCommentDto.fromJson(data) as T;
    }
    if (t == _i63.VideoCommentRow) {
      return _i63.VideoCommentRow.fromJson(data) as T;
    }
    if (t == _i64.VideoContentType) {
      return _i64.VideoContentType.fromJson(data) as T;
    }
    if (t == _i65.VideoFavorite) {
      return _i65.VideoFavorite.fromJson(data) as T;
    }
    if (t == _i66.VideoLike) {
      return _i66.VideoLike.fromJson(data) as T;
    }
    if (t == _i67.VideoSeries) {
      return _i67.VideoSeries.fromJson(data) as T;
    }
    if (t == _i68.VideoStatus) {
      return _i68.VideoStatus.fromJson(data) as T;
    }
    if (t == _i69.WatchHistory) {
      return _i69.WatchHistory.fromJson(data) as T;
    }
    if (t == _i70.WordList) {
      return _i70.WordList.fromJson(data) as T;
    }
    if (t == _i71.WordListDetail) {
      return _i71.WordListDetail.fromJson(data) as T;
    }
    if (t == _i72.WordListItem) {
      return _i72.WordListItem.fromJson(data) as T;
    }
    if (t == _i73.WordListItemDetail) {
      return _i73.WordListItemDetail.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AppNotification?>()) {
      return (data != null ? _i5.AppNotification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AppProfile?>()) {
      return (data != null ? _i6.AppProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AsrJob?>()) {
      return (data != null ? _i7.AsrJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AsrJobStatus?>()) {
      return (data != null ? _i8.AsrJobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.CommentLike?>()) {
      return (data != null ? _i9.CommentLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.CommentPageDto?>()) {
      return (data != null ? _i10.CommentPageDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.CommentReplyDto?>()) {
      return (data != null ? _i11.CommentReplyDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.CommentReplyLike?>()) {
      return (data != null ? _i12.CommentReplyLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.CommentReplyRow?>()) {
      return (data != null ? _i13.CommentReplyRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.CreatorFollow?>()) {
      return (data != null ? _i14.CreatorFollow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.DictionaryDefinition?>()) {
      return (data != null ? _i15.DictionaryDefinition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.DictionaryEntry?>()) {
      return (data != null ? _i16.DictionaryEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.DictionaryEntryDetail?>()) {
      return (data != null ? _i17.DictionaryEntryDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.DictionaryExample?>()) {
      return (data != null ? _i18.DictionaryExample.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.DictionaryExampleDetail?>()) {
      return (data != null ? _i19.DictionaryExampleDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.DictionaryExampleText?>()) {
      return (data != null ? _i20.DictionaryExampleText.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.DictionaryForm?>()) {
      return (data != null ? _i21.DictionaryForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.DictionaryImportCommitResult?>()) {
      return (data != null
              ? _i22.DictionaryImportCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i23.DictionaryImportMapping?>()) {
      return (data != null ? _i23.DictionaryImportMapping.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.DictionaryImportPreview?>()) {
      return (data != null ? _i24.DictionaryImportPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.DictionaryImportPreviewRow?>()) {
      return (data != null
              ? _i25.DictionaryImportPreviewRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i26.DictionaryImportProfile?>()) {
      return (data != null ? _i26.DictionaryImportProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.DictionaryImportProfileDetail?>()) {
      return (data != null
              ? _i27.DictionaryImportProfileDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i28.DictionaryRelation?>()) {
      return (data != null ? _i28.DictionaryRelation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.DictionaryRelationDetail?>()) {
      return (data != null
              ? _i29.DictionaryRelationDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i30.EntryKnowledgeState?>()) {
      return (data != null ? _i30.EntryKnowledgeState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.Greeting?>()) {
      return (data != null ? _i31.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.KnowledgeStateQuery?>()) {
      return (data != null ? _i32.KnowledgeStateQuery.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.KnowledgeStateResult?>()) {
      return (data != null ? _i33.KnowledgeStateResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i34.NotificationSettings?>()) {
      return (data != null ? _i34.NotificationSettings.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.NotificationType?>()) {
      return (data != null ? _i35.NotificationType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.PrivacySettings?>()) {
      return (data != null ? _i36.PrivacySettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.ProfileStats?>()) {
      return (data != null ? _i37.ProfileStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.ScriptConversionCommitResult?>()) {
      return (data != null
              ? _i38.ScriptConversionCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i39.ScriptConversionEntry?>()) {
      return (data != null ? _i39.ScriptConversionEntry.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.ScriptConversionImportPreview?>()) {
      return (data != null
              ? _i40.ScriptConversionImportPreview.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i41.ScriptConversionImportPreviewRow?>()) {
      return (data != null
              ? _i41.ScriptConversionImportPreviewRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i42.ScriptConversionProfile?>()) {
      return (data != null ? _i42.ScriptConversionProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i43.SubtitleCue?>()) {
      return (data != null ? _i43.SubtitleCue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.SubtitleCueDetail?>()) {
      return (data != null ? _i44.SubtitleCueDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.SubtitleCueText?>()) {
      return (data != null ? _i45.SubtitleCueText.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.SubtitleKaraokeSegment?>()) {
      return (data != null ? _i46.SubtitleKaraokeSegment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i47.SubtitleKaraokeSegmentInput?>()) {
      return (data != null
              ? _i47.SubtitleKaraokeSegmentInput.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i48.SubtitlePhrase?>()) {
      return (data != null ? _i48.SubtitlePhrase.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.SubtitlePublishState?>()) {
      return (data != null ? _i49.SubtitlePublishState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i50.SubtitlePublishStatus?>()) {
      return (data != null ? _i50.SubtitlePublishStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i51.SubtitleReviewDashboard?>()) {
      return (data != null ? _i51.SubtitleReviewDashboard.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i52.SubtitleReviewEvent?>()) {
      return (data != null ? _i52.SubtitleReviewEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i53.SubtitleReviewQueueItem?>()) {
      return (data != null ? _i53.SubtitleReviewQueueItem.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.SubtitleReviewTask?>()) {
      return (data != null ? _i54.SubtitleReviewTask.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.SubtitleReviewTaskDetail?>()) {
      return (data != null
              ? _i55.SubtitleReviewTaskDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i56.SubtitleReviewTaskStatus?>()) {
      return (data != null
              ? _i56.SubtitleReviewTaskStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i57.SubtitleSrtPreview?>()) {
      return (data != null ? _i57.SubtitleSrtPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i58.SubtitleToken?>()) {
      return (data != null ? _i58.SubtitleToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.SubtitleTrack?>()) {
      return (data != null ? _i59.SubtitleTrack.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.UserKnownEntry?>()) {
      return (data != null ? _i60.UserKnownEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.Video?>()) {
      return (data != null ? _i61.Video.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.VideoCommentDto?>()) {
      return (data != null ? _i62.VideoCommentDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.VideoCommentRow?>()) {
      return (data != null ? _i63.VideoCommentRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.VideoContentType?>()) {
      return (data != null ? _i64.VideoContentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.VideoFavorite?>()) {
      return (data != null ? _i65.VideoFavorite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.VideoLike?>()) {
      return (data != null ? _i66.VideoLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.VideoSeries?>()) {
      return (data != null ? _i67.VideoSeries.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.VideoStatus?>()) {
      return (data != null ? _i68.VideoStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.WatchHistory?>()) {
      return (data != null ? _i69.WatchHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.WordList?>()) {
      return (data != null ? _i70.WordList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.WordListDetail?>()) {
      return (data != null ? _i71.WordListDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.WordListItem?>()) {
      return (data != null ? _i72.WordListItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.WordListItemDetail?>()) {
      return (data != null ? _i73.WordListItemDetail.fromJson(data) : null)
          as T;
    }
    if (t == List<_i62.VideoCommentDto>) {
      return (data as List)
              .map((e) => deserialize<_i62.VideoCommentDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i15.DictionaryDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i15.DictionaryDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.DictionaryForm>) {
      return (data as List)
              .map((e) => deserialize<_i21.DictionaryForm>(e))
              .toList()
          as T;
    }
    if (t == List<_i19.DictionaryExampleDetail>) {
      return (data as List)
              .map((e) => deserialize<_i19.DictionaryExampleDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i29.DictionaryRelationDetail>) {
      return (data as List)
              .map((e) => deserialize<_i29.DictionaryRelationDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.DictionaryExampleText>) {
      return (data as List)
              .map((e) => deserialize<_i20.DictionaryExampleText>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i25.DictionaryImportPreviewRow>) {
      return (data as List)
              .map((e) => deserialize<_i25.DictionaryImportPreviewRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i23.DictionaryImportMapping>) {
      return (data as List)
              .map((e) => deserialize<_i23.DictionaryImportMapping>(e))
              .toList()
          as T;
    }
    if (t == List<_i41.ScriptConversionImportPreviewRow>) {
      return (data as List)
              .map((e) => deserialize<_i41.ScriptConversionImportPreviewRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i45.SubtitleCueText>) {
      return (data as List)
              .map((e) => deserialize<_i45.SubtitleCueText>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i45.SubtitleCueText>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i45.SubtitleCueText>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i58.SubtitleToken>) {
      return (data as List)
              .map((e) => deserialize<_i58.SubtitleToken>(e))
              .toList()
          as T;
    }
    if (t == List<_i48.SubtitlePhrase>) {
      return (data as List)
              .map((e) => deserialize<_i48.SubtitlePhrase>(e))
              .toList()
          as T;
    }
    if (t == List<_i46.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i46.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i46.SubtitleKaraokeSegment>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i46.SubtitleKaraokeSegment>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i53.SubtitleReviewQueueItem>) {
      return (data as List)
              .map((e) => deserialize<_i53.SubtitleReviewQueueItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i52.SubtitleReviewEvent>) {
      return (data as List)
              .map((e) => deserialize<_i52.SubtitleReviewEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i11.CommentReplyDto>) {
      return (data as List)
              .map((e) => deserialize<_i11.CommentReplyDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i73.WordListItemDetail>) {
      return (data as List)
              .map((e) => deserialize<_i73.WordListItemDetail>(e))
              .toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i74.AsrJob>) {
      return (data as List).map((e) => deserialize<_i74.AsrJob>(e)).toList()
          as T;
    }
    if (t == List<_i75.Video>) {
      return (data as List).map((e) => deserialize<_i75.Video>(e)).toList()
          as T;
    }
    if (t == List<_i76.SubtitleTrack>) {
      return (data as List)
              .map((e) => deserialize<_i76.SubtitleTrack>(e))
              .toList()
          as T;
    }
    if (t == List<_i77.DictionaryEntryDetail>) {
      return (data as List)
              .map((e) => deserialize<_i77.DictionaryEntryDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i78.DictionaryImportProfile>) {
      return (data as List)
              .map((e) => deserialize<_i78.DictionaryImportProfile>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i79.EntryKnowledgeState>) {
      return (data as List)
              .map((e) => deserialize<_i79.EntryKnowledgeState>(e))
              .toList()
          as T;
    }
    if (t == List<_i80.KnowledgeStateResult>) {
      return (data as List)
              .map((e) => deserialize<_i80.KnowledgeStateResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i81.KnowledgeStateQuery>) {
      return (data as List)
              .map((e) => deserialize<_i81.KnowledgeStateQuery>(e))
              .toList()
          as T;
    }
    if (t == List<_i82.AppNotification>) {
      return (data as List)
              .map((e) => deserialize<_i82.AppNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_i83.ScriptConversionProfile>) {
      return (data as List)
              .map((e) => deserialize<_i83.ScriptConversionProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_i84.ScriptConversionEntry>) {
      return (data as List)
              .map((e) => deserialize<_i84.ScriptConversionEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i85.WatchHistory>) {
      return (data as List)
              .map((e) => deserialize<_i85.WatchHistory>(e))
              .toList()
          as T;
    }
    if (t == List<_i86.SubtitleCueDetail>) {
      return (data as List)
              .map((e) => deserialize<_i86.SubtitleCueDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i87.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i87.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == List<_i88.SubtitleKaraokeSegmentInput>) {
      return (data as List)
              .map((e) => deserialize<_i88.SubtitleKaraokeSegmentInput>(e))
              .toList()
          as T;
    }
    if (t == List<_i89.VideoSeries>) {
      return (data as List)
              .map((e) => deserialize<_i89.VideoSeries>(e))
              .toList()
          as T;
    }
    if (t == List<_i90.WordList>) {
      return (data as List).map((e) => deserialize<_i90.WordList>(e)).toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.AppNotification => 'AppNotification',
      _i6.AppProfile => 'AppProfile',
      _i7.AsrJob => 'AsrJob',
      _i8.AsrJobStatus => 'AsrJobStatus',
      _i9.CommentLike => 'CommentLike',
      _i10.CommentPageDto => 'CommentPageDto',
      _i11.CommentReplyDto => 'CommentReplyDto',
      _i12.CommentReplyLike => 'CommentReplyLike',
      _i13.CommentReplyRow => 'CommentReplyRow',
      _i14.CreatorFollow => 'CreatorFollow',
      _i15.DictionaryDefinition => 'DictionaryDefinition',
      _i16.DictionaryEntry => 'DictionaryEntry',
      _i17.DictionaryEntryDetail => 'DictionaryEntryDetail',
      _i18.DictionaryExample => 'DictionaryExample',
      _i19.DictionaryExampleDetail => 'DictionaryExampleDetail',
      _i20.DictionaryExampleText => 'DictionaryExampleText',
      _i21.DictionaryForm => 'DictionaryForm',
      _i22.DictionaryImportCommitResult => 'DictionaryImportCommitResult',
      _i23.DictionaryImportMapping => 'DictionaryImportMapping',
      _i24.DictionaryImportPreview => 'DictionaryImportPreview',
      _i25.DictionaryImportPreviewRow => 'DictionaryImportPreviewRow',
      _i26.DictionaryImportProfile => 'DictionaryImportProfile',
      _i27.DictionaryImportProfileDetail => 'DictionaryImportProfileDetail',
      _i28.DictionaryRelation => 'DictionaryRelation',
      _i29.DictionaryRelationDetail => 'DictionaryRelationDetail',
      _i30.EntryKnowledgeState => 'EntryKnowledgeState',
      _i31.Greeting => 'Greeting',
      _i32.KnowledgeStateQuery => 'KnowledgeStateQuery',
      _i33.KnowledgeStateResult => 'KnowledgeStateResult',
      _i34.NotificationSettings => 'NotificationSettings',
      _i35.NotificationType => 'NotificationType',
      _i36.PrivacySettings => 'PrivacySettings',
      _i37.ProfileStats => 'ProfileStats',
      _i38.ScriptConversionCommitResult => 'ScriptConversionCommitResult',
      _i39.ScriptConversionEntry => 'ScriptConversionEntry',
      _i40.ScriptConversionImportPreview => 'ScriptConversionImportPreview',
      _i41.ScriptConversionImportPreviewRow =>
        'ScriptConversionImportPreviewRow',
      _i42.ScriptConversionProfile => 'ScriptConversionProfile',
      _i43.SubtitleCue => 'SubtitleCue',
      _i44.SubtitleCueDetail => 'SubtitleCueDetail',
      _i45.SubtitleCueText => 'SubtitleCueText',
      _i46.SubtitleKaraokeSegment => 'SubtitleKaraokeSegment',
      _i47.SubtitleKaraokeSegmentInput => 'SubtitleKaraokeSegmentInput',
      _i48.SubtitlePhrase => 'SubtitlePhrase',
      _i49.SubtitlePublishState => 'SubtitlePublishState',
      _i50.SubtitlePublishStatus => 'SubtitlePublishStatus',
      _i51.SubtitleReviewDashboard => 'SubtitleReviewDashboard',
      _i52.SubtitleReviewEvent => 'SubtitleReviewEvent',
      _i53.SubtitleReviewQueueItem => 'SubtitleReviewQueueItem',
      _i54.SubtitleReviewTask => 'SubtitleReviewTask',
      _i55.SubtitleReviewTaskDetail => 'SubtitleReviewTaskDetail',
      _i56.SubtitleReviewTaskStatus => 'SubtitleReviewTaskStatus',
      _i57.SubtitleSrtPreview => 'SubtitleSrtPreview',
      _i58.SubtitleToken => 'SubtitleToken',
      _i59.SubtitleTrack => 'SubtitleTrack',
      _i60.UserKnownEntry => 'UserKnownEntry',
      _i61.Video => 'Video',
      _i62.VideoCommentDto => 'VideoCommentDto',
      _i63.VideoCommentRow => 'VideoCommentRow',
      _i64.VideoContentType => 'VideoContentType',
      _i65.VideoFavorite => 'VideoFavorite',
      _i66.VideoLike => 'VideoLike',
      _i67.VideoSeries => 'VideoSeries',
      _i68.VideoStatus => 'VideoStatus',
      _i69.WatchHistory => 'WatchHistory',
      _i70.WordList => 'WordList',
      _i71.WordListDetail => 'WordListDetail',
      _i72.WordListItem => 'WordListItem',
      _i73.WordListItemDetail => 'WordListItemDetail',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'clyven_backend.',
        '',
      );
    }

    switch (data) {
      case _i5.AppNotification():
        return 'AppNotification';
      case _i6.AppProfile():
        return 'AppProfile';
      case _i7.AsrJob():
        return 'AsrJob';
      case _i8.AsrJobStatus():
        return 'AsrJobStatus';
      case _i9.CommentLike():
        return 'CommentLike';
      case _i10.CommentPageDto():
        return 'CommentPageDto';
      case _i11.CommentReplyDto():
        return 'CommentReplyDto';
      case _i12.CommentReplyLike():
        return 'CommentReplyLike';
      case _i13.CommentReplyRow():
        return 'CommentReplyRow';
      case _i14.CreatorFollow():
        return 'CreatorFollow';
      case _i15.DictionaryDefinition():
        return 'DictionaryDefinition';
      case _i16.DictionaryEntry():
        return 'DictionaryEntry';
      case _i17.DictionaryEntryDetail():
        return 'DictionaryEntryDetail';
      case _i18.DictionaryExample():
        return 'DictionaryExample';
      case _i19.DictionaryExampleDetail():
        return 'DictionaryExampleDetail';
      case _i20.DictionaryExampleText():
        return 'DictionaryExampleText';
      case _i21.DictionaryForm():
        return 'DictionaryForm';
      case _i22.DictionaryImportCommitResult():
        return 'DictionaryImportCommitResult';
      case _i23.DictionaryImportMapping():
        return 'DictionaryImportMapping';
      case _i24.DictionaryImportPreview():
        return 'DictionaryImportPreview';
      case _i25.DictionaryImportPreviewRow():
        return 'DictionaryImportPreviewRow';
      case _i26.DictionaryImportProfile():
        return 'DictionaryImportProfile';
      case _i27.DictionaryImportProfileDetail():
        return 'DictionaryImportProfileDetail';
      case _i28.DictionaryRelation():
        return 'DictionaryRelation';
      case _i29.DictionaryRelationDetail():
        return 'DictionaryRelationDetail';
      case _i30.EntryKnowledgeState():
        return 'EntryKnowledgeState';
      case _i31.Greeting():
        return 'Greeting';
      case _i32.KnowledgeStateQuery():
        return 'KnowledgeStateQuery';
      case _i33.KnowledgeStateResult():
        return 'KnowledgeStateResult';
      case _i34.NotificationSettings():
        return 'NotificationSettings';
      case _i35.NotificationType():
        return 'NotificationType';
      case _i36.PrivacySettings():
        return 'PrivacySettings';
      case _i37.ProfileStats():
        return 'ProfileStats';
      case _i38.ScriptConversionCommitResult():
        return 'ScriptConversionCommitResult';
      case _i39.ScriptConversionEntry():
        return 'ScriptConversionEntry';
      case _i40.ScriptConversionImportPreview():
        return 'ScriptConversionImportPreview';
      case _i41.ScriptConversionImportPreviewRow():
        return 'ScriptConversionImportPreviewRow';
      case _i42.ScriptConversionProfile():
        return 'ScriptConversionProfile';
      case _i43.SubtitleCue():
        return 'SubtitleCue';
      case _i44.SubtitleCueDetail():
        return 'SubtitleCueDetail';
      case _i45.SubtitleCueText():
        return 'SubtitleCueText';
      case _i46.SubtitleKaraokeSegment():
        return 'SubtitleKaraokeSegment';
      case _i47.SubtitleKaraokeSegmentInput():
        return 'SubtitleKaraokeSegmentInput';
      case _i48.SubtitlePhrase():
        return 'SubtitlePhrase';
      case _i49.SubtitlePublishState():
        return 'SubtitlePublishState';
      case _i50.SubtitlePublishStatus():
        return 'SubtitlePublishStatus';
      case _i51.SubtitleReviewDashboard():
        return 'SubtitleReviewDashboard';
      case _i52.SubtitleReviewEvent():
        return 'SubtitleReviewEvent';
      case _i53.SubtitleReviewQueueItem():
        return 'SubtitleReviewQueueItem';
      case _i54.SubtitleReviewTask():
        return 'SubtitleReviewTask';
      case _i55.SubtitleReviewTaskDetail():
        return 'SubtitleReviewTaskDetail';
      case _i56.SubtitleReviewTaskStatus():
        return 'SubtitleReviewTaskStatus';
      case _i57.SubtitleSrtPreview():
        return 'SubtitleSrtPreview';
      case _i58.SubtitleToken():
        return 'SubtitleToken';
      case _i59.SubtitleTrack():
        return 'SubtitleTrack';
      case _i60.UserKnownEntry():
        return 'UserKnownEntry';
      case _i61.Video():
        return 'Video';
      case _i62.VideoCommentDto():
        return 'VideoCommentDto';
      case _i63.VideoCommentRow():
        return 'VideoCommentRow';
      case _i64.VideoContentType():
        return 'VideoContentType';
      case _i65.VideoFavorite():
        return 'VideoFavorite';
      case _i66.VideoLike():
        return 'VideoLike';
      case _i67.VideoSeries():
        return 'VideoSeries';
      case _i68.VideoStatus():
        return 'VideoStatus';
      case _i69.WatchHistory():
        return 'WatchHistory';
      case _i70.WordList():
        return 'WordList';
      case _i71.WordListDetail():
        return 'WordListDetail';
      case _i72.WordListItem():
        return 'WordListItem';
      case _i73.WordListItemDetail():
        return 'WordListItemDetail';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AppNotification') {
      return deserialize<_i5.AppNotification>(data['data']);
    }
    if (dataClassName == 'AppProfile') {
      return deserialize<_i6.AppProfile>(data['data']);
    }
    if (dataClassName == 'AsrJob') {
      return deserialize<_i7.AsrJob>(data['data']);
    }
    if (dataClassName == 'AsrJobStatus') {
      return deserialize<_i8.AsrJobStatus>(data['data']);
    }
    if (dataClassName == 'CommentLike') {
      return deserialize<_i9.CommentLike>(data['data']);
    }
    if (dataClassName == 'CommentPageDto') {
      return deserialize<_i10.CommentPageDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyDto') {
      return deserialize<_i11.CommentReplyDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyLike') {
      return deserialize<_i12.CommentReplyLike>(data['data']);
    }
    if (dataClassName == 'CommentReplyRow') {
      return deserialize<_i13.CommentReplyRow>(data['data']);
    }
    if (dataClassName == 'CreatorFollow') {
      return deserialize<_i14.CreatorFollow>(data['data']);
    }
    if (dataClassName == 'DictionaryDefinition') {
      return deserialize<_i15.DictionaryDefinition>(data['data']);
    }
    if (dataClassName == 'DictionaryEntry') {
      return deserialize<_i16.DictionaryEntry>(data['data']);
    }
    if (dataClassName == 'DictionaryEntryDetail') {
      return deserialize<_i17.DictionaryEntryDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExample') {
      return deserialize<_i18.DictionaryExample>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleDetail') {
      return deserialize<_i19.DictionaryExampleDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleText') {
      return deserialize<_i20.DictionaryExampleText>(data['data']);
    }
    if (dataClassName == 'DictionaryForm') {
      return deserialize<_i21.DictionaryForm>(data['data']);
    }
    if (dataClassName == 'DictionaryImportCommitResult') {
      return deserialize<_i22.DictionaryImportCommitResult>(data['data']);
    }
    if (dataClassName == 'DictionaryImportMapping') {
      return deserialize<_i23.DictionaryImportMapping>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreview') {
      return deserialize<_i24.DictionaryImportPreview>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreviewRow') {
      return deserialize<_i25.DictionaryImportPreviewRow>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfile') {
      return deserialize<_i26.DictionaryImportProfile>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfileDetail') {
      return deserialize<_i27.DictionaryImportProfileDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryRelation') {
      return deserialize<_i28.DictionaryRelation>(data['data']);
    }
    if (dataClassName == 'DictionaryRelationDetail') {
      return deserialize<_i29.DictionaryRelationDetail>(data['data']);
    }
    if (dataClassName == 'EntryKnowledgeState') {
      return deserialize<_i30.EntryKnowledgeState>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i31.Greeting>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateQuery') {
      return deserialize<_i32.KnowledgeStateQuery>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateResult') {
      return deserialize<_i33.KnowledgeStateResult>(data['data']);
    }
    if (dataClassName == 'NotificationSettings') {
      return deserialize<_i34.NotificationSettings>(data['data']);
    }
    if (dataClassName == 'NotificationType') {
      return deserialize<_i35.NotificationType>(data['data']);
    }
    if (dataClassName == 'PrivacySettings') {
      return deserialize<_i36.PrivacySettings>(data['data']);
    }
    if (dataClassName == 'ProfileStats') {
      return deserialize<_i37.ProfileStats>(data['data']);
    }
    if (dataClassName == 'ScriptConversionCommitResult') {
      return deserialize<_i38.ScriptConversionCommitResult>(data['data']);
    }
    if (dataClassName == 'ScriptConversionEntry') {
      return deserialize<_i39.ScriptConversionEntry>(data['data']);
    }
    if (dataClassName == 'ScriptConversionImportPreview') {
      return deserialize<_i40.ScriptConversionImportPreview>(data['data']);
    }
    if (dataClassName == 'ScriptConversionImportPreviewRow') {
      return deserialize<_i41.ScriptConversionImportPreviewRow>(data['data']);
    }
    if (dataClassName == 'ScriptConversionProfile') {
      return deserialize<_i42.ScriptConversionProfile>(data['data']);
    }
    if (dataClassName == 'SubtitleCue') {
      return deserialize<_i43.SubtitleCue>(data['data']);
    }
    if (dataClassName == 'SubtitleCueDetail') {
      return deserialize<_i44.SubtitleCueDetail>(data['data']);
    }
    if (dataClassName == 'SubtitleCueText') {
      return deserialize<_i45.SubtitleCueText>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegment') {
      return deserialize<_i46.SubtitleKaraokeSegment>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegmentInput') {
      return deserialize<_i47.SubtitleKaraokeSegmentInput>(data['data']);
    }
    if (dataClassName == 'SubtitlePhrase') {
      return deserialize<_i48.SubtitlePhrase>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishState') {
      return deserialize<_i49.SubtitlePublishState>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishStatus') {
      return deserialize<_i50.SubtitlePublishStatus>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewDashboard') {
      return deserialize<_i51.SubtitleReviewDashboard>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewEvent') {
      return deserialize<_i52.SubtitleReviewEvent>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewQueueItem') {
      return deserialize<_i53.SubtitleReviewQueueItem>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTask') {
      return deserialize<_i54.SubtitleReviewTask>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTaskDetail') {
      return deserialize<_i55.SubtitleReviewTaskDetail>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTaskStatus') {
      return deserialize<_i56.SubtitleReviewTaskStatus>(data['data']);
    }
    if (dataClassName == 'SubtitleSrtPreview') {
      return deserialize<_i57.SubtitleSrtPreview>(data['data']);
    }
    if (dataClassName == 'SubtitleToken') {
      return deserialize<_i58.SubtitleToken>(data['data']);
    }
    if (dataClassName == 'SubtitleTrack') {
      return deserialize<_i59.SubtitleTrack>(data['data']);
    }
    if (dataClassName == 'UserKnownEntry') {
      return deserialize<_i60.UserKnownEntry>(data['data']);
    }
    if (dataClassName == 'Video') {
      return deserialize<_i61.Video>(data['data']);
    }
    if (dataClassName == 'VideoCommentDto') {
      return deserialize<_i62.VideoCommentDto>(data['data']);
    }
    if (dataClassName == 'VideoCommentRow') {
      return deserialize<_i63.VideoCommentRow>(data['data']);
    }
    if (dataClassName == 'VideoContentType') {
      return deserialize<_i64.VideoContentType>(data['data']);
    }
    if (dataClassName == 'VideoFavorite') {
      return deserialize<_i65.VideoFavorite>(data['data']);
    }
    if (dataClassName == 'VideoLike') {
      return deserialize<_i66.VideoLike>(data['data']);
    }
    if (dataClassName == 'VideoSeries') {
      return deserialize<_i67.VideoSeries>(data['data']);
    }
    if (dataClassName == 'VideoStatus') {
      return deserialize<_i68.VideoStatus>(data['data']);
    }
    if (dataClassName == 'WatchHistory') {
      return deserialize<_i69.WatchHistory>(data['data']);
    }
    if (dataClassName == 'WordList') {
      return deserialize<_i70.WordList>(data['data']);
    }
    if (dataClassName == 'WordListDetail') {
      return deserialize<_i71.WordListDetail>(data['data']);
    }
    if (dataClassName == 'WordListItem') {
      return deserialize<_i72.WordListItem>(data['data']);
    }
    if (dataClassName == 'WordListItemDetail') {
      return deserialize<_i73.WordListItemDetail>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.AppNotification:
        return _i5.AppNotification.t;
      case _i6.AppProfile:
        return _i6.AppProfile.t;
      case _i7.AsrJob:
        return _i7.AsrJob.t;
      case _i9.CommentLike:
        return _i9.CommentLike.t;
      case _i12.CommentReplyLike:
        return _i12.CommentReplyLike.t;
      case _i13.CommentReplyRow:
        return _i13.CommentReplyRow.t;
      case _i14.CreatorFollow:
        return _i14.CreatorFollow.t;
      case _i15.DictionaryDefinition:
        return _i15.DictionaryDefinition.t;
      case _i16.DictionaryEntry:
        return _i16.DictionaryEntry.t;
      case _i18.DictionaryExample:
        return _i18.DictionaryExample.t;
      case _i20.DictionaryExampleText:
        return _i20.DictionaryExampleText.t;
      case _i21.DictionaryForm:
        return _i21.DictionaryForm.t;
      case _i23.DictionaryImportMapping:
        return _i23.DictionaryImportMapping.t;
      case _i26.DictionaryImportProfile:
        return _i26.DictionaryImportProfile.t;
      case _i28.DictionaryRelation:
        return _i28.DictionaryRelation.t;
      case _i34.NotificationSettings:
        return _i34.NotificationSettings.t;
      case _i36.PrivacySettings:
        return _i36.PrivacySettings.t;
      case _i39.ScriptConversionEntry:
        return _i39.ScriptConversionEntry.t;
      case _i42.ScriptConversionProfile:
        return _i42.ScriptConversionProfile.t;
      case _i43.SubtitleCue:
        return _i43.SubtitleCue.t;
      case _i45.SubtitleCueText:
        return _i45.SubtitleCueText.t;
      case _i46.SubtitleKaraokeSegment:
        return _i46.SubtitleKaraokeSegment.t;
      case _i48.SubtitlePhrase:
        return _i48.SubtitlePhrase.t;
      case _i49.SubtitlePublishState:
        return _i49.SubtitlePublishState.t;
      case _i52.SubtitleReviewEvent:
        return _i52.SubtitleReviewEvent.t;
      case _i54.SubtitleReviewTask:
        return _i54.SubtitleReviewTask.t;
      case _i58.SubtitleToken:
        return _i58.SubtitleToken.t;
      case _i59.SubtitleTrack:
        return _i59.SubtitleTrack.t;
      case _i60.UserKnownEntry:
        return _i60.UserKnownEntry.t;
      case _i61.Video:
        return _i61.Video.t;
      case _i63.VideoCommentRow:
        return _i63.VideoCommentRow.t;
      case _i65.VideoFavorite:
        return _i65.VideoFavorite.t;
      case _i66.VideoLike:
        return _i66.VideoLike.t;
      case _i67.VideoSeries:
        return _i67.VideoSeries.t;
      case _i69.WatchHistory:
        return _i69.WatchHistory.t;
      case _i70.WordList:
        return _i70.WordList.t;
      case _i72.WordListItem:
        return _i72.WordListItem.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'clyven_backend';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
