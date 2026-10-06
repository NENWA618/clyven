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
import 'admin_member.dart' as _i5;
import 'admin_permission.dart' as _i6;
import 'admin_role.dart' as _i7;
import 'admin_role_permission.dart' as _i8;
import 'admin_workspace.dart' as _i9;
import 'app_notification.dart' as _i10;
import 'app_profile.dart' as _i11;
import 'asr_job.dart' as _i12;
import 'asr_job_status.dart' as _i13;
import 'comment_like.dart' as _i14;
import 'comment_page_dto.dart' as _i15;
import 'comment_reply_dto.dart' as _i16;
import 'comment_reply_like.dart' as _i17;
import 'comment_reply_row.dart' as _i18;
import 'creator_follow.dart' as _i19;
import 'device_token.dart' as _i20;
import 'dictionary_definition.dart' as _i21;
import 'dictionary_entry.dart' as _i22;
import 'dictionary_entry_detail.dart' as _i23;
import 'dictionary_example.dart' as _i24;
import 'dictionary_example_detail.dart' as _i25;
import 'dictionary_example_text.dart' as _i26;
import 'dictionary_form.dart' as _i27;
import 'dictionary_import_commit_result.dart' as _i28;
import 'dictionary_import_mapping.dart' as _i29;
import 'dictionary_import_preview.dart' as _i30;
import 'dictionary_import_preview_row.dart' as _i31;
import 'dictionary_import_profile.dart' as _i32;
import 'dictionary_import_profile_detail.dart' as _i33;
import 'dictionary_relation.dart' as _i34;
import 'dictionary_relation_detail.dart' as _i35;
import 'entry_knowledge_state.dart' as _i36;
import 'greetings/greeting.dart' as _i37;
import 'knowledge_state_query.dart' as _i38;
import 'knowledge_state_result.dart' as _i39;
import 'notification_settings.dart' as _i40;
import 'notification_type.dart' as _i41;
import 'privacy_settings.dart' as _i42;
import 'profile_stats.dart' as _i43;
import 'script_conversion_commit_result.dart' as _i44;
import 'script_conversion_entry.dart' as _i45;
import 'script_conversion_import_preview.dart' as _i46;
import 'script_conversion_import_preview_row.dart' as _i47;
import 'script_conversion_profile.dart' as _i48;
import 'subtitle_cue.dart' as _i49;
import 'subtitle_cue_detail.dart' as _i50;
import 'subtitle_cue_text.dart' as _i51;
import 'subtitle_karaoke_segment.dart' as _i52;
import 'subtitle_karaoke_segment_input.dart' as _i53;
import 'subtitle_phrase.dart' as _i54;
import 'subtitle_publish_state.dart' as _i55;
import 'subtitle_publish_status.dart' as _i56;
import 'subtitle_review_dashboard.dart' as _i57;
import 'subtitle_review_event.dart' as _i58;
import 'subtitle_review_queue_item.dart' as _i59;
import 'subtitle_review_task.dart' as _i60;
import 'subtitle_review_task_detail.dart' as _i61;
import 'subtitle_review_task_status.dart' as _i62;
import 'subtitle_search_result.dart' as _i63;
import 'subtitle_srt_preview.dart' as _i64;
import 'subtitle_token.dart' as _i65;
import 'subtitle_track.dart' as _i66;
import 'user_known_entry.dart' as _i67;
import 'video.dart' as _i68;
import 'video_comment_dto.dart' as _i69;
import 'video_comment_row.dart' as _i70;
import 'video_content_type.dart' as _i71;
import 'video_favorite.dart' as _i72;
import 'video_like.dart' as _i73;
import 'video_series.dart' as _i74;
import 'video_status.dart' as _i75;
import 'watch_history.dart' as _i76;
import 'word_list.dart' as _i77;
import 'word_list_detail.dart' as _i78;
import 'word_list_item.dart' as _i79;
import 'word_list_item_detail.dart' as _i80;
import 'package:glyphora_backend_server/src/generated/asr_job.dart' as _i81;
import 'package:glyphora_backend_server/src/generated/video.dart' as _i82;
import 'package:glyphora_backend_server/src/generated/subtitle_track.dart'
    as _i83;
import 'package:glyphora_backend_server/src/generated/admin_member.dart'
    as _i84;
import 'package:glyphora_backend_server/src/generated/admin_role.dart' as _i85;
import 'package:glyphora_backend_server/src/generated/admin_permission.dart'
    as _i86;
import 'package:glyphora_backend_server/src/generated/admin_role_permission.dart'
    as _i87;
import 'package:glyphora_backend_server/src/generated/dictionary_entry_detail.dart'
    as _i88;
import 'package:glyphora_backend_server/src/generated/dictionary_import_profile.dart'
    as _i89;
import 'package:glyphora_backend_server/src/generated/entry_knowledge_state.dart'
    as _i90;
import 'package:glyphora_backend_server/src/generated/knowledge_state_result.dart'
    as _i91;
import 'package:glyphora_backend_server/src/generated/knowledge_state_query.dart'
    as _i92;
import 'package:glyphora_backend_server/src/generated/app_notification.dart'
    as _i93;
import 'package:glyphora_backend_server/src/generated/script_conversion_profile.dart'
    as _i94;
import 'package:glyphora_backend_server/src/generated/script_conversion_entry.dart'
    as _i95;
import 'package:glyphora_backend_server/src/generated/watch_history.dart'
    as _i96;
import 'package:glyphora_backend_server/src/generated/subtitle_search_result.dart'
    as _i97;
import 'package:glyphora_backend_server/src/generated/subtitle_cue_detail.dart'
    as _i98;
import 'package:glyphora_backend_server/src/generated/subtitle_karaoke_segment.dart'
    as _i99;
import 'package:glyphora_backend_server/src/generated/subtitle_karaoke_segment_input.dart'
    as _i100;
import 'package:glyphora_backend_server/src/generated/video_series.dart'
    as _i101;
