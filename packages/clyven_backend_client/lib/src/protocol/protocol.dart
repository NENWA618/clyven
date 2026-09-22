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
import 'comment_like.dart' as _i2;
import 'comment_page_dto.dart' as _i3;
import 'comment_reply_dto.dart' as _i4;
import 'comment_reply_like.dart' as _i5;
import 'comment_reply_row.dart' as _i6;
import 'dictionary_definition.dart' as _i7;
import 'dictionary_entry.dart' as _i8;
import 'dictionary_entry_detail.dart' as _i9;
import 'dictionary_example.dart' as _i10;
import 'dictionary_example_detail.dart' as _i11;
import 'dictionary_example_text.dart' as _i12;
import 'dictionary_form.dart' as _i13;
import 'dictionary_import_commit_result.dart' as _i14;
import 'dictionary_import_mapping.dart' as _i15;
import 'dictionary_import_preview.dart' as _i16;
import 'dictionary_import_preview_row.dart' as _i17;
import 'dictionary_import_profile.dart' as _i18;
import 'dictionary_import_profile_detail.dart' as _i19;
import 'dictionary_relation.dart' as _i20;
import 'dictionary_relation_detail.dart' as _i21;
import 'entry_knowledge_state.dart' as _i22;
import 'greetings/greeting.dart' as _i23;
import 'knowledge_state_query.dart' as _i24;
import 'knowledge_state_result.dart' as _i25;
import 'subtitle_cue.dart' as _i26;
import 'subtitle_cue_detail.dart' as _i27;
import 'subtitle_cue_text.dart' as _i28;
import 'subtitle_karaoke_segment.dart' as _i29;
import 'subtitle_karaoke_segment_input.dart' as _i30;
import 'subtitle_phrase.dart' as _i31;
import 'subtitle_publish_state.dart' as _i32;
import 'subtitle_publish_status.dart' as _i33;
import 'subtitle_srt_preview.dart' as _i34;
import 'subtitle_token.dart' as _i35;
import 'subtitle_track.dart' as _i36;
import 'user_known_entry.dart' as _i37;
import 'video.dart' as _i38;
import 'video_comment_dto.dart' as _i39;
import 'video_comment_row.dart' as _i40;
import 'video_status.dart' as _i41;
import 'word_list.dart' as _i42;
import 'word_list_detail.dart' as _i43;
import 'word_list_item.dart' as _i44;
import 'word_list_item_detail.dart' as _i45;
import 'package:clyven_backend_client/src/protocol/video.dart' as _i46;
import 'package:clyven_backend_client/src/protocol/subtitle_track.dart' as _i47;
import 'package:clyven_backend_client/src/protocol/dictionary_entry_detail.dart'
    as _i48;
import 'package:clyven_backend_client/src/protocol/dictionary_import_profile.dart'
    as _i49;
import 'package:clyven_backend_client/src/protocol/entry_knowledge_state.dart'
    as _i50;
import 'package:clyven_backend_client/src/protocol/knowledge_state_result.dart'
    as _i51;
import 'package:clyven_backend_client/src/protocol/knowledge_state_query.dart'
    as _i52;
import 'package:clyven_backend_client/src/protocol/subtitle_cue_detail.dart'
    as _i53;
import 'package:clyven_backend_client/src/protocol/subtitle_karaoke_segment.dart'
    as _i54;
import 'package:clyven_backend_client/src/protocol/subtitle_karaoke_segment_input.dart'
    as _i55;
