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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'admin_member.dart' as _i2;
import 'admin_permission.dart' as _i3;
import 'admin_role.dart' as _i4;
import 'admin_role_permission.dart' as _i5;
import 'admin_workspace.dart' as _i6;
import 'app_notification.dart' as _i7;
import 'app_profile.dart' as _i8;
import 'asr_job.dart' as _i9;
import 'asr_job_status.dart' as _i10;
import 'comment_like.dart' as _i11;
import 'comment_page_dto.dart' as _i12;
import 'comment_reply_dto.dart' as _i13;
import 'comment_reply_like.dart' as _i14;
import 'comment_reply_row.dart' as _i15;
import 'creator_follow.dart' as _i16;
import 'dictionary_definition.dart' as _i17;
import 'dictionary_entry.dart' as _i18;
import 'dictionary_entry_detail.dart' as _i19;
import 'dictionary_example.dart' as _i20;
import 'dictionary_example_detail.dart' as _i21;
import 'dictionary_example_text.dart' as _i22;
import 'dictionary_form.dart' as _i23;
import 'dictionary_import_commit_result.dart' as _i24;
import 'dictionary_import_mapping.dart' as _i25;
import 'dictionary_import_preview.dart' as _i26;
import 'dictionary_import_preview_row.dart' as _i27;
import 'dictionary_import_profile.dart' as _i28;
import 'dictionary_import_profile_detail.dart' as _i29;
import 'dictionary_relation.dart' as _i30;
import 'dictionary_relation_detail.dart' as _i31;
import 'entry_knowledge_state.dart' as _i32;
import 'greetings/greeting.dart' as _i33;
import 'knowledge_state_query.dart' as _i34;
import 'knowledge_state_result.dart' as _i35;
import 'notification_settings.dart' as _i36;
import 'notification_type.dart' as _i37;
import 'privacy_settings.dart' as _i38;
import 'profile_stats.dart' as _i39;
import 'script_conversion_commit_result.dart' as _i40;
import 'script_conversion_entry.dart' as _i41;
import 'script_conversion_import_preview.dart' as _i42;
import 'script_conversion_import_preview_row.dart' as _i43;
import 'script_conversion_profile.dart' as _i44;
import 'subtitle_cue.dart' as _i45;
import 'subtitle_cue_detail.dart' as _i46;
import 'subtitle_cue_text.dart' as _i47;
import 'subtitle_karaoke_segment.dart' as _i48;
import 'subtitle_karaoke_segment_input.dart' as _i49;
import 'subtitle_phrase.dart' as _i50;
import 'subtitle_publish_state.dart' as _i51;
import 'subtitle_publish_status.dart' as _i52;
import 'subtitle_review_dashboard.dart' as _i53;
import 'subtitle_review_event.dart' as _i54;
import 'subtitle_review_queue_item.dart' as _i55;
import 'subtitle_review_task.dart' as _i56;
import 'subtitle_review_task_detail.dart' as _i57;
import 'subtitle_review_task_status.dart' as _i58;
import 'subtitle_srt_preview.dart' as _i59;
import 'subtitle_token.dart' as _i60;
import 'subtitle_track.dart' as _i61;
import 'user_known_entry.dart' as _i62;
import 'video.dart' as _i63;
import 'video_comment_dto.dart' as _i64;
import 'video_comment_row.dart' as _i65;
import 'video_content_type.dart' as _i66;
import 'video_favorite.dart' as _i67;
import 'video_like.dart' as _i68;
import 'video_series.dart' as _i69;
import 'video_status.dart' as _i70;
import 'watch_history.dart' as _i71;
import 'word_list.dart' as _i72;
import 'word_list_detail.dart' as _i73;
import 'word_list_item.dart' as _i74;
import 'word_list_item_detail.dart' as _i75;
import 'package:clyven_backend_client/src/protocol/asr_job.dart' as _i76;
import 'package:clyven_backend_client/src/protocol/video.dart' as _i77;
import 'package:clyven_backend_client/src/protocol/subtitle_track.dart' as _i78;
import 'package:clyven_backend_client/src/protocol/admin_member.dart' as _i79;
import 'package:clyven_backend_client/src/protocol/admin_role.dart' as _i80;
import 'package:clyven_backend_client/src/protocol/admin_permission.dart'
    as _i81;
import 'package:clyven_backend_client/src/protocol/admin_role_permission.dart'
    as _i82;
import 'package:clyven_backend_client/src/protocol/dictionary_entry_detail.dart'
    as _i83;
import 'package:clyven_backend_client/src/protocol/dictionary_import_profile.dart'
    as _i84;
import 'package:clyven_backend_client/src/protocol/entry_knowledge_state.dart'
    as _i85;
import 'package:clyven_backend_client/src/protocol/knowledge_state_result.dart'
    as _i86;
import 'package:clyven_backend_client/src/protocol/knowledge_state_query.dart'
    as _i87;
import 'package:clyven_backend_client/src/protocol/app_notification.dart'
    as _i88;
import 'package:clyven_backend_client/src/protocol/script_conversion_profile.dart'
    as _i89;
import 'package:clyven_backend_client/src/protocol/script_conversion_entry.dart'
    as _i90;
import 'package:clyven_backend_client/src/protocol/watch_history.dart' as _i91;
import 'package:clyven_backend_client/src/protocol/subtitle_cue_detail.dart'
    as _i92;
import 'package:clyven_backend_client/src/protocol/subtitle_karaoke_segment.dart'
    as _i93;
import 'package:clyven_backend_client/src/protocol/subtitle_karaoke_segment_input.dart'
    as _i94;
