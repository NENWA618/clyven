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
import 'app_profile.dart' as _i5;
import 'asr_job.dart' as _i6;
import 'asr_job_status.dart' as _i7;
import 'comment_like.dart' as _i8;
import 'comment_page_dto.dart' as _i9;
import 'comment_reply_dto.dart' as _i10;
import 'comment_reply_like.dart' as _i11;
import 'comment_reply_row.dart' as _i12;
import 'creator_follow.dart' as _i13;
import 'dictionary_definition.dart' as _i14;
import 'dictionary_entry.dart' as _i15;
import 'dictionary_entry_detail.dart' as _i16;
import 'dictionary_example.dart' as _i17;
import 'dictionary_example_detail.dart' as _i18;
import 'dictionary_example_text.dart' as _i19;
import 'dictionary_form.dart' as _i20;
import 'dictionary_import_commit_result.dart' as _i21;
import 'dictionary_import_mapping.dart' as _i22;
import 'dictionary_import_preview.dart' as _i23;
import 'dictionary_import_preview_row.dart' as _i24;
import 'dictionary_import_profile.dart' as _i25;
import 'dictionary_import_profile_detail.dart' as _i26;
import 'dictionary_relation.dart' as _i27;
import 'dictionary_relation_detail.dart' as _i28;
import 'entry_knowledge_state.dart' as _i29;
import 'greetings/greeting.dart' as _i30;
import 'knowledge_state_query.dart' as _i31;
import 'knowledge_state_result.dart' as _i32;
import 'profile_stats.dart' as _i33;
import 'script_conversion_commit_result.dart' as _i34;
import 'script_conversion_entry.dart' as _i35;
import 'script_conversion_import_preview.dart' as _i36;
import 'script_conversion_import_preview_row.dart' as _i37;
import 'script_conversion_profile.dart' as _i38;
import 'subtitle_cue.dart' as _i39;
import 'subtitle_cue_detail.dart' as _i40;
import 'subtitle_cue_text.dart' as _i41;
import 'subtitle_karaoke_segment.dart' as _i42;
import 'subtitle_karaoke_segment_input.dart' as _i43;
import 'subtitle_phrase.dart' as _i44;
import 'subtitle_publish_state.dart' as _i45;
import 'subtitle_publish_status.dart' as _i46;
import 'subtitle_review_dashboard.dart' as _i47;
import 'subtitle_review_event.dart' as _i48;
import 'subtitle_review_queue_item.dart' as _i49;
import 'subtitle_review_task.dart' as _i50;
import 'subtitle_review_task_detail.dart' as _i51;
import 'subtitle_review_task_status.dart' as _i52;
import 'subtitle_srt_preview.dart' as _i53;
import 'subtitle_token.dart' as _i54;
import 'subtitle_track.dart' as _i55;
import 'user_known_entry.dart' as _i56;
import 'video.dart' as _i57;
import 'video_comment_dto.dart' as _i58;
import 'video_comment_row.dart' as _i59;
import 'video_content_type.dart' as _i60;
import 'video_favorite.dart' as _i61;
import 'video_status.dart' as _i62;
import 'watch_history.dart' as _i63;
import 'word_list.dart' as _i64;
import 'word_list_detail.dart' as _i65;
import 'word_list_item.dart' as _i66;
import 'word_list_item_detail.dart' as _i67;
import 'package:clyven_backend_server/src/generated/asr_job.dart' as _i68;
import 'package:clyven_backend_server/src/generated/video.dart' as _i69;
import 'package:clyven_backend_server/src/generated/subtitle_track.dart'
    as _i70;
import 'package:clyven_backend_server/src/generated/dictionary_entry_detail.dart'
    as _i71;
import 'package:clyven_backend_server/src/generated/dictionary_import_profile.dart'
    as _i72;
import 'package:clyven_backend_server/src/generated/entry_knowledge_state.dart'
    as _i73;
import 'package:clyven_backend_server/src/generated/knowledge_state_result.dart'
    as _i74;
import 'package:clyven_backend_server/src/generated/knowledge_state_query.dart'
    as _i75;
import 'package:clyven_backend_server/src/generated/script_conversion_profile.dart'
    as _i76;
import 'package:clyven_backend_server/src/generated/script_conversion_entry.dart'
    as _i77;
import 'package:clyven_backend_server/src/generated/watch_history.dart' as _i78;
import 'package:clyven_backend_server/src/generated/subtitle_cue_detail.dart'
    as _i79;
import 'package:clyven_backend_server/src/generated/subtitle_karaoke_segment.dart'
    as _i80;
import 'package:clyven_backend_server/src/generated/subtitle_karaoke_segment_input.dart'
    as _i81;