import 'package:glyphora_backend_server/src/generated/word_list.dart' as _i102;
export 'admin_member.dart';
export 'admin_permission.dart';
export 'admin_role.dart';
export 'admin_role_permission.dart';
export 'admin_workspace.dart';
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
export 'device_token.dart';
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
export 'subtitle_search_result.dart';
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
      name: 'admin_member',
      dartName: 'AdminMember',
      schema: 'public',
      module: 'glyphora_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'admin_member_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'workspaceId',
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
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'roleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'active\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'invitedByUserId',
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
          indexName: 'admin_member_pkey',
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
          indexName: 'admin_member_workspace_user_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'workspaceId',
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
      name: 'admin_permission',
      dartName: 'AdminPermission',
      schema: 'public',
      module: 'glyphora_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'admin_permission_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
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
          indexName: 'admin_permission_pkey',
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
          indexName: 'admin_permission_code_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
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
      name: 'admin_role',
      dartName: 'AdminRole',
      schema: 'public',
      module: 'glyphora_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'admin_role_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'workspaceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'key',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isSystem',
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
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'admin_role_pkey',
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
          indexName: 'admin_role_workspace_key_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'workspaceId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'key',
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
      name: 'admin_role_permission',
      dartName: 'AdminRolePermission',
      schema: 'public',
      module: 'glyphora_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'admin_role_permission_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'roleId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'permissionCode',
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
          indexName: 'admin_role_permission_pkey',
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
          indexName: 'admin_role_permission_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'roleId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'permissionCode',
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
      name: 'admin_workspace',
      dartName: 'AdminWorkspace',
      schema: 'public',
      module: 'glyphora_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'admin_workspace_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'ownerMemberId',
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
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'admin_workspace_pkey',
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
      name: 'app_profile',
      dartName: 'AppProfile',
      schema: 'public',
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      name: 'device_token',
      dartName: 'DeviceToken',
      schema: 'public',
      module: 'glyphora_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'device_token_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'token',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'platform',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'languageCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'en\'::text',
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
          indexName: 'device_token_pkey',
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
          indexName: 'device_token_token_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'token',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'device_token_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
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
      name: 'dictionary_definition',
      dartName: 'DictionaryDefinition',
      schema: 'public',
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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
      module: 'glyphora_backend',
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

    if (t == _i5.AdminMember) {
      return _i5.AdminMember.fromJson(data) as T;
    }
    if (t == _i6.AdminPermission) {
      return _i6.AdminPermission.fromJson(data) as T;
    }
    if (t == _i7.AdminRole) {
      return _i7.AdminRole.fromJson(data) as T;
    }
    if (t == _i8.AdminRolePermission) {
      return _i8.AdminRolePermission.fromJson(data) as T;
    }
    if (t == _i9.AdminWorkspace) {
      return _i9.AdminWorkspace.fromJson(data) as T;
    }
    if (t == _i10.AppNotification) {
      return _i10.AppNotification.fromJson(data) as T;
    }
    if (t == _i11.AppProfile) {
      return _i11.AppProfile.fromJson(data) as T;
    }
    if (t == _i12.AsrJob) {
      return _i12.AsrJob.fromJson(data) as T;
    }
    if (t == _i13.AsrJobStatus) {
      return _i13.AsrJobStatus.fromJson(data) as T;
    }
    if (t == _i14.CommentLike) {
      return _i14.CommentLike.fromJson(data) as T;
    }
    if (t == _i15.CommentPageDto) {
      return _i15.CommentPageDto.fromJson(data) as T;
    }
    if (t == _i16.CommentReplyDto) {
      return _i16.CommentReplyDto.fromJson(data) as T;
    }
    if (t == _i17.CommentReplyLike) {
      return _i17.CommentReplyLike.fromJson(data) as T;
    }
    if (t == _i18.CommentReplyRow) {
      return _i18.CommentReplyRow.fromJson(data) as T;
    }
    if (t == _i19.CreatorFollow) {
      return _i19.CreatorFollow.fromJson(data) as T;
    }
    if (t == _i20.DeviceToken) {
      return _i20.DeviceToken.fromJson(data) as T;
    }
    if (t == _i21.DictionaryDefinition) {
      return _i21.DictionaryDefinition.fromJson(data) as T;
    }
    if (t == _i22.DictionaryEntry) {
      return _i22.DictionaryEntry.fromJson(data) as T;
    }
    if (t == _i23.DictionaryEntryDetail) {
      return _i23.DictionaryEntryDetail.fromJson(data) as T;
    }
    if (t == _i24.DictionaryExample) {
      return _i24.DictionaryExample.fromJson(data) as T;
    }
    if (t == _i25.DictionaryExampleDetail) {
      return _i25.DictionaryExampleDetail.fromJson(data) as T;
    }
    if (t == _i26.DictionaryExampleText) {
      return _i26.DictionaryExampleText.fromJson(data) as T;
    }
    if (t == _i27.DictionaryForm) {
      return _i27.DictionaryForm.fromJson(data) as T;
    }
    if (t == _i28.DictionaryImportCommitResult) {
      return _i28.DictionaryImportCommitResult.fromJson(data) as T;
    }
    if (t == _i29.DictionaryImportMapping) {
      return _i29.DictionaryImportMapping.fromJson(data) as T;
    }
    if (t == _i30.DictionaryImportPreview) {
      return _i30.DictionaryImportPreview.fromJson(data) as T;
    }
    if (t == _i31.DictionaryImportPreviewRow) {
      return _i31.DictionaryImportPreviewRow.fromJson(data) as T;
    }
    if (t == _i32.DictionaryImportProfile) {
      return _i32.DictionaryImportProfile.fromJson(data) as T;
    }
    if (t == _i33.DictionaryImportProfileDetail) {
      return _i33.DictionaryImportProfileDetail.fromJson(data) as T;
    }
    if (t == _i34.DictionaryRelation) {
      return _i34.DictionaryRelation.fromJson(data) as T;
    }
    if (t == _i35.DictionaryRelationDetail) {
      return _i35.DictionaryRelationDetail.fromJson(data) as T;
    }
    if (t == _i36.EntryKnowledgeState) {
      return _i36.EntryKnowledgeState.fromJson(data) as T;
    }
    if (t == _i37.Greeting) {
      return _i37.Greeting.fromJson(data) as T;
    }
    if (t == _i38.KnowledgeStateQuery) {
      return _i38.KnowledgeStateQuery.fromJson(data) as T;
    }
    if (t == _i39.KnowledgeStateResult) {
      return _i39.KnowledgeStateResult.fromJson(data) as T;
    }
    if (t == _i40.NotificationSettings) {
      return _i40.NotificationSettings.fromJson(data) as T;
    }
    if (t == _i41.NotificationType) {
      return _i41.NotificationType.fromJson(data) as T;
    }
    if (t == _i42.PrivacySettings) {
      return _i42.PrivacySettings.fromJson(data) as T;
    }
    if (t == _i43.ProfileStats) {
      return _i43.ProfileStats.fromJson(data) as T;
    }
    if (t == _i44.ScriptConversionCommitResult) {
      return _i44.ScriptConversionCommitResult.fromJson(data) as T;
    }
    if (t == _i45.ScriptConversionEntry) {
      return _i45.ScriptConversionEntry.fromJson(data) as T;
    }
    if (t == _i46.ScriptConversionImportPreview) {
      return _i46.ScriptConversionImportPreview.fromJson(data) as T;
    }
    if (t == _i47.ScriptConversionImportPreviewRow) {
      return _i47.ScriptConversionImportPreviewRow.fromJson(data) as T;
    }
    if (t == _i48.ScriptConversionProfile) {
      return _i48.ScriptConversionProfile.fromJson(data) as T;
    }
    if (t == _i49.SubtitleCue) {
      return _i49.SubtitleCue.fromJson(data) as T;
    }
    if (t == _i50.SubtitleCueDetail) {
      return _i50.SubtitleCueDetail.fromJson(data) as T;
    }
    if (t == _i51.SubtitleCueText) {
      return _i51.SubtitleCueText.fromJson(data) as T;
    }
    if (t == _i52.SubtitleKaraokeSegment) {
      return _i52.SubtitleKaraokeSegment.fromJson(data) as T;
    }
    if (t == _i53.SubtitleKaraokeSegmentInput) {
      return _i53.SubtitleKaraokeSegmentInput.fromJson(data) as T;
    }
    if (t == _i54.SubtitlePhrase) {
      return _i54.SubtitlePhrase.fromJson(data) as T;
    }
    if (t == _i55.SubtitlePublishState) {
      return _i55.SubtitlePublishState.fromJson(data) as T;
    }
    if (t == _i56.SubtitlePublishStatus) {
      return _i56.SubtitlePublishStatus.fromJson(data) as T;
    }
    if (t == _i57.SubtitleReviewDashboard) {
      return _i57.SubtitleReviewDashboard.fromJson(data) as T;
    }
    if (t == _i58.SubtitleReviewEvent) {
      return _i58.SubtitleReviewEvent.fromJson(data) as T;
    }
    if (t == _i59.SubtitleReviewQueueItem) {
      return _i59.SubtitleReviewQueueItem.fromJson(data) as T;
    }
    if (t == _i60.SubtitleReviewTask) {
      return _i60.SubtitleReviewTask.fromJson(data) as T;
    }
    if (t == _i61.SubtitleReviewTaskDetail) {
      return _i61.SubtitleReviewTaskDetail.fromJson(data) as T;
    }
    if (t == _i62.SubtitleReviewTaskStatus) {
      return _i62.SubtitleReviewTaskStatus.fromJson(data) as T;
    }
    if (t == _i63.SubtitleSearchResult) {
      return _i63.SubtitleSearchResult.fromJson(data) as T;
    }
    if (t == _i64.SubtitleSrtPreview) {
      return _i64.SubtitleSrtPreview.fromJson(data) as T;
    }
    if (t == _i65.SubtitleToken) {
      return _i65.SubtitleToken.fromJson(data) as T;
    }
    if (t == _i66.SubtitleTrack) {
      return _i66.SubtitleTrack.fromJson(data) as T;
    }
    if (t == _i67.UserKnownEntry) {
      return _i67.UserKnownEntry.fromJson(data) as T;
    }
    if (t == _i68.Video) {
      return _i68.Video.fromJson(data) as T;
    }
    if (t == _i69.VideoCommentDto) {
      return _i69.VideoCommentDto.fromJson(data) as T;
    }
    if (t == _i70.VideoCommentRow) {
      return _i70.VideoCommentRow.fromJson(data) as T;
    }
    if (t == _i71.VideoContentType) {
      return _i71.VideoContentType.fromJson(data) as T;
    }
    if (t == _i72.VideoFavorite) {
      return _i72.VideoFavorite.fromJson(data) as T;
    }
    if (t == _i73.VideoLike) {
      return _i73.VideoLike.fromJson(data) as T;
    }
    if (t == _i74.VideoSeries) {
      return _i74.VideoSeries.fromJson(data) as T;
    }
    if (t == _i75.VideoStatus) {
      return _i75.VideoStatus.fromJson(data) as T;
    }
    if (t == _i76.WatchHistory) {
      return _i76.WatchHistory.fromJson(data) as T;
    }
    if (t == _i77.WordList) {
      return _i77.WordList.fromJson(data) as T;
    }
    if (t == _i78.WordListDetail) {
      return _i78.WordListDetail.fromJson(data) as T;
    }
    if (t == _i79.WordListItem) {
      return _i79.WordListItem.fromJson(data) as T;
    }
    if (t == _i80.WordListItemDetail) {
      return _i80.WordListItemDetail.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AdminMember?>()) {
      return (data != null ? _i5.AdminMember.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AdminPermission?>()) {
      return (data != null ? _i6.AdminPermission.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AdminRole?>()) {
      return (data != null ? _i7.AdminRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AdminRolePermission?>()) {
      return (data != null ? _i8.AdminRolePermission.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.AdminWorkspace?>()) {
      return (data != null ? _i9.AdminWorkspace.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.AppNotification?>()) {
      return (data != null ? _i10.AppNotification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.AppProfile?>()) {
      return (data != null ? _i11.AppProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.AsrJob?>()) {
      return (data != null ? _i12.AsrJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.AsrJobStatus?>()) {
      return (data != null ? _i13.AsrJobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.CommentLike?>()) {
      return (data != null ? _i14.CommentLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.CommentPageDto?>()) {
      return (data != null ? _i15.CommentPageDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.CommentReplyDto?>()) {
      return (data != null ? _i16.CommentReplyDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.CommentReplyLike?>()) {
      return (data != null ? _i17.CommentReplyLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.CommentReplyRow?>()) {
      return (data != null ? _i18.CommentReplyRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.CreatorFollow?>()) {
      return (data != null ? _i19.CreatorFollow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.DeviceToken?>()) {
      return (data != null ? _i20.DeviceToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.DictionaryDefinition?>()) {
      return (data != null ? _i21.DictionaryDefinition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.DictionaryEntry?>()) {
      return (data != null ? _i22.DictionaryEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.DictionaryEntryDetail?>()) {
      return (data != null ? _i23.DictionaryEntryDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.DictionaryExample?>()) {
      return (data != null ? _i24.DictionaryExample.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.DictionaryExampleDetail?>()) {
      return (data != null ? _i25.DictionaryExampleDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.DictionaryExampleText?>()) {
      return (data != null ? _i26.DictionaryExampleText.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.DictionaryForm?>()) {
      return (data != null ? _i27.DictionaryForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.DictionaryImportCommitResult?>()) {
      return (data != null
              ? _i28.DictionaryImportCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i29.DictionaryImportMapping?>()) {
      return (data != null ? _i29.DictionaryImportMapping.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i30.DictionaryImportPreview?>()) {
      return (data != null ? _i30.DictionaryImportPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.DictionaryImportPreviewRow?>()) {
      return (data != null
              ? _i31.DictionaryImportPreviewRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i32.DictionaryImportProfile?>()) {
      return (data != null ? _i32.DictionaryImportProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.DictionaryImportProfileDetail?>()) {
      return (data != null
              ? _i33.DictionaryImportProfileDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i34.DictionaryRelation?>()) {
      return (data != null ? _i34.DictionaryRelation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.DictionaryRelationDetail?>()) {
      return (data != null
              ? _i35.DictionaryRelationDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i36.EntryKnowledgeState?>()) {
      return (data != null ? _i36.EntryKnowledgeState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i37.Greeting?>()) {
      return (data != null ? _i37.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.KnowledgeStateQuery?>()) {
      return (data != null ? _i38.KnowledgeStateQuery.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.KnowledgeStateResult?>()) {
      return (data != null ? _i39.KnowledgeStateResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.NotificationSettings?>()) {
      return (data != null ? _i40.NotificationSettings.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.NotificationType?>()) {
      return (data != null ? _i41.NotificationType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.PrivacySettings?>()) {
      return (data != null ? _i42.PrivacySettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.ProfileStats?>()) {
      return (data != null ? _i43.ProfileStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.ScriptConversionCommitResult?>()) {
      return (data != null
              ? _i44.ScriptConversionCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i45.ScriptConversionEntry?>()) {
      return (data != null ? _i45.ScriptConversionEntry.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i46.ScriptConversionImportPreview?>()) {
      return (data != null
              ? _i46.ScriptConversionImportPreview.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i47.ScriptConversionImportPreviewRow?>()) {
      return (data != null
              ? _i47.ScriptConversionImportPreviewRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i48.ScriptConversionProfile?>()) {
      return (data != null ? _i48.ScriptConversionProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i49.SubtitleCue?>()) {
      return (data != null ? _i49.SubtitleCue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.SubtitleCueDetail?>()) {
      return (data != null ? _i50.SubtitleCueDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.SubtitleCueText?>()) {
      return (data != null ? _i51.SubtitleCueText.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.SubtitleKaraokeSegment?>()) {
      return (data != null ? _i52.SubtitleKaraokeSegment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i53.SubtitleKaraokeSegmentInput?>()) {
      return (data != null
              ? _i53.SubtitleKaraokeSegmentInput.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i54.SubtitlePhrase?>()) {
      return (data != null ? _i54.SubtitlePhrase.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.SubtitlePublishState?>()) {
      return (data != null ? _i55.SubtitlePublishState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i56.SubtitlePublishStatus?>()) {
      return (data != null ? _i56.SubtitlePublishStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i57.SubtitleReviewDashboard?>()) {
      return (data != null ? _i57.SubtitleReviewDashboard.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i58.SubtitleReviewEvent?>()) {
      return (data != null ? _i58.SubtitleReviewEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i59.SubtitleReviewQueueItem?>()) {
      return (data != null ? _i59.SubtitleReviewQueueItem.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i60.SubtitleReviewTask?>()) {
      return (data != null ? _i60.SubtitleReviewTask.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i61.SubtitleReviewTaskDetail?>()) {
      return (data != null
              ? _i61.SubtitleReviewTaskDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i62.SubtitleReviewTaskStatus?>()) {
      return (data != null
              ? _i62.SubtitleReviewTaskStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i63.SubtitleSearchResult?>()) {
      return (data != null ? _i63.SubtitleSearchResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i64.SubtitleSrtPreview?>()) {
      return (data != null ? _i64.SubtitleSrtPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i65.SubtitleToken?>()) {
      return (data != null ? _i65.SubtitleToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.SubtitleTrack?>()) {
      return (data != null ? _i66.SubtitleTrack.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.UserKnownEntry?>()) {
      return (data != null ? _i67.UserKnownEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.Video?>()) {
      return (data != null ? _i68.Video.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.VideoCommentDto?>()) {
      return (data != null ? _i69.VideoCommentDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.VideoCommentRow?>()) {
      return (data != null ? _i70.VideoCommentRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.VideoContentType?>()) {
      return (data != null ? _i71.VideoContentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.VideoFavorite?>()) {
      return (data != null ? _i72.VideoFavorite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.VideoLike?>()) {
      return (data != null ? _i73.VideoLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.VideoSeries?>()) {
      return (data != null ? _i74.VideoSeries.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i75.VideoStatus?>()) {
      return (data != null ? _i75.VideoStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.WatchHistory?>()) {
      return (data != null ? _i76.WatchHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.WordList?>()) {
      return (data != null ? _i77.WordList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i78.WordListDetail?>()) {
      return (data != null ? _i78.WordListDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i79.WordListItem?>()) {
      return (data != null ? _i79.WordListItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.WordListItemDetail?>()) {
      return (data != null ? _i80.WordListItemDetail.fromJson(data) : null)
          as T;
    }
    if (t == List<_i69.VideoCommentDto>) {
      return (data as List)
              .map((e) => deserialize<_i69.VideoCommentDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.DictionaryDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i21.DictionaryDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i27.DictionaryForm>) {
      return (data as List)
              .map((e) => deserialize<_i27.DictionaryForm>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.DictionaryExampleDetail>) {
      return (data as List)
              .map((e) => deserialize<_i25.DictionaryExampleDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i35.DictionaryRelationDetail>) {
      return (data as List)
              .map((e) => deserialize<_i35.DictionaryRelationDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i26.DictionaryExampleText>) {
      return (data as List)
              .map((e) => deserialize<_i26.DictionaryExampleText>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i31.DictionaryImportPreviewRow>) {
      return (data as List)
              .map((e) => deserialize<_i31.DictionaryImportPreviewRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i29.DictionaryImportMapping>) {
      return (data as List)
              .map((e) => deserialize<_i29.DictionaryImportMapping>(e))
              .toList()
          as T;
    }
    if (t == List<_i47.ScriptConversionImportPreviewRow>) {
      return (data as List)
              .map((e) => deserialize<_i47.ScriptConversionImportPreviewRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i51.SubtitleCueText>) {
      return (data as List)
              .map((e) => deserialize<_i51.SubtitleCueText>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i51.SubtitleCueText>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i51.SubtitleCueText>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i65.SubtitleToken>) {
      return (data as List)
              .map((e) => deserialize<_i65.SubtitleToken>(e))
              .toList()
          as T;
    }
    if (t == List<_i54.SubtitlePhrase>) {
      return (data as List)
              .map((e) => deserialize<_i54.SubtitlePhrase>(e))
              .toList()
          as T;
    }
    if (t == List<_i52.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i52.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i52.SubtitleKaraokeSegment>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i52.SubtitleKaraokeSegment>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i59.SubtitleReviewQueueItem>) {
      return (data as List)
              .map((e) => deserialize<_i59.SubtitleReviewQueueItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i58.SubtitleReviewEvent>) {
      return (data as List)
              .map((e) => deserialize<_i58.SubtitleReviewEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i16.CommentReplyDto>) {
      return (data as List)
              .map((e) => deserialize<_i16.CommentReplyDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i80.WordListItemDetail>) {
      return (data as List)
              .map((e) => deserialize<_i80.WordListItemDetail>(e))
              .toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i81.AsrJob>) {
      return (data as List).map((e) => deserialize<_i81.AsrJob>(e)).toList()
          as T;
    }
    if (t == List<_i82.Video>) {
      return (data as List).map((e) => deserialize<_i82.Video>(e)).toList()
          as T;
    }
    if (t == List<_i83.SubtitleTrack>) {
      return (data as List)
              .map((e) => deserialize<_i83.SubtitleTrack>(e))
              .toList()
          as T;
    }
    if (t == List<_i84.AdminMember>) {
      return (data as List)
              .map((e) => deserialize<_i84.AdminMember>(e))
              .toList()
          as T;
    }
    if (t == List<_i85.AdminRole>) {
      return (data as List).map((e) => deserialize<_i85.AdminRole>(e)).toList()
          as T;
    }
    if (t == List<_i86.AdminPermission>) {
      return (data as List)
              .map((e) => deserialize<_i86.AdminPermission>(e))
              .toList()
          as T;
    }
    if (t == List<_i87.AdminRolePermission>) {
      return (data as List)
              .map((e) => deserialize<_i87.AdminRolePermission>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i88.DictionaryEntryDetail>) {
      return (data as List)
              .map((e) => deserialize<_i88.DictionaryEntryDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i89.DictionaryImportProfile>) {
      return (data as List)
              .map((e) => deserialize<_i89.DictionaryImportProfile>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i90.EntryKnowledgeState>) {
      return (data as List)
              .map((e) => deserialize<_i90.EntryKnowledgeState>(e))
              .toList()
          as T;
    }
    if (t == List<_i91.KnowledgeStateResult>) {
      return (data as List)
              .map((e) => deserialize<_i91.KnowledgeStateResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i92.KnowledgeStateQuery>) {
      return (data as List)
              .map((e) => deserialize<_i92.KnowledgeStateQuery>(e))
              .toList()
          as T;
    }
    if (t == List<_i93.AppNotification>) {
      return (data as List)
              .map((e) => deserialize<_i93.AppNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_i94.ScriptConversionProfile>) {
      return (data as List)
              .map((e) => deserialize<_i94.ScriptConversionProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_i95.ScriptConversionEntry>) {
      return (data as List)
              .map((e) => deserialize<_i95.ScriptConversionEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i96.WatchHistory>) {
      return (data as List)
              .map((e) => deserialize<_i96.WatchHistory>(e))
              .toList()
          as T;
    }
    if (t == List<Map<String, String>>) {
      return (data as List)
              .map((e) => deserialize<Map<String, String>>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i97.SubtitleSearchResult>) {
      return (data as List)
              .map((e) => deserialize<_i97.SubtitleSearchResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i98.SubtitleCueDetail>) {
      return (data as List)
              .map((e) => deserialize<_i98.SubtitleCueDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i99.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i99.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == List<_i100.SubtitleKaraokeSegmentInput>) {
      return (data as List)
              .map((e) => deserialize<_i100.SubtitleKaraokeSegmentInput>(e))
              .toList()
          as T;
    }
    if (t == List<_i101.VideoSeries>) {
      return (data as List)
              .map((e) => deserialize<_i101.VideoSeries>(e))
              .toList()
          as T;
    }
    if (t == List<_i102.WordList>) {
      return (data as List).map((e) => deserialize<_i102.WordList>(e)).toList()
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
      _i5.AdminMember => 'AdminMember',
      _i6.AdminPermission => 'AdminPermission',
      _i7.AdminRole => 'AdminRole',
      _i8.AdminRolePermission => 'AdminRolePermission',
      _i9.AdminWorkspace => 'AdminWorkspace',
      _i10.AppNotification => 'AppNotification',
      _i11.AppProfile => 'AppProfile',
      _i12.AsrJob => 'AsrJob',
      _i13.AsrJobStatus => 'AsrJobStatus',
      _i14.CommentLike => 'CommentLike',
      _i15.CommentPageDto => 'CommentPageDto',
      _i16.CommentReplyDto => 'CommentReplyDto',
      _i17.CommentReplyLike => 'CommentReplyLike',
      _i18.CommentReplyRow => 'CommentReplyRow',
      _i19.CreatorFollow => 'CreatorFollow',
      _i20.DeviceToken => 'DeviceToken',
      _i21.DictionaryDefinition => 'DictionaryDefinition',
      _i22.DictionaryEntry => 'DictionaryEntry',
      _i23.DictionaryEntryDetail => 'DictionaryEntryDetail',
      _i24.DictionaryExample => 'DictionaryExample',
      _i25.DictionaryExampleDetail => 'DictionaryExampleDetail',
      _i26.DictionaryExampleText => 'DictionaryExampleText',
      _i27.DictionaryForm => 'DictionaryForm',
      _i28.DictionaryImportCommitResult => 'DictionaryImportCommitResult',
      _i29.DictionaryImportMapping => 'DictionaryImportMapping',
      _i30.DictionaryImportPreview => 'DictionaryImportPreview',
      _i31.DictionaryImportPreviewRow => 'DictionaryImportPreviewRow',
      _i32.DictionaryImportProfile => 'DictionaryImportProfile',
      _i33.DictionaryImportProfileDetail => 'DictionaryImportProfileDetail',
      _i34.DictionaryRelation => 'DictionaryRelation',
      _i35.DictionaryRelationDetail => 'DictionaryRelationDetail',
      _i36.EntryKnowledgeState => 'EntryKnowledgeState',
      _i37.Greeting => 'Greeting',
      _i38.KnowledgeStateQuery => 'KnowledgeStateQuery',
      _i39.KnowledgeStateResult => 'KnowledgeStateResult',
      _i40.NotificationSettings => 'NotificationSettings',
      _i41.NotificationType => 'NotificationType',
      _i42.PrivacySettings => 'PrivacySettings',
      _i43.ProfileStats => 'ProfileStats',
      _i44.ScriptConversionCommitResult => 'ScriptConversionCommitResult',
      _i45.ScriptConversionEntry => 'ScriptConversionEntry',
      _i46.ScriptConversionImportPreview => 'ScriptConversionImportPreview',
      _i47.ScriptConversionImportPreviewRow =>
        'ScriptConversionImportPreviewRow',
      _i48.ScriptConversionProfile => 'ScriptConversionProfile',
      _i49.SubtitleCue => 'SubtitleCue',
      _i50.SubtitleCueDetail => 'SubtitleCueDetail',
      _i51.SubtitleCueText => 'SubtitleCueText',
      _i52.SubtitleKaraokeSegment => 'SubtitleKaraokeSegment',
      _i53.SubtitleKaraokeSegmentInput => 'SubtitleKaraokeSegmentInput',
      _i54.SubtitlePhrase => 'SubtitlePhrase',
      _i55.SubtitlePublishState => 'SubtitlePublishState',
      _i56.SubtitlePublishStatus => 'SubtitlePublishStatus',
      _i57.SubtitleReviewDashboard => 'SubtitleReviewDashboard',
      _i58.SubtitleReviewEvent => 'SubtitleReviewEvent',
      _i59.SubtitleReviewQueueItem => 'SubtitleReviewQueueItem',
      _i60.SubtitleReviewTask => 'SubtitleReviewTask',
      _i61.SubtitleReviewTaskDetail => 'SubtitleReviewTaskDetail',
      _i62.SubtitleReviewTaskStatus => 'SubtitleReviewTaskStatus',
      _i63.SubtitleSearchResult => 'SubtitleSearchResult',
      _i64.SubtitleSrtPreview => 'SubtitleSrtPreview',
      _i65.SubtitleToken => 'SubtitleToken',
      _i66.SubtitleTrack => 'SubtitleTrack',
      _i67.UserKnownEntry => 'UserKnownEntry',
      _i68.Video => 'Video',
      _i69.VideoCommentDto => 'VideoCommentDto',
      _i70.VideoCommentRow => 'VideoCommentRow',
      _i71.VideoContentType => 'VideoContentType',
      _i72.VideoFavorite => 'VideoFavorite',
      _i73.VideoLike => 'VideoLike',
      _i74.VideoSeries => 'VideoSeries',
      _i75.VideoStatus => 'VideoStatus',
      _i76.WatchHistory => 'WatchHistory',
      _i77.WordList => 'WordList',
      _i78.WordListDetail => 'WordListDetail',
      _i79.WordListItem => 'WordListItem',
      _i80.WordListItemDetail => 'WordListItemDetail',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'glyphora_backend.',
        '',
      );
    }

    switch (data) {
      case _i5.AdminMember():
        return 'AdminMember';
      case _i6.AdminPermission():
        return 'AdminPermission';
      case _i7.AdminRole():
        return 'AdminRole';
      case _i8.AdminRolePermission():
        return 'AdminRolePermission';
      case _i9.AdminWorkspace():
        return 'AdminWorkspace';
      case _i10.AppNotification():
        return 'AppNotification';
      case _i11.AppProfile():
        return 'AppProfile';
      case _i12.AsrJob():
        return 'AsrJob';
      case _i13.AsrJobStatus():
        return 'AsrJobStatus';
      case _i14.CommentLike():
        return 'CommentLike';
      case _i15.CommentPageDto():
        return 'CommentPageDto';
      case _i16.CommentReplyDto():
        return 'CommentReplyDto';
      case _i17.CommentReplyLike():
        return 'CommentReplyLike';
      case _i18.CommentReplyRow():
        return 'CommentReplyRow';
      case _i19.CreatorFollow():
        return 'CreatorFollow';
      case _i20.DeviceToken():
        return 'DeviceToken';
      case _i21.DictionaryDefinition():
        return 'DictionaryDefinition';
      case _i22.DictionaryEntry():
        return 'DictionaryEntry';
      case _i23.DictionaryEntryDetail():
        return 'DictionaryEntryDetail';
      case _i24.DictionaryExample():
        return 'DictionaryExample';
      case _i25.DictionaryExampleDetail():
        return 'DictionaryExampleDetail';
      case _i26.DictionaryExampleText():
        return 'DictionaryExampleText';
      case _i27.DictionaryForm():
        return 'DictionaryForm';
      case _i28.DictionaryImportCommitResult():
        return 'DictionaryImportCommitResult';
      case _i29.DictionaryImportMapping():
        return 'DictionaryImportMapping';
      case _i30.DictionaryImportPreview():
        return 'DictionaryImportPreview';
      case _i31.DictionaryImportPreviewRow():
        return 'DictionaryImportPreviewRow';
      case _i32.DictionaryImportProfile():
        return 'DictionaryImportProfile';
      case _i33.DictionaryImportProfileDetail():
        return 'DictionaryImportProfileDetail';
      case _i34.DictionaryRelation():
        return 'DictionaryRelation';
      case _i35.DictionaryRelationDetail():
        return 'DictionaryRelationDetail';
      case _i36.EntryKnowledgeState():
        return 'EntryKnowledgeState';
      case _i37.Greeting():
        return 'Greeting';
      case _i38.KnowledgeStateQuery():
        return 'KnowledgeStateQuery';
      case _i39.KnowledgeStateResult():
        return 'KnowledgeStateResult';
      case _i40.NotificationSettings():
        return 'NotificationSettings';
      case _i41.NotificationType():
        return 'NotificationType';
      case _i42.PrivacySettings():
        return 'PrivacySettings';
      case _i43.ProfileStats():
        return 'ProfileStats';
      case _i44.ScriptConversionCommitResult():
        return 'ScriptConversionCommitResult';
      case _i45.ScriptConversionEntry():
        return 'ScriptConversionEntry';
      case _i46.ScriptConversionImportPreview():
        return 'ScriptConversionImportPreview';
      case _i47.ScriptConversionImportPreviewRow():
        return 'ScriptConversionImportPreviewRow';
      case _i48.ScriptConversionProfile():
        return 'ScriptConversionProfile';
      case _i49.SubtitleCue():
        return 'SubtitleCue';
      case _i50.SubtitleCueDetail():
        return 'SubtitleCueDetail';
      case _i51.SubtitleCueText():
        return 'SubtitleCueText';
      case _i52.SubtitleKaraokeSegment():
        return 'SubtitleKaraokeSegment';
      case _i53.SubtitleKaraokeSegmentInput():
        return 'SubtitleKaraokeSegmentInput';
      case _i54.SubtitlePhrase():
        return 'SubtitlePhrase';
      case _i55.SubtitlePublishState():
        return 'SubtitlePublishState';
      case _i56.SubtitlePublishStatus():
        return 'SubtitlePublishStatus';
      case _i57.SubtitleReviewDashboard():
        return 'SubtitleReviewDashboard';
      case _i58.SubtitleReviewEvent():
        return 'SubtitleReviewEvent';
      case _i59.SubtitleReviewQueueItem():
        return 'SubtitleReviewQueueItem';
      case _i60.SubtitleReviewTask():
        return 'SubtitleReviewTask';
      case _i61.SubtitleReviewTaskDetail():
        return 'SubtitleReviewTaskDetail';
      case _i62.SubtitleReviewTaskStatus():
        return 'SubtitleReviewTaskStatus';
      case _i63.SubtitleSearchResult():
        return 'SubtitleSearchResult';
      case _i64.SubtitleSrtPreview():
        return 'SubtitleSrtPreview';
      case _i65.SubtitleToken():
        return 'SubtitleToken';
      case _i66.SubtitleTrack():
        return 'SubtitleTrack';
      case _i67.UserKnownEntry():
        return 'UserKnownEntry';
      case _i68.Video():
        return 'Video';
      case _i69.VideoCommentDto():
        return 'VideoCommentDto';
      case _i70.VideoCommentRow():
        return 'VideoCommentRow';
      case _i71.VideoContentType():
        return 'VideoContentType';
      case _i72.VideoFavorite():
        return 'VideoFavorite';
      case _i73.VideoLike():
        return 'VideoLike';
      case _i74.VideoSeries():
        return 'VideoSeries';
      case _i75.VideoStatus():
        return 'VideoStatus';
      case _i76.WatchHistory():
        return 'WatchHistory';
      case _i77.WordList():
        return 'WordList';
      case _i78.WordListDetail():
        return 'WordListDetail';
      case _i79.WordListItem():
        return 'WordListItem';
      case _i80.WordListItemDetail():
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
    if (dataClassName == 'AdminMember') {
      return deserialize<_i5.AdminMember>(data['data']);
    }
    if (dataClassName == 'AdminPermission') {
      return deserialize<_i6.AdminPermission>(data['data']);
    }
    if (dataClassName == 'AdminRole') {
      return deserialize<_i7.AdminRole>(data['data']);
    }
    if (dataClassName == 'AdminRolePermission') {
      return deserialize<_i8.AdminRolePermission>(data['data']);
    }
    if (dataClassName == 'AdminWorkspace') {
      return deserialize<_i9.AdminWorkspace>(data['data']);
    }
    if (dataClassName == 'AppNotification') {
      return deserialize<_i10.AppNotification>(data['data']);
    }
    if (dataClassName == 'AppProfile') {
      return deserialize<_i11.AppProfile>(data['data']);
    }
    if (dataClassName == 'AsrJob') {
      return deserialize<_i12.AsrJob>(data['data']);
    }
    if (dataClassName == 'AsrJobStatus') {
      return deserialize<_i13.AsrJobStatus>(data['data']);
    }
    if (dataClassName == 'CommentLike') {
      return deserialize<_i14.CommentLike>(data['data']);
    }
    if (dataClassName == 'CommentPageDto') {
      return deserialize<_i15.CommentPageDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyDto') {
      return deserialize<_i16.CommentReplyDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyLike') {
      return deserialize<_i17.CommentReplyLike>(data['data']);
    }
    if (dataClassName == 'CommentReplyRow') {
      return deserialize<_i18.CommentReplyRow>(data['data']);
    }
    if (dataClassName == 'CreatorFollow') {
      return deserialize<_i19.CreatorFollow>(data['data']);
    }
    if (dataClassName == 'DeviceToken') {
      return deserialize<_i20.DeviceToken>(data['data']);
    }
    if (dataClassName == 'DictionaryDefinition') {
      return deserialize<_i21.DictionaryDefinition>(data['data']);
    }
    if (dataClassName == 'DictionaryEntry') {
      return deserialize<_i22.DictionaryEntry>(data['data']);
    }
    if (dataClassName == 'DictionaryEntryDetail') {
      return deserialize<_i23.DictionaryEntryDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExample') {
      return deserialize<_i24.DictionaryExample>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleDetail') {
      return deserialize<_i25.DictionaryExampleDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleText') {
      return deserialize<_i26.DictionaryExampleText>(data['data']);
    }
    if (dataClassName == 'DictionaryForm') {
      return deserialize<_i27.DictionaryForm>(data['data']);
    }
    if (dataClassName == 'DictionaryImportCommitResult') {
      return deserialize<_i28.DictionaryImportCommitResult>(data['data']);
    }
    if (dataClassName == 'DictionaryImportMapping') {
      return deserialize<_i29.DictionaryImportMapping>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreview') {
      return deserialize<_i30.DictionaryImportPreview>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreviewRow') {
      return deserialize<_i31.DictionaryImportPreviewRow>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfile') {
      return deserialize<_i32.DictionaryImportProfile>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfileDetail') {
      return deserialize<_i33.DictionaryImportProfileDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryRelation') {
      return deserialize<_i34.DictionaryRelation>(data['data']);
    }
    if (dataClassName == 'DictionaryRelationDetail') {
      return deserialize<_i35.DictionaryRelationDetail>(data['data']);
    }
    if (dataClassName == 'EntryKnowledgeState') {
      return deserialize<_i36.EntryKnowledgeState>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i37.Greeting>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateQuery') {
      return deserialize<_i38.KnowledgeStateQuery>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateResult') {
      return deserialize<_i39.KnowledgeStateResult>(data['data']);
    }
    if (dataClassName == 'NotificationSettings') {
      return deserialize<_i40.NotificationSettings>(data['data']);
    }
    if (dataClassName == 'NotificationType') {
      return deserialize<_i41.NotificationType>(data['data']);
    }
    if (dataClassName == 'PrivacySettings') {
      return deserialize<_i42.PrivacySettings>(data['data']);
    }
    if (dataClassName == 'ProfileStats') {
      return deserialize<_i43.ProfileStats>(data['data']);
    }
    if (dataClassName == 'ScriptConversionCommitResult') {
      return deserialize<_i44.ScriptConversionCommitResult>(data['data']);
    }
    if (dataClassName == 'ScriptConversionEntry') {
      return deserialize<_i45.ScriptConversionEntry>(data['data']);
    }
    if (dataClassName == 'ScriptConversionImportPreview') {
      return deserialize<_i46.ScriptConversionImportPreview>(data['data']);
    }
    if (dataClassName == 'ScriptConversionImportPreviewRow') {
      return deserialize<_i47.ScriptConversionImportPreviewRow>(data['data']);
    }
    if (dataClassName == 'ScriptConversionProfile') {
      return deserialize<_i48.ScriptConversionProfile>(data['data']);
    }
    if (dataClassName == 'SubtitleCue') {
      return deserialize<_i49.SubtitleCue>(data['data']);
    }
    if (dataClassName == 'SubtitleCueDetail') {
      return deserialize<_i50.SubtitleCueDetail>(data['data']);
    }
    if (dataClassName == 'SubtitleCueText') {
      return deserialize<_i51.SubtitleCueText>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegment') {
      return deserialize<_i52.SubtitleKaraokeSegment>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegmentInput') {
      return deserialize<_i53.SubtitleKaraokeSegmentInput>(data['data']);
    }
    if (dataClassName == 'SubtitlePhrase') {
      return deserialize<_i54.SubtitlePhrase>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishState') {
      return deserialize<_i55.SubtitlePublishState>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishStatus') {
      return deserialize<_i56.SubtitlePublishStatus>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewDashboard') {
      return deserialize<_i57.SubtitleReviewDashboard>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewEvent') {
      return deserialize<_i58.SubtitleReviewEvent>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewQueueItem') {
      return deserialize<_i59.SubtitleReviewQueueItem>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTask') {
      return deserialize<_i60.SubtitleReviewTask>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTaskDetail') {
      return deserialize<_i61.SubtitleReviewTaskDetail>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTaskStatus') {
      return deserialize<_i62.SubtitleReviewTaskStatus>(data['data']);
    }
    if (dataClassName == 'SubtitleSearchResult') {
      return deserialize<_i63.SubtitleSearchResult>(data['data']);
    }
    if (dataClassName == 'SubtitleSrtPreview') {
      return deserialize<_i64.SubtitleSrtPreview>(data['data']);
    }
    if (dataClassName == 'SubtitleToken') {
      return deserialize<_i65.SubtitleToken>(data['data']);
    }
    if (dataClassName == 'SubtitleTrack') {
      return deserialize<_i66.SubtitleTrack>(data['data']);
    }
    if (dataClassName == 'UserKnownEntry') {
      return deserialize<_i67.UserKnownEntry>(data['data']);
    }
    if (dataClassName == 'Video') {
      return deserialize<_i68.Video>(data['data']);
    }
    if (dataClassName == 'VideoCommentDto') {
      return deserialize<_i69.VideoCommentDto>(data['data']);
    }
    if (dataClassName == 'VideoCommentRow') {
      return deserialize<_i70.VideoCommentRow>(data['data']);
    }
    if (dataClassName == 'VideoContentType') {
      return deserialize<_i71.VideoContentType>(data['data']);
    }
    if (dataClassName == 'VideoFavorite') {
      return deserialize<_i72.VideoFavorite>(data['data']);
    }
    if (dataClassName == 'VideoLike') {
      return deserialize<_i73.VideoLike>(data['data']);
    }
    if (dataClassName == 'VideoSeries') {
      return deserialize<_i74.VideoSeries>(data['data']);
    }
    if (dataClassName == 'VideoStatus') {
      return deserialize<_i75.VideoStatus>(data['data']);
    }
    if (dataClassName == 'WatchHistory') {
      return deserialize<_i76.WatchHistory>(data['data']);
    }
    if (dataClassName == 'WordList') {
      return deserialize<_i77.WordList>(data['data']);
    }
    if (dataClassName == 'WordListDetail') {
      return deserialize<_i78.WordListDetail>(data['data']);
    }
    if (dataClassName == 'WordListItem') {
      return deserialize<_i79.WordListItem>(data['data']);
    }
    if (dataClassName == 'WordListItemDetail') {
      return deserialize<_i80.WordListItemDetail>(data['data']);
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
      case _i5.AdminMember:
        return _i5.AdminMember.t;
      case _i6.AdminPermission:
        return _i6.AdminPermission.t;
      case _i7.AdminRole:
        return _i7.AdminRole.t;
      case _i8.AdminRolePermission:
        return _i8.AdminRolePermission.t;
      case _i9.AdminWorkspace:
        return _i9.AdminWorkspace.t;
      case _i10.AppNotification:
        return _i10.AppNotification.t;
      case _i11.AppProfile:
        return _i11.AppProfile.t;
      case _i12.AsrJob:
        return _i12.AsrJob.t;
      case _i14.CommentLike:
        return _i14.CommentLike.t;
      case _i17.CommentReplyLike:
        return _i17.CommentReplyLike.t;
      case _i18.CommentReplyRow:
        return _i18.CommentReplyRow.t;
      case _i19.CreatorFollow:
        return _i19.CreatorFollow.t;
      case _i20.DeviceToken:
        return _i20.DeviceToken.t;
      case _i21.DictionaryDefinition:
        return _i21.DictionaryDefinition.t;
      case _i22.DictionaryEntry:
        return _i22.DictionaryEntry.t;
      case _i24.DictionaryExample:
        return _i24.DictionaryExample.t;
      case _i26.DictionaryExampleText:
        return _i26.DictionaryExampleText.t;
      case _i27.DictionaryForm:
        return _i27.DictionaryForm.t;
      case _i29.DictionaryImportMapping:
        return _i29.DictionaryImportMapping.t;
      case _i32.DictionaryImportProfile:
        return _i32.DictionaryImportProfile.t;
      case _i34.DictionaryRelation:
        return _i34.DictionaryRelation.t;
      case _i40.NotificationSettings:
        return _i40.NotificationSettings.t;
      case _i42.PrivacySettings:
        return _i42.PrivacySettings.t;
      case _i45.ScriptConversionEntry:
        return _i45.ScriptConversionEntry.t;
      case _i48.ScriptConversionProfile:
        return _i48.ScriptConversionProfile.t;
      case _i49.SubtitleCue:
        return _i49.SubtitleCue.t;
      case _i51.SubtitleCueText:
        return _i51.SubtitleCueText.t;
      case _i52.SubtitleKaraokeSegment:
        return _i52.SubtitleKaraokeSegment.t;
      case _i54.SubtitlePhrase:
        return _i54.SubtitlePhrase.t;
      case _i55.SubtitlePublishState:
        return _i55.SubtitlePublishState.t;
      case _i58.SubtitleReviewEvent:
        return _i58.SubtitleReviewEvent.t;
      case _i60.SubtitleReviewTask:
        return _i60.SubtitleReviewTask.t;
      case _i65.SubtitleToken:
        return _i65.SubtitleToken.t;
      case _i66.SubtitleTrack:
        return _i66.SubtitleTrack.t;
      case _i67.UserKnownEntry:
        return _i67.UserKnownEntry.t;
      case _i68.Video:
        return _i68.Video.t;
      case _i70.VideoCommentRow:
        return _i70.VideoCommentRow.t;
      case _i72.VideoFavorite:
        return _i72.VideoFavorite.t;
      case _i73.VideoLike:
        return _i73.VideoLike.t;
      case _i74.VideoSeries:
        return _i74.VideoSeries.t;
      case _i76.WatchHistory:
        return _i76.WatchHistory.t;
      case _i77.WordList:
        return _i77.WordList.t;
      case _i79.WordListItem:
        return _i79.WordListItem.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'glyphora_backend';

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
