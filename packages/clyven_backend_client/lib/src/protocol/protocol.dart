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
import 'app_profile.dart' as _i2;
import 'asr_job.dart' as _i3;
import 'asr_job_status.dart' as _i4;
import 'comment_like.dart' as _i5;
import 'comment_page_dto.dart' as _i6;
import 'comment_reply_dto.dart' as _i7;
import 'comment_reply_like.dart' as _i8;
import 'comment_reply_row.dart' as _i9;
import 'creator_follow.dart' as _i10;
import 'dictionary_definition.dart' as _i11;
import 'dictionary_entry.dart' as _i12;
import 'dictionary_entry_detail.dart' as _i13;
import 'dictionary_example.dart' as _i14;
import 'dictionary_example_detail.dart' as _i15;
import 'dictionary_example_text.dart' as _i16;
import 'dictionary_form.dart' as _i17;
import 'dictionary_import_commit_result.dart' as _i18;
import 'dictionary_import_mapping.dart' as _i19;
import 'dictionary_import_preview.dart' as _i20;
import 'dictionary_import_preview_row.dart' as _i21;
import 'dictionary_import_profile.dart' as _i22;
import 'dictionary_import_profile_detail.dart' as _i23;
import 'dictionary_relation.dart' as _i24;
import 'dictionary_relation_detail.dart' as _i25;
import 'entry_knowledge_state.dart' as _i26;
import 'greetings/greeting.dart' as _i27;
import 'knowledge_state_query.dart' as _i28;
import 'knowledge_state_result.dart' as _i29;
import 'profile_stats.dart' as _i30;
import 'script_conversion_commit_result.dart' as _i31;
import 'script_conversion_entry.dart' as _i32;
import 'script_conversion_import_preview.dart' as _i33;
import 'script_conversion_import_preview_row.dart' as _i34;
import 'script_conversion_profile.dart' as _i35;
import 'subtitle_cue.dart' as _i36;
import 'subtitle_cue_detail.dart' as _i37;
import 'subtitle_cue_text.dart' as _i38;
import 'subtitle_karaoke_segment.dart' as _i39;
import 'subtitle_karaoke_segment_input.dart' as _i40;
import 'subtitle_phrase.dart' as _i41;
import 'subtitle_publish_state.dart' as _i42;
import 'subtitle_publish_status.dart' as _i43;
import 'subtitle_review_dashboard.dart' as _i44;
import 'subtitle_review_event.dart' as _i45;
import 'subtitle_review_queue_item.dart' as _i46;
import 'subtitle_review_task.dart' as _i47;
import 'subtitle_review_task_detail.dart' as _i48;
import 'subtitle_review_task_status.dart' as _i49;
import 'subtitle_srt_preview.dart' as _i50;
import 'subtitle_token.dart' as _i51;
import 'subtitle_track.dart' as _i52;
import 'user_known_entry.dart' as _i53;
import 'video.dart' as _i54;
import 'video_comment_dto.dart' as _i55;
import 'video_comment_row.dart' as _i56;
import 'video_content_type.dart' as _i57;
import 'video_favorite.dart' as _i58;
import 'video_status.dart' as _i59;
import 'watch_history.dart' as _i60;
import 'word_list.dart' as _i61;
import 'word_list_detail.dart' as _i62;
import 'word_list_item.dart' as _i63;
import 'word_list_item_detail.dart' as _i64;
import 'package:clyven_backend_client/src/protocol/asr_job.dart' as _i65;
import 'package:clyven_backend_client/src/protocol/video.dart' as _i66;
import 'package:clyven_backend_client/src/protocol/subtitle_track.dart' as _i67;
import 'package:clyven_backend_client/src/protocol/dictionary_entry_detail.dart'
    as _i68;
import 'package:clyven_backend_client/src/protocol/dictionary_import_profile.dart'
    as _i69;
import 'package:clyven_backend_client/src/protocol/entry_knowledge_state.dart'
    as _i70;
import 'package:clyven_backend_client/src/protocol/knowledge_state_result.dart'
    as _i71;
import 'package:clyven_backend_client/src/protocol/knowledge_state_query.dart'
    as _i72;
import 'package:clyven_backend_client/src/protocol/script_conversion_profile.dart'
    as _i73;
import 'package:clyven_backend_client/src/protocol/script_conversion_entry.dart'
    as _i74;
import 'package:clyven_backend_client/src/protocol/watch_history.dart' as _i75;
import 'package:clyven_backend_client/src/protocol/subtitle_cue_detail.dart'
    as _i76;
import 'package:clyven_backend_client/src/protocol/subtitle_karaoke_segment.dart'
    as _i77;
import 'package:clyven_backend_client/src/protocol/subtitle_karaoke_segment_input.dart'
    as _i78;
