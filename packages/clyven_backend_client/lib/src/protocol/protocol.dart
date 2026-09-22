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
import 'asr_job.dart' as _i2;
import 'asr_job_status.dart' as _i3;
import 'comment_like.dart' as _i4;
import 'comment_page_dto.dart' as _i5;
import 'comment_reply_dto.dart' as _i6;
import 'comment_reply_like.dart' as _i7;
import 'comment_reply_row.dart' as _i8;
import 'dictionary_definition.dart' as _i9;
import 'dictionary_entry.dart' as _i10;
import 'dictionary_entry_detail.dart' as _i11;
import 'dictionary_example.dart' as _i12;
import 'dictionary_example_detail.dart' as _i13;
import 'dictionary_example_text.dart' as _i14;
import 'dictionary_form.dart' as _i15;
import 'dictionary_import_commit_result.dart' as _i16;
import 'dictionary_import_mapping.dart' as _i17;
import 'dictionary_import_preview.dart' as _i18;
import 'dictionary_import_preview_row.dart' as _i19;
import 'dictionary_import_profile.dart' as _i20;
import 'dictionary_import_profile_detail.dart' as _i21;
import 'dictionary_relation.dart' as _i22;
import 'dictionary_relation_detail.dart' as _i23;
import 'entry_knowledge_state.dart' as _i24;
import 'greetings/greeting.dart' as _i25;
import 'knowledge_state_query.dart' as _i26;
import 'knowledge_state_result.dart' as _i27;
import 'subtitle_cue.dart' as _i28;
import 'subtitle_cue_detail.dart' as _i29;
import 'subtitle_cue_text.dart' as _i30;
import 'subtitle_karaoke_segment.dart' as _i31;
import 'subtitle_karaoke_segment_input.dart' as _i32;
import 'subtitle_phrase.dart' as _i33;
import 'subtitle_publish_state.dart' as _i34;
import 'subtitle_publish_status.dart' as _i35;
import 'subtitle_review_dashboard.dart' as _i36;
import 'subtitle_review_event.dart' as _i37;
import 'subtitle_review_queue_item.dart' as _i38;
import 'subtitle_review_task.dart' as _i39;
import 'subtitle_review_task_detail.dart' as _i40;
import 'subtitle_review_task_status.dart' as _i41;
import 'subtitle_srt_preview.dart' as _i42;
import 'subtitle_token.dart' as _i43;
import 'subtitle_track.dart' as _i44;
import 'user_known_entry.dart' as _i45;
import 'video.dart' as _i46;
import 'video_comment_dto.dart' as _i47;
import 'video_comment_row.dart' as _i48;
import 'video_status.dart' as _i49;
import 'word_list.dart' as _i50;
import 'word_list_detail.dart' as _i51;
import 'word_list_item.dart' as _i52;
import 'word_list_item_detail.dart' as _i53;
import 'package:clyven_backend_client/src/protocol/asr_job.dart' as _i54;
import 'package:clyven_backend_client/src/protocol/video.dart' as _i55;
import 'package:clyven_backend_client/src/protocol/subtitle_track.dart' as _i56;
import 'package:clyven_backend_client/src/protocol/dictionary_entry_detail.dart'
    as _i57;
import 'package:clyven_backend_client/src/protocol/dictionary_import_profile.dart'
    as _i58;
import 'package:clyven_backend_client/src/protocol/entry_knowledge_state.dart'
    as _i59;
import 'package:clyven_backend_client/src/protocol/knowledge_state_result.dart'
    as _i60;
import 'package:clyven_backend_client/src/protocol/knowledge_state_query.dart'
    as _i61;
import 'package:clyven_backend_client/src/protocol/subtitle_cue_detail.dart'
    as _i62;
import 'package:clyven_backend_client/src/protocol/subtitle_karaoke_segment.dart'
    as _i63;
import 'package:clyven_backend_client/src/protocol/subtitle_karaoke_segment_input.dart'
    as _i64;
