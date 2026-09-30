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
import 'app_notification.dart' as _i2;
import 'app_profile.dart' as _i3;
import 'asr_job.dart' as _i4;
import 'asr_job_status.dart' as _i5;
import 'comment_like.dart' as _i6;
import 'comment_page_dto.dart' as _i7;
import 'comment_reply_dto.dart' as _i8;
import 'comment_reply_like.dart' as _i9;
import 'comment_reply_row.dart' as _i10;
import 'creator_follow.dart' as _i11;
import 'dictionary_definition.dart' as _i12;
import 'dictionary_entry.dart' as _i13;
import 'dictionary_entry_detail.dart' as _i14;
import 'dictionary_example.dart' as _i15;
import 'dictionary_example_detail.dart' as _i16;
import 'dictionary_example_text.dart' as _i17;
import 'dictionary_form.dart' as _i18;
import 'dictionary_import_commit_result.dart' as _i19;
import 'dictionary_import_mapping.dart' as _i20;
import 'dictionary_import_preview.dart' as _i21;
import 'dictionary_import_preview_row.dart' as _i22;
import 'dictionary_import_profile.dart' as _i23;
import 'dictionary_import_profile_detail.dart' as _i24;
import 'dictionary_relation.dart' as _i25;
import 'dictionary_relation_detail.dart' as _i26;
import 'entry_knowledge_state.dart' as _i27;
import 'greetings/greeting.dart' as _i28;
import 'knowledge_state_query.dart' as _i29;
import 'knowledge_state_result.dart' as _i30;
import 'notification_settings.dart' as _i31;
import 'notification_type.dart' as _i32;
import 'privacy_settings.dart' as _i33;
import 'profile_stats.dart' as _i34;
import 'script_conversion_commit_result.dart' as _i35;
import 'script_conversion_entry.dart' as _i36;
import 'script_conversion_import_preview.dart' as _i37;
import 'script_conversion_import_preview_row.dart' as _i38;
import 'script_conversion_profile.dart' as _i39;
import 'subtitle_cue.dart' as _i40;
import 'subtitle_cue_detail.dart' as _i41;
import 'subtitle_cue_text.dart' as _i42;
import 'subtitle_karaoke_segment.dart' as _i43;
import 'subtitle_karaoke_segment_input.dart' as _i44;
import 'subtitle_phrase.dart' as _i45;
import 'subtitle_publish_state.dart' as _i46;
import 'subtitle_publish_status.dart' as _i47;
import 'subtitle_review_dashboard.dart' as _i48;
import 'subtitle_review_event.dart' as _i49;
import 'subtitle_review_queue_item.dart' as _i50;
import 'subtitle_review_task.dart' as _i51;
import 'subtitle_review_task_detail.dart' as _i52;
import 'subtitle_review_task_status.dart' as _i53;
import 'subtitle_srt_preview.dart' as _i54;
import 'subtitle_token.dart' as _i55;
import 'subtitle_track.dart' as _i56;
import 'user_known_entry.dart' as _i57;
import 'video.dart' as _i58;
import 'video_comment_dto.dart' as _i59;
import 'video_comment_row.dart' as _i60;
import 'video_content_type.dart' as _i61;
import 'video_favorite.dart' as _i62;
import 'video_like.dart' as _i63;
import 'video_series.dart' as _i64;
import 'video_status.dart' as _i65;
import 'watch_history.dart' as _i66;
import 'word_list.dart' as _i67;
import 'word_list_detail.dart' as _i68;
import 'word_list_item.dart' as _i69;
import 'word_list_item_detail.dart' as _i70;
import 'package:clyven_backend_client/src/protocol/asr_job.dart' as _i71;
import 'package:clyven_backend_client/src/protocol/video.dart' as _i72;
import 'package:clyven_backend_client/src/protocol/subtitle_track.dart' as _i73;
import 'package:clyven_backend_client/src/protocol/dictionary_entry_detail.dart'
    as _i74;
import 'package:clyven_backend_client/src/protocol/dictionary_import_profile.dart'
    as _i75;
import 'package:clyven_backend_client/src/protocol/entry_knowledge_state.dart'
    as _i76;
import 'package:clyven_backend_client/src/protocol/knowledge_state_result.dart'
    as _i77;
import 'package:clyven_backend_client/src/protocol/knowledge_state_query.dart'
    as _i78;
import 'package:clyven_backend_client/src/protocol/app_notification.dart'
    as _i79;
import 'package:clyven_backend_client/src/protocol/script_conversion_profile.dart'
    as _i80;
import 'package:clyven_backend_client/src/protocol/script_conversion_entry.dart'
    as _i81;
import 'package:clyven_backend_client/src/protocol/watch_history.dart' as _i82;
import 'package:clyven_backend_client/src/protocol/subtitle_cue_detail.dart'
    as _i83;
import 'package:clyven_backend_client/src/protocol/subtitle_karaoke_segment.dart'
    as _i84;
import 'package:clyven_backend_client/src/protocol/subtitle_karaoke_segment_input.dart'
    as _i85;