import 'package:clyven_backend_client/src/protocol/video_series.dart' as _i95;
import 'package:clyven_backend_client/src/protocol/word_list.dart' as _i96;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i97;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i98;
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
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

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

    if (t == _i2.AdminMember) {
      return _i2.AdminMember.fromJson(data) as T;
    }
    if (t == _i3.AdminPermission) {
      return _i3.AdminPermission.fromJson(data) as T;
    }
    if (t == _i4.AdminRole) {
      return _i4.AdminRole.fromJson(data) as T;
    }
    if (t == _i5.AdminRolePermission) {
      return _i5.AdminRolePermission.fromJson(data) as T;
    }
    if (t == _i6.AdminWorkspace) {
      return _i6.AdminWorkspace.fromJson(data) as T;
    }
    if (t == _i7.AppNotification) {
      return _i7.AppNotification.fromJson(data) as T;
    }
    if (t == _i8.AppProfile) {
      return _i8.AppProfile.fromJson(data) as T;
    }
    if (t == _i9.AsrJob) {
      return _i9.AsrJob.fromJson(data) as T;
    }
    if (t == _i10.AsrJobStatus) {
      return _i10.AsrJobStatus.fromJson(data) as T;
    }
    if (t == _i11.CommentLike) {
      return _i11.CommentLike.fromJson(data) as T;
    }
    if (t == _i12.CommentPageDto) {
      return _i12.CommentPageDto.fromJson(data) as T;
    }
    if (t == _i13.CommentReplyDto) {
      return _i13.CommentReplyDto.fromJson(data) as T;
    }
    if (t == _i14.CommentReplyLike) {
      return _i14.CommentReplyLike.fromJson(data) as T;
    }
    if (t == _i15.CommentReplyRow) {
      return _i15.CommentReplyRow.fromJson(data) as T;
    }
    if (t == _i16.CreatorFollow) {
      return _i16.CreatorFollow.fromJson(data) as T;
    }
    if (t == _i17.DictionaryDefinition) {
      return _i17.DictionaryDefinition.fromJson(data) as T;
    }
    if (t == _i18.DictionaryEntry) {
      return _i18.DictionaryEntry.fromJson(data) as T;
    }
    if (t == _i19.DictionaryEntryDetail) {
      return _i19.DictionaryEntryDetail.fromJson(data) as T;
    }
    if (t == _i20.DictionaryExample) {
      return _i20.DictionaryExample.fromJson(data) as T;
    }
    if (t == _i21.DictionaryExampleDetail) {
      return _i21.DictionaryExampleDetail.fromJson(data) as T;
    }
    if (t == _i22.DictionaryExampleText) {
      return _i22.DictionaryExampleText.fromJson(data) as T;
    }
    if (t == _i23.DictionaryForm) {
      return _i23.DictionaryForm.fromJson(data) as T;
    }
    if (t == _i24.DictionaryImportCommitResult) {
      return _i24.DictionaryImportCommitResult.fromJson(data) as T;
    }
    if (t == _i25.DictionaryImportMapping) {
      return _i25.DictionaryImportMapping.fromJson(data) as T;
    }
    if (t == _i26.DictionaryImportPreview) {
      return _i26.DictionaryImportPreview.fromJson(data) as T;
    }
    if (t == _i27.DictionaryImportPreviewRow) {
      return _i27.DictionaryImportPreviewRow.fromJson(data) as T;
    }
    if (t == _i28.DictionaryImportProfile) {
      return _i28.DictionaryImportProfile.fromJson(data) as T;
    }
    if (t == _i29.DictionaryImportProfileDetail) {
      return _i29.DictionaryImportProfileDetail.fromJson(data) as T;
    }
    if (t == _i30.DictionaryRelation) {
      return _i30.DictionaryRelation.fromJson(data) as T;
    }
    if (t == _i31.DictionaryRelationDetail) {
      return _i31.DictionaryRelationDetail.fromJson(data) as T;
    }
    if (t == _i32.EntryKnowledgeState) {
      return _i32.EntryKnowledgeState.fromJson(data) as T;
    }
    if (t == _i33.Greeting) {
      return _i33.Greeting.fromJson(data) as T;
    }
    if (t == _i34.KnowledgeStateQuery) {
      return _i34.KnowledgeStateQuery.fromJson(data) as T;
    }
    if (t == _i35.KnowledgeStateResult) {
      return _i35.KnowledgeStateResult.fromJson(data) as T;
    }
    if (t == _i36.NotificationSettings) {
      return _i36.NotificationSettings.fromJson(data) as T;
    }
    if (t == _i37.NotificationType) {
      return _i37.NotificationType.fromJson(data) as T;
    }
    if (t == _i38.PrivacySettings) {
      return _i38.PrivacySettings.fromJson(data) as T;
    }
    if (t == _i39.ProfileStats) {
      return _i39.ProfileStats.fromJson(data) as T;
    }
    if (t == _i40.ScriptConversionCommitResult) {
      return _i40.ScriptConversionCommitResult.fromJson(data) as T;
    }
    if (t == _i41.ScriptConversionEntry) {
      return _i41.ScriptConversionEntry.fromJson(data) as T;
    }
    if (t == _i42.ScriptConversionImportPreview) {
      return _i42.ScriptConversionImportPreview.fromJson(data) as T;
    }
    if (t == _i43.ScriptConversionImportPreviewRow) {
      return _i43.ScriptConversionImportPreviewRow.fromJson(data) as T;
    }
    if (t == _i44.ScriptConversionProfile) {
      return _i44.ScriptConversionProfile.fromJson(data) as T;
    }
    if (t == _i45.SubtitleCue) {
      return _i45.SubtitleCue.fromJson(data) as T;
    }
    if (t == _i46.SubtitleCueDetail) {
      return _i46.SubtitleCueDetail.fromJson(data) as T;
    }
    if (t == _i47.SubtitleCueText) {
      return _i47.SubtitleCueText.fromJson(data) as T;
    }
    if (t == _i48.SubtitleKaraokeSegment) {
      return _i48.SubtitleKaraokeSegment.fromJson(data) as T;
    }
    if (t == _i49.SubtitleKaraokeSegmentInput) {
      return _i49.SubtitleKaraokeSegmentInput.fromJson(data) as T;
    }
    if (t == _i50.SubtitlePhrase) {
      return _i50.SubtitlePhrase.fromJson(data) as T;
    }
    if (t == _i51.SubtitlePublishState) {
      return _i51.SubtitlePublishState.fromJson(data) as T;
    }
    if (t == _i52.SubtitlePublishStatus) {
      return _i52.SubtitlePublishStatus.fromJson(data) as T;
    }
    if (t == _i53.SubtitleReviewDashboard) {
      return _i53.SubtitleReviewDashboard.fromJson(data) as T;
    }
    if (t == _i54.SubtitleReviewEvent) {
      return _i54.SubtitleReviewEvent.fromJson(data) as T;
    }
    if (t == _i55.SubtitleReviewQueueItem) {
      return _i55.SubtitleReviewQueueItem.fromJson(data) as T;
    }
    if (t == _i56.SubtitleReviewTask) {
      return _i56.SubtitleReviewTask.fromJson(data) as T;
    }
    if (t == _i57.SubtitleReviewTaskDetail) {
      return _i57.SubtitleReviewTaskDetail.fromJson(data) as T;
    }
    if (t == _i58.SubtitleReviewTaskStatus) {
      return _i58.SubtitleReviewTaskStatus.fromJson(data) as T;
    }
    if (t == _i59.SubtitleSrtPreview) {
      return _i59.SubtitleSrtPreview.fromJson(data) as T;
    }
    if (t == _i60.SubtitleToken) {
      return _i60.SubtitleToken.fromJson(data) as T;
    }
    if (t == _i61.SubtitleTrack) {
      return _i61.SubtitleTrack.fromJson(data) as T;
    }
    if (t == _i62.UserKnownEntry) {
      return _i62.UserKnownEntry.fromJson(data) as T;
    }
    if (t == _i63.Video) {
      return _i63.Video.fromJson(data) as T;
    }
    if (t == _i64.VideoCommentDto) {
      return _i64.VideoCommentDto.fromJson(data) as T;
    }
    if (t == _i65.VideoCommentRow) {
      return _i65.VideoCommentRow.fromJson(data) as T;
    }
    if (t == _i66.VideoContentType) {
      return _i66.VideoContentType.fromJson(data) as T;
    }
    if (t == _i67.VideoFavorite) {
      return _i67.VideoFavorite.fromJson(data) as T;
    }
    if (t == _i68.VideoLike) {
      return _i68.VideoLike.fromJson(data) as T;
    }
    if (t == _i69.VideoSeries) {
      return _i69.VideoSeries.fromJson(data) as T;
    }
    if (t == _i70.VideoStatus) {
      return _i70.VideoStatus.fromJson(data) as T;
    }
    if (t == _i71.WatchHistory) {
      return _i71.WatchHistory.fromJson(data) as T;
    }
    if (t == _i72.WordList) {
      return _i72.WordList.fromJson(data) as T;
    }
    if (t == _i73.WordListDetail) {
      return _i73.WordListDetail.fromJson(data) as T;
    }
    if (t == _i74.WordListItem) {
      return _i74.WordListItem.fromJson(data) as T;
    }
    if (t == _i75.WordListItemDetail) {
      return _i75.WordListItemDetail.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AdminMember?>()) {
      return (data != null ? _i2.AdminMember.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AdminPermission?>()) {
      return (data != null ? _i3.AdminPermission.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AdminRole?>()) {
      return (data != null ? _i4.AdminRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AdminRolePermission?>()) {
      return (data != null ? _i5.AdminRolePermission.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.AdminWorkspace?>()) {
      return (data != null ? _i6.AdminWorkspace.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AppNotification?>()) {
      return (data != null ? _i7.AppNotification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AppProfile?>()) {
      return (data != null ? _i8.AppProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.AsrJob?>()) {
      return (data != null ? _i9.AsrJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.AsrJobStatus?>()) {
      return (data != null ? _i10.AsrJobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.CommentLike?>()) {
      return (data != null ? _i11.CommentLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.CommentPageDto?>()) {
      return (data != null ? _i12.CommentPageDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.CommentReplyDto?>()) {
      return (data != null ? _i13.CommentReplyDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.CommentReplyLike?>()) {
      return (data != null ? _i14.CommentReplyLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.CommentReplyRow?>()) {
      return (data != null ? _i15.CommentReplyRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.CreatorFollow?>()) {
      return (data != null ? _i16.CreatorFollow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.DictionaryDefinition?>()) {
      return (data != null ? _i17.DictionaryDefinition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.DictionaryEntry?>()) {
      return (data != null ? _i18.DictionaryEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.DictionaryEntryDetail?>()) {
      return (data != null ? _i19.DictionaryEntryDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.DictionaryExample?>()) {
      return (data != null ? _i20.DictionaryExample.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.DictionaryExampleDetail?>()) {
      return (data != null ? _i21.DictionaryExampleDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.DictionaryExampleText?>()) {
      return (data != null ? _i22.DictionaryExampleText.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.DictionaryForm?>()) {
      return (data != null ? _i23.DictionaryForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.DictionaryImportCommitResult?>()) {
      return (data != null
              ? _i24.DictionaryImportCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i25.DictionaryImportMapping?>()) {
      return (data != null ? _i25.DictionaryImportMapping.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.DictionaryImportPreview?>()) {
      return (data != null ? _i26.DictionaryImportPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.DictionaryImportPreviewRow?>()) {
      return (data != null
              ? _i27.DictionaryImportPreviewRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i28.DictionaryImportProfile?>()) {
      return (data != null ? _i28.DictionaryImportProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.DictionaryImportProfileDetail?>()) {
      return (data != null
              ? _i29.DictionaryImportProfileDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i30.DictionaryRelation?>()) {
      return (data != null ? _i30.DictionaryRelation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.DictionaryRelationDetail?>()) {
      return (data != null
              ? _i31.DictionaryRelationDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i32.EntryKnowledgeState?>()) {
      return (data != null ? _i32.EntryKnowledgeState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.Greeting?>()) {
      return (data != null ? _i33.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.KnowledgeStateQuery?>()) {
      return (data != null ? _i34.KnowledgeStateQuery.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.KnowledgeStateResult?>()) {
      return (data != null ? _i35.KnowledgeStateResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i36.NotificationSettings?>()) {
      return (data != null ? _i36.NotificationSettings.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i37.NotificationType?>()) {
      return (data != null ? _i37.NotificationType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.PrivacySettings?>()) {
      return (data != null ? _i38.PrivacySettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.ProfileStats?>()) {
      return (data != null ? _i39.ProfileStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.ScriptConversionCommitResult?>()) {
      return (data != null
              ? _i40.ScriptConversionCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i41.ScriptConversionEntry?>()) {
      return (data != null ? _i41.ScriptConversionEntry.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i42.ScriptConversionImportPreview?>()) {
      return (data != null
              ? _i42.ScriptConversionImportPreview.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i43.ScriptConversionImportPreviewRow?>()) {
      return (data != null
              ? _i43.ScriptConversionImportPreviewRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i44.ScriptConversionProfile?>()) {
      return (data != null ? _i44.ScriptConversionProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i45.SubtitleCue?>()) {
      return (data != null ? _i45.SubtitleCue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.SubtitleCueDetail?>()) {
      return (data != null ? _i46.SubtitleCueDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.SubtitleCueText?>()) {
      return (data != null ? _i47.SubtitleCueText.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.SubtitleKaraokeSegment?>()) {
      return (data != null ? _i48.SubtitleKaraokeSegment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i49.SubtitleKaraokeSegmentInput?>()) {
      return (data != null
              ? _i49.SubtitleKaraokeSegmentInput.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i50.SubtitlePhrase?>()) {
      return (data != null ? _i50.SubtitlePhrase.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.SubtitlePublishState?>()) {
      return (data != null ? _i51.SubtitlePublishState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i52.SubtitlePublishStatus?>()) {
      return (data != null ? _i52.SubtitlePublishStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i53.SubtitleReviewDashboard?>()) {
      return (data != null ? _i53.SubtitleReviewDashboard.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.SubtitleReviewEvent?>()) {
      return (data != null ? _i54.SubtitleReviewEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.SubtitleReviewQueueItem?>()) {
      return (data != null ? _i55.SubtitleReviewQueueItem.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i56.SubtitleReviewTask?>()) {
      return (data != null ? _i56.SubtitleReviewTask.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i57.SubtitleReviewTaskDetail?>()) {
      return (data != null
              ? _i57.SubtitleReviewTaskDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i58.SubtitleReviewTaskStatus?>()) {
      return (data != null
              ? _i58.SubtitleReviewTaskStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i59.SubtitleSrtPreview?>()) {
      return (data != null ? _i59.SubtitleSrtPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i60.SubtitleToken?>()) {
      return (data != null ? _i60.SubtitleToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.SubtitleTrack?>()) {
      return (data != null ? _i61.SubtitleTrack.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.UserKnownEntry?>()) {
      return (data != null ? _i62.UserKnownEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.Video?>()) {
      return (data != null ? _i63.Video.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.VideoCommentDto?>()) {
      return (data != null ? _i64.VideoCommentDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.VideoCommentRow?>()) {
      return (data != null ? _i65.VideoCommentRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.VideoContentType?>()) {
      return (data != null ? _i66.VideoContentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.VideoFavorite?>()) {
      return (data != null ? _i67.VideoFavorite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.VideoLike?>()) {
      return (data != null ? _i68.VideoLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.VideoSeries?>()) {
      return (data != null ? _i69.VideoSeries.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.VideoStatus?>()) {
      return (data != null ? _i70.VideoStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.WatchHistory?>()) {
      return (data != null ? _i71.WatchHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.WordList?>()) {
      return (data != null ? _i72.WordList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.WordListDetail?>()) {
      return (data != null ? _i73.WordListDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.WordListItem?>()) {
      return (data != null ? _i74.WordListItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i75.WordListItemDetail?>()) {
      return (data != null ? _i75.WordListItemDetail.fromJson(data) : null)
          as T;
    }
    if (t == List<_i64.VideoCommentDto>) {
      return (data as List)
              .map((e) => deserialize<_i64.VideoCommentDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i17.DictionaryDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i17.DictionaryDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i23.DictionaryForm>) {
      return (data as List)
              .map((e) => deserialize<_i23.DictionaryForm>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.DictionaryExampleDetail>) {
      return (data as List)
              .map((e) => deserialize<_i21.DictionaryExampleDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i31.DictionaryRelationDetail>) {
      return (data as List)
              .map((e) => deserialize<_i31.DictionaryRelationDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.DictionaryExampleText>) {
      return (data as List)
              .map((e) => deserialize<_i22.DictionaryExampleText>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i27.DictionaryImportPreviewRow>) {
      return (data as List)
              .map((e) => deserialize<_i27.DictionaryImportPreviewRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.DictionaryImportMapping>) {
      return (data as List)
              .map((e) => deserialize<_i25.DictionaryImportMapping>(e))
              .toList()
          as T;
    }
    if (t == List<_i43.ScriptConversionImportPreviewRow>) {
      return (data as List)
              .map((e) => deserialize<_i43.ScriptConversionImportPreviewRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i47.SubtitleCueText>) {
      return (data as List)
              .map((e) => deserialize<_i47.SubtitleCueText>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i47.SubtitleCueText>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i47.SubtitleCueText>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i60.SubtitleToken>) {
      return (data as List)
              .map((e) => deserialize<_i60.SubtitleToken>(e))
              .toList()
          as T;
    }
    if (t == List<_i50.SubtitlePhrase>) {
      return (data as List)
              .map((e) => deserialize<_i50.SubtitlePhrase>(e))
              .toList()
          as T;
    }
    if (t == List<_i48.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i48.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i48.SubtitleKaraokeSegment>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i48.SubtitleKaraokeSegment>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i55.SubtitleReviewQueueItem>) {
      return (data as List)
              .map((e) => deserialize<_i55.SubtitleReviewQueueItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i54.SubtitleReviewEvent>) {
      return (data as List)
              .map((e) => deserialize<_i54.SubtitleReviewEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.CommentReplyDto>) {
      return (data as List)
              .map((e) => deserialize<_i13.CommentReplyDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i75.WordListItemDetail>) {
      return (data as List)
              .map((e) => deserialize<_i75.WordListItemDetail>(e))
              .toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i76.AsrJob>) {
      return (data as List).map((e) => deserialize<_i76.AsrJob>(e)).toList()
          as T;
    }
    if (t == List<_i77.Video>) {
      return (data as List).map((e) => deserialize<_i77.Video>(e)).toList()
          as T;
    }
    if (t == List<_i78.SubtitleTrack>) {
      return (data as List)
              .map((e) => deserialize<_i78.SubtitleTrack>(e))
              .toList()
          as T;
    }
    if (t == List<_i79.AdminMember>) {
      return (data as List)
              .map((e) => deserialize<_i79.AdminMember>(e))
              .toList()
          as T;
    }
    if (t == List<_i80.AdminRole>) {
      return (data as List).map((e) => deserialize<_i80.AdminRole>(e)).toList()
          as T;
    }
    if (t == List<_i81.AdminPermission>) {
      return (data as List)
              .map((e) => deserialize<_i81.AdminPermission>(e))
              .toList()
          as T;
    }
    if (t == List<_i82.AdminRolePermission>) {
      return (data as List)
              .map((e) => deserialize<_i82.AdminRolePermission>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i83.DictionaryEntryDetail>) {
      return (data as List)
              .map((e) => deserialize<_i83.DictionaryEntryDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i84.DictionaryImportProfile>) {
      return (data as List)
              .map((e) => deserialize<_i84.DictionaryImportProfile>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i85.EntryKnowledgeState>) {
      return (data as List)
              .map((e) => deserialize<_i85.EntryKnowledgeState>(e))
              .toList()
          as T;
    }
    if (t == List<_i86.KnowledgeStateResult>) {
      return (data as List)
              .map((e) => deserialize<_i86.KnowledgeStateResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i87.KnowledgeStateQuery>) {
      return (data as List)
              .map((e) => deserialize<_i87.KnowledgeStateQuery>(e))
              .toList()
          as T;
    }
    if (t == List<_i88.AppNotification>) {
      return (data as List)
              .map((e) => deserialize<_i88.AppNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_i89.ScriptConversionProfile>) {
      return (data as List)
              .map((e) => deserialize<_i89.ScriptConversionProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_i90.ScriptConversionEntry>) {
      return (data as List)
              .map((e) => deserialize<_i90.ScriptConversionEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i91.WatchHistory>) {
      return (data as List)
              .map((e) => deserialize<_i91.WatchHistory>(e))
              .toList()
          as T;
    }
    if (t == List<_i92.SubtitleCueDetail>) {
      return (data as List)
              .map((e) => deserialize<_i92.SubtitleCueDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i93.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i93.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == List<_i94.SubtitleKaraokeSegmentInput>) {
      return (data as List)
              .map((e) => deserialize<_i94.SubtitleKaraokeSegmentInput>(e))
              .toList()
          as T;
    }
    if (t == List<_i95.VideoSeries>) {
      return (data as List)
              .map((e) => deserialize<_i95.VideoSeries>(e))
              .toList()
          as T;
    }
    if (t == List<_i96.WordList>) {
      return (data as List).map((e) => deserialize<_i96.WordList>(e)).toList()
          as T;
    }
    try {
      return _i97.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i98.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AdminMember => 'AdminMember',
      _i3.AdminPermission => 'AdminPermission',
      _i4.AdminRole => 'AdminRole',
      _i5.AdminRolePermission => 'AdminRolePermission',
      _i6.AdminWorkspace => 'AdminWorkspace',
      _i7.AppNotification => 'AppNotification',
      _i8.AppProfile => 'AppProfile',
      _i9.AsrJob => 'AsrJob',
      _i10.AsrJobStatus => 'AsrJobStatus',
      _i11.CommentLike => 'CommentLike',
      _i12.CommentPageDto => 'CommentPageDto',
      _i13.CommentReplyDto => 'CommentReplyDto',
      _i14.CommentReplyLike => 'CommentReplyLike',
      _i15.CommentReplyRow => 'CommentReplyRow',
      _i16.CreatorFollow => 'CreatorFollow',
      _i17.DictionaryDefinition => 'DictionaryDefinition',
      _i18.DictionaryEntry => 'DictionaryEntry',
      _i19.DictionaryEntryDetail => 'DictionaryEntryDetail',
      _i20.DictionaryExample => 'DictionaryExample',
      _i21.DictionaryExampleDetail => 'DictionaryExampleDetail',
      _i22.DictionaryExampleText => 'DictionaryExampleText',
      _i23.DictionaryForm => 'DictionaryForm',
      _i24.DictionaryImportCommitResult => 'DictionaryImportCommitResult',
      _i25.DictionaryImportMapping => 'DictionaryImportMapping',
      _i26.DictionaryImportPreview => 'DictionaryImportPreview',
      _i27.DictionaryImportPreviewRow => 'DictionaryImportPreviewRow',
      _i28.DictionaryImportProfile => 'DictionaryImportProfile',
      _i29.DictionaryImportProfileDetail => 'DictionaryImportProfileDetail',
      _i30.DictionaryRelation => 'DictionaryRelation',
      _i31.DictionaryRelationDetail => 'DictionaryRelationDetail',
      _i32.EntryKnowledgeState => 'EntryKnowledgeState',
      _i33.Greeting => 'Greeting',
      _i34.KnowledgeStateQuery => 'KnowledgeStateQuery',
      _i35.KnowledgeStateResult => 'KnowledgeStateResult',
      _i36.NotificationSettings => 'NotificationSettings',
      _i37.NotificationType => 'NotificationType',
      _i38.PrivacySettings => 'PrivacySettings',
      _i39.ProfileStats => 'ProfileStats',
      _i40.ScriptConversionCommitResult => 'ScriptConversionCommitResult',
      _i41.ScriptConversionEntry => 'ScriptConversionEntry',
      _i42.ScriptConversionImportPreview => 'ScriptConversionImportPreview',
      _i43.ScriptConversionImportPreviewRow =>
        'ScriptConversionImportPreviewRow',
      _i44.ScriptConversionProfile => 'ScriptConversionProfile',
      _i45.SubtitleCue => 'SubtitleCue',
      _i46.SubtitleCueDetail => 'SubtitleCueDetail',
      _i47.SubtitleCueText => 'SubtitleCueText',
      _i48.SubtitleKaraokeSegment => 'SubtitleKaraokeSegment',
      _i49.SubtitleKaraokeSegmentInput => 'SubtitleKaraokeSegmentInput',
      _i50.SubtitlePhrase => 'SubtitlePhrase',
      _i51.SubtitlePublishState => 'SubtitlePublishState',
      _i52.SubtitlePublishStatus => 'SubtitlePublishStatus',
      _i53.SubtitleReviewDashboard => 'SubtitleReviewDashboard',
      _i54.SubtitleReviewEvent => 'SubtitleReviewEvent',
      _i55.SubtitleReviewQueueItem => 'SubtitleReviewQueueItem',
      _i56.SubtitleReviewTask => 'SubtitleReviewTask',
      _i57.SubtitleReviewTaskDetail => 'SubtitleReviewTaskDetail',
      _i58.SubtitleReviewTaskStatus => 'SubtitleReviewTaskStatus',
      _i59.SubtitleSrtPreview => 'SubtitleSrtPreview',
      _i60.SubtitleToken => 'SubtitleToken',
      _i61.SubtitleTrack => 'SubtitleTrack',
      _i62.UserKnownEntry => 'UserKnownEntry',
      _i63.Video => 'Video',
      _i64.VideoCommentDto => 'VideoCommentDto',
      _i65.VideoCommentRow => 'VideoCommentRow',
      _i66.VideoContentType => 'VideoContentType',
      _i67.VideoFavorite => 'VideoFavorite',
      _i68.VideoLike => 'VideoLike',
      _i69.VideoSeries => 'VideoSeries',
      _i70.VideoStatus => 'VideoStatus',
      _i71.WatchHistory => 'WatchHistory',
      _i72.WordList => 'WordList',
      _i73.WordListDetail => 'WordListDetail',
      _i74.WordListItem => 'WordListItem',
      _i75.WordListItemDetail => 'WordListItemDetail',
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
      case _i2.AdminMember():
        return 'AdminMember';
      case _i3.AdminPermission():
        return 'AdminPermission';
      case _i4.AdminRole():
        return 'AdminRole';
      case _i5.AdminRolePermission():
        return 'AdminRolePermission';
      case _i6.AdminWorkspace():
        return 'AdminWorkspace';
      case _i7.AppNotification():
        return 'AppNotification';
      case _i8.AppProfile():
        return 'AppProfile';
      case _i9.AsrJob():
        return 'AsrJob';
      case _i10.AsrJobStatus():
        return 'AsrJobStatus';
      case _i11.CommentLike():
        return 'CommentLike';
      case _i12.CommentPageDto():
        return 'CommentPageDto';
      case _i13.CommentReplyDto():
        return 'CommentReplyDto';
      case _i14.CommentReplyLike():
        return 'CommentReplyLike';
      case _i15.CommentReplyRow():
        return 'CommentReplyRow';
      case _i16.CreatorFollow():
        return 'CreatorFollow';
      case _i17.DictionaryDefinition():
        return 'DictionaryDefinition';
      case _i18.DictionaryEntry():
        return 'DictionaryEntry';
      case _i19.DictionaryEntryDetail():
        return 'DictionaryEntryDetail';
      case _i20.DictionaryExample():
        return 'DictionaryExample';
      case _i21.DictionaryExampleDetail():
        return 'DictionaryExampleDetail';
      case _i22.DictionaryExampleText():
        return 'DictionaryExampleText';
      case _i23.DictionaryForm():
        return 'DictionaryForm';
      case _i24.DictionaryImportCommitResult():
        return 'DictionaryImportCommitResult';
      case _i25.DictionaryImportMapping():
        return 'DictionaryImportMapping';
      case _i26.DictionaryImportPreview():
        return 'DictionaryImportPreview';
      case _i27.DictionaryImportPreviewRow():
        return 'DictionaryImportPreviewRow';
      case _i28.DictionaryImportProfile():
        return 'DictionaryImportProfile';
      case _i29.DictionaryImportProfileDetail():
        return 'DictionaryImportProfileDetail';
      case _i30.DictionaryRelation():
        return 'DictionaryRelation';
      case _i31.DictionaryRelationDetail():
        return 'DictionaryRelationDetail';
      case _i32.EntryKnowledgeState():
        return 'EntryKnowledgeState';
      case _i33.Greeting():
        return 'Greeting';
      case _i34.KnowledgeStateQuery():
        return 'KnowledgeStateQuery';
      case _i35.KnowledgeStateResult():
        return 'KnowledgeStateResult';
      case _i36.NotificationSettings():
        return 'NotificationSettings';
      case _i37.NotificationType():
        return 'NotificationType';
      case _i38.PrivacySettings():
        return 'PrivacySettings';
      case _i39.ProfileStats():
        return 'ProfileStats';
      case _i40.ScriptConversionCommitResult():
        return 'ScriptConversionCommitResult';
      case _i41.ScriptConversionEntry():
        return 'ScriptConversionEntry';
      case _i42.ScriptConversionImportPreview():
        return 'ScriptConversionImportPreview';
      case _i43.ScriptConversionImportPreviewRow():
        return 'ScriptConversionImportPreviewRow';
      case _i44.ScriptConversionProfile():
        return 'ScriptConversionProfile';
      case _i45.SubtitleCue():
        return 'SubtitleCue';
      case _i46.SubtitleCueDetail():
        return 'SubtitleCueDetail';
      case _i47.SubtitleCueText():
        return 'SubtitleCueText';
      case _i48.SubtitleKaraokeSegment():
        return 'SubtitleKaraokeSegment';
      case _i49.SubtitleKaraokeSegmentInput():
        return 'SubtitleKaraokeSegmentInput';
      case _i50.SubtitlePhrase():
        return 'SubtitlePhrase';
      case _i51.SubtitlePublishState():
        return 'SubtitlePublishState';
      case _i52.SubtitlePublishStatus():
        return 'SubtitlePublishStatus';
      case _i53.SubtitleReviewDashboard():
        return 'SubtitleReviewDashboard';
      case _i54.SubtitleReviewEvent():
        return 'SubtitleReviewEvent';
      case _i55.SubtitleReviewQueueItem():
        return 'SubtitleReviewQueueItem';
      case _i56.SubtitleReviewTask():
        return 'SubtitleReviewTask';
      case _i57.SubtitleReviewTaskDetail():
        return 'SubtitleReviewTaskDetail';
      case _i58.SubtitleReviewTaskStatus():
        return 'SubtitleReviewTaskStatus';
      case _i59.SubtitleSrtPreview():
        return 'SubtitleSrtPreview';
      case _i60.SubtitleToken():
        return 'SubtitleToken';
      case _i61.SubtitleTrack():
        return 'SubtitleTrack';
      case _i62.UserKnownEntry():
        return 'UserKnownEntry';
      case _i63.Video():
        return 'Video';
      case _i64.VideoCommentDto():
        return 'VideoCommentDto';
      case _i65.VideoCommentRow():
        return 'VideoCommentRow';
      case _i66.VideoContentType():
        return 'VideoContentType';
      case _i67.VideoFavorite():
        return 'VideoFavorite';
      case _i68.VideoLike():
        return 'VideoLike';
      case _i69.VideoSeries():
        return 'VideoSeries';
      case _i70.VideoStatus():
        return 'VideoStatus';
      case _i71.WatchHistory():
        return 'WatchHistory';
      case _i72.WordList():
        return 'WordList';
      case _i73.WordListDetail():
        return 'WordListDetail';
      case _i74.WordListItem():
        return 'WordListItem';
      case _i75.WordListItemDetail():
        return 'WordListItemDetail';
    }
    className = _i97.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i98.Protocol().getClassNameForObject(data);
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
      return deserialize<_i2.AdminMember>(data['data']);
    }
    if (dataClassName == 'AdminPermission') {
      return deserialize<_i3.AdminPermission>(data['data']);
    }
    if (dataClassName == 'AdminRole') {
      return deserialize<_i4.AdminRole>(data['data']);
    }
    if (dataClassName == 'AdminRolePermission') {
      return deserialize<_i5.AdminRolePermission>(data['data']);
    }
    if (dataClassName == 'AdminWorkspace') {
      return deserialize<_i6.AdminWorkspace>(data['data']);
    }
    if (dataClassName == 'AppNotification') {
      return deserialize<_i7.AppNotification>(data['data']);
    }
    if (dataClassName == 'AppProfile') {
      return deserialize<_i8.AppProfile>(data['data']);
    }
    if (dataClassName == 'AsrJob') {
      return deserialize<_i9.AsrJob>(data['data']);
    }
    if (dataClassName == 'AsrJobStatus') {
      return deserialize<_i10.AsrJobStatus>(data['data']);
    }
    if (dataClassName == 'CommentLike') {
      return deserialize<_i11.CommentLike>(data['data']);
    }
    if (dataClassName == 'CommentPageDto') {
      return deserialize<_i12.CommentPageDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyDto') {
      return deserialize<_i13.CommentReplyDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyLike') {
      return deserialize<_i14.CommentReplyLike>(data['data']);
    }
    if (dataClassName == 'CommentReplyRow') {
      return deserialize<_i15.CommentReplyRow>(data['data']);
    }
    if (dataClassName == 'CreatorFollow') {
      return deserialize<_i16.CreatorFollow>(data['data']);
    }
    if (dataClassName == 'DictionaryDefinition') {
      return deserialize<_i17.DictionaryDefinition>(data['data']);
    }
    if (dataClassName == 'DictionaryEntry') {
      return deserialize<_i18.DictionaryEntry>(data['data']);
    }
    if (dataClassName == 'DictionaryEntryDetail') {
      return deserialize<_i19.DictionaryEntryDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExample') {
      return deserialize<_i20.DictionaryExample>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleDetail') {
      return deserialize<_i21.DictionaryExampleDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleText') {
      return deserialize<_i22.DictionaryExampleText>(data['data']);
    }
    if (dataClassName == 'DictionaryForm') {
      return deserialize<_i23.DictionaryForm>(data['data']);
    }
    if (dataClassName == 'DictionaryImportCommitResult') {
      return deserialize<_i24.DictionaryImportCommitResult>(data['data']);
    }
    if (dataClassName == 'DictionaryImportMapping') {
      return deserialize<_i25.DictionaryImportMapping>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreview') {
      return deserialize<_i26.DictionaryImportPreview>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreviewRow') {
      return deserialize<_i27.DictionaryImportPreviewRow>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfile') {
      return deserialize<_i28.DictionaryImportProfile>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfileDetail') {
      return deserialize<_i29.DictionaryImportProfileDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryRelation') {
      return deserialize<_i30.DictionaryRelation>(data['data']);
    }
    if (dataClassName == 'DictionaryRelationDetail') {
      return deserialize<_i31.DictionaryRelationDetail>(data['data']);
    }
    if (dataClassName == 'EntryKnowledgeState') {
      return deserialize<_i32.EntryKnowledgeState>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i33.Greeting>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateQuery') {
      return deserialize<_i34.KnowledgeStateQuery>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateResult') {
      return deserialize<_i35.KnowledgeStateResult>(data['data']);
    }
    if (dataClassName == 'NotificationSettings') {
      return deserialize<_i36.NotificationSettings>(data['data']);
    }
    if (dataClassName == 'NotificationType') {
      return deserialize<_i37.NotificationType>(data['data']);
    }
    if (dataClassName == 'PrivacySettings') {
      return deserialize<_i38.PrivacySettings>(data['data']);
    }
    if (dataClassName == 'ProfileStats') {
      return deserialize<_i39.ProfileStats>(data['data']);
    }
    if (dataClassName == 'ScriptConversionCommitResult') {
      return deserialize<_i40.ScriptConversionCommitResult>(data['data']);
    }
    if (dataClassName == 'ScriptConversionEntry') {
      return deserialize<_i41.ScriptConversionEntry>(data['data']);
    }
    if (dataClassName == 'ScriptConversionImportPreview') {
      return deserialize<_i42.ScriptConversionImportPreview>(data['data']);
    }
    if (dataClassName == 'ScriptConversionImportPreviewRow') {
      return deserialize<_i43.ScriptConversionImportPreviewRow>(data['data']);
    }
    if (dataClassName == 'ScriptConversionProfile') {
      return deserialize<_i44.ScriptConversionProfile>(data['data']);
    }
    if (dataClassName == 'SubtitleCue') {
      return deserialize<_i45.SubtitleCue>(data['data']);
    }
    if (dataClassName == 'SubtitleCueDetail') {
      return deserialize<_i46.SubtitleCueDetail>(data['data']);
    }
    if (dataClassName == 'SubtitleCueText') {
      return deserialize<_i47.SubtitleCueText>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegment') {
      return deserialize<_i48.SubtitleKaraokeSegment>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegmentInput') {
      return deserialize<_i49.SubtitleKaraokeSegmentInput>(data['data']);
    }
    if (dataClassName == 'SubtitlePhrase') {
      return deserialize<_i50.SubtitlePhrase>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishState') {
      return deserialize<_i51.SubtitlePublishState>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishStatus') {
      return deserialize<_i52.SubtitlePublishStatus>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewDashboard') {
      return deserialize<_i53.SubtitleReviewDashboard>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewEvent') {
      return deserialize<_i54.SubtitleReviewEvent>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewQueueItem') {
      return deserialize<_i55.SubtitleReviewQueueItem>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTask') {
      return deserialize<_i56.SubtitleReviewTask>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTaskDetail') {
      return deserialize<_i57.SubtitleReviewTaskDetail>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTaskStatus') {
      return deserialize<_i58.SubtitleReviewTaskStatus>(data['data']);
    }
    if (dataClassName == 'SubtitleSrtPreview') {
      return deserialize<_i59.SubtitleSrtPreview>(data['data']);
    }
    if (dataClassName == 'SubtitleToken') {
      return deserialize<_i60.SubtitleToken>(data['data']);
    }
    if (dataClassName == 'SubtitleTrack') {
      return deserialize<_i61.SubtitleTrack>(data['data']);
    }
    if (dataClassName == 'UserKnownEntry') {
      return deserialize<_i62.UserKnownEntry>(data['data']);
    }
    if (dataClassName == 'Video') {
      return deserialize<_i63.Video>(data['data']);
    }
    if (dataClassName == 'VideoCommentDto') {
      return deserialize<_i64.VideoCommentDto>(data['data']);
    }
    if (dataClassName == 'VideoCommentRow') {
      return deserialize<_i65.VideoCommentRow>(data['data']);
    }
    if (dataClassName == 'VideoContentType') {
      return deserialize<_i66.VideoContentType>(data['data']);
    }
    if (dataClassName == 'VideoFavorite') {
      return deserialize<_i67.VideoFavorite>(data['data']);
    }
    if (dataClassName == 'VideoLike') {
      return deserialize<_i68.VideoLike>(data['data']);
    }
    if (dataClassName == 'VideoSeries') {
      return deserialize<_i69.VideoSeries>(data['data']);
    }
    if (dataClassName == 'VideoStatus') {
      return deserialize<_i70.VideoStatus>(data['data']);
    }
    if (dataClassName == 'WatchHistory') {
      return deserialize<_i71.WatchHistory>(data['data']);
    }
    if (dataClassName == 'WordList') {
      return deserialize<_i72.WordList>(data['data']);
    }
    if (dataClassName == 'WordListDetail') {
      return deserialize<_i73.WordListDetail>(data['data']);
    }
    if (dataClassName == 'WordListItem') {
      return deserialize<_i74.WordListItem>(data['data']);
    }
    if (dataClassName == 'WordListItemDetail') {
      return deserialize<_i75.WordListItemDetail>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i97.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i98.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

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
      return _i97.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i98.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