import 'package:clyven_backend_client/src/protocol/word_list.dart' as _i65;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i66;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i67;
export 'asr_job.dart';
export 'asr_job_status.dart';
export 'comment_like.dart';
export 'comment_page_dto.dart';
export 'comment_reply_dto.dart';
export 'comment_reply_like.dart';
export 'comment_reply_row.dart';
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
export 'video_status.dart';
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

    if (t == _i2.AsrJob) {
      return _i2.AsrJob.fromJson(data) as T;
    }
    if (t == _i3.AsrJobStatus) {
      return _i3.AsrJobStatus.fromJson(data) as T;
    }
    if (t == _i4.CommentLike) {
      return _i4.CommentLike.fromJson(data) as T;
    }
    if (t == _i5.CommentPageDto) {
      return _i5.CommentPageDto.fromJson(data) as T;
    }
    if (t == _i6.CommentReplyDto) {
      return _i6.CommentReplyDto.fromJson(data) as T;
    }
    if (t == _i7.CommentReplyLike) {
      return _i7.CommentReplyLike.fromJson(data) as T;
    }
    if (t == _i8.CommentReplyRow) {
      return _i8.CommentReplyRow.fromJson(data) as T;
    }
    if (t == _i9.DictionaryDefinition) {
      return _i9.DictionaryDefinition.fromJson(data) as T;
    }
    if (t == _i10.DictionaryEntry) {
      return _i10.DictionaryEntry.fromJson(data) as T;
    }
    if (t == _i11.DictionaryEntryDetail) {
      return _i11.DictionaryEntryDetail.fromJson(data) as T;
    }
    if (t == _i12.DictionaryExample) {
      return _i12.DictionaryExample.fromJson(data) as T;
    }
    if (t == _i13.DictionaryExampleDetail) {
      return _i13.DictionaryExampleDetail.fromJson(data) as T;
    }
    if (t == _i14.DictionaryExampleText) {
      return _i14.DictionaryExampleText.fromJson(data) as T;
    }
    if (t == _i15.DictionaryForm) {
      return _i15.DictionaryForm.fromJson(data) as T;
    }
    if (t == _i16.DictionaryImportCommitResult) {
      return _i16.DictionaryImportCommitResult.fromJson(data) as T;
    }
    if (t == _i17.DictionaryImportMapping) {
      return _i17.DictionaryImportMapping.fromJson(data) as T;
    }
    if (t == _i18.DictionaryImportPreview) {
      return _i18.DictionaryImportPreview.fromJson(data) as T;
    }
    if (t == _i19.DictionaryImportPreviewRow) {
      return _i19.DictionaryImportPreviewRow.fromJson(data) as T;
    }
    if (t == _i20.DictionaryImportProfile) {
      return _i20.DictionaryImportProfile.fromJson(data) as T;
    }
    if (t == _i21.DictionaryImportProfileDetail) {
      return _i21.DictionaryImportProfileDetail.fromJson(data) as T;
    }
    if (t == _i22.DictionaryRelation) {
      return _i22.DictionaryRelation.fromJson(data) as T;
    }
    if (t == _i23.DictionaryRelationDetail) {
      return _i23.DictionaryRelationDetail.fromJson(data) as T;
    }
    if (t == _i24.EntryKnowledgeState) {
      return _i24.EntryKnowledgeState.fromJson(data) as T;
    }
    if (t == _i25.Greeting) {
      return _i25.Greeting.fromJson(data) as T;
    }
    if (t == _i26.KnowledgeStateQuery) {
      return _i26.KnowledgeStateQuery.fromJson(data) as T;
    }
    if (t == _i27.KnowledgeStateResult) {
      return _i27.KnowledgeStateResult.fromJson(data) as T;
    }
    if (t == _i28.SubtitleCue) {
      return _i28.SubtitleCue.fromJson(data) as T;
    }
    if (t == _i29.SubtitleCueDetail) {
      return _i29.SubtitleCueDetail.fromJson(data) as T;
    }
    if (t == _i30.SubtitleCueText) {
      return _i30.SubtitleCueText.fromJson(data) as T;
    }
    if (t == _i31.SubtitleKaraokeSegment) {
      return _i31.SubtitleKaraokeSegment.fromJson(data) as T;
    }
    if (t == _i32.SubtitleKaraokeSegmentInput) {
      return _i32.SubtitleKaraokeSegmentInput.fromJson(data) as T;
    }
    if (t == _i33.SubtitlePhrase) {
      return _i33.SubtitlePhrase.fromJson(data) as T;
    }
    if (t == _i34.SubtitlePublishState) {
      return _i34.SubtitlePublishState.fromJson(data) as T;
    }
    if (t == _i35.SubtitlePublishStatus) {
      return _i35.SubtitlePublishStatus.fromJson(data) as T;
    }
    if (t == _i36.SubtitleReviewDashboard) {
      return _i36.SubtitleReviewDashboard.fromJson(data) as T;
    }
    if (t == _i37.SubtitleReviewEvent) {
      return _i37.SubtitleReviewEvent.fromJson(data) as T;
    }
    if (t == _i38.SubtitleReviewQueueItem) {
      return _i38.SubtitleReviewQueueItem.fromJson(data) as T;
    }
    if (t == _i39.SubtitleReviewTask) {
      return _i39.SubtitleReviewTask.fromJson(data) as T;
    }
    if (t == _i40.SubtitleReviewTaskDetail) {
      return _i40.SubtitleReviewTaskDetail.fromJson(data) as T;
    }
    if (t == _i41.SubtitleReviewTaskStatus) {
      return _i41.SubtitleReviewTaskStatus.fromJson(data) as T;
    }
    if (t == _i42.SubtitleSrtPreview) {
      return _i42.SubtitleSrtPreview.fromJson(data) as T;
    }
    if (t == _i43.SubtitleToken) {
      return _i43.SubtitleToken.fromJson(data) as T;
    }
    if (t == _i44.SubtitleTrack) {
      return _i44.SubtitleTrack.fromJson(data) as T;
    }
    if (t == _i45.UserKnownEntry) {
      return _i45.UserKnownEntry.fromJson(data) as T;
    }
    if (t == _i46.Video) {
      return _i46.Video.fromJson(data) as T;
    }
    if (t == _i47.VideoCommentDto) {
      return _i47.VideoCommentDto.fromJson(data) as T;
    }
    if (t == _i48.VideoCommentRow) {
      return _i48.VideoCommentRow.fromJson(data) as T;
    }
    if (t == _i49.VideoStatus) {
      return _i49.VideoStatus.fromJson(data) as T;
    }
    if (t == _i50.WordList) {
      return _i50.WordList.fromJson(data) as T;
    }
    if (t == _i51.WordListDetail) {
      return _i51.WordListDetail.fromJson(data) as T;
    }
    if (t == _i52.WordListItem) {
      return _i52.WordListItem.fromJson(data) as T;
    }
    if (t == _i53.WordListItemDetail) {
      return _i53.WordListItemDetail.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AsrJob?>()) {
      return (data != null ? _i2.AsrJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AsrJobStatus?>()) {
      return (data != null ? _i3.AsrJobStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.CommentLike?>()) {
      return (data != null ? _i4.CommentLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.CommentPageDto?>()) {
      return (data != null ? _i5.CommentPageDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.CommentReplyDto?>()) {
      return (data != null ? _i6.CommentReplyDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.CommentReplyLike?>()) {
      return (data != null ? _i7.CommentReplyLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CommentReplyRow?>()) {
      return (data != null ? _i8.CommentReplyRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.DictionaryDefinition?>()) {
      return (data != null ? _i9.DictionaryDefinition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.DictionaryEntry?>()) {
      return (data != null ? _i10.DictionaryEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.DictionaryEntryDetail?>()) {
      return (data != null ? _i11.DictionaryEntryDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.DictionaryExample?>()) {
      return (data != null ? _i12.DictionaryExample.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.DictionaryExampleDetail?>()) {
      return (data != null ? _i13.DictionaryExampleDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.DictionaryExampleText?>()) {
      return (data != null ? _i14.DictionaryExampleText.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.DictionaryForm?>()) {
      return (data != null ? _i15.DictionaryForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.DictionaryImportCommitResult?>()) {
      return (data != null
              ? _i16.DictionaryImportCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i17.DictionaryImportMapping?>()) {
      return (data != null ? _i17.DictionaryImportMapping.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.DictionaryImportPreview?>()) {
      return (data != null ? _i18.DictionaryImportPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.DictionaryImportPreviewRow?>()) {
      return (data != null
              ? _i19.DictionaryImportPreviewRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i20.DictionaryImportProfile?>()) {
      return (data != null ? _i20.DictionaryImportProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.DictionaryImportProfileDetail?>()) {
      return (data != null
              ? _i21.DictionaryImportProfileDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i22.DictionaryRelation?>()) {
      return (data != null ? _i22.DictionaryRelation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.DictionaryRelationDetail?>()) {
      return (data != null
              ? _i23.DictionaryRelationDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i24.EntryKnowledgeState?>()) {
      return (data != null ? _i24.EntryKnowledgeState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.Greeting?>()) {
      return (data != null ? _i25.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.KnowledgeStateQuery?>()) {
      return (data != null ? _i26.KnowledgeStateQuery.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.KnowledgeStateResult?>()) {
      return (data != null ? _i27.KnowledgeStateResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.SubtitleCue?>()) {
      return (data != null ? _i28.SubtitleCue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.SubtitleCueDetail?>()) {
      return (data != null ? _i29.SubtitleCueDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.SubtitleCueText?>()) {
      return (data != null ? _i30.SubtitleCueText.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.SubtitleKaraokeSegment?>()) {
      return (data != null ? _i31.SubtitleKaraokeSegment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.SubtitleKaraokeSegmentInput?>()) {
      return (data != null
              ? _i32.SubtitleKaraokeSegmentInput.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i33.SubtitlePhrase?>()) {
      return (data != null ? _i33.SubtitlePhrase.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.SubtitlePublishState?>()) {
      return (data != null ? _i34.SubtitlePublishState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.SubtitlePublishStatus?>()) {
      return (data != null ? _i35.SubtitlePublishStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i36.SubtitleReviewDashboard?>()) {
      return (data != null ? _i36.SubtitleReviewDashboard.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i37.SubtitleReviewEvent?>()) {
      return (data != null ? _i37.SubtitleReviewEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i38.SubtitleReviewQueueItem?>()) {
      return (data != null ? _i38.SubtitleReviewQueueItem.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.SubtitleReviewTask?>()) {
      return (data != null ? _i39.SubtitleReviewTask.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.SubtitleReviewTaskDetail?>()) {
      return (data != null
              ? _i40.SubtitleReviewTaskDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i41.SubtitleReviewTaskStatus?>()) {
      return (data != null
              ? _i41.SubtitleReviewTaskStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i42.SubtitleSrtPreview?>()) {
      return (data != null ? _i42.SubtitleSrtPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i43.SubtitleToken?>()) {
      return (data != null ? _i43.SubtitleToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.SubtitleTrack?>()) {
      return (data != null ? _i44.SubtitleTrack.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.UserKnownEntry?>()) {
      return (data != null ? _i45.UserKnownEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.Video?>()) {
      return (data != null ? _i46.Video.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.VideoCommentDto?>()) {
      return (data != null ? _i47.VideoCommentDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.VideoCommentRow?>()) {
      return (data != null ? _i48.VideoCommentRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.VideoStatus?>()) {
      return (data != null ? _i49.VideoStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.WordList?>()) {
      return (data != null ? _i50.WordList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.WordListDetail?>()) {
      return (data != null ? _i51.WordListDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.WordListItem?>()) {
      return (data != null ? _i52.WordListItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.WordListItemDetail?>()) {
      return (data != null ? _i53.WordListItemDetail.fromJson(data) : null)
          as T;
    }
    if (t == List<_i47.VideoCommentDto>) {
      return (data as List)
              .map((e) => deserialize<_i47.VideoCommentDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i9.DictionaryDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i9.DictionaryDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i15.DictionaryForm>) {
      return (data as List)
              .map((e) => deserialize<_i15.DictionaryForm>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.DictionaryExampleDetail>) {
      return (data as List)
              .map((e) => deserialize<_i13.DictionaryExampleDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i23.DictionaryRelationDetail>) {
      return (data as List)
              .map((e) => deserialize<_i23.DictionaryRelationDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i14.DictionaryExampleText>) {
      return (data as List)
              .map((e) => deserialize<_i14.DictionaryExampleText>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i19.DictionaryImportPreviewRow>) {
      return (data as List)
              .map((e) => deserialize<_i19.DictionaryImportPreviewRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i17.DictionaryImportMapping>) {
      return (data as List)
              .map((e) => deserialize<_i17.DictionaryImportMapping>(e))
              .toList()
          as T;
    }
    if (t == List<_i30.SubtitleCueText>) {
      return (data as List)
              .map((e) => deserialize<_i30.SubtitleCueText>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i30.SubtitleCueText>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i30.SubtitleCueText>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i43.SubtitleToken>) {
      return (data as List)
              .map((e) => deserialize<_i43.SubtitleToken>(e))
              .toList()
          as T;
    }
    if (t == List<_i33.SubtitlePhrase>) {
      return (data as List)
              .map((e) => deserialize<_i33.SubtitlePhrase>(e))
              .toList()
          as T;
    }
    if (t == List<_i31.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i31.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i31.SubtitleKaraokeSegment>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i31.SubtitleKaraokeSegment>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i38.SubtitleReviewQueueItem>) {
      return (data as List)
              .map((e) => deserialize<_i38.SubtitleReviewQueueItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i37.SubtitleReviewEvent>) {
      return (data as List)
              .map((e) => deserialize<_i37.SubtitleReviewEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_i6.CommentReplyDto>) {
      return (data as List)
              .map((e) => deserialize<_i6.CommentReplyDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i53.WordListItemDetail>) {
      return (data as List)
              .map((e) => deserialize<_i53.WordListItemDetail>(e))
              .toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i54.AsrJob>) {
      return (data as List).map((e) => deserialize<_i54.AsrJob>(e)).toList()
          as T;
    }
    if (t == List<_i55.Video>) {
      return (data as List).map((e) => deserialize<_i55.Video>(e)).toList()
          as T;
    }
    if (t == List<_i56.SubtitleTrack>) {
      return (data as List)
              .map((e) => deserialize<_i56.SubtitleTrack>(e))
              .toList()
          as T;
    }
    if (t == List<_i57.DictionaryEntryDetail>) {
      return (data as List)
              .map((e) => deserialize<_i57.DictionaryEntryDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i58.DictionaryImportProfile>) {
      return (data as List)
              .map((e) => deserialize<_i58.DictionaryImportProfile>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i59.EntryKnowledgeState>) {
      return (data as List)
              .map((e) => deserialize<_i59.EntryKnowledgeState>(e))
              .toList()
          as T;
    }
    if (t == List<_i60.KnowledgeStateResult>) {
      return (data as List)
              .map((e) => deserialize<_i60.KnowledgeStateResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i61.KnowledgeStateQuery>) {
      return (data as List)
              .map((e) => deserialize<_i61.KnowledgeStateQuery>(e))
              .toList()
          as T;
    }
    if (t == List<_i62.SubtitleCueDetail>) {
      return (data as List)
              .map((e) => deserialize<_i62.SubtitleCueDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i63.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i63.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == List<_i64.SubtitleKaraokeSegmentInput>) {
      return (data as List)
              .map((e) => deserialize<_i64.SubtitleKaraokeSegmentInput>(e))
              .toList()
          as T;
    }
    if (t == List<_i65.WordList>) {
      return (data as List).map((e) => deserialize<_i65.WordList>(e)).toList()
          as T;
    }
    try {
      return _i66.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i67.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AsrJob => 'AsrJob',
      _i3.AsrJobStatus => 'AsrJobStatus',
      _i4.CommentLike => 'CommentLike',
      _i5.CommentPageDto => 'CommentPageDto',
      _i6.CommentReplyDto => 'CommentReplyDto',
      _i7.CommentReplyLike => 'CommentReplyLike',
      _i8.CommentReplyRow => 'CommentReplyRow',
      _i9.DictionaryDefinition => 'DictionaryDefinition',
      _i10.DictionaryEntry => 'DictionaryEntry',
      _i11.DictionaryEntryDetail => 'DictionaryEntryDetail',
      _i12.DictionaryExample => 'DictionaryExample',
      _i13.DictionaryExampleDetail => 'DictionaryExampleDetail',
      _i14.DictionaryExampleText => 'DictionaryExampleText',
      _i15.DictionaryForm => 'DictionaryForm',
      _i16.DictionaryImportCommitResult => 'DictionaryImportCommitResult',
      _i17.DictionaryImportMapping => 'DictionaryImportMapping',
      _i18.DictionaryImportPreview => 'DictionaryImportPreview',
      _i19.DictionaryImportPreviewRow => 'DictionaryImportPreviewRow',
      _i20.DictionaryImportProfile => 'DictionaryImportProfile',
      _i21.DictionaryImportProfileDetail => 'DictionaryImportProfileDetail',
      _i22.DictionaryRelation => 'DictionaryRelation',
      _i23.DictionaryRelationDetail => 'DictionaryRelationDetail',
      _i24.EntryKnowledgeState => 'EntryKnowledgeState',
      _i25.Greeting => 'Greeting',
      _i26.KnowledgeStateQuery => 'KnowledgeStateQuery',
      _i27.KnowledgeStateResult => 'KnowledgeStateResult',
      _i28.SubtitleCue => 'SubtitleCue',
      _i29.SubtitleCueDetail => 'SubtitleCueDetail',
      _i30.SubtitleCueText => 'SubtitleCueText',
      _i31.SubtitleKaraokeSegment => 'SubtitleKaraokeSegment',
      _i32.SubtitleKaraokeSegmentInput => 'SubtitleKaraokeSegmentInput',
      _i33.SubtitlePhrase => 'SubtitlePhrase',
      _i34.SubtitlePublishState => 'SubtitlePublishState',
      _i35.SubtitlePublishStatus => 'SubtitlePublishStatus',
      _i36.SubtitleReviewDashboard => 'SubtitleReviewDashboard',
      _i37.SubtitleReviewEvent => 'SubtitleReviewEvent',
      _i38.SubtitleReviewQueueItem => 'SubtitleReviewQueueItem',
      _i39.SubtitleReviewTask => 'SubtitleReviewTask',
      _i40.SubtitleReviewTaskDetail => 'SubtitleReviewTaskDetail',
      _i41.SubtitleReviewTaskStatus => 'SubtitleReviewTaskStatus',
      _i42.SubtitleSrtPreview => 'SubtitleSrtPreview',
      _i43.SubtitleToken => 'SubtitleToken',
      _i44.SubtitleTrack => 'SubtitleTrack',
      _i45.UserKnownEntry => 'UserKnownEntry',
      _i46.Video => 'Video',
      _i47.VideoCommentDto => 'VideoCommentDto',
      _i48.VideoCommentRow => 'VideoCommentRow',
      _i49.VideoStatus => 'VideoStatus',
      _i50.WordList => 'WordList',
      _i51.WordListDetail => 'WordListDetail',
      _i52.WordListItem => 'WordListItem',
      _i53.WordListItemDetail => 'WordListItemDetail',
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
      case _i2.AsrJob():
        return 'AsrJob';
      case _i3.AsrJobStatus():
        return 'AsrJobStatus';
      case _i4.CommentLike():
        return 'CommentLike';
      case _i5.CommentPageDto():
        return 'CommentPageDto';
      case _i6.CommentReplyDto():
        return 'CommentReplyDto';
      case _i7.CommentReplyLike():
        return 'CommentReplyLike';
      case _i8.CommentReplyRow():
        return 'CommentReplyRow';
      case _i9.DictionaryDefinition():
        return 'DictionaryDefinition';
      case _i10.DictionaryEntry():
        return 'DictionaryEntry';
      case _i11.DictionaryEntryDetail():
        return 'DictionaryEntryDetail';
      case _i12.DictionaryExample():
        return 'DictionaryExample';
      case _i13.DictionaryExampleDetail():
        return 'DictionaryExampleDetail';
      case _i14.DictionaryExampleText():
        return 'DictionaryExampleText';
      case _i15.DictionaryForm():
        return 'DictionaryForm';
      case _i16.DictionaryImportCommitResult():
        return 'DictionaryImportCommitResult';
      case _i17.DictionaryImportMapping():
        return 'DictionaryImportMapping';
      case _i18.DictionaryImportPreview():
        return 'DictionaryImportPreview';
      case _i19.DictionaryImportPreviewRow():
        return 'DictionaryImportPreviewRow';
      case _i20.DictionaryImportProfile():
        return 'DictionaryImportProfile';
      case _i21.DictionaryImportProfileDetail():
        return 'DictionaryImportProfileDetail';
      case _i22.DictionaryRelation():
        return 'DictionaryRelation';
      case _i23.DictionaryRelationDetail():
        return 'DictionaryRelationDetail';
      case _i24.EntryKnowledgeState():
        return 'EntryKnowledgeState';
      case _i25.Greeting():
        return 'Greeting';
      case _i26.KnowledgeStateQuery():
        return 'KnowledgeStateQuery';
      case _i27.KnowledgeStateResult():
        return 'KnowledgeStateResult';
      case _i28.SubtitleCue():
        return 'SubtitleCue';
      case _i29.SubtitleCueDetail():
        return 'SubtitleCueDetail';
      case _i30.SubtitleCueText():
        return 'SubtitleCueText';
      case _i31.SubtitleKaraokeSegment():
        return 'SubtitleKaraokeSegment';
      case _i32.SubtitleKaraokeSegmentInput():
        return 'SubtitleKaraokeSegmentInput';
      case _i33.SubtitlePhrase():
        return 'SubtitlePhrase';
      case _i34.SubtitlePublishState():
        return 'SubtitlePublishState';
      case _i35.SubtitlePublishStatus():
        return 'SubtitlePublishStatus';
      case _i36.SubtitleReviewDashboard():
        return 'SubtitleReviewDashboard';
      case _i37.SubtitleReviewEvent():
        return 'SubtitleReviewEvent';
      case _i38.SubtitleReviewQueueItem():
        return 'SubtitleReviewQueueItem';
      case _i39.SubtitleReviewTask():
        return 'SubtitleReviewTask';
      case _i40.SubtitleReviewTaskDetail():
        return 'SubtitleReviewTaskDetail';
      case _i41.SubtitleReviewTaskStatus():
        return 'SubtitleReviewTaskStatus';
      case _i42.SubtitleSrtPreview():
        return 'SubtitleSrtPreview';
      case _i43.SubtitleToken():
        return 'SubtitleToken';
      case _i44.SubtitleTrack():
        return 'SubtitleTrack';
      case _i45.UserKnownEntry():
        return 'UserKnownEntry';
      case _i46.Video():
        return 'Video';
      case _i47.VideoCommentDto():
        return 'VideoCommentDto';
      case _i48.VideoCommentRow():
        return 'VideoCommentRow';
      case _i49.VideoStatus():
        return 'VideoStatus';
      case _i50.WordList():
        return 'WordList';
      case _i51.WordListDetail():
        return 'WordListDetail';
      case _i52.WordListItem():
        return 'WordListItem';
      case _i53.WordListItemDetail():
        return 'WordListItemDetail';
    }
    className = _i66.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i67.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'AsrJob') {
      return deserialize<_i2.AsrJob>(data['data']);
    }
    if (dataClassName == 'AsrJobStatus') {
      return deserialize<_i3.AsrJobStatus>(data['data']);
    }
    if (dataClassName == 'CommentLike') {
      return deserialize<_i4.CommentLike>(data['data']);
    }
    if (dataClassName == 'CommentPageDto') {
      return deserialize<_i5.CommentPageDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyDto') {
      return deserialize<_i6.CommentReplyDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyLike') {
      return deserialize<_i7.CommentReplyLike>(data['data']);
    }
    if (dataClassName == 'CommentReplyRow') {
      return deserialize<_i8.CommentReplyRow>(data['data']);
    }
    if (dataClassName == 'DictionaryDefinition') {
      return deserialize<_i9.DictionaryDefinition>(data['data']);
    }
    if (dataClassName == 'DictionaryEntry') {
      return deserialize<_i10.DictionaryEntry>(data['data']);
    }
    if (dataClassName == 'DictionaryEntryDetail') {
      return deserialize<_i11.DictionaryEntryDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExample') {
      return deserialize<_i12.DictionaryExample>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleDetail') {
      return deserialize<_i13.DictionaryExampleDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleText') {
      return deserialize<_i14.DictionaryExampleText>(data['data']);
    }
    if (dataClassName == 'DictionaryForm') {
      return deserialize<_i15.DictionaryForm>(data['data']);
    }
    if (dataClassName == 'DictionaryImportCommitResult') {
      return deserialize<_i16.DictionaryImportCommitResult>(data['data']);
    }
    if (dataClassName == 'DictionaryImportMapping') {
      return deserialize<_i17.DictionaryImportMapping>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreview') {
      return deserialize<_i18.DictionaryImportPreview>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreviewRow') {
      return deserialize<_i19.DictionaryImportPreviewRow>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfile') {
      return deserialize<_i20.DictionaryImportProfile>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfileDetail') {
      return deserialize<_i21.DictionaryImportProfileDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryRelation') {
      return deserialize<_i22.DictionaryRelation>(data['data']);
    }
    if (dataClassName == 'DictionaryRelationDetail') {
      return deserialize<_i23.DictionaryRelationDetail>(data['data']);
    }
    if (dataClassName == 'EntryKnowledgeState') {
      return deserialize<_i24.EntryKnowledgeState>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i25.Greeting>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateQuery') {
      return deserialize<_i26.KnowledgeStateQuery>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateResult') {
      return deserialize<_i27.KnowledgeStateResult>(data['data']);
    }
    if (dataClassName == 'SubtitleCue') {
      return deserialize<_i28.SubtitleCue>(data['data']);
    }
    if (dataClassName == 'SubtitleCueDetail') {
      return deserialize<_i29.SubtitleCueDetail>(data['data']);
    }
    if (dataClassName == 'SubtitleCueText') {
      return deserialize<_i30.SubtitleCueText>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegment') {
      return deserialize<_i31.SubtitleKaraokeSegment>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegmentInput') {
      return deserialize<_i32.SubtitleKaraokeSegmentInput>(data['data']);
    }
    if (dataClassName == 'SubtitlePhrase') {
      return deserialize<_i33.SubtitlePhrase>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishState') {
      return deserialize<_i34.SubtitlePublishState>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishStatus') {
      return deserialize<_i35.SubtitlePublishStatus>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewDashboard') {
      return deserialize<_i36.SubtitleReviewDashboard>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewEvent') {
      return deserialize<_i37.SubtitleReviewEvent>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewQueueItem') {
      return deserialize<_i38.SubtitleReviewQueueItem>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTask') {
      return deserialize<_i39.SubtitleReviewTask>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTaskDetail') {
      return deserialize<_i40.SubtitleReviewTaskDetail>(data['data']);
    }
    if (dataClassName == 'SubtitleReviewTaskStatus') {
      return deserialize<_i41.SubtitleReviewTaskStatus>(data['data']);
    }
    if (dataClassName == 'SubtitleSrtPreview') {
      return deserialize<_i42.SubtitleSrtPreview>(data['data']);
    }
    if (dataClassName == 'SubtitleToken') {
      return deserialize<_i43.SubtitleToken>(data['data']);
    }
    if (dataClassName == 'SubtitleTrack') {
      return deserialize<_i44.SubtitleTrack>(data['data']);
    }
    if (dataClassName == 'UserKnownEntry') {
      return deserialize<_i45.UserKnownEntry>(data['data']);
    }
    if (dataClassName == 'Video') {
      return deserialize<_i46.Video>(data['data']);
    }
    if (dataClassName == 'VideoCommentDto') {
      return deserialize<_i47.VideoCommentDto>(data['data']);
    }
    if (dataClassName == 'VideoCommentRow') {
      return deserialize<_i48.VideoCommentRow>(data['data']);
    }
    if (dataClassName == 'VideoStatus') {
      return deserialize<_i49.VideoStatus>(data['data']);
    }
    if (dataClassName == 'WordList') {
      return deserialize<_i50.WordList>(data['data']);
    }
    if (dataClassName == 'WordListDetail') {
      return deserialize<_i51.WordListDetail>(data['data']);
    }
    if (dataClassName == 'WordListItem') {
      return deserialize<_i52.WordListItem>(data['data']);
    }
    if (dataClassName == 'WordListItemDetail') {
      return deserialize<_i53.WordListItemDetail>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i66.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i67.Protocol().deserializeByClassName(data);
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
      return _i66.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i67.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