import 'package:clyven_backend_client/src/protocol/word_list.dart' as _i56;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i57;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i58;
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

    if (t == _i2.CommentLike) {
      return _i2.CommentLike.fromJson(data) as T;
    }
    if (t == _i3.CommentPageDto) {
      return _i3.CommentPageDto.fromJson(data) as T;
    }
    if (t == _i4.CommentReplyDto) {
      return _i4.CommentReplyDto.fromJson(data) as T;
    }
    if (t == _i5.CommentReplyLike) {
      return _i5.CommentReplyLike.fromJson(data) as T;
    }
    if (t == _i6.CommentReplyRow) {
      return _i6.CommentReplyRow.fromJson(data) as T;
    }
    if (t == _i7.DictionaryDefinition) {
      return _i7.DictionaryDefinition.fromJson(data) as T;
    }
    if (t == _i8.DictionaryEntry) {
      return _i8.DictionaryEntry.fromJson(data) as T;
    }
    if (t == _i9.DictionaryEntryDetail) {
      return _i9.DictionaryEntryDetail.fromJson(data) as T;
    }
    if (t == _i10.DictionaryExample) {
      return _i10.DictionaryExample.fromJson(data) as T;
    }
    if (t == _i11.DictionaryExampleDetail) {
      return _i11.DictionaryExampleDetail.fromJson(data) as T;
    }
    if (t == _i12.DictionaryExampleText) {
      return _i12.DictionaryExampleText.fromJson(data) as T;
    }
    if (t == _i13.DictionaryForm) {
      return _i13.DictionaryForm.fromJson(data) as T;
    }
    if (t == _i14.DictionaryImportCommitResult) {
      return _i14.DictionaryImportCommitResult.fromJson(data) as T;
    }
    if (t == _i15.DictionaryImportMapping) {
      return _i15.DictionaryImportMapping.fromJson(data) as T;
    }
    if (t == _i16.DictionaryImportPreview) {
      return _i16.DictionaryImportPreview.fromJson(data) as T;
    }
    if (t == _i17.DictionaryImportPreviewRow) {
      return _i17.DictionaryImportPreviewRow.fromJson(data) as T;
    }
    if (t == _i18.DictionaryImportProfile) {
      return _i18.DictionaryImportProfile.fromJson(data) as T;
    }
    if (t == _i19.DictionaryImportProfileDetail) {
      return _i19.DictionaryImportProfileDetail.fromJson(data) as T;
    }
    if (t == _i20.DictionaryRelation) {
      return _i20.DictionaryRelation.fromJson(data) as T;
    }
    if (t == _i21.DictionaryRelationDetail) {
      return _i21.DictionaryRelationDetail.fromJson(data) as T;
    }
    if (t == _i22.EntryKnowledgeState) {
      return _i22.EntryKnowledgeState.fromJson(data) as T;
    }
    if (t == _i23.Greeting) {
      return _i23.Greeting.fromJson(data) as T;
    }
    if (t == _i24.KnowledgeStateQuery) {
      return _i24.KnowledgeStateQuery.fromJson(data) as T;
    }
    if (t == _i25.KnowledgeStateResult) {
      return _i25.KnowledgeStateResult.fromJson(data) as T;
    }
    if (t == _i26.SubtitleCue) {
      return _i26.SubtitleCue.fromJson(data) as T;
    }
    if (t == _i27.SubtitleCueDetail) {
      return _i27.SubtitleCueDetail.fromJson(data) as T;
    }
    if (t == _i28.SubtitleCueText) {
      return _i28.SubtitleCueText.fromJson(data) as T;
    }
    if (t == _i29.SubtitleKaraokeSegment) {
      return _i29.SubtitleKaraokeSegment.fromJson(data) as T;
    }
    if (t == _i30.SubtitleKaraokeSegmentInput) {
      return _i30.SubtitleKaraokeSegmentInput.fromJson(data) as T;
    }
    if (t == _i31.SubtitlePhrase) {
      return _i31.SubtitlePhrase.fromJson(data) as T;
    }
    if (t == _i32.SubtitlePublishState) {
      return _i32.SubtitlePublishState.fromJson(data) as T;
    }
    if (t == _i33.SubtitlePublishStatus) {
      return _i33.SubtitlePublishStatus.fromJson(data) as T;
    }
    if (t == _i34.SubtitleSrtPreview) {
      return _i34.SubtitleSrtPreview.fromJson(data) as T;
    }
    if (t == _i35.SubtitleToken) {
      return _i35.SubtitleToken.fromJson(data) as T;
    }
    if (t == _i36.SubtitleTrack) {
      return _i36.SubtitleTrack.fromJson(data) as T;
    }
    if (t == _i37.UserKnownEntry) {
      return _i37.UserKnownEntry.fromJson(data) as T;
    }
    if (t == _i38.Video) {
      return _i38.Video.fromJson(data) as T;
    }
    if (t == _i39.VideoCommentDto) {
      return _i39.VideoCommentDto.fromJson(data) as T;
    }
    if (t == _i40.VideoCommentRow) {
      return _i40.VideoCommentRow.fromJson(data) as T;
    }
    if (t == _i41.VideoStatus) {
      return _i41.VideoStatus.fromJson(data) as T;
    }
    if (t == _i42.WordList) {
      return _i42.WordList.fromJson(data) as T;
    }
    if (t == _i43.WordListDetail) {
      return _i43.WordListDetail.fromJson(data) as T;
    }
    if (t == _i44.WordListItem) {
      return _i44.WordListItem.fromJson(data) as T;
    }
    if (t == _i45.WordListItemDetail) {
      return _i45.WordListItemDetail.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.CommentLike?>()) {
      return (data != null ? _i2.CommentLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.CommentPageDto?>()) {
      return (data != null ? _i3.CommentPageDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.CommentReplyDto?>()) {
      return (data != null ? _i4.CommentReplyDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.CommentReplyLike?>()) {
      return (data != null ? _i5.CommentReplyLike.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.CommentReplyRow?>()) {
      return (data != null ? _i6.CommentReplyRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.DictionaryDefinition?>()) {
      return (data != null ? _i7.DictionaryDefinition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.DictionaryEntry?>()) {
      return (data != null ? _i8.DictionaryEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.DictionaryEntryDetail?>()) {
      return (data != null ? _i9.DictionaryEntryDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.DictionaryExample?>()) {
      return (data != null ? _i10.DictionaryExample.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.DictionaryExampleDetail?>()) {
      return (data != null ? _i11.DictionaryExampleDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.DictionaryExampleText?>()) {
      return (data != null ? _i12.DictionaryExampleText.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.DictionaryForm?>()) {
      return (data != null ? _i13.DictionaryForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.DictionaryImportCommitResult?>()) {
      return (data != null
              ? _i14.DictionaryImportCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i15.DictionaryImportMapping?>()) {
      return (data != null ? _i15.DictionaryImportMapping.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.DictionaryImportPreview?>()) {
      return (data != null ? _i16.DictionaryImportPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.DictionaryImportPreviewRow?>()) {
      return (data != null
              ? _i17.DictionaryImportPreviewRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i18.DictionaryImportProfile?>()) {
      return (data != null ? _i18.DictionaryImportProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.DictionaryImportProfileDetail?>()) {
      return (data != null
              ? _i19.DictionaryImportProfileDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i20.DictionaryRelation?>()) {
      return (data != null ? _i20.DictionaryRelation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.DictionaryRelationDetail?>()) {
      return (data != null
              ? _i21.DictionaryRelationDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i22.EntryKnowledgeState?>()) {
      return (data != null ? _i22.EntryKnowledgeState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.Greeting?>()) {
      return (data != null ? _i23.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.KnowledgeStateQuery?>()) {
      return (data != null ? _i24.KnowledgeStateQuery.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.KnowledgeStateResult?>()) {
      return (data != null ? _i25.KnowledgeStateResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.SubtitleCue?>()) {
      return (data != null ? _i26.SubtitleCue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.SubtitleCueDetail?>()) {
      return (data != null ? _i27.SubtitleCueDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.SubtitleCueText?>()) {
      return (data != null ? _i28.SubtitleCueText.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.SubtitleKaraokeSegment?>()) {
      return (data != null ? _i29.SubtitleKaraokeSegment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i30.SubtitleKaraokeSegmentInput?>()) {
      return (data != null
              ? _i30.SubtitleKaraokeSegmentInput.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i31.SubtitlePhrase?>()) {
      return (data != null ? _i31.SubtitlePhrase.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.SubtitlePublishState?>()) {
      return (data != null ? _i32.SubtitlePublishState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.SubtitlePublishStatus?>()) {
      return (data != null ? _i33.SubtitlePublishStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i34.SubtitleSrtPreview?>()) {
      return (data != null ? _i34.SubtitleSrtPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.SubtitleToken?>()) {
      return (data != null ? _i35.SubtitleToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.SubtitleTrack?>()) {
      return (data != null ? _i36.SubtitleTrack.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.UserKnownEntry?>()) {
      return (data != null ? _i37.UserKnownEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.Video?>()) {
      return (data != null ? _i38.Video.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.VideoCommentDto?>()) {
      return (data != null ? _i39.VideoCommentDto.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.VideoCommentRow?>()) {
      return (data != null ? _i40.VideoCommentRow.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.VideoStatus?>()) {
      return (data != null ? _i41.VideoStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.WordList?>()) {
      return (data != null ? _i42.WordList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.WordListDetail?>()) {
      return (data != null ? _i43.WordListDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.WordListItem?>()) {
      return (data != null ? _i44.WordListItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.WordListItemDetail?>()) {
      return (data != null ? _i45.WordListItemDetail.fromJson(data) : null)
          as T;
    }
    if (t == List<_i39.VideoCommentDto>) {
      return (data as List)
              .map((e) => deserialize<_i39.VideoCommentDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i7.DictionaryDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i7.DictionaryDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.DictionaryForm>) {
      return (data as List)
              .map((e) => deserialize<_i13.DictionaryForm>(e))
              .toList()
          as T;
    }
    if (t == List<_i11.DictionaryExampleDetail>) {
      return (data as List)
              .map((e) => deserialize<_i11.DictionaryExampleDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.DictionaryRelationDetail>) {
      return (data as List)
              .map((e) => deserialize<_i21.DictionaryRelationDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i12.DictionaryExampleText>) {
      return (data as List)
              .map((e) => deserialize<_i12.DictionaryExampleText>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i17.DictionaryImportPreviewRow>) {
      return (data as List)
              .map((e) => deserialize<_i17.DictionaryImportPreviewRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i15.DictionaryImportMapping>) {
      return (data as List)
              .map((e) => deserialize<_i15.DictionaryImportMapping>(e))
              .toList()
          as T;
    }
    if (t == List<_i28.SubtitleCueText>) {
      return (data as List)
              .map((e) => deserialize<_i28.SubtitleCueText>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i28.SubtitleCueText>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i28.SubtitleCueText>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i35.SubtitleToken>) {
      return (data as List)
              .map((e) => deserialize<_i35.SubtitleToken>(e))
              .toList()
          as T;
    }
    if (t == List<_i31.SubtitlePhrase>) {
      return (data as List)
              .map((e) => deserialize<_i31.SubtitlePhrase>(e))
              .toList()
          as T;
    }
    if (t == List<_i29.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i29.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i29.SubtitleKaraokeSegment>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i29.SubtitleKaraokeSegment>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i4.CommentReplyDto>) {
      return (data as List)
              .map((e) => deserialize<_i4.CommentReplyDto>(e))
              .toList()
          as T;
    }
    if (t == List<_i45.WordListItemDetail>) {
      return (data as List)
              .map((e) => deserialize<_i45.WordListItemDetail>(e))
              .toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i46.Video>) {
      return (data as List).map((e) => deserialize<_i46.Video>(e)).toList()
          as T;
    }
    if (t == List<_i47.SubtitleTrack>) {
      return (data as List)
              .map((e) => deserialize<_i47.SubtitleTrack>(e))
              .toList()
          as T;
    }
    if (t == List<_i48.DictionaryEntryDetail>) {
      return (data as List)
              .map((e) => deserialize<_i48.DictionaryEntryDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i49.DictionaryImportProfile>) {
      return (data as List)
              .map((e) => deserialize<_i49.DictionaryImportProfile>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i50.EntryKnowledgeState>) {
      return (data as List)
              .map((e) => deserialize<_i50.EntryKnowledgeState>(e))
              .toList()
          as T;
    }
    if (t == List<_i51.KnowledgeStateResult>) {
      return (data as List)
              .map((e) => deserialize<_i51.KnowledgeStateResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i52.KnowledgeStateQuery>) {
      return (data as List)
              .map((e) => deserialize<_i52.KnowledgeStateQuery>(e))
              .toList()
          as T;
    }
    if (t == List<_i53.SubtitleCueDetail>) {
      return (data as List)
              .map((e) => deserialize<_i53.SubtitleCueDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i54.SubtitleKaraokeSegment>) {
      return (data as List)
              .map((e) => deserialize<_i54.SubtitleKaraokeSegment>(e))
              .toList()
          as T;
    }
    if (t == List<_i55.SubtitleKaraokeSegmentInput>) {
      return (data as List)
              .map((e) => deserialize<_i55.SubtitleKaraokeSegmentInput>(e))
              .toList()
          as T;
    }
    if (t == List<_i56.WordList>) {
      return (data as List).map((e) => deserialize<_i56.WordList>(e)).toList()
          as T;
    }
    try {
      return _i57.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i58.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.CommentLike => 'CommentLike',
      _i3.CommentPageDto => 'CommentPageDto',
      _i4.CommentReplyDto => 'CommentReplyDto',
      _i5.CommentReplyLike => 'CommentReplyLike',
      _i6.CommentReplyRow => 'CommentReplyRow',
      _i7.DictionaryDefinition => 'DictionaryDefinition',
      _i8.DictionaryEntry => 'DictionaryEntry',
      _i9.DictionaryEntryDetail => 'DictionaryEntryDetail',
      _i10.DictionaryExample => 'DictionaryExample',
      _i11.DictionaryExampleDetail => 'DictionaryExampleDetail',
      _i12.DictionaryExampleText => 'DictionaryExampleText',
      _i13.DictionaryForm => 'DictionaryForm',
      _i14.DictionaryImportCommitResult => 'DictionaryImportCommitResult',
      _i15.DictionaryImportMapping => 'DictionaryImportMapping',
      _i16.DictionaryImportPreview => 'DictionaryImportPreview',
      _i17.DictionaryImportPreviewRow => 'DictionaryImportPreviewRow',
      _i18.DictionaryImportProfile => 'DictionaryImportProfile',
      _i19.DictionaryImportProfileDetail => 'DictionaryImportProfileDetail',
      _i20.DictionaryRelation => 'DictionaryRelation',
      _i21.DictionaryRelationDetail => 'DictionaryRelationDetail',
      _i22.EntryKnowledgeState => 'EntryKnowledgeState',
      _i23.Greeting => 'Greeting',
      _i24.KnowledgeStateQuery => 'KnowledgeStateQuery',
      _i25.KnowledgeStateResult => 'KnowledgeStateResult',
      _i26.SubtitleCue => 'SubtitleCue',
      _i27.SubtitleCueDetail => 'SubtitleCueDetail',
      _i28.SubtitleCueText => 'SubtitleCueText',
      _i29.SubtitleKaraokeSegment => 'SubtitleKaraokeSegment',
      _i30.SubtitleKaraokeSegmentInput => 'SubtitleKaraokeSegmentInput',
      _i31.SubtitlePhrase => 'SubtitlePhrase',
      _i32.SubtitlePublishState => 'SubtitlePublishState',
      _i33.SubtitlePublishStatus => 'SubtitlePublishStatus',
      _i34.SubtitleSrtPreview => 'SubtitleSrtPreview',
      _i35.SubtitleToken => 'SubtitleToken',
      _i36.SubtitleTrack => 'SubtitleTrack',
      _i37.UserKnownEntry => 'UserKnownEntry',
      _i38.Video => 'Video',
      _i39.VideoCommentDto => 'VideoCommentDto',
      _i40.VideoCommentRow => 'VideoCommentRow',
      _i41.VideoStatus => 'VideoStatus',
      _i42.WordList => 'WordList',
      _i43.WordListDetail => 'WordListDetail',
      _i44.WordListItem => 'WordListItem',
      _i45.WordListItemDetail => 'WordListItemDetail',
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
      case _i2.CommentLike():
        return 'CommentLike';
      case _i3.CommentPageDto():
        return 'CommentPageDto';
      case _i4.CommentReplyDto():
        return 'CommentReplyDto';
      case _i5.CommentReplyLike():
        return 'CommentReplyLike';
      case _i6.CommentReplyRow():
        return 'CommentReplyRow';
      case _i7.DictionaryDefinition():
        return 'DictionaryDefinition';
      case _i8.DictionaryEntry():
        return 'DictionaryEntry';
      case _i9.DictionaryEntryDetail():
        return 'DictionaryEntryDetail';
      case _i10.DictionaryExample():
        return 'DictionaryExample';
      case _i11.DictionaryExampleDetail():
        return 'DictionaryExampleDetail';
      case _i12.DictionaryExampleText():
        return 'DictionaryExampleText';
      case _i13.DictionaryForm():
        return 'DictionaryForm';
      case _i14.DictionaryImportCommitResult():
        return 'DictionaryImportCommitResult';
      case _i15.DictionaryImportMapping():
        return 'DictionaryImportMapping';
      case _i16.DictionaryImportPreview():
        return 'DictionaryImportPreview';
      case _i17.DictionaryImportPreviewRow():
        return 'DictionaryImportPreviewRow';
      case _i18.DictionaryImportProfile():
        return 'DictionaryImportProfile';
      case _i19.DictionaryImportProfileDetail():
        return 'DictionaryImportProfileDetail';
      case _i20.DictionaryRelation():
        return 'DictionaryRelation';
      case _i21.DictionaryRelationDetail():
        return 'DictionaryRelationDetail';
      case _i22.EntryKnowledgeState():
        return 'EntryKnowledgeState';
      case _i23.Greeting():
        return 'Greeting';
      case _i24.KnowledgeStateQuery():
        return 'KnowledgeStateQuery';
      case _i25.KnowledgeStateResult():
        return 'KnowledgeStateResult';
      case _i26.SubtitleCue():
        return 'SubtitleCue';
      case _i27.SubtitleCueDetail():
        return 'SubtitleCueDetail';
      case _i28.SubtitleCueText():
        return 'SubtitleCueText';
      case _i29.SubtitleKaraokeSegment():
        return 'SubtitleKaraokeSegment';
      case _i30.SubtitleKaraokeSegmentInput():
        return 'SubtitleKaraokeSegmentInput';
      case _i31.SubtitlePhrase():
        return 'SubtitlePhrase';
      case _i32.SubtitlePublishState():
        return 'SubtitlePublishState';
      case _i33.SubtitlePublishStatus():
        return 'SubtitlePublishStatus';
      case _i34.SubtitleSrtPreview():
        return 'SubtitleSrtPreview';
      case _i35.SubtitleToken():
        return 'SubtitleToken';
      case _i36.SubtitleTrack():
        return 'SubtitleTrack';
      case _i37.UserKnownEntry():
        return 'UserKnownEntry';
      case _i38.Video():
        return 'Video';
      case _i39.VideoCommentDto():
        return 'VideoCommentDto';
      case _i40.VideoCommentRow():
        return 'VideoCommentRow';
      case _i41.VideoStatus():
        return 'VideoStatus';
      case _i42.WordList():
        return 'WordList';
      case _i43.WordListDetail():
        return 'WordListDetail';
      case _i44.WordListItem():
        return 'WordListItem';
      case _i45.WordListItemDetail():
        return 'WordListItemDetail';
    }
    className = _i57.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i58.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'CommentLike') {
      return deserialize<_i2.CommentLike>(data['data']);
    }
    if (dataClassName == 'CommentPageDto') {
      return deserialize<_i3.CommentPageDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyDto') {
      return deserialize<_i4.CommentReplyDto>(data['data']);
    }
    if (dataClassName == 'CommentReplyLike') {
      return deserialize<_i5.CommentReplyLike>(data['data']);
    }
    if (dataClassName == 'CommentReplyRow') {
      return deserialize<_i6.CommentReplyRow>(data['data']);
    }
    if (dataClassName == 'DictionaryDefinition') {
      return deserialize<_i7.DictionaryDefinition>(data['data']);
    }
    if (dataClassName == 'DictionaryEntry') {
      return deserialize<_i8.DictionaryEntry>(data['data']);
    }
    if (dataClassName == 'DictionaryEntryDetail') {
      return deserialize<_i9.DictionaryEntryDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExample') {
      return deserialize<_i10.DictionaryExample>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleDetail') {
      return deserialize<_i11.DictionaryExampleDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleText') {
      return deserialize<_i12.DictionaryExampleText>(data['data']);
    }
    if (dataClassName == 'DictionaryForm') {
      return deserialize<_i13.DictionaryForm>(data['data']);
    }
    if (dataClassName == 'DictionaryImportCommitResult') {
      return deserialize<_i14.DictionaryImportCommitResult>(data['data']);
    }
    if (dataClassName == 'DictionaryImportMapping') {
      return deserialize<_i15.DictionaryImportMapping>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreview') {
      return deserialize<_i16.DictionaryImportPreview>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreviewRow') {
      return deserialize<_i17.DictionaryImportPreviewRow>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfile') {
      return deserialize<_i18.DictionaryImportProfile>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfileDetail') {
      return deserialize<_i19.DictionaryImportProfileDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryRelation') {
      return deserialize<_i20.DictionaryRelation>(data['data']);
    }
    if (dataClassName == 'DictionaryRelationDetail') {
      return deserialize<_i21.DictionaryRelationDetail>(data['data']);
    }
    if (dataClassName == 'EntryKnowledgeState') {
      return deserialize<_i22.EntryKnowledgeState>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i23.Greeting>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateQuery') {
      return deserialize<_i24.KnowledgeStateQuery>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateResult') {
      return deserialize<_i25.KnowledgeStateResult>(data['data']);
    }
    if (dataClassName == 'SubtitleCue') {
      return deserialize<_i26.SubtitleCue>(data['data']);
    }
    if (dataClassName == 'SubtitleCueDetail') {
      return deserialize<_i27.SubtitleCueDetail>(data['data']);
    }
    if (dataClassName == 'SubtitleCueText') {
      return deserialize<_i28.SubtitleCueText>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegment') {
      return deserialize<_i29.SubtitleKaraokeSegment>(data['data']);
    }
    if (dataClassName == 'SubtitleKaraokeSegmentInput') {
      return deserialize<_i30.SubtitleKaraokeSegmentInput>(data['data']);
    }
    if (dataClassName == 'SubtitlePhrase') {
      return deserialize<_i31.SubtitlePhrase>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishState') {
      return deserialize<_i32.SubtitlePublishState>(data['data']);
    }
    if (dataClassName == 'SubtitlePublishStatus') {
      return deserialize<_i33.SubtitlePublishStatus>(data['data']);
    }
    if (dataClassName == 'SubtitleSrtPreview') {
      return deserialize<_i34.SubtitleSrtPreview>(data['data']);
    }
    if (dataClassName == 'SubtitleToken') {
      return deserialize<_i35.SubtitleToken>(data['data']);
    }
    if (dataClassName == 'SubtitleTrack') {
      return deserialize<_i36.SubtitleTrack>(data['data']);
    }
    if (dataClassName == 'UserKnownEntry') {
      return deserialize<_i37.UserKnownEntry>(data['data']);
    }
    if (dataClassName == 'Video') {
      return deserialize<_i38.Video>(data['data']);
    }
    if (dataClassName == 'VideoCommentDto') {
      return deserialize<_i39.VideoCommentDto>(data['data']);
    }
    if (dataClassName == 'VideoCommentRow') {
      return deserialize<_i40.VideoCommentRow>(data['data']);
    }
    if (dataClassName == 'VideoStatus') {
      return deserialize<_i41.VideoStatus>(data['data']);
    }
    if (dataClassName == 'WordList') {
      return deserialize<_i42.WordList>(data['data']);
    }
    if (dataClassName == 'WordListDetail') {
      return deserialize<_i43.WordListDetail>(data['data']);
    }
    if (dataClassName == 'WordListItem') {
      return deserialize<_i44.WordListItem>(data['data']);
    }
    if (dataClassName == 'WordListItemDetail') {
      return deserialize<_i45.WordListItemDetail>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i57.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i58.Protocol().deserializeByClassName(data);
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
      return _i57.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i58.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