import 'package:clyven_backend_client/src/protocol/word_list.dart' as _i79;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i80;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i81;
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

    if (t == _i2.AppProfile) {
      return _i2.AppProfile.fromJson(data) as T;
    }
    if (t == _i3.AsrJob) {
      return _i3.AsrJob.fromJson(data) as T;
    }
    if (t == _i4.AsrJobStatus) {
      return _i4.AsrJobStatus.fromJson(data) as T;
    }
    if (t == _i5.CommentLike) {
      return _i5.CommentLike.fromJson(data) as T;
    }
    if (t == _i6.CommentPageDto) {
      return _i6.CommentPageDto.fromJson(data) as T;
    }
    if (t == _i7.CommentReplyDto) {
      return _i7.CommentReplyDto.fromJson(data) as T;
    }
    if (t == _i8.CommentReplyLike) {
      return _i8.CommentReplyLike.fromJson(data) as T;
    }
    if (t == _i9.CommentReplyRow) {
      return _i9.CommentReplyRow.fromJson(data) as T;
    }
    if (t == _i10.CreatorFollow) {
      return _i10.CreatorFollow.fromJson(data) as T;
    }
    if (t == _i11.DictionaryDefinition) {
      return _i11.DictionaryDefinition.fromJson(data) as T;
    }
    if (t == _i12.DictionaryEntry) {
      return _i12.DictionaryEntry.fromJson(data) as T;
    }
    if (t == _i13.DictionaryEntryDetail) {
      return _i13.DictionaryEntryDetail.fromJson(data) as T;
    }
    if (t == _i14.DictionaryExample) {
      return _i14.DictionaryExample.fromJson(data) as T;
    }
    if (t == _i15.DictionaryExampleDetail) {
      return _i15.DictionaryExampleDetail.fromJson(data) as T;
    }
    if (t == _i16.DictionaryExampleText) {
      return _i16.DictionaryExampleText.fromJson(data) as T;
    }
    if (t == _i17.DictionaryForm) {
      return _i17.DictionaryForm.fromJson(data) as T;
    }
    if (t == _i18.DictionaryImportCommitResult) {
      return _i18.DictionaryImportCommitResult.fromJson(data) as T;
    }
    if (t == _i19.DictionaryImportMapping) {
      return _i19.DictionaryImportMapping.fromJson(data) as T;
    }
    if (t == _i20.DictionaryImportPreview) {
      return _i20.DictionaryImportPreview.fromJson(data) as T;
    }
    if (t == _i21.DictionaryImportPreviewRow) {
      return _i21.DictionaryImportPreviewRow.fromJson(data) as T;
    }
    if (t == _i22.DictionaryImportProfile) {
      return _i22.DictionaryImportProfile.fromJson(data) as T;
    }
    if (t == _i23.DictionaryImportProfileDetail) {
      return _i23.DictionaryImportProfileDetail.fromJson(data) as T;
    }
    if (t == _i24.DictionaryRelation) {
      return _i24.DictionaryRelation.fromJson(data) as T;
    }
    if (t == _i25.DictionaryRelationDetail) {
      return _i25.DictionaryRelationDetail.fromJson(data) as T;
    }
    if (t == _i26.EntryKnowledgeState) {
      return _i26.EntryKnowledgeState.fromJson(data) as T;
    }
    if (t == _i27.Greeting) {
      return _i27.Greeting.fromJson(data) as T;
    }
    if (t == _i28.KnowledgeStateQuery) {
      return _i28.KnowledgeStateQuery.fromJson(data) as T;
    }
    if (t == _i29.KnowledgeStateResult) {
      return _i29.KnowledgeStateResult.fromJson(data) as T;
    }
    if (t == _i30.ProfileStats) {
      return _i30.ProfileStats.fromJson(data) as T;
    }
    if (t == _i31.ScriptConversionCommitResult) {
      return _i31.ScriptConversionCommitResult.fromJson(data) as T;
    }
    if (t == _i32.ScriptConversionEntry) {
      return _i32.ScriptConversionEntry.fromJson(data) as T;
    }
    if (t == _i33.ScriptConversionImportPreview) {
      return _i33.ScriptConversionImportPreview.fromJson(data) as T;
    }
    if (t == _i34.ScriptConversionImportPreviewRow) {
      return _i34.ScriptConversionImportPreviewRow.fromJson(data) as T;
    }
    if (t == _i35.ScriptConversionProfile) {
      return _i35.ScriptConversionProfile.fromJson(data) as T;
    }
    if (t == _i36.SubtitleCue) {
      return _i36.SubtitleCue.fromJson(data) as T;
    }
    if (t == _i37.SubtitleCueDetail) {
      return _i37.SubtitleCueDetail.fromJson(data) as T;
    }
    if (t == _i38.SubtitleCueText) {
      return _i38.SubtitleCueText.fromJson(data) as T;
    }
    if (t == _i39.SubtitleKaraokeSegment) {
      return _i39.SubtitleKaraokeSegment.fromJson(data) as T;
    }
    if (t == _i40.SubtitleKaraokeSegmentInput) {
      return _i40.SubtitleKaraokeSegmentInput.fromJson(data) as T;
    }
    if (t == _i41.SubtitlePhrase) {
      return _i41.SubtitlePhrase.fromJson(data) as T;
    }
    if (t == _i42.SubtitlePublishState) {
      return _i42.SubtitlePublishState.fromJson(data) as T;
    }
    if (t == _i43.SubtitlePublishStatus) {
      return _i43.SubtitlePublishStatus.fromJson(data) as T;
    }
    if (t == _i44.SubtitleReviewDashboard) {
      return _i44.SubtitleReviewDashboard.fromJson(data) as T;
    }
    if (t == _i45.SubtitleReviewEvent) {
      return _i45.SubtitleReviewEvent.fromJson(data) as T;
    }
    if (t == _i46.SubtitleReviewQueueItem) {
      return _i46.SubtitleReviewQueueItem.fromJson(data) as T;
    }
    if (t == _i47.SubtitleReviewTask) {
      return _i47.SubtitleReviewTask.fromJson(data) as T;
    }
    if (t == _i48.SubtitleReviewTaskDetail) {
      return _i48.SubtitleReviewTaskDetail.fromJson(data) as T;
    }
    if (t == _i49.SubtitleReviewTaskStatus) {
      return _i49.SubtitleReviewTaskStatus.fromJson(data) as T;
    }
    if (t == _i50.SubtitleSrtPreview) {
      return _i50.SubtitleSrtPreview.fromJson(data) as T;
    }
    if (t == _i51.SubtitleToken) {
      return _i51.SubtitleToken.fromJson(data) as T;
    }
    if (t == _i52.SubtitleTrack) {
      return _i52.SubtitleTrack.fromJson(data) as T;
    }
    if (t == _i53.UserKnownEntry) {
      return _i53.UserKnownEntry.fromJson(data) as T;
    }
    if (t == _i54.Video) {
      return _i54.Video.fromJson(data) as T;
    }
    if (t == _i55.VideoCommentDto) {
      return _i55.VideoCommentDto.fromJson(data) as T;
    }
    if (t == _i56.VideoCommentRow) {
      return _i56.VideoCommentRow.fromJson(data) as T;
    }
    if (t == _i57.VideoContentType) {
      return _i57.VideoContentType.fromJson(data) as T;
    }
    if (t == _i58.VideoFavorite) {
      return _i58.VideoFavorite.fromJson(data) as T;
    }
    if (t == _i59.VideoStatus) {
      return _i59.VideoStatus.fromJson(data) as T;
    }
    if (t == _i60.WatchHistory) {
      return _i60.WatchHistory.fromJson(data) as T;
    }
    if (t == _i61.WordList) {
      return _i61.WordList.fromJson(data) as T;
    }
    if (t == _i62.WordListDetail) {
      return _i62.WordListDetail.fromJson(data) as T;
    }
    if (t == _i63.WordListItem) {
      return _i63.WordListItem.fromJson(data) as T;
    }
    if (t == _i64.WordListItemDetail) {
      return _i64.WordListItemDetail.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AppProfile?>()) {
      return (data != null ? _i2.AppProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AsrJob?>()) {
      return (data != null ? _i3.AsrJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AsrJobStatus?>()) {
      return (data != null ? _i4.AsrJobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.CommentLike?>()) {
      return (data != null ? _i5.CommentLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.CommentPageDto?>()) {
      return (data != null ? _i6.CommentPageDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.CommentReplyDto?>()) {
      return (data != null ? _i7.CommentReplyDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CommentReplyLike?>()) {
      return (data != null ? _i8.CommentReplyLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.CommentReplyRow?>()) {
      return (data != null ? _i9.CommentReplyRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.CreatorFollow?>()) {
      return (data != null ? _i10.CreatorFollow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.DictionaryDefinition?>()) {
      return (data != null ? _i11.DictionaryDefinition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.DictionaryEntry?>()) {
      return (data != null ? _i12.DictionaryEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.DictionaryEntryDetail?>()) {
      return (data != null ? _i13.DictionaryEntryDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.DictionaryExample?>()) {
      return (data != null ? _i14.DictionaryExample.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.DictionaryExampleDetail?>()) {
      return (data != null ? _i15.DictionaryExampleDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.DictionaryExampleText?>()) {
      return (data != null ? _i16.DictionaryExampleText.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.DictionaryForm?>()) {
      return (data != null ? _i17.DictionaryForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.DictionaryImportCommitResult?>()) {
      return (data != null
              ? _i18.DictionaryImportCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i19.DictionaryImportMapping?>()) {
      return (data != null ? _i19.DictionaryImportMapping.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.DictionaryImportPreview?>()) {
      return (data != null ? _i20.DictionaryImportPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.DictionaryImportPreviewRow?>()) {
      return (data != null
              ? _i21.DictionaryImportPreviewRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i22.DictionaryImportProfile?>()) {
      return (data != null ? _i22.DictionaryImportProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.DictionaryImportProfileDetail?>()) {
      return (data != null
              ? _i23.DictionaryImportProfileDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i24.DictionaryRelation?>()) {
      return (data != null ? _i24.DictionaryRelation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.DictionaryRelationDetail?>()) {
      return (data != null
              ? _i25.DictionaryRelationDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i26.EntryKnowledgeState?>()) {
      return (data != null ? _i26.EntryKnowledgeState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.Greeting?>()) {
      return (data != null ? _i27.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.KnowledgeStateQuery?>()) {
      return (data != null ? _i28.KnowledgeStateQuery.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.KnowledgeStateResult?>()) {
      return (data != null ? _i29.KnowledgeStateResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i30.ProfileStats?>()) {
      return (data != null ? _i30.ProfileStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.ScriptConversionCommitResult?>()) {
      return (data != null
              ? _i31.ScriptConversionCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i32.ScriptConversionEntry?>()) {
      return (data != null ? _i32.ScriptConversionEntry.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.ScriptConversionImportPreview?>()) {
      return (data != null
              ? _i33.ScriptConversionImportPreview.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i34.ScriptConversionImportPreviewRow?>()) {
      return (data != null
              ? _i34.ScriptConversionImportPreviewRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i35.ScriptConversionProfile?>()) {
      return (data != null ? _i35.ScriptConversionProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i36.SubtitleCue?>()) {
      return (data != null ? _i36.SubtitleCue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.SubtitleCueDetail?>()) {
      return (data != null ? _i37.SubtitleCueDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.SubtitleCueText?>()) {
      return (data != null ? _i38.SubtitleCueText.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.SubtitleKaraokeSegment?>()) {
      return (data != null ? _i39.SubtitleKaraokeSegment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.SubtitleKaraokeSegmentInput?>()) {
      return (data != null
              ? _i40.SubtitleKaraokeSegmentInput.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i41.SubtitlePhrase?>()) {
      return (data != null ? _i41.SubtitlePhrase.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.SubtitlePublishState?>()) {
      return (data != null ? _i42.SubtitlePublishState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i43.SubtitlePublishStatus?>()) {
      return (data != null ? _i43.SubtitlePublishStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.SubtitleReviewDashboard?>()) {
      return (data != null ? _i44.SubtitleReviewDashboard.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i45.SubtitleReviewEvent?>()) {
      return (data != null ? _i45.SubtitleReviewEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i46.SubtitleReviewQueueItem?>()) {
      return (data != null ? _i46.SubtitleReviewQueueItem.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i47.SubtitleReviewTask?>()) {
      return (data != null ? _i47.SubtitleReviewTask.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i48.SubtitleReviewTaskDetail?>()) {
      return (data != null
              ? _i48.SubtitleReviewTaskDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i49.SubtitleReviewTaskStatus?>()) {
      return (data != null
              ? _i49.SubtitleReviewTaskStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i50.SubtitleSrtPreview?>()) {
      return (data != null ? _i50.SubtitleSrtPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i51.SubtitleToken?>()) {
      return (data != null ? _i51.SubtitleToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.SubtitleTrack?>()) {
      return (data != null ? _i52.SubtitleTrack.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.UserKnownEntry?>()) {
      return (data != null ? _i53.UserKnownEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.Video?>()) {
      return (data != null ? _i54.Video.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.VideoCommentDto?>()) {
      return (data != null ? _i55.VideoCommentDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.VideoCommentRow?>()) {
      return (data != null ? _i56.VideoCommentRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.VideoContentType?>()) {
      return (data != null ? _i57.VideoContentType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.VideoFavorite?>()) {
      return (data != null ? _i58.VideoFavorite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.VideoStatus?>()) {
      return (data != null ? _i59.VideoStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.WatchHistory?>()) {
      return (data != null ? _i60.WatchHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.WordList?>()) {
      return (data != null ? _i61.WordList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.WordListDetail?>()) {
      return (data != null ? _i62.WordListDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.WordListItem?>()) {
      return (data != null ? _i63.WordListItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.WordListItemDetail?>()) {
      return (data != null ? _i64.WordListItemDetail.fromJson(data) : null)
          as T;
    }
    if (t == List<_i55.VideoCommentDto>) {
      return (data as List)
              .map((e) => deserialize<_i55.VideoCommentDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i11.DictionaryDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i11.DictionaryDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i17.DictionaryForm>) {
      return (data as List)
              .map((e) => deserialize<_i17.DictionaryForm>(e))
              .toList()
          as T;
    }
    if (t == List<_i15.DictionaryExampleDetail>) {
      return (data as List)
              .map((e) => deserialize<_i15.DictionaryExampleDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.DictionaryRelationDetail>) {
      return (data as List)
              .map((e) => deserialize<_i25.DictionaryRelationDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i16.DictionaryExampleText>) {
      return (data as List)
              .map((e) => deserialize<_i16.DictionaryExampleText>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i21.DictionaryImportPreviewRow>) {
      return (data as List)
              .map((e) => deserialize<_i21.DictionaryImportPreviewRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i19.DictionaryImportMapping>) {
      return (data as List)
              .map((e) => deserialize<_i19.DictionaryImportMapping>(e))
              .toList()
          as T;
    }
    if (t == List<_i34.ScriptConversionImportPreviewRow>) {
      return (data as List)
              .map((e) => deserialize<_i34.ScriptConversionImportPreviewRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i38.SubtitleCueText>) {
      return (data as List)
              .map((e) => deserialize<_i38.SubtitleCueText>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i38.SubtitleCueText>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i38.SubtitleCueText>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i51.SubtitleToken>) {
      return (data as List)
              .map((e) => deserialize<_i51.SubtitleToken>(e))
              .toList()
          as T;
    }
    if (t == List<_i41.SubtitlePhrase>) {
      return (data as List)
              .map((e) => deserialize<_i41.SubtitlePhrase>(e))
              .toList()
          as T;
    }
    if (t == List<_i39.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i39.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i39.SubtitleKaraokeSegment>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i39.SubtitleKaraokeSegment>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i46.SubtitleReviewQueueItem>) {
      return (data as List)
              .map((e) => deserialize<_i46.SubtitleReviewQueueItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i45.SubtitleReviewEvent>) {
      return (data as List)
              .map((e) => deserialize<_i45.SubtitleReviewEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i7.CommentReplyDto>) {
      return (data as List)
              .map((e) => deserialize<_i7.CommentReplyDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i64.WordListItemDetail>) {
      return (data as List)
              .map((e) => deserialize<_i64.WordListItemDetail>(e))
              .toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i65.AsrJob>) {
      return (data as List).map((e) => deserialize<_i65.AsrJob>(e)).toList()
          as T;
    }
    if (t == List<_i66.Video>) {
      return (data as List).map((e) => deserialize<_i66.Video>(e)).toList()
          as T;
    }
    if (t == List<_i67.SubtitleTrack>) {
      return (data as List)
              .map((e) => deserialize<_i67.SubtitleTrack>(e))
              .toList()
          as T;
    }
    if (t == List<_i68.DictionaryEntryDetail>) {
      return (data as List)
              .map((e) => deserialize<_i68.DictionaryEntryDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i69.DictionaryImportProfile>) {
      return (data as List)
              .map((e) => deserialize<_i69.DictionaryImportProfile>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i70.EntryKnowledgeState>) {
      return (data as List)
              .map((e) => deserialize<_i70.EntryKnowledgeState>(e))
              .toList()
          as T;
    }
    if (t == List<_i71.KnowledgeStateResult>) {
      return (data as List)
              .map((e) => deserialize<_i71.KnowledgeStateResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i72.KnowledgeStateQuery>) {
      return (data as List)
              .map((e) => deserialize<_i72.KnowledgeStateQuery>(e))
              .toList()
          as T;
    }
    if (t == List<_i73.ScriptConversionProfile>) {
      return (data as List)
              .map((e) => deserialize<_i73.ScriptConversionProfile>(e))
              .toList()
          as T;
    }
    if (t == List<_i74.ScriptConversionEntry>) {
      return (data as List)
              .map((e) => deserialize<_i74.ScriptConversionEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i75.WatchHistory>) {
      return (data as List)
              .map((e) => deserialize<_i75.WatchHistory>(e))
              .toList()
          as T;
    }
    if (t == List<_i76.SubtitleCueDetail>) {
      return (data as List)
              .map((e) => deserialize<_i76.SubtitleCueDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i77.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i77.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == List<_i78.SubtitleKaraokeSegmentInput>) {
      return (data as List)
              .map((e) => deserialize<_i78.SubtitleKaraokeSegmentInput>(e))
              .toList()
          as T;
    }
    if (t == List<_i79.WordList>) {
      return (data as List).map((e) => deserialize<_i79.WordList>(e)).toList()
          as T;
    }
    try {
      return _i80.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i81.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AppProfile => 'AppProfile',
      _i3.AsrJob => 'AsrJob',
      _i4.AsrJobStatus => 'AsrJobStatus',
      _i5.CommentLike => 'CommentLike',
      _i6.CommentPageDto => 'CommentPageDto',
      _i7.CommentReplyDto => 'CommentReplyDto',
      _i8.CommentReplyLike => 'CommentReplyLike',
      _i9.CommentReplyRow => 'CommentReplyRow',
      _i10.CreatorFollow => 'CreatorFollow',
      _i11.DictionaryDefinition => 'DictionaryDefinition',
      _i12.DictionaryEntry => 'DictionaryEntry',
      _i13.DictionaryEntryDetail => 'DictionaryEntryDetail',
      _i14.DictionaryExample => 'DictionaryExample',
      _i15.DictionaryExampleDetail => 'DictionaryExampleDetail',
      _i16.DictionaryExampleText => 'DictionaryExampleText',
      _i17.DictionaryForm => 'DictionaryForm',
      _i18.DictionaryImportCommitResult => 'DictionaryImportCommitResult',
      _i19.DictionaryImportMapping => 'DictionaryImportMapping',
      _i20.DictionaryImportPreview => 'DictionaryImportPreview',
      _i21.DictionaryImportPreviewRow => 'DictionaryImportPreviewRow',
      _i22.DictionaryImportProfile => 'DictionaryImportProfile',
      _i23.DictionaryImportProfileDetail => 'DictionaryImportProfileDetail',
      _i24.DictionaryRelation => 'DictionaryRelation',
      _i25.DictionaryRelationDetail => 'DictionaryRelationDetail',
      _i26.EntryKnowledgeState => 'EntryKnowledgeState',
      _i27.Greeting => 'Greeting',
      _i28.KnowledgeStateQuery => 'KnowledgeStateQuery',
      _i29.KnowledgeStateResult => 'KnowledgeStateResult',
      _i30.ProfileStats => 'ProfileStats',
      _i31.ScriptConversionCommitResult => 'ScriptConversionCommitResult',
      _i32.ScriptConversionEntry => 'ScriptConversionEntry',
      _i33.ScriptConversionImportPreview => 'ScriptConversionImportPreview',
      _i34.ScriptConversionImportPreviewRow =>
        'ScriptConversionImportPreviewRow',
      _i35.ScriptConversionProfile => 'ScriptConversionProfile',
      _i36.SubtitleCue => 'SubtitleCue',
      _i37.SubtitleCueDetail => 'SubtitleCueDetail',
      _i38.SubtitleCueText => 'SubtitleCueText',
      _i39.SubtitleKaraokeSegment => 'SubtitleKaraokeSegment',
      _i40.SubtitleKaraokeSegmentInput => 'SubtitleKaraokeSegmentInput',
      _i41.SubtitlePhrase => 'SubtitlePhrase',
      _i42.SubtitlePublishState => 'SubtitlePublishState',
      _i43.SubtitlePublishStatus => 'SubtitlePublishStatus',
      _i44.SubtitleReviewDashboard => 'SubtitleReviewDashboard',
      _i45.SubtitleReviewEvent => 'SubtitleReviewEvent',
      _i46.SubtitleReviewQueueItem => 'SubtitleReviewQueueItem',
      _i47.SubtitleReviewTask => 'SubtitleReviewTask',
      _i48.SubtitleReviewTaskDetail => 'SubtitleReviewTaskDetail',
      _i49.SubtitleReviewTaskStatus => 'SubtitleReviewTaskStatus',
      _i50.SubtitleSrtPreview => 'SubtitleSrtPreview',
      _i51.SubtitleToken => 'SubtitleToken',
      _i52.SubtitleTrack => 'SubtitleTrack',
      _i53.UserKnownEntry => 'UserKnownEntry',
      _i54.Video => 'Video',
      _i55.VideoCommentDto => 'VideoCommentDto',
      _i56.VideoCommentRow => 'VideoCommentRow',
      _i57.VideoContentType => 'VideoContentType',
      _i58.VideoFavorite => 'VideoFavorite',
      _i59.VideoStatus => 'VideoStatus',
      _i60.WatchHistory => 'WatchHistory',
      _i61.WordList => 'WordList',
      _i62.WordListDetail => 'WordListDetail',
      _i63.WordListItem => 'WordListItem',
      _i64.WordListItemDetail => 'WordListItemDetail',
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
      case _i2.AppProfile():
        return 'AppProfile';
      case _i3.AsrJob():
        return 'AsrJob';
      case _i4.AsrJobStatus():
        return 'AsrJobStatus';
      case _i5.CommentLike():
        return 'CommentLike';
      case _i6.CommentPageDto():
        return 'CommentPageDto';
      case _i7.CommentReplyDto():
        return 'CommentReplyDto';
      case _i8.CommentReplyLike():
        return 'CommentReplyLike';
      case _i9.CommentReplyRow():
        return 'CommentReplyRow';
      case _i10.CreatorFollow():
        return 'CreatorFollow';
      case _i11.DictionaryDefinition():
        return 'DictionaryDefinition';
      case _i12.DictionaryEntry():
        return 'DictionaryEntry';
      case _i13.DictionaryEntryDetail():
        return 'DictionaryEntryDetail';
      case _i14.DictionaryExample():
        return 'DictionaryExample';
      case _i15.DictionaryExampleDetail():
        return 'DictionaryExampleDetail';
      case _i16.DictionaryExampleText():
        return 'DictionaryExampleText';
      case _i17.DictionaryForm():
        return 'DictionaryForm';
      case _i18.DictionaryImportCommitResult():
        return 'DictionaryImportCommitResult';
      case _i19.DictionaryImportMapping():
        return 'DictionaryImportMapping';
      case _i20.DictionaryImportPreview():
        return 'DictionaryImportPreview';
      case _i21.DictionaryImportPreviewRow():
        return 'DictionaryImportPreviewRow';
      case _i22.DictionaryImportProfile():
        return 'DictionaryImportProfile';
      case _i23.DictionaryImportProfileDetail():
        return 'DictionaryImportProfileDetail';
      case _i24.DictionaryRelation():
        return 'DictionaryRelation';
      case _i25.DictionaryRelationDetail():
        return 'DictionaryRelationDetail';
      case _i26.EntryKnowledgeState():
        return 'EntryKnowledgeState';
      case _i27.Greeting():
        return 'Greeting';
      case _i28.KnowledgeStateQuery():
        return 'KnowledgeStateQuery';
      case _i29.KnowledgeStateResult():
        return 'KnowledgeStateResult';
      case _i30.ProfileStats():
        return 'ProfileStats';
      case _i31.ScriptConversionCommitResult():
        return 'ScriptConversionCommitResult';
      case _i32.ScriptConversionEntry():
        return 'ScriptConversionEntry';
      case _i33.ScriptConversionImportPreview():
        return 'ScriptConversionImportPreview';
      case _i34.ScriptConversionImportPreviewRow():
        return 'ScriptConversionImportPreviewRow';
      case _i35.ScriptConversionProfile():
        return 'ScriptConversionProfile';
      case _i36.SubtitleCue():
        return 'SubtitleCue';
      case _i37.SubtitleCueDetail():
        return 'SubtitleCueDetail';
      case _i38.SubtitleCueText():
        return 'SubtitleCueText';
      case _i39.SubtitleKaraokeSegment():
        return 'SubtitleKaraokeSegment';
      case _i40.SubtitleKaraokeSegmentInput():
        return 'SubtitleKaraokeSegmentInput';
      case _i41.SubtitlePhrase():
        return 'SubtitlePhrase';
      case _i42.SubtitlePublishState():
        return 'SubtitlePublishState';
      case _i43.SubtitlePublishStatus():
        return 'SubtitlePublishStatus';
      case _i44.SubtitleReviewDashboard():
        return 'SubtitleReviewDashboard';
      case _i45.SubtitleReviewEvent():
        return 'SubtitleReviewEvent';
      case _i46.SubtitleReviewQueueItem():
        return 'SubtitleReviewQueueItem';
      case _i47.SubtitleReviewTask():
        return 'SubtitleReviewTask';
      case _i48.SubtitleReviewTaskDetail():
        return 'SubtitleReviewTaskDetail';
      case _i49.SubtitleReviewTaskStatus():
        return 'SubtitleReviewTaskStatus';
      case _i50.SubtitleSrtPreview():
        return 'SubtitleSrtPreview';
      case _i51.SubtitleToken():
        return 'SubtitleToken';
      case _i52.SubtitleTrack():
        return 'SubtitleTrack';
      case _i53.UserKnownEntry():
        return 'UserKnownEntry';
      case _i54.Video():
        return 'Video';
      case _i55.VideoCommentDto():
        return 'VideoCommentDto';
      case _i56.VideoCommentRow():
        return 'VideoCommentRow';
      case _i57.VideoContentType():
        return 'VideoContentType';
      case _i58.VideoFavorite():
        return 'VideoFavorite';
      case _i59.VideoStatus():
        return 'VideoStatus';
      case _i60.WatchHistory():
        return 'WatchHistory';
      case _i61.WordList():
        return 'WordList';
      case _i62.WordListDetail():
        return 'WordListDetail';
      case _i63.WordListItem():
        return 'WordListItem';
      case _i64.WordListItemDetail():
        return 'WordListItemDetail';
    }
    className = _i80.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i81.Protocol().getClassNameForObject(data);
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
      return deserialize<_i2.AppProfile>(data['data']);
    }
    if (dataClassName == 'AsrJob') {
      return deserialize<_i3.AsrJob>(data['data']);
    }
    if (dataClassName == 'AsrJobStatus') {
      return deserialize<_i4.AsrJobStatus>(data['data']);
    }
    if (dataClassName == 'CommentLike') {
      return deserialize<_i5.CommentLike>(data['data']);
    }
    if (dataClassName == 'CommentPageDto') {
      return deserialize<_i6.CommentPageDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyDto') {
      return deserialize<_i7.CommentReplyDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyLike') {
      return deserialize<_i8.CommentReplyLike>(data['data']);
    }
    if (dataClassName == 'CommentReplyRow') {
      return deserialize<_i9.CommentReplyRow>(data['data']);
    }
    if (dataClassName == 'CreatorFollow') {
      return deserialize<_i10.CreatorFollow>(data['data']);
    }
    if (dataClassName == 'DictionaryDefinition') {
      return deserialize<_i11.DictionaryDefinition>(data['data']);
    }
    if (dataClassName == 'DictionaryEntry') {
      return deserialize<_i12.DictionaryEntry>(data['data']);
    }
    if (dataClassName == 'DictionaryEntryDetail') {
      return deserialize<_i13.DictionaryEntryDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExample') {
      return deserialize<_i14.DictionaryExample>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleDetail') {
      return deserialize<_i15.DictionaryExampleDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleText') {
      return deserialize<_i16.DictionaryExampleText>(data['data']);
    }
    if (dataClassName == 'DictionaryForm') {
      return deserialize<_i17.DictionaryForm>(data['data']);
    }
    if (dataClassName == 'DictionaryImportCommitResult') {
      return deserialize<_i18.DictionaryImportCommitResult>(data['data']);
    }
    if (dataClassName == 'DictionaryImportMapping') {
      return deserialize<_i19.DictionaryImportMapping>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreview') {
      return deserialize<_i20.DictionaryImportPreview>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreviewRow') {
      return deserialize<_i21.DictionaryImportPreviewRow>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfile') {
      return deserialize<_i22.DictionaryImportProfile>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfileDetail') {
      return deserialize<_i23.DictionaryImportProfileDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryRelation') {
      return deserialize<_i24.DictionaryRelation>(data['data']);
    }
    if (dataClassName == 'DictionaryRelationDetail') {
      return deserialize<_i25.DictionaryRelationDetail>(data['data']);
    }
    if (dataClassName == 'EntryKnowledgeState') {
      return deserialize<_i26.EntryKnowledgeState>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i27.Greeting>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateQuery') {
      return deserialize<_i28.KnowledgeStateQuery>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateResult') {
      return deserialize<_i29.KnowledgeStateResult>(data['data']);
    }
    if (dataClassName == 'ProfileStats') {
      return deserialize<_i30.ProfileStats>(data['data']);
    }
    if (dataClassName == 'ScriptConversionCommitResult') {
      return deserialize<_i31.ScriptConversionCommitResult>(data['data']);
    }
    if (dataClassName == 'ScriptConversionEntry') {
      return deserialize<_i32.ScriptConversionEntry>(data['data']);
    }
    if (dataClassName == 'ScriptConversionImportPreview') {
      return deserialize<_i33.ScriptConversionImportPreview>(data['data']);
    }
    if (dataClassName == 'ScriptConversionImportPreviewRow') {
      return deserialize<_i34.ScriptConversionImportPreviewRow>(data['data']);
    }
    if (dataClassName == 'ScriptConversionProfile') {
      return deserialize<_i35.ScriptConversionProfile>(data['data']);
    }
    if (dataClassName == 'SubtitleCue') {
      return deserialize<_i36.SubtitleCue>(data['data']);
    }
    if (dataClassName == 'SubtitleCueDetail') {
      return deserialize<_i37.SubtitleCueDetail>(data['data']);
    }
    if (dataClassName == 'SubtitleCueText') {
      return deserialize<_i38.SubtitleCueText>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegment') {
      return deserialize<_i39.SubtitleKaraokeSegment>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegmentInput') {
      return deserialize<_i40.SubtitleKaraokeSegmentInput>(data['data']);
    }
    if (dataClassName == 'SubtitlePhrase') {
      return deserialize<_i41.SubtitlePhrase>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishState') {
      return deserialize<_i42.SubtitlePublishState>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishStatus') {
      return deserialize<_i43.SubtitlePublishStatus>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewDashboard') {
      return deserialize<_i44.SubtitleReviewDashboard>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewEvent') {
      return deserialize<_i45.SubtitleReviewEvent>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewQueueItem') {
      return deserialize<_i46.SubtitleReviewQueueItem>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTask') {
      return deserialize<_i47.SubtitleReviewTask>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTaskDetail') {
      return deserialize<_i48.SubtitleReviewTaskDetail>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTaskStatus') {
      return deserialize<_i49.SubtitleReviewTaskStatus>(data['data']);
    }
    if (dataClassName == 'SubtitleSrtPreview') {
      return deserialize<_i50.SubtitleSrtPreview>(data['data']);
    }
    if (dataClassName == 'SubtitleToken') {
      return deserialize<_i51.SubtitleToken>(data['data']);
    }
    if (dataClassName == 'SubtitleTrack') {
      return deserialize<_i52.SubtitleTrack>(data['data']);
    }
    if (dataClassName == 'UserKnownEntry') {
      return deserialize<_i53.UserKnownEntry>(data['data']);
    }
    if (dataClassName == 'Video') {
      return deserialize<_i54.Video>(data['data']);
    }
    if (dataClassName == 'VideoCommentDto') {
      return deserialize<_i55.VideoCommentDto>(data['data']);
    }
    if (dataClassName == 'VideoCommentRow') {
      return deserialize<_i56.VideoCommentRow>(data['data']);
    }
    if (dataClassName == 'VideoContentType') {
      return deserialize<_i57.VideoContentType>(data['data']);
    }
    if (dataClassName == 'VideoFavorite') {
      return deserialize<_i58.VideoFavorite>(data['data']);
    }
    if (dataClassName == 'VideoStatus') {
      return deserialize<_i59.VideoStatus>(data['data']);
    }
    if (dataClassName == 'WatchHistory') {
      return deserialize<_i60.WatchHistory>(data['data']);
    }
    if (dataClassName == 'WordList') {
      return deserialize<_i61.WordList>(data['data']);
    }
    if (dataClassName == 'WordListDetail') {
      return deserialize<_i62.WordListDetail>(data['data']);
    }
    if (dataClassName == 'WordListItem') {
      return deserialize<_i63.WordListItem>(data['data']);
    }
    if (dataClassName == 'WordListItemDetail') {
      return deserialize<_i64.WordListItemDetail>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i80.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i81.Protocol().deserializeByClassName(data);
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
      return _i80.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i81.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