import 'package:clyven_backend_server/src/generated/word_list.dart' as _i82;
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

    if (t == _i5.AppProfile) {
      return _i5.AppProfile.fromJson(data) as T;
    }
    if (t == _i6.AsrJob) {
      return _i6.AsrJob.fromJson(data) as T;
    }
    if (t == _i7.AsrJobStatus) {
      return _i7.AsrJobStatus.fromJson(data) as T;
    }
    if (t == _i8.CommentLike) {
      return _i8.CommentLike.fromJson(data) as T;
    }
    if (t == _i9.CommentPageDto) {
      return _i9.CommentPageDto.fromJson(data) as T;
    }
    if (t == _i10.CommentReplyDto) {
      return _i10.CommentReplyDto.fromJson(data) as T;
    }
    if (t == _i11.CommentReplyLike) {
      return _i11.CommentReplyLike.fromJson(data) as T;
    }
    if (t == _i12.CommentReplyRow) {
      return _i12.CommentReplyRow.fromJson(data) as T;
    }
    if (t == _i13.CreatorFollow) {
      return _i13.CreatorFollow.fromJson(data) as T;
    }
    if (t == _i14.DictionaryDefinition) {
      return _i14.DictionaryDefinition.fromJson(data) as T;
    }
    if (t == _i15.DictionaryEntry) {
      return _i15.DictionaryEntry.fromJson(data) as T;
    }
    if (t == _i16.DictionaryEntryDetail) {
      return _i16.DictionaryEntryDetail.fromJson(data) as T;
    }
    if (t == _i17.DictionaryExample) {
      return _i17.DictionaryExample.fromJson(data) as T;
    }
    if (t == _i18.DictionaryExampleDetail) {
      return _i18.DictionaryExampleDetail.fromJson(data) as T;
    }
    if (t == _i19.DictionaryExampleText) {
      return _i19.DictionaryExampleText.fromJson(data) as T;
    }
    if (t == _i20.DictionaryForm) {
      return _i20.DictionaryForm.fromJson(data) as T;
    }
    if (t == _i21.DictionaryImportCommitResult) {
      return _i21.DictionaryImportCommitResult.fromJson(data) as T;
    }
    if (t == _i22.DictionaryImportMapping) {
      return _i22.DictionaryImportMapping.fromJson(data) as T;
    }
    if (t == _i23.DictionaryImportPreview) {
      return _i23.DictionaryImportPreview.fromJson(data) as T;
    }
    if (t == _i24.DictionaryImportPreviewRow) {
      return _i24.DictionaryImportPreviewRow.fromJson(data) as T;
    }
    if (t == _i25.DictionaryImportProfile) {
      return _i25.DictionaryImportProfile.fromJson(data) as T;
    }
    if (t == _i26.DictionaryImportProfileDetail) {
      return _i26.DictionaryImportProfileDetail.fromJson(data) as T;
    }
    if (t == _i27.DictionaryRelation) {
      return _i27.DictionaryRelation.fromJson(data) as T;
    }
    if (t == _i28.DictionaryRelationDetail) {
      return _i28.DictionaryRelationDetail.fromJson(data) as T;
    }
    if (t == _i29.EntryKnowledgeState) {
      return _i29.EntryKnowledgeState.fromJson(data) as T;
    }
    if (t == _i30.Greeting) {
      return _i30.Greeting.fromJson(data) as T;
    }
    if (t == _i31.KnowledgeStateQuery) {
      return _i31.KnowledgeStateQuery.fromJson(data) as T;
    }
    if (t == _i32.KnowledgeStateResult) {
      return _i32.KnowledgeStateResult.fromJson(data) as T;
    }
    if (t == _i33.ProfileStats) {
      return _i33.ProfileStats.fromJson(data) as T;
    }
    if (t == _i34.ScriptConversionCommitResult) {
      return _i34.ScriptConversionCommitResult.fromJson(data) as T;
    }
    if (t == _i35.ScriptConversionEntry) {
      return _i35.ScriptConversionEntry.fromJson(data) as T;
    }
    if (t == _i36.ScriptConversionImportPreview) {
      return _i36.ScriptConversionImportPreview.fromJson(data) as T;
    }
    if (t == _i37.ScriptConversionImportPreviewRow) {
      return _i37.ScriptConversionImportPreviewRow.fromJson(data) as T;
    }
    if (t == _i38.ScriptConversionProfile) {
      return _i38.ScriptConversionProfile.fromJson(data) as T;
    }
    if (t == _i39.SubtitleCue) {
      return _i39.SubtitleCue.fromJson(data) as T;
    }
    if (t == _i40.SubtitleCueDetail) {
      return _i40.SubtitleCueDetail.fromJson(data) as T;
    }
    if (t == _i41.SubtitleCueText) {
      return _i41.SubtitleCueText.fromJson(data) as T;
    }
    if (t == _i42.SubtitleKaraokeSegment) {
      return _i42.SubtitleKaraokeSegment.fromJson(data) as T;
    }
    if (t == _i43.SubtitleKaraokeSegmentInput) {
      return _i43.SubtitleKaraokeSegmentInput.fromJson(data) as T;
    }
    if (t == _i44.SubtitlePhrase) {
      return _i44.SubtitlePhrase.fromJson(data) as T;
    }
    if (t == _i45.SubtitlePublishState) {
      return _i45.SubtitlePublishState.fromJson(data) as T;
    }
    if (t == _i46.SubtitlePublishStatus) {
      return _i46.SubtitlePublishStatus.fromJson(data) as T;
    }
    if (t == _i47.SubtitleReviewDashboard) {
      return _i47.SubtitleReviewDashboard.fromJson(data) as T;
    }
    if (t == _i48.SubtitleReviewEvent) {
      return _i48.SubtitleReviewEvent.fromJson(data) as T;
    }
    if (t == _i49.SubtitleReviewQueueItem) {
      return _i49.SubtitleReviewQueueItem.fromJson(data) as T;
    }
    if (t == _i50.SubtitleReviewTask) {
      return _i50.SubtitleReviewTask.fromJson(data) as T;
    }
    if (t == _i51.SubtitleReviewTaskDetail) {
      return _i51.SubtitleReviewTaskDetail.fromJson(data) as T;
    }
    if (t == _i52.SubtitleReviewTaskStatus) {
      return _i52.SubtitleReviewTaskStatus.fromJson(data) as T;
    }
    if (t == _i53.SubtitleSrtPreview) {
      return _i53.SubtitleSrtPreview.fromJson(data) as T;
    }
    if (t == _i54.SubtitleToken) {
      return _i54.SubtitleToken.fromJson(data) as T;
    }
    if (t == _i55.SubtitleTrack) {
      return _i55.SubtitleTrack.fromJson(data) as T;
    }
    if (t == _i56.UserKnownEntry) {
      return _i56.UserKnownEntry.fromJson(data) as T;
    }
    if (t == _i57.Video) {
      return _i57.Video.fromJson(data) as T;
    }
    if (t == _i58.VideoCommentDto) {
      return _i58.VideoCommentDto.fromJson(data) as T;
    }
    if (t == _i59.VideoCommentRow) {
      return _i59.VideoCommentRow.fromJson(data) as T;
    }
    if (t == _i60.VideoContentType) {
      return _i60.VideoContentType.fromJson(data) as T;
    }
    if (t == _i61.VideoFavorite) {
      return _i61.VideoFavorite.fromJson(data) as T;
    }
    if (t == _i62.VideoStatus) {
      return _i62.VideoStatus.fromJson(data) as T;
    }
    if (t == _i63.WatchHistory) {
      return _i63.WatchHistory.fromJson(data) as T;
    }
    if (t == _i64.WordList) {
      return _i64.WordList.fromJson(data) as T;
    }
    if (t == _i65.WordListDetail) {
      return _i65.WordListDetail.fromJson(data) as T;
    }
    if (t == _i66.WordListItem) {
      return _i66.WordListItem.fromJson(data) as T;
    }
    if (t == _i67.WordListItemDetail) {
      return _i67.WordListItemDetail.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AppProfile?>()) {
      return (data != null ? _i5.AppProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AsrJob?>()) {
      return (data != null ? _i6.AsrJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AsrJobStatus?>()) {
      return (data != null ? _i7.AsrJobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CommentLike?>()) {
      return (data != null ? _i8.CommentLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.CommentPageDto?>()) {
      return (data != null ? _i9.CommentPageDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.CommentReplyDto?>()) {
      return (data != null ? _i10.CommentReplyDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.CommentReplyLike?>()) {
      return (data != null ? _i11.CommentReplyLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.CommentReplyRow?>()) {
      return (data != null ? _i12.CommentReplyRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.CreatorFollow?>()) {
      return (data != null ? _i13.CreatorFollow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.DictionaryDefinition?>()) {
      return (data != null ? _i14.DictionaryDefinition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.DictionaryEntry?>()) {
      return (data != null ? _i15.DictionaryEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.DictionaryEntryDetail?>()) {
      return (data != null ? _i16.DictionaryEntryDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.DictionaryExample?>()) {
      return (data != null ? _i17.DictionaryExample.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.DictionaryExampleDetail?>()) {
      return (data != null ? _i18.DictionaryExampleDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.DictionaryExampleText?>()) {
      return (data != null ? _i19.DictionaryExampleText.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.DictionaryForm?>()) {
      return (data != null ? _i20.DictionaryForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.DictionaryImportCommitResult?>()) {
      return (data != null
              ? _i21.DictionaryImportCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i22.DictionaryImportMapping?>()) {
      return (data != null ? _i22.DictionaryImportMapping.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.DictionaryImportPreview?>()) {
      return (data != null ? _i23.DictionaryImportPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.DictionaryImportPreviewRow?>()) {
      return (data != null
              ? _i24.DictionaryImportPreviewRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i25.DictionaryImportProfile?>()) {
      return (data != null ? _i25.DictionaryImportProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.DictionaryImportProfileDetail?>()) {
      return (data != null
              ? _i26.DictionaryImportProfileDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i27.DictionaryRelation?>()) {
      return (data != null ? _i27.DictionaryRelation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.DictionaryRelationDetail?>()) {
      return (data != null
              ? _i28.DictionaryRelationDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i29.EntryKnowledgeState?>()) {
      return (data != null ? _i29.EntryKnowledgeState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i30.Greeting?>()) {
      return (data != null ? _i30.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.KnowledgeStateQuery?>()) {
      return (data != null ? _i31.KnowledgeStateQuery.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.KnowledgeStateResult?>()) {
      return (data != null ? _i32.KnowledgeStateResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.ProfileStats?>()) {
      return (data != null ? _i33.ProfileStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.ScriptConversionCommitResult?>()) {
      return (data != null
              ? _i34.ScriptConversionCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i35.ScriptConversionEntry?>()) {
      return (data != null ? _i35.ScriptConversionEntry.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i36.ScriptConversionImportPreview?>()) {
      return (data != null
              ? _i36.ScriptConversionImportPreview.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i37.ScriptConversionImportPreviewRow?>()) {
      return (data != null
              ? _i37.ScriptConversionImportPreviewRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i38.ScriptConversionProfile?>()) {
      return (data != null ? _i38.ScriptConversionProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.SubtitleCue?>()) {
      return (data != null ? _i39.SubtitleCue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.SubtitleCueDetail?>()) {
      return (data != null ? _i40.SubtitleCueDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.SubtitleCueText?>()) {
      return (data != null ? _i41.SubtitleCueText.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.SubtitleKaraokeSegment?>()) {
      return (data != null ? _i42.SubtitleKaraokeSegment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i43.SubtitleKaraokeSegmentInput?>()) {
      return (data != null
              ? _i43.SubtitleKaraokeSegmentInput.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i44.SubtitlePhrase?>()) {
      return (data != null ? _i44.SubtitlePhrase.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.SubtitlePublishState?>()) {
      return (data != null ? _i45.SubtitlePublishState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i46.SubtitlePublishStatus?>()) {
      return (data != null ? _i46.SubtitlePublishStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i47.SubtitleReviewDashboard?>()) {
      return (data != null ? _i47.SubtitleReviewDashboard.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i48.SubtitleReviewEvent?>()) {
      return (data != null ? _i48.SubtitleReviewEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i49.SubtitleReviewQueueItem?>()) {
      return (data != null ? _i49.SubtitleReviewQueueItem.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i50.SubtitleReviewTask?>()) {
      return (data != null ? _i50.SubtitleReviewTask.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i51.SubtitleReviewTaskDetail?>()) {
      return (data != null
              ? _i51.SubtitleReviewTaskDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i52.SubtitleReviewTaskStatus?>()) {
      return (data != null
              ? _i52.SubtitleReviewTaskStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i53.SubtitleSrtPreview?>()) {
      return (data != null ? _i53.SubtitleSrtPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.SubtitleToken?>()) {
      return (data != null ? _i54.SubtitleToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.SubtitleTrack?>()) {
      return (data != null ? _i55.SubtitleTrack.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.UserKnownEntry?>()) {
      return (data != null ? _i56.UserKnownEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.Video?>()) {
      return (data != null ? _i57.Video.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.VideoCommentDto?>()) {
      return (data != null ? _i58.VideoCommentDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.VideoCommentRow?>()) {
      return (data != null ? _i59.VideoCommentRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.VideoContentType?>()) {
      return (data != null ? _i60.VideoContentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.VideoFavorite?>()) {
      return (data != null ? _i61.VideoFavorite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.VideoStatus?>()) {
      return (data != null ? _i62.VideoStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.WatchHistory?>()) {
      return (data != null ? _i63.WatchHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.WordList?>()) {
      return (data != null ? _i64.WordList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.WordListDetail?>()) {
      return (data != null ? _i65.WordListDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.WordListItem?>()) {
      return (data != null ? _i66.WordListItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.WordListItemDetail?>()) {
      return (data != null ? _i67.WordListItemDetail.fromJson(data) : null)
          as T;
    }
    if (t == List<_i58.VideoCommentDto>) {
      return (data as List)
              .map((e) => deserialize<_i58.VideoCommentDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i14.DictionaryDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i14.DictionaryDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.DictionaryForm>) {
      return (data as List)
              .map((e) => deserialize<_i20.DictionaryForm>(e))
              .toList()
          as T;
    }
    if (t == List<_i18.DictionaryExampleDetail>) {
      return (data as List)
              .map((e) => deserialize<_i18.DictionaryExampleDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i28.DictionaryRelationDetail>) {
      return (data as List)
              .map((e) => deserialize<_i28.DictionaryRelationDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i19.DictionaryExampleText>) {
      return (data as List)
              .map((e) => deserialize<_i19.DictionaryExampleText>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i24.DictionaryImportPreviewRow>) {
      return (data as List)
              .map((e) => deserialize<_i24.DictionaryImportPreviewRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.DictionaryImportMapping>) {
      return (data as List)
              .map((e) => deserialize<_i22.DictionaryImportMapping>(e))
              .toList()
          as T;
    }
    if (t == List<_i37.ScriptConversionImportPreviewRow>) {
      return (data as List)
              .map((e) => deserialize<_i37.ScriptConversionImportPreviewRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i41.SubtitleCueText>) {
      return (data as List)
              .map((e) => deserialize<_i41.SubtitleCueText>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i41.SubtitleCueText>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i41.SubtitleCueText>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i54.SubtitleToken>) {
      return (data as List)
              .map((e) => deserialize<_i54.SubtitleToken>(e))
              .toList()
          as T;
    }
    if (t == List<_i44.SubtitlePhrase>) {
      return (data as List)
              .map((e) => deserialize<_i44.SubtitlePhrase>(e))
              .toList()
          as T;
    }
    if (t == List<_i42.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i42.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i42.SubtitleKaraokeSegment>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i42.SubtitleKaraokeSegment>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i49.SubtitleReviewQueueItem>) {
      return (data as List)
              .map((e) => deserialize<_i49.SubtitleReviewQueueItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i48.SubtitleReviewEvent>) {
      return (data as List)
              .map((e) => deserialize<_i48.SubtitleReviewEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i10.CommentReplyDto>) {
      return (data as List)
              .map((e) => deserialize<_i10.CommentReplyDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i67.WordListItemDetail>) {
      return (data as List)
              .map((e) => deserialize<_i67.WordListItemDetail>(e))
              .toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i68.AsrJob>) {
      return (data as List).map((e) => deserialize<_i68.AsrJob>(e)).toList()
          as T;
    }
    if (t == List<_i69.Video>) {
      return (data as List).map((e) => deserialize<_i69.Video>(e)).toList()
          as T;
    }
    if (t == List<_i70.SubtitleTrack>) {
      return (data as List)
              .map((e) => deserialize<_i70.SubtitleTrack>(e))
              .toList()
          as T;
    }
    if (t == List<_i71.DictionaryEntryDetail>) {
      return (data as List)
              .map((e) => deserialize<_i71.DictionaryEntryDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i72.DictionaryImportProfile>) {
      return (data as List)
              .map((e) => deserialize<_i72.DictionaryImportProfile>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i73.EntryKnowledgeState>) {
      return (data as List)
              .map((e) => deserialize<_i73.EntryKnowledgeState>(e))
              .toList()
          as T;
    }
    if (t == List<_i74.KnowledgeStateResult>) {
      return (data as List)
              .map((e) => deserialize<_i74.KnowledgeStateResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i75.KnowledgeStateQuery>) {
      return (data as List)
              .map((e) => deserialize<_i75.KnowledgeStateQuery>(e))
              .toList()
          as T;
    }
    if (t == List<_i76.ScriptConversionProfile>) {
      return (data as List)
              .map((e) => deserialize<_i76.ScriptConversionProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_i77.ScriptConversionEntry>) {
      return (data as List)
              .map((e) => deserialize<_i77.ScriptConversionEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i78.WatchHistory>) {
      return (data as List)
              .map((e) => deserialize<_i78.WatchHistory>(e))
              .toList()
          as T;
    }
    if (t == List<_i79.SubtitleCueDetail>) {
      return (data as List)
              .map((e) => deserialize<_i79.SubtitleCueDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i80.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i80.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == List<_i81.SubtitleKaraokeSegmentInput>) {
      return (data as List)
              .map((e) => deserialize<_i81.SubtitleKaraokeSegmentInput>(e))
              .toList()
          as T;
    }
    if (t == List<_i82.WordList>) {
      return (data as List).map((e) => deserialize<_i82.WordList>(e)).toList()
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
      _i5.AppProfile => 'AppProfile',
      _i6.AsrJob => 'AsrJob',
      _i7.AsrJobStatus => 'AsrJobStatus',
      _i8.CommentLike => 'CommentLike',
      _i9.CommentPageDto => 'CommentPageDto',
      _i10.CommentReplyDto => 'CommentReplyDto',
      _i11.CommentReplyLike => 'CommentReplyLike',
      _i12.CommentReplyRow => 'CommentReplyRow',
      _i13.CreatorFollow => 'CreatorFollow',
      _i14.DictionaryDefinition => 'DictionaryDefinition',
      _i15.DictionaryEntry => 'DictionaryEntry',
      _i16.DictionaryEntryDetail => 'DictionaryEntryDetail',
      _i17.DictionaryExample => 'DictionaryExample',
      _i18.DictionaryExampleDetail => 'DictionaryExampleDetail',
      _i19.DictionaryExampleText => 'DictionaryExampleText',
      _i20.DictionaryForm => 'DictionaryForm',
      _i21.DictionaryImportCommitResult => 'DictionaryImportCommitResult',
      _i22.DictionaryImportMapping => 'DictionaryImportMapping',
      _i23.DictionaryImportPreview => 'DictionaryImportPreview',
      _i24.DictionaryImportPreviewRow => 'DictionaryImportPreviewRow',
      _i25.DictionaryImportProfile => 'DictionaryImportProfile',
      _i26.DictionaryImportProfileDetail => 'DictionaryImportProfileDetail',
      _i27.DictionaryRelation => 'DictionaryRelation',
      _i28.DictionaryRelationDetail => 'DictionaryRelationDetail',
      _i29.EntryKnowledgeState => 'EntryKnowledgeState',
      _i30.Greeting => 'Greeting',
      _i31.KnowledgeStateQuery => 'KnowledgeStateQuery',
      _i32.KnowledgeStateResult => 'KnowledgeStateResult',
      _i33.ProfileStats => 'ProfileStats',
      _i34.ScriptConversionCommitResult => 'ScriptConversionCommitResult',
      _i35.ScriptConversionEntry => 'ScriptConversionEntry',
      _i36.ScriptConversionImportPreview => 'ScriptConversionImportPreview',
      _i37.ScriptConversionImportPreviewRow =>
        'ScriptConversionImportPreviewRow',
      _i38.ScriptConversionProfile => 'ScriptConversionProfile',
      _i39.SubtitleCue => 'SubtitleCue',
      _i40.SubtitleCueDetail => 'SubtitleCueDetail',
      _i41.SubtitleCueText => 'SubtitleCueText',
      _i42.SubtitleKaraokeSegment => 'SubtitleKaraokeSegment',
      _i43.SubtitleKaraokeSegmentInput => 'SubtitleKaraokeSegmentInput',
      _i44.SubtitlePhrase => 'SubtitlePhrase',
      _i45.SubtitlePublishState => 'SubtitlePublishState',
      _i46.SubtitlePublishStatus => 'SubtitlePublishStatus',
      _i47.SubtitleReviewDashboard => 'SubtitleReviewDashboard',
      _i48.SubtitleReviewEvent => 'SubtitleReviewEvent',
      _i49.SubtitleReviewQueueItem => 'SubtitleReviewQueueItem',
      _i50.SubtitleReviewTask => 'SubtitleReviewTask',
      _i51.SubtitleReviewTaskDetail => 'SubtitleReviewTaskDetail',
      _i52.SubtitleReviewTaskStatus => 'SubtitleReviewTaskStatus',
      _i53.SubtitleSrtPreview => 'SubtitleSrtPreview',
      _i54.SubtitleToken => 'SubtitleToken',
      _i55.SubtitleTrack => 'SubtitleTrack',
      _i56.UserKnownEntry => 'UserKnownEntry',
      _i57.Video => 'Video',
      _i58.VideoCommentDto => 'VideoCommentDto',
      _i59.VideoCommentRow => 'VideoCommentRow',
      _i60.VideoContentType => 'VideoContentType',
      _i61.VideoFavorite => 'VideoFavorite',
      _i62.VideoStatus => 'VideoStatus',
      _i63.WatchHistory => 'WatchHistory',
      _i64.WordList => 'WordList',
      _i65.WordListDetail => 'WordListDetail',
      _i66.WordListItem => 'WordListItem',
      _i67.WordListItemDetail => 'WordListItemDetail',
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
      case _i5.AppProfile():
        return 'AppProfile';
      case _i6.AsrJob():
        return 'AsrJob';
      case _i7.AsrJobStatus():
        return 'AsrJobStatus';
      case _i8.CommentLike():
        return 'CommentLike';
      case _i9.CommentPageDto():
        return 'CommentPageDto';
      case _i10.CommentReplyDto():
        return 'CommentReplyDto';
      case _i11.CommentReplyLike():
        return 'CommentReplyLike';
      case _i12.CommentReplyRow():
        return 'CommentReplyRow';
      case _i13.CreatorFollow():
        return 'CreatorFollow';
      case _i14.DictionaryDefinition():
        return 'DictionaryDefinition';
      case _i15.DictionaryEntry():
        return 'DictionaryEntry';
      case _i16.DictionaryEntryDetail():
        return 'DictionaryEntryDetail';
      case _i17.DictionaryExample():
        return 'DictionaryExample';
      case _i18.DictionaryExampleDetail():
        return 'DictionaryExampleDetail';
      case _i19.DictionaryExampleText():
        return 'DictionaryExampleText';
      case _i20.DictionaryForm():
        return 'DictionaryForm';
      case _i21.DictionaryImportCommitResult():
        return 'DictionaryImportCommitResult';
      case _i22.DictionaryImportMapping():
        return 'DictionaryImportMapping';
      case _i23.DictionaryImportPreview():
        return 'DictionaryImportPreview';
      case _i24.DictionaryImportPreviewRow():
        return 'DictionaryImportPreviewRow';
      case _i25.DictionaryImportProfile():
        return 'DictionaryImportProfile';
      case _i26.DictionaryImportProfileDetail():
        return 'DictionaryImportProfileDetail';
      case _i27.DictionaryRelation():
        return 'DictionaryRelation';
      case _i28.DictionaryRelationDetail():
        return 'DictionaryRelationDetail';
      case _i29.EntryKnowledgeState():
        return 'EntryKnowledgeState';
      case _i30.Greeting():
        return 'Greeting';
      case _i31.KnowledgeStateQuery():
        return 'KnowledgeStateQuery';
      case _i32.KnowledgeStateResult():
        return 'KnowledgeStateResult';
      case _i33.ProfileStats():
        return 'ProfileStats';
      case _i34.ScriptConversionCommitResult():
        return 'ScriptConversionCommitResult';
      case _i35.ScriptConversionEntry():
        return 'ScriptConversionEntry';
      case _i36.ScriptConversionImportPreview():
        return 'ScriptConversionImportPreview';
      case _i37.ScriptConversionImportPreviewRow():
        return 'ScriptConversionImportPreviewRow';
      case _i38.ScriptConversionProfile():
        return 'ScriptConversionProfile';
      case _i39.SubtitleCue():
        return 'SubtitleCue';
      case _i40.SubtitleCueDetail():
        return 'SubtitleCueDetail';
      case _i41.SubtitleCueText():
        return 'SubtitleCueText';
      case _i42.SubtitleKaraokeSegment():
        return 'SubtitleKaraokeSegment';
      case _i43.SubtitleKaraokeSegmentInput():
        return 'SubtitleKaraokeSegmentInput';
      case _i44.SubtitlePhrase():
        return 'SubtitlePhrase';
      case _i45.SubtitlePublishState():
        return 'SubtitlePublishState';
      case _i46.SubtitlePublishStatus():
        return 'SubtitlePublishStatus';
      case _i47.SubtitleReviewDashboard():
        return 'SubtitleReviewDashboard';
      case _i48.SubtitleReviewEvent():
        return 'SubtitleReviewEvent';
      case _i49.SubtitleReviewQueueItem():
        return 'SubtitleReviewQueueItem';
      case _i50.SubtitleReviewTask():
        return 'SubtitleReviewTask';
      case _i51.SubtitleReviewTaskDetail():
        return 'SubtitleReviewTaskDetail';
      case _i52.SubtitleReviewTaskStatus():
        return 'SubtitleReviewTaskStatus';
      case _i53.SubtitleSrtPreview():
        return 'SubtitleSrtPreview';
      case _i54.SubtitleToken():
        return 'SubtitleToken';
      case _i55.SubtitleTrack():
        return 'SubtitleTrack';
      case _i56.UserKnownEntry():
        return 'UserKnownEntry';
      case _i57.Video():
        return 'Video';
      case _i58.VideoCommentDto():
        return 'VideoCommentDto';
      case _i59.VideoCommentRow():
        return 'VideoCommentRow';
      case _i60.VideoContentType():
        return 'VideoContentType';
      case _i61.VideoFavorite():
        return 'VideoFavorite';
      case _i62.VideoStatus():
        return 'VideoStatus';
      case _i63.WatchHistory():
        return 'WatchHistory';
      case _i64.WordList():
        return 'WordList';
      case _i65.WordListDetail():
        return 'WordListDetail';
      case _i66.WordListItem():
        return 'WordListItem';
      case _i67.WordListItemDetail():
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
    if (dataClassName == 'AppProfile') {
      return deserialize<_i5.AppProfile>(data['data']);
    }
    if (dataClassName == 'AsrJob') {
      return deserialize<_i6.AsrJob>(data['data']);
    }
    if (dataClassName == 'AsrJobStatus') {
      return deserialize<_i7.AsrJobStatus>(data['data']);
    }
    if (dataClassName == 'CommentLike') {
      return deserialize<_i8.CommentLike>(data['data']);
    }
    if (dataClassName == 'CommentPageDto') {
      return deserialize<_i9.CommentPageDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyDto') {
      return deserialize<_i10.CommentReplyDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyLike') {
      return deserialize<_i11.CommentReplyLike>(data['data']);
    }
    if (dataClassName == 'CommentReplyRow') {
      return deserialize<_i12.CommentReplyRow>(data['data']);
    }
    if (dataClassName == 'CreatorFollow') {
      return deserialize<_i13.CreatorFollow>(data['data']);
    }
    if (dataClassName == 'DictionaryDefinition') {
      return deserialize<_i14.DictionaryDefinition>(data['data']);
    }
    if (dataClassName == 'DictionaryEntry') {
      return deserialize<_i15.DictionaryEntry>(data['data']);
    }
    if (dataClassName == 'DictionaryEntryDetail') {
      return deserialize<_i16.DictionaryEntryDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExample') {
      return deserialize<_i17.DictionaryExample>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleDetail') {
      return deserialize<_i18.DictionaryExampleDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleText') {
      return deserialize<_i19.DictionaryExampleText>(data['data']);
    }
    if (dataClassName == 'DictionaryForm') {
      return deserialize<_i20.DictionaryForm>(data['data']);
    }
    if (dataClassName == 'DictionaryImportCommitResult') {
      return deserialize<_i21.DictionaryImportCommitResult>(data['data']);
    }
    if (dataClassName == 'DictionaryImportMapping') {
      return deserialize<_i22.DictionaryImportMapping>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreview') {
      return deserialize<_i23.DictionaryImportPreview>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreviewRow') {
      return deserialize<_i24.DictionaryImportPreviewRow>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfile') {
      return deserialize<_i25.DictionaryImportProfile>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfileDetail') {
      return deserialize<_i26.DictionaryImportProfileDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryRelation') {
      return deserialize<_i27.DictionaryRelation>(data['data']);
    }
    if (dataClassName == 'DictionaryRelationDetail') {
      return deserialize<_i28.DictionaryRelationDetail>(data['data']);
    }
    if (dataClassName == 'EntryKnowledgeState') {
      return deserialize<_i29.EntryKnowledgeState>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i30.Greeting>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateQuery') {
      return deserialize<_i31.KnowledgeStateQuery>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateResult') {
      return deserialize<_i32.KnowledgeStateResult>(data['data']);
    }
    if (dataClassName == 'ProfileStats') {
      return deserialize<_i33.ProfileStats>(data['data']);
    }
    if (dataClassName == 'ScriptConversionCommitResult') {
      return deserialize<_i34.ScriptConversionCommitResult>(data['data']);
    }
    if (dataClassName == 'ScriptConversionEntry') {
      return deserialize<_i35.ScriptConversionEntry>(data['data']);
    }
    if (dataClassName == 'ScriptConversionImportPreview') {
      return deserialize<_i36.ScriptConversionImportPreview>(data['data']);
    }
    if (dataClassName == 'ScriptConversionImportPreviewRow') {
      return deserialize<_i37.ScriptConversionImportPreviewRow>(data['data']);
    }
    if (dataClassName == 'ScriptConversionProfile') {
      return deserialize<_i38.ScriptConversionProfile>(data['data']);
    }
    if (dataClassName == 'SubtitleCue') {
      return deserialize<_i39.SubtitleCue>(data['data']);
    }
    if (dataClassName == 'SubtitleCueDetail') {
      return deserialize<_i40.SubtitleCueDetail>(data['data']);
    }
    if (dataClassName == 'SubtitleCueText') {
      return deserialize<_i41.SubtitleCueText>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegment') {
      return deserialize<_i42.SubtitleKaraokeSegment>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegmentInput') {
      return deserialize<_i43.SubtitleKaraokeSegmentInput>(data['data']);
    }
    if (dataClassName == 'SubtitlePhrase') {
      return deserialize<_i44.SubtitlePhrase>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishState') {
      return deserialize<_i45.SubtitlePublishState>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishStatus') {
      return deserialize<_i46.SubtitlePublishStatus>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewDashboard') {
      return deserialize<_i47.SubtitleReviewDashboard>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewEvent') {
      return deserialize<_i48.SubtitleReviewEvent>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewQueueItem') {
      return deserialize<_i49.SubtitleReviewQueueItem>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTask') {
      return deserialize<_i50.SubtitleReviewTask>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTaskDetail') {
      return deserialize<_i51.SubtitleReviewTaskDetail>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTaskStatus') {
      return deserialize<_i52.SubtitleReviewTaskStatus>(data['data']);
    }
    if (dataClassName == 'SubtitleSrtPreview') {
      return deserialize<_i53.SubtitleSrtPreview>(data['data']);
    }
    if (dataClassName == 'SubtitleToken') {
      return deserialize<_i54.SubtitleToken>(data['data']);
    }
    if (dataClassName == 'SubtitleTrack') {
      return deserialize<_i55.SubtitleTrack>(data['data']);
    }
    if (dataClassName == 'UserKnownEntry') {
      return deserialize<_i56.UserKnownEntry>(data['data']);
    }
    if (dataClassName == 'Video') {
      return deserialize<_i57.Video>(data['data']);
    }
    if (dataClassName == 'VideoCommentDto') {
      return deserialize<_i58.VideoCommentDto>(data['data']);
    }
    if (dataClassName == 'VideoCommentRow') {
      return deserialize<_i59.VideoCommentRow>(data['data']);
    }
    if (dataClassName == 'VideoContentType') {
      return deserialize<_i60.VideoContentType>(data['data']);
    }
    if (dataClassName == 'VideoFavorite') {
      return deserialize<_i61.VideoFavorite>(data['data']);
    }
    if (dataClassName == 'VideoStatus') {
      return deserialize<_i62.VideoStatus>(data['data']);
    }
    if (dataClassName == 'WatchHistory') {
      return deserialize<_i63.WatchHistory>(data['data']);
    }
    if (dataClassName == 'WordList') {
      return deserialize<_i64.WordList>(data['data']);
    }
    if (dataClassName == 'WordListDetail') {
      return deserialize<_i65.WordListDetail>(data['data']);
    }
    if (dataClassName == 'WordListItem') {
      return deserialize<_i66.WordListItem>(data['data']);
    }
    if (dataClassName == 'WordListItemDetail') {
      return deserialize<_i67.WordListItemDetail>(data['data']);
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
      case _i5.AppProfile:
        return _i5.AppProfile.t;
      case _i6.AsrJob:
        return _i6.AsrJob.t;
      case _i8.CommentLike:
        return _i8.CommentLike.t;
      case _i11.CommentReplyLike:
        return _i11.CommentReplyLike.t;
      case _i12.CommentReplyRow:
        return _i12.CommentReplyRow.t;
      case _i13.CreatorFollow:
        return _i13.CreatorFollow.t;
      case _i14.DictionaryDefinition:
        return _i14.DictionaryDefinition.t;
      case _i15.DictionaryEntry:
        return _i15.DictionaryEntry.t;
      case _i17.DictionaryExample:
        return _i17.DictionaryExample.t;
      case _i19.DictionaryExampleText:
        return _i19.DictionaryExampleText.t;
      case _i20.DictionaryForm:
        return _i20.DictionaryForm.t;
      case _i22.DictionaryImportMapping:
        return _i22.DictionaryImportMapping.t;
      case _i25.DictionaryImportProfile:
        return _i25.DictionaryImportProfile.t;
      case _i27.DictionaryRelation:
        return _i27.DictionaryRelation.t;
      case _i35.ScriptConversionEntry:
        return _i35.ScriptConversionEntry.t;
      case _i38.ScriptConversionProfile:
        return _i38.ScriptConversionProfile.t;
      case _i39.SubtitleCue:
        return _i39.SubtitleCue.t;
      case _i41.SubtitleCueText:
        return _i41.SubtitleCueText.t;
      case _i42.SubtitleKaraokeSegment:
        return _i42.SubtitleKaraokeSegment.t;
      case _i44.SubtitlePhrase:
        return _i44.SubtitlePhrase.t;
      case _i45.SubtitlePublishState:
        return _i45.SubtitlePublishState.t;
      case _i48.SubtitleReviewEvent:
        return _i48.SubtitleReviewEvent.t;
      case _i50.SubtitleReviewTask:
        return _i50.SubtitleReviewTask.t;
      case _i54.SubtitleToken:
        return _i54.SubtitleToken.t;
      case _i55.SubtitleTrack:
        return _i55.SubtitleTrack.t;
      case _i56.UserKnownEntry:
        return _i56.UserKnownEntry.t;
      case _i57.Video:
        return _i57.Video.t;
      case _i59.VideoCommentRow:
        return _i59.VideoCommentRow.t;
      case _i61.VideoFavorite:
        return _i61.VideoFavorite.t;
      case _i63.WatchHistory:
        return _i63.WatchHistory.t;
      case _i64.WordList:
        return _i64.WordList.t;
      case _i66.WordListItem:
        return _i66.WordListItem.t;
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