import 'package:clyven_backend_client/src/protocol/video_series.dart' as _i86;
import 'package:clyven_backend_client/src/protocol/word_list.dart' as _i87;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i88;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i89;
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

    if (t == _i2.AppNotification) {
      return _i2.AppNotification.fromJson(data) as T;
    }
    if (t == _i3.AppProfile) {
      return _i3.AppProfile.fromJson(data) as T;
    }
    if (t == _i4.AsrJob) {
      return _i4.AsrJob.fromJson(data) as T;
    }
    if (t == _i5.AsrJobStatus) {
      return _i5.AsrJobStatus.fromJson(data) as T;
    }
    if (t == _i6.CommentLike) {
      return _i6.CommentLike.fromJson(data) as T;
    }
    if (t == _i7.CommentPageDto) {
      return _i7.CommentPageDto.fromJson(data) as T;
    }
    if (t == _i8.CommentReplyDto) {
      return _i8.CommentReplyDto.fromJson(data) as T;
    }
    if (t == _i9.CommentReplyLike) {
      return _i9.CommentReplyLike.fromJson(data) as T;
    }
    if (t == _i10.CommentReplyRow) {
      return _i10.CommentReplyRow.fromJson(data) as T;
    }
    if (t == _i11.CreatorFollow) {
      return _i11.CreatorFollow.fromJson(data) as T;
    }
    if (t == _i12.DictionaryDefinition) {
      return _i12.DictionaryDefinition.fromJson(data) as T;
    }
    if (t == _i13.DictionaryEntry) {
      return _i13.DictionaryEntry.fromJson(data) as T;
    }
    if (t == _i14.DictionaryEntryDetail) {
      return _i14.DictionaryEntryDetail.fromJson(data) as T;
    }
    if (t == _i15.DictionaryExample) {
      return _i15.DictionaryExample.fromJson(data) as T;
    }
    if (t == _i16.DictionaryExampleDetail) {
      return _i16.DictionaryExampleDetail.fromJson(data) as T;
    }
    if (t == _i17.DictionaryExampleText) {
      return _i17.DictionaryExampleText.fromJson(data) as T;
    }
    if (t == _i18.DictionaryForm) {
      return _i18.DictionaryForm.fromJson(data) as T;
    }
    if (t == _i19.DictionaryImportCommitResult) {
      return _i19.DictionaryImportCommitResult.fromJson(data) as T;
    }
    if (t == _i20.DictionaryImportMapping) {
      return _i20.DictionaryImportMapping.fromJson(data) as T;
    }
    if (t == _i21.DictionaryImportPreview) {
      return _i21.DictionaryImportPreview.fromJson(data) as T;
    }
    if (t == _i22.DictionaryImportPreviewRow) {
      return _i22.DictionaryImportPreviewRow.fromJson(data) as T;
    }
    if (t == _i23.DictionaryImportProfile) {
      return _i23.DictionaryImportProfile.fromJson(data) as T;
    }
    if (t == _i24.DictionaryImportProfileDetail) {
      return _i24.DictionaryImportProfileDetail.fromJson(data) as T;
    }
    if (t == _i25.DictionaryRelation) {
      return _i25.DictionaryRelation.fromJson(data) as T;
    }
    if (t == _i26.DictionaryRelationDetail) {
      return _i26.DictionaryRelationDetail.fromJson(data) as T;
    }
    if (t == _i27.EntryKnowledgeState) {
      return _i27.EntryKnowledgeState.fromJson(data) as T;
    }
    if (t == _i28.Greeting) {
      return _i28.Greeting.fromJson(data) as T;
    }
    if (t == _i29.KnowledgeStateQuery) {
      return _i29.KnowledgeStateQuery.fromJson(data) as T;
    }
    if (t == _i30.KnowledgeStateResult) {
      return _i30.KnowledgeStateResult.fromJson(data) as T;
    }
    if (t == _i31.NotificationSettings) {
      return _i31.NotificationSettings.fromJson(data) as T;
    }
    if (t == _i32.NotificationType) {
      return _i32.NotificationType.fromJson(data) as T;
    }
    if (t == _i33.PrivacySettings) {
      return _i33.PrivacySettings.fromJson(data) as T;
    }
    if (t == _i34.ProfileStats) {
      return _i34.ProfileStats.fromJson(data) as T;
    }
    if (t == _i35.ScriptConversionCommitResult) {
      return _i35.ScriptConversionCommitResult.fromJson(data) as T;
    }
    if (t == _i36.ScriptConversionEntry) {
      return _i36.ScriptConversionEntry.fromJson(data) as T;
    }
    if (t == _i37.ScriptConversionImportPreview) {
      return _i37.ScriptConversionImportPreview.fromJson(data) as T;
    }
    if (t == _i38.ScriptConversionImportPreviewRow) {
      return _i38.ScriptConversionImportPreviewRow.fromJson(data) as T;
    }
    if (t == _i39.ScriptConversionProfile) {
      return _i39.ScriptConversionProfile.fromJson(data) as T;
    }
    if (t == _i40.SubtitleCue) {
      return _i40.SubtitleCue.fromJson(data) as T;
    }
    if (t == _i41.SubtitleCueDetail) {
      return _i41.SubtitleCueDetail.fromJson(data) as T;
    }
    if (t == _i42.SubtitleCueText) {
      return _i42.SubtitleCueText.fromJson(data) as T;
    }
    if (t == _i43.SubtitleKaraokeSegment) {
      return _i43.SubtitleKaraokeSegment.fromJson(data) as T;
    }
    if (t == _i44.SubtitleKaraokeSegmentInput) {
      return _i44.SubtitleKaraokeSegmentInput.fromJson(data) as T;
    }
    if (t == _i45.SubtitlePhrase) {
      return _i45.SubtitlePhrase.fromJson(data) as T;
    }
    if (t == _i46.SubtitlePublishState) {
      return _i46.SubtitlePublishState.fromJson(data) as T;
    }
    if (t == _i47.SubtitlePublishStatus) {
      return _i47.SubtitlePublishStatus.fromJson(data) as T;
    }
    if (t == _i48.SubtitleReviewDashboard) {
      return _i48.SubtitleReviewDashboard.fromJson(data) as T;
    }
    if (t == _i49.SubtitleReviewEvent) {
      return _i49.SubtitleReviewEvent.fromJson(data) as T;
    }
    if (t == _i50.SubtitleReviewQueueItem) {
      return _i50.SubtitleReviewQueueItem.fromJson(data) as T;
    }
    if (t == _i51.SubtitleReviewTask) {
      return _i51.SubtitleReviewTask.fromJson(data) as T;
    }
    if (t == _i52.SubtitleReviewTaskDetail) {
      return _i52.SubtitleReviewTaskDetail.fromJson(data) as T;
    }
    if (t == _i53.SubtitleReviewTaskStatus) {
      return _i53.SubtitleReviewTaskStatus.fromJson(data) as T;
    }
    if (t == _i54.SubtitleSrtPreview) {
      return _i54.SubtitleSrtPreview.fromJson(data) as T;
    }
    if (t == _i55.SubtitleToken) {
      return _i55.SubtitleToken.fromJson(data) as T;
    }
    if (t == _i56.SubtitleTrack) {
      return _i56.SubtitleTrack.fromJson(data) as T;
    }
    if (t == _i57.UserKnownEntry) {
      return _i57.UserKnownEntry.fromJson(data) as T;
    }
    if (t == _i58.Video) {
      return _i58.Video.fromJson(data) as T;
    }
    if (t == _i59.VideoCommentDto) {
      return _i59.VideoCommentDto.fromJson(data) as T;
    }
    if (t == _i60.VideoCommentRow) {
      return _i60.VideoCommentRow.fromJson(data) as T;
    }
    if (t == _i61.VideoContentType) {
      return _i61.VideoContentType.fromJson(data) as T;
    }
    if (t == _i62.VideoFavorite) {
      return _i62.VideoFavorite.fromJson(data) as T;
    }
    if (t == _i63.VideoLike) {
      return _i63.VideoLike.fromJson(data) as T;
    }
    if (t == _i64.VideoSeries) {
      return _i64.VideoSeries.fromJson(data) as T;
    }
    if (t == _i65.VideoStatus) {
      return _i65.VideoStatus.fromJson(data) as T;
    }
    if (t == _i66.WatchHistory) {
      return _i66.WatchHistory.fromJson(data) as T;
    }
    if (t == _i67.WordList) {
      return _i67.WordList.fromJson(data) as T;
    }
    if (t == _i68.WordListDetail) {
      return _i68.WordListDetail.fromJson(data) as T;
    }
    if (t == _i69.WordListItem) {
      return _i69.WordListItem.fromJson(data) as T;
    }
    if (t == _i70.WordListItemDetail) {
      return _i70.WordListItemDetail.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AppNotification?>()) {
      return (data != null ? _i2.AppNotification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AppProfile?>()) {
      return (data != null ? _i3.AppProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AsrJob?>()) {
      return (data != null ? _i4.AsrJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AsrJobStatus?>()) {
      return (data != null ? _i5.AsrJobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.CommentLike?>()) {
      return (data != null ? _i6.CommentLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.CommentPageDto?>()) {
      return (data != null ? _i7.CommentPageDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CommentReplyDto?>()) {
      return (data != null ? _i8.CommentReplyDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.CommentReplyLike?>()) {
      return (data != null ? _i9.CommentReplyLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.CommentReplyRow?>()) {
      return (data != null ? _i10.CommentReplyRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.CreatorFollow?>()) {
      return (data != null ? _i11.CreatorFollow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.DictionaryDefinition?>()) {
      return (data != null ? _i12.DictionaryDefinition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.DictionaryEntry?>()) {
      return (data != null ? _i13.DictionaryEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.DictionaryEntryDetail?>()) {
      return (data != null ? _i14.DictionaryEntryDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.DictionaryExample?>()) {
      return (data != null ? _i15.DictionaryExample.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.DictionaryExampleDetail?>()) {
      return (data != null ? _i16.DictionaryExampleDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.DictionaryExampleText?>()) {
      return (data != null ? _i17.DictionaryExampleText.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.DictionaryForm?>()) {
      return (data != null ? _i18.DictionaryForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.DictionaryImportCommitResult?>()) {
      return (data != null
              ? _i19.DictionaryImportCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i20.DictionaryImportMapping?>()) {
      return (data != null ? _i20.DictionaryImportMapping.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.DictionaryImportPreview?>()) {
      return (data != null ? _i21.DictionaryImportPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.DictionaryImportPreviewRow?>()) {
      return (data != null
              ? _i22.DictionaryImportPreviewRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i23.DictionaryImportProfile?>()) {
      return (data != null ? _i23.DictionaryImportProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.DictionaryImportProfileDetail?>()) {
      return (data != null
              ? _i24.DictionaryImportProfileDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i25.DictionaryRelation?>()) {
      return (data != null ? _i25.DictionaryRelation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.DictionaryRelationDetail?>()) {
      return (data != null
              ? _i26.DictionaryRelationDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i27.EntryKnowledgeState?>()) {
      return (data != null ? _i27.EntryKnowledgeState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.Greeting?>()) {
      return (data != null ? _i28.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.KnowledgeStateQuery?>()) {
      return (data != null ? _i29.KnowledgeStateQuery.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i30.KnowledgeStateResult?>()) {
      return (data != null ? _i30.KnowledgeStateResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.NotificationSettings?>()) {
      return (data != null ? _i31.NotificationSettings.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.NotificationType?>()) {
      return (data != null ? _i32.NotificationType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.PrivacySettings?>()) {
      return (data != null ? _i33.PrivacySettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.ProfileStats?>()) {
      return (data != null ? _i34.ProfileStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.ScriptConversionCommitResult?>()) {
      return (data != null
              ? _i35.ScriptConversionCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i36.ScriptConversionEntry?>()) {
      return (data != null ? _i36.ScriptConversionEntry.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i37.ScriptConversionImportPreview?>()) {
      return (data != null
              ? _i37.ScriptConversionImportPreview.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i38.ScriptConversionImportPreviewRow?>()) {
      return (data != null
              ? _i38.ScriptConversionImportPreviewRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i39.ScriptConversionProfile?>()) {
      return (data != null ? _i39.ScriptConversionProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.SubtitleCue?>()) {
      return (data != null ? _i40.SubtitleCue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.SubtitleCueDetail?>()) {
      return (data != null ? _i41.SubtitleCueDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.SubtitleCueText?>()) {
      return (data != null ? _i42.SubtitleCueText.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.SubtitleKaraokeSegment?>()) {
      return (data != null ? _i43.SubtitleKaraokeSegment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.SubtitleKaraokeSegmentInput?>()) {
      return (data != null
              ? _i44.SubtitleKaraokeSegmentInput.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i45.SubtitlePhrase?>()) {
      return (data != null ? _i45.SubtitlePhrase.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.SubtitlePublishState?>()) {
      return (data != null ? _i46.SubtitlePublishState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i47.SubtitlePublishStatus?>()) {
      return (data != null ? _i47.SubtitlePublishStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i48.SubtitleReviewDashboard?>()) {
      return (data != null ? _i48.SubtitleReviewDashboard.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i49.SubtitleReviewEvent?>()) {
      return (data != null ? _i49.SubtitleReviewEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i50.SubtitleReviewQueueItem?>()) {
      return (data != null ? _i50.SubtitleReviewQueueItem.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i51.SubtitleReviewTask?>()) {
      return (data != null ? _i51.SubtitleReviewTask.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i52.SubtitleReviewTaskDetail?>()) {
      return (data != null
              ? _i52.SubtitleReviewTaskDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i53.SubtitleReviewTaskStatus?>()) {
      return (data != null
              ? _i53.SubtitleReviewTaskStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i54.SubtitleSrtPreview?>()) {
      return (data != null ? _i54.SubtitleSrtPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.SubtitleToken?>()) {
      return (data != null ? _i55.SubtitleToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.SubtitleTrack?>()) {
      return (data != null ? _i56.SubtitleTrack.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.UserKnownEntry?>()) {
      return (data != null ? _i57.UserKnownEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.Video?>()) {
      return (data != null ? _i58.Video.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.VideoCommentDto?>()) {
      return (data != null ? _i59.VideoCommentDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.VideoCommentRow?>()) {
      return (data != null ? _i60.VideoCommentRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.VideoContentType?>()) {
      return (data != null ? _i61.VideoContentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.VideoFavorite?>()) {
      return (data != null ? _i62.VideoFavorite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.VideoLike?>()) {
      return (data != null ? _i63.VideoLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.VideoSeries?>()) {
      return (data != null ? _i64.VideoSeries.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.VideoStatus?>()) {
      return (data != null ? _i65.VideoStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.WatchHistory?>()) {
      return (data != null ? _i66.WatchHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.WordList?>()) {
      return (data != null ? _i67.WordList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.WordListDetail?>()) {
      return (data != null ? _i68.WordListDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.WordListItem?>()) {
      return (data != null ? _i69.WordListItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.WordListItemDetail?>()) {
      return (data != null ? _i70.WordListItemDetail.fromJson(data) : null)
          as T;
    }
    if (t == List<_i59.VideoCommentDto>) {
      return (data as List)
              .map((e) => deserialize<_i59.VideoCommentDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i12.DictionaryDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i12.DictionaryDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i18.DictionaryForm>) {
      return (data as List)
              .map((e) => deserialize<_i18.DictionaryForm>(e))
              .toList()
          as T;
    }
    if (t == List<_i16.DictionaryExampleDetail>) {
      return (data as List)
              .map((e) => deserialize<_i16.DictionaryExampleDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i26.DictionaryRelationDetail>) {
      return (data as List)
              .map((e) => deserialize<_i26.DictionaryRelationDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i17.DictionaryExampleText>) {
      return (data as List)
              .map((e) => deserialize<_i17.DictionaryExampleText>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i22.DictionaryImportPreviewRow>) {
      return (data as List)
              .map((e) => deserialize<_i22.DictionaryImportPreviewRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.DictionaryImportMapping>) {
      return (data as List)
              .map((e) => deserialize<_i20.DictionaryImportMapping>(e))
              .toList()
          as T;
    }
    if (t == List<_i38.ScriptConversionImportPreviewRow>) {
      return (data as List)
              .map((e) => deserialize<_i38.ScriptConversionImportPreviewRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i42.SubtitleCueText>) {
      return (data as List)
              .map((e) => deserialize<_i42.SubtitleCueText>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i42.SubtitleCueText>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i42.SubtitleCueText>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i55.SubtitleToken>) {
      return (data as List)
              .map((e) => deserialize<_i55.SubtitleToken>(e))
              .toList()
          as T;
    }
    if (t == List<_i45.SubtitlePhrase>) {
      return (data as List)
              .map((e) => deserialize<_i45.SubtitlePhrase>(e))
              .toList()
          as T;
    }
    if (t == List<_i43.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i43.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i43.SubtitleKaraokeSegment>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i43.SubtitleKaraokeSegment>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i50.SubtitleReviewQueueItem>) {
      return (data as List)
              .map((e) => deserialize<_i50.SubtitleReviewQueueItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i49.SubtitleReviewEvent>) {
      return (data as List)
              .map((e) => deserialize<_i49.SubtitleReviewEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i8.CommentReplyDto>) {
      return (data as List)
              .map((e) => deserialize<_i8.CommentReplyDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i70.WordListItemDetail>) {
      return (data as List)
              .map((e) => deserialize<_i70.WordListItemDetail>(e))
              .toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i71.AsrJob>) {
      return (data as List).map((e) => deserialize<_i71.AsrJob>(e)).toList()
          as T;
    }
    if (t == List<_i72.Video>) {
      return (data as List).map((e) => deserialize<_i72.Video>(e)).toList()
          as T;
    }
    if (t == List<_i73.SubtitleTrack>) {
      return (data as List)
              .map((e) => deserialize<_i73.SubtitleTrack>(e))
              .toList()
          as T;
    }
    if (t == List<_i74.DictionaryEntryDetail>) {
      return (data as List)
              .map((e) => deserialize<_i74.DictionaryEntryDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i75.DictionaryImportProfile>) {
      return (data as List)
              .map((e) => deserialize<_i75.DictionaryImportProfile>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i76.EntryKnowledgeState>) {
      return (data as List)
              .map((e) => deserialize<_i76.EntryKnowledgeState>(e))
              .toList()
          as T;
    }
    if (t == List<_i77.KnowledgeStateResult>) {
      return (data as List)
              .map((e) => deserialize<_i77.KnowledgeStateResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i78.KnowledgeStateQuery>) {
      return (data as List)
              .map((e) => deserialize<_i78.KnowledgeStateQuery>(e))
              .toList()
          as T;
    }
    if (t == List<_i79.AppNotification>) {
      return (data as List)
              .map((e) => deserialize<_i79.AppNotification>(e))
              .toList()
          as T;
    }
    if (t == List<_i80.ScriptConversionProfile>) {
      return (data as List)
              .map((e) => deserialize<_i80.ScriptConversionProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_i81.ScriptConversionEntry>) {
      return (data as List)
              .map((e) => deserialize<_i81.ScriptConversionEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i82.WatchHistory>) {
      return (data as List)
              .map((e) => deserialize<_i82.WatchHistory>(e))
              .toList()
          as T;
    }
    if (t == List<_i83.SubtitleCueDetail>) {
      return (data as List)
              .map((e) => deserialize<_i83.SubtitleCueDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i84.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i84.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == List<_i85.SubtitleKaraokeSegmentInput>) {
      return (data as List)
              .map((e) => deserialize<_i85.SubtitleKaraokeSegmentInput>(e))
              .toList()
          as T;
    }
    if (t == List<_i86.VideoSeries>) {
      return (data as List)
              .map((e) => deserialize<_i86.VideoSeries>(e))
              .toList()
          as T;
    }
    if (t == List<_i87.WordList>) {
      return (data as List).map((e) => deserialize<_i87.WordList>(e)).toList()
          as T;
    }
    try {
      return _i88.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i89.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AppNotification => 'AppNotification',
      _i3.AppProfile => 'AppProfile',
      _i4.AsrJob => 'AsrJob',
      _i5.AsrJobStatus => 'AsrJobStatus',
      _i6.CommentLike => 'CommentLike',
      _i7.CommentPageDto => 'CommentPageDto',
      _i8.CommentReplyDto => 'CommentReplyDto',
      _i9.CommentReplyLike => 'CommentReplyLike',
      _i10.CommentReplyRow => 'CommentReplyRow',
      _i11.CreatorFollow => 'CreatorFollow',
      _i12.DictionaryDefinition => 'DictionaryDefinition',
      _i13.DictionaryEntry => 'DictionaryEntry',
      _i14.DictionaryEntryDetail => 'DictionaryEntryDetail',
      _i15.DictionaryExample => 'DictionaryExample',
      _i16.DictionaryExampleDetail => 'DictionaryExampleDetail',
      _i17.DictionaryExampleText => 'DictionaryExampleText',
      _i18.DictionaryForm => 'DictionaryForm',
      _i19.DictionaryImportCommitResult => 'DictionaryImportCommitResult',
      _i20.DictionaryImportMapping => 'DictionaryImportMapping',
      _i21.DictionaryImportPreview => 'DictionaryImportPreview',
      _i22.DictionaryImportPreviewRow => 'DictionaryImportPreviewRow',
      _i23.DictionaryImportProfile => 'DictionaryImportProfile',
      _i24.DictionaryImportProfileDetail => 'DictionaryImportProfileDetail',
      _i25.DictionaryRelation => 'DictionaryRelation',
      _i26.DictionaryRelationDetail => 'DictionaryRelationDetail',
      _i27.EntryKnowledgeState => 'EntryKnowledgeState',
      _i28.Greeting => 'Greeting',
      _i29.KnowledgeStateQuery => 'KnowledgeStateQuery',
      _i30.KnowledgeStateResult => 'KnowledgeStateResult',
      _i31.NotificationSettings => 'NotificationSettings',
      _i32.NotificationType => 'NotificationType',
      _i33.PrivacySettings => 'PrivacySettings',
      _i34.ProfileStats => 'ProfileStats',
      _i35.ScriptConversionCommitResult => 'ScriptConversionCommitResult',
      _i36.ScriptConversionEntry => 'ScriptConversionEntry',
      _i37.ScriptConversionImportPreview => 'ScriptConversionImportPreview',
      _i38.ScriptConversionImportPreviewRow =>
        'ScriptConversionImportPreviewRow',
      _i39.ScriptConversionProfile => 'ScriptConversionProfile',
      _i40.SubtitleCue => 'SubtitleCue',
      _i41.SubtitleCueDetail => 'SubtitleCueDetail',
      _i42.SubtitleCueText => 'SubtitleCueText',
      _i43.SubtitleKaraokeSegment => 'SubtitleKaraokeSegment',
      _i44.SubtitleKaraokeSegmentInput => 'SubtitleKaraokeSegmentInput',
      _i45.SubtitlePhrase => 'SubtitlePhrase',
      _i46.SubtitlePublishState => 'SubtitlePublishState',
      _i47.SubtitlePublishStatus => 'SubtitlePublishStatus',
      _i48.SubtitleReviewDashboard => 'SubtitleReviewDashboard',
      _i49.SubtitleReviewEvent => 'SubtitleReviewEvent',
      _i50.SubtitleReviewQueueItem => 'SubtitleReviewQueueItem',
      _i51.SubtitleReviewTask => 'SubtitleReviewTask',
      _i52.SubtitleReviewTaskDetail => 'SubtitleReviewTaskDetail',
      _i53.SubtitleReviewTaskStatus => 'SubtitleReviewTaskStatus',
      _i54.SubtitleSrtPreview => 'SubtitleSrtPreview',
      _i55.SubtitleToken => 'SubtitleToken',
      _i56.SubtitleTrack => 'SubtitleTrack',
      _i57.UserKnownEntry => 'UserKnownEntry',
      _i58.Video => 'Video',
      _i59.VideoCommentDto => 'VideoCommentDto',
      _i60.VideoCommentRow => 'VideoCommentRow',
      _i61.VideoContentType => 'VideoContentType',
      _i62.VideoFavorite => 'VideoFavorite',
      _i63.VideoLike => 'VideoLike',
      _i64.VideoSeries => 'VideoSeries',
      _i65.VideoStatus => 'VideoStatus',
      _i66.WatchHistory => 'WatchHistory',
      _i67.WordList => 'WordList',
      _i68.WordListDetail => 'WordListDetail',
      _i69.WordListItem => 'WordListItem',
      _i70.WordListItemDetail => 'WordListItemDetail',
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
      case _i2.AppNotification():
        return 'AppNotification';
      case _i3.AppProfile():
        return 'AppProfile';
      case _i4.AsrJob():
        return 'AsrJob';
      case _i5.AsrJobStatus():
        return 'AsrJobStatus';
      case _i6.CommentLike():
        return 'CommentLike';
      case _i7.CommentPageDto():
        return 'CommentPageDto';
      case _i8.CommentReplyDto():
        return 'CommentReplyDto';
      case _i9.CommentReplyLike():
        return 'CommentReplyLike';
      case _i10.CommentReplyRow():
        return 'CommentReplyRow';
      case _i11.CreatorFollow():
        return 'CreatorFollow';
      case _i12.DictionaryDefinition():
        return 'DictionaryDefinition';
      case _i13.DictionaryEntry():
        return 'DictionaryEntry';
      case _i14.DictionaryEntryDetail():
        return 'DictionaryEntryDetail';
      case _i15.DictionaryExample():
        return 'DictionaryExample';
      case _i16.DictionaryExampleDetail():
        return 'DictionaryExampleDetail';
      case _i17.DictionaryExampleText():
        return 'DictionaryExampleText';
      case _i18.DictionaryForm():
        return 'DictionaryForm';
      case _i19.DictionaryImportCommitResult():
        return 'DictionaryImportCommitResult';
      case _i20.DictionaryImportMapping():
        return 'DictionaryImportMapping';
      case _i21.DictionaryImportPreview():
        return 'DictionaryImportPreview';
      case _i22.DictionaryImportPreviewRow():
        return 'DictionaryImportPreviewRow';
      case _i23.DictionaryImportProfile():
        return 'DictionaryImportProfile';
      case _i24.DictionaryImportProfileDetail():
        return 'DictionaryImportProfileDetail';
      case _i25.DictionaryRelation():
        return 'DictionaryRelation';
      case _i26.DictionaryRelationDetail():
        return 'DictionaryRelationDetail';
      case _i27.EntryKnowledgeState():
        return 'EntryKnowledgeState';
      case _i28.Greeting():
        return 'Greeting';
      case _i29.KnowledgeStateQuery():
        return 'KnowledgeStateQuery';
      case _i30.KnowledgeStateResult():
        return 'KnowledgeStateResult';
      case _i31.NotificationSettings():
        return 'NotificationSettings';
      case _i32.NotificationType():
        return 'NotificationType';
      case _i33.PrivacySettings():
        return 'PrivacySettings';
      case _i34.ProfileStats():
        return 'ProfileStats';
      case _i35.ScriptConversionCommitResult():
        return 'ScriptConversionCommitResult';
      case _i36.ScriptConversionEntry():
        return 'ScriptConversionEntry';
      case _i37.ScriptConversionImportPreview():
        return 'ScriptConversionImportPreview';
      case _i38.ScriptConversionImportPreviewRow():
        return 'ScriptConversionImportPreviewRow';
      case _i39.ScriptConversionProfile():
        return 'ScriptConversionProfile';
      case _i40.SubtitleCue():
        return 'SubtitleCue';
      case _i41.SubtitleCueDetail():
        return 'SubtitleCueDetail';
      case _i42.SubtitleCueText():
        return 'SubtitleCueText';
      case _i43.SubtitleKaraokeSegment():
        return 'SubtitleKaraokeSegment';
      case _i44.SubtitleKaraokeSegmentInput():
        return 'SubtitleKaraokeSegmentInput';
      case _i45.SubtitlePhrase():
        return 'SubtitlePhrase';
      case _i46.SubtitlePublishState():
        return 'SubtitlePublishState';
      case _i47.SubtitlePublishStatus():
        return 'SubtitlePublishStatus';
      case _i48.SubtitleReviewDashboard():
        return 'SubtitleReviewDashboard';
      case _i49.SubtitleReviewEvent():
        return 'SubtitleReviewEvent';
      case _i50.SubtitleReviewQueueItem():
        return 'SubtitleReviewQueueItem';
      case _i51.SubtitleReviewTask():
        return 'SubtitleReviewTask';
      case _i52.SubtitleReviewTaskDetail():
        return 'SubtitleReviewTaskDetail';
      case _i53.SubtitleReviewTaskStatus():
        return 'SubtitleReviewTaskStatus';
      case _i54.SubtitleSrtPreview():
        return 'SubtitleSrtPreview';
      case _i55.SubtitleToken():
        return 'SubtitleToken';
      case _i56.SubtitleTrack():
        return 'SubtitleTrack';
      case _i57.UserKnownEntry():
        return 'UserKnownEntry';
      case _i58.Video():
        return 'Video';
      case _i59.VideoCommentDto():
        return 'VideoCommentDto';
      case _i60.VideoCommentRow():
        return 'VideoCommentRow';
      case _i61.VideoContentType():
        return 'VideoContentType';
      case _i62.VideoFavorite():
        return 'VideoFavorite';
      case _i63.VideoLike():
        return 'VideoLike';
      case _i64.VideoSeries():
        return 'VideoSeries';
      case _i65.VideoStatus():
        return 'VideoStatus';
      case _i66.WatchHistory():
        return 'WatchHistory';
      case _i67.WordList():
        return 'WordList';
      case _i68.WordListDetail():
        return 'WordListDetail';
      case _i69.WordListItem():
        return 'WordListItem';
      case _i70.WordListItemDetail():
        return 'WordListItemDetail';
    }
    className = _i88.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i89.Protocol().getClassNameForObject(data);
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
      return deserialize<_i2.AppNotification>(data['data']);
    }
    if (dataClassName == 'AppProfile') {
      return deserialize<_i3.AppProfile>(data['data']);
    }
    if (dataClassName == 'AsrJob') {
      return deserialize<_i4.AsrJob>(data['data']);
    }
    if (dataClassName == 'AsrJobStatus') {
      return deserialize<_i5.AsrJobStatus>(data['data']);
    }
    if (dataClassName == 'CommentLike') {
      return deserialize<_i6.CommentLike>(data['data']);
    }
    if (dataClassName == 'CommentPageDto') {
      return deserialize<_i7.CommentPageDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyDto') {
      return deserialize<_i8.CommentReplyDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyLike') {
      return deserialize<_i9.CommentReplyLike>(data['data']);
    }
    if (dataClassName == 'CommentReplyRow') {
      return deserialize<_i10.CommentReplyRow>(data['data']);
    }
    if (dataClassName == 'CreatorFollow') {
      return deserialize<_i11.CreatorFollow>(data['data']);
    }
    if (dataClassName == 'DictionaryDefinition') {
      return deserialize<_i12.DictionaryDefinition>(data['data']);
    }
    if (dataClassName == 'DictionaryEntry') {
      return deserialize<_i13.DictionaryEntry>(data['data']);
    }
    if (dataClassName == 'DictionaryEntryDetail') {
      return deserialize<_i14.DictionaryEntryDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExample') {
      return deserialize<_i15.DictionaryExample>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleDetail') {
      return deserialize<_i16.DictionaryExampleDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleText') {
      return deserialize<_i17.DictionaryExampleText>(data['data']);
    }
    if (dataClassName == 'DictionaryForm') {
      return deserialize<_i18.DictionaryForm>(data['data']);
    }
    if (dataClassName == 'DictionaryImportCommitResult') {
      return deserialize<_i19.DictionaryImportCommitResult>(data['data']);
    }
    if (dataClassName == 'DictionaryImportMapping') {
      return deserialize<_i20.DictionaryImportMapping>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreview') {
      return deserialize<_i21.DictionaryImportPreview>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreviewRow') {
      return deserialize<_i22.DictionaryImportPreviewRow>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfile') {
      return deserialize<_i23.DictionaryImportProfile>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfileDetail') {
      return deserialize<_i24.DictionaryImportProfileDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryRelation') {
      return deserialize<_i25.DictionaryRelation>(data['data']);
    }
    if (dataClassName == 'DictionaryRelationDetail') {
      return deserialize<_i26.DictionaryRelationDetail>(data['data']);
    }
    if (dataClassName == 'EntryKnowledgeState') {
      return deserialize<_i27.EntryKnowledgeState>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i28.Greeting>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateQuery') {
      return deserialize<_i29.KnowledgeStateQuery>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateResult') {
      return deserialize<_i30.KnowledgeStateResult>(data['data']);
    }
    if (dataClassName == 'NotificationSettings') {
      return deserialize<_i31.NotificationSettings>(data['data']);
    }
    if (dataClassName == 'NotificationType') {
      return deserialize<_i32.NotificationType>(data['data']);
    }
    if (dataClassName == 'PrivacySettings') {
      return deserialize<_i33.PrivacySettings>(data['data']);
    }
    if (dataClassName == 'ProfileStats') {
      return deserialize<_i34.ProfileStats>(data['data']);
    }
    if (dataClassName == 'ScriptConversionCommitResult') {
      return deserialize<_i35.ScriptConversionCommitResult>(data['data']);
    }
    if (dataClassName == 'ScriptConversionEntry') {
      return deserialize<_i36.ScriptConversionEntry>(data['data']);
    }
    if (dataClassName == 'ScriptConversionImportPreview') {
      return deserialize<_i37.ScriptConversionImportPreview>(data['data']);
    }
    if (dataClassName == 'ScriptConversionImportPreviewRow') {
      return deserialize<_i38.ScriptConversionImportPreviewRow>(data['data']);
    }
    if (dataClassName == 'ScriptConversionProfile') {
      return deserialize<_i39.ScriptConversionProfile>(data['data']);
    }
    if (dataClassName == 'SubtitleCue') {
      return deserialize<_i40.SubtitleCue>(data['data']);
    }
    if (dataClassName == 'SubtitleCueDetail') {
      return deserialize<_i41.SubtitleCueDetail>(data['data']);
    }
    if (dataClassName == 'SubtitleCueText') {
      return deserialize<_i42.SubtitleCueText>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegment') {
      return deserialize<_i43.SubtitleKaraokeSegment>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegmentInput') {
      return deserialize<_i44.SubtitleKaraokeSegmentInput>(data['data']);
    }
    if (dataClassName == 'SubtitlePhrase') {
      return deserialize<_i45.SubtitlePhrase>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishState') {
      return deserialize<_i46.SubtitlePublishState>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishStatus') {
      return deserialize<_i47.SubtitlePublishStatus>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewDashboard') {
      return deserialize<_i48.SubtitleReviewDashboard>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewEvent') {
      return deserialize<_i49.SubtitleReviewEvent>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewQueueItem') {
      return deserialize<_i50.SubtitleReviewQueueItem>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTask') {
      return deserialize<_i51.SubtitleReviewTask>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTaskDetail') {
      return deserialize<_i52.SubtitleReviewTaskDetail>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTaskStatus') {
      return deserialize<_i53.SubtitleReviewTaskStatus>(data['data']);
    }
    if (dataClassName == 'SubtitleSrtPreview') {
      return deserialize<_i54.SubtitleSrtPreview>(data['data']);
    }
    if (dataClassName == 'SubtitleToken') {
      return deserialize<_i55.SubtitleToken>(data['data']);
    }
    if (dataClassName == 'SubtitleTrack') {
      return deserialize<_i56.SubtitleTrack>(data['data']);
    }
    if (dataClassName == 'UserKnownEntry') {
      return deserialize<_i57.UserKnownEntry>(data['data']);
    }
    if (dataClassName == 'Video') {
      return deserialize<_i58.Video>(data['data']);
    }
    if (dataClassName == 'VideoCommentDto') {
      return deserialize<_i59.VideoCommentDto>(data['data']);
    }
    if (dataClassName == 'VideoCommentRow') {
      return deserialize<_i60.VideoCommentRow>(data['data']);
    }
    if (dataClassName == 'VideoContentType') {
      return deserialize<_i61.VideoContentType>(data['data']);
    }
    if (dataClassName == 'VideoFavorite') {
      return deserialize<_i62.VideoFavorite>(data['data']);
    }
    if (dataClassName == 'VideoLike') {
      return deserialize<_i63.VideoLike>(data['data']);
    }
    if (dataClassName == 'VideoSeries') {
      return deserialize<_i64.VideoSeries>(data['data']);
    }
    if (dataClassName == 'VideoStatus') {
      return deserialize<_i65.VideoStatus>(data['data']);
    }
    if (dataClassName == 'WatchHistory') {
      return deserialize<_i66.WatchHistory>(data['data']);
    }
    if (dataClassName == 'WordList') {
      return deserialize<_i67.WordList>(data['data']);
    }
    if (dataClassName == 'WordListDetail') {
      return deserialize<_i68.WordListDetail>(data['data']);
    }
    if (dataClassName == 'WordListItem') {
      return deserialize<_i69.WordListItem>(data['data']);
    }
    if (dataClassName == 'WordListItemDetail') {
      return deserialize<_i70.WordListItemDetail>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i88.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i89.Protocol().deserializeByClassName(data);
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
      return _i88.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i89.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
