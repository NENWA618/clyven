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
import 'dictionary_definition.dart' as _i2;
import 'dictionary_entry.dart' as _i3;
import 'dictionary_entry_detail.dart' as _i4;
import 'dictionary_example.dart' as _i5;
import 'dictionary_example_text.dart' as _i6;
import 'dictionary_form.dart' as _i7;
import 'dictionary_import_commit_result.dart' as _i8;
import 'dictionary_import_mapping.dart' as _i9;
import 'dictionary_import_preview.dart' as _i10;
import 'dictionary_import_preview_row.dart' as _i11;
import 'dictionary_import_profile.dart' as _i12;
import 'dictionary_import_profile_detail.dart' as _i13;
import 'dictionary_relation.dart' as _i14;
import 'dictionary_relation_detail.dart' as _i15;
import 'greetings/greeting.dart' as _i16;
import 'knowledge_state_query.dart' as _i17;
import 'knowledge_state_result.dart' as _i18;
import 'subtitle_cue.dart' as _i19;
import 'subtitle_cue_detail.dart' as _i20;
import 'subtitle_phrase.dart' as _i21;
import 'subtitle_token.dart' as _i22;
import 'subtitle_track.dart' as _i23;
import 'user_known_entry.dart' as _i24;
import 'video.dart' as _i25;
import 'video_status.dart' as _i26;
import 'word_list.dart' as _i27;
import 'word_list_detail.dart' as _i28;
import 'word_list_item.dart' as _i29;
import 'word_list_item_detail.dart' as _i30;
import 'package:clyven_backend_client/src/protocol/dictionary_import_profile.dart'
    as _i31;
import 'package:clyven_backend_client/src/protocol/knowledge_state_result.dart'
    as _i32;
import 'package:clyven_backend_client/src/protocol/knowledge_state_query.dart'
    as _i33;
import 'package:clyven_backend_client/src/protocol/subtitle_cue_detail.dart'
    as _i34;
import 'package:clyven_backend_client/src/protocol/video.dart' as _i35;
import 'package:clyven_backend_client/src/protocol/word_list.dart' as _i36;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i37;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i38;
export 'dictionary_definition.dart';
export 'dictionary_entry.dart';
export 'dictionary_entry_detail.dart';
export 'dictionary_example.dart';
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
export 'greetings/greeting.dart';
export 'knowledge_state_query.dart';
export 'knowledge_state_result.dart';
export 'subtitle_cue.dart';
export 'subtitle_cue_detail.dart';
export 'subtitle_phrase.dart';
export 'subtitle_token.dart';
export 'subtitle_track.dart';
export 'user_known_entry.dart';
export 'video.dart';
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

    if (t == _i2.DictionaryDefinition) {
      return _i2.DictionaryDefinition.fromJson(data) as T;
    }
    if (t == _i3.DictionaryEntry) {
      return _i3.DictionaryEntry.fromJson(data) as T;
    }
    if (t == _i4.DictionaryEntryDetail) {
      return _i4.DictionaryEntryDetail.fromJson(data) as T;
    }
    if (t == _i5.DictionaryExample) {
      return _i5.DictionaryExample.fromJson(data) as T;
    }
    if (t == _i6.DictionaryExampleText) {
      return _i6.DictionaryExampleText.fromJson(data) as T;
    }
    if (t == _i7.DictionaryForm) {
      return _i7.DictionaryForm.fromJson(data) as T;
    }
    if (t == _i8.DictionaryImportCommitResult) {
      return _i8.DictionaryImportCommitResult.fromJson(data) as T;
    }
    if (t == _i9.DictionaryImportMapping) {
      return _i9.DictionaryImportMapping.fromJson(data) as T;
    }
    if (t == _i10.DictionaryImportPreview) {
      return _i10.DictionaryImportPreview.fromJson(data) as T;
    }
    if (t == _i11.DictionaryImportPreviewRow) {
      return _i11.DictionaryImportPreviewRow.fromJson(data) as T;
    }
    if (t == _i12.DictionaryImportProfile) {
      return _i12.DictionaryImportProfile.fromJson(data) as T;
    }
    if (t == _i13.DictionaryImportProfileDetail) {
      return _i13.DictionaryImportProfileDetail.fromJson(data) as T;
    }
    if (t == _i14.DictionaryRelation) {
      return _i14.DictionaryRelation.fromJson(data) as T;
    }
    if (t == _i15.DictionaryRelationDetail) {
      return _i15.DictionaryRelationDetail.fromJson(data) as T;
    }
    if (t == _i16.Greeting) {
      return _i16.Greeting.fromJson(data) as T;
    }
    if (t == _i17.KnowledgeStateQuery) {
      return _i17.KnowledgeStateQuery.fromJson(data) as T;
    }
    if (t == _i18.KnowledgeStateResult) {
      return _i18.KnowledgeStateResult.fromJson(data) as T;
    }
    if (t == _i19.SubtitleCue) {
      return _i19.SubtitleCue.fromJson(data) as T;
    }
    if (t == _i20.SubtitleCueDetail) {
      return _i20.SubtitleCueDetail.fromJson(data) as T;
    }
    if (t == _i21.SubtitlePhrase) {
      return _i21.SubtitlePhrase.fromJson(data) as T;
    }
    if (t == _i22.SubtitleToken) {
      return _i22.SubtitleToken.fromJson(data) as T;
    }
    if (t == _i23.SubtitleTrack) {
      return _i23.SubtitleTrack.fromJson(data) as T;
    }
    if (t == _i24.UserKnownEntry) {
      return _i24.UserKnownEntry.fromJson(data) as T;
    }
    if (t == _i25.Video) {
      return _i25.Video.fromJson(data) as T;
    }
    if (t == _i26.VideoStatus) {
      return _i26.VideoStatus.fromJson(data) as T;
    }
    if (t == _i27.WordList) {
      return _i27.WordList.fromJson(data) as T;
    }
    if (t == _i28.WordListDetail) {
      return _i28.WordListDetail.fromJson(data) as T;
    }
    if (t == _i29.WordListItem) {
      return _i29.WordListItem.fromJson(data) as T;
    }
    if (t == _i30.WordListItemDetail) {
      return _i30.WordListItemDetail.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.DictionaryDefinition?>()) {
      return (data != null ? _i2.DictionaryDefinition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i3.DictionaryEntry?>()) {
      return (data != null ? _i3.DictionaryEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.DictionaryEntryDetail?>()) {
      return (data != null ? _i4.DictionaryEntryDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i5.DictionaryExample?>()) {
      return (data != null ? _i5.DictionaryExample.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.DictionaryExampleText?>()) {
      return (data != null ? _i6.DictionaryExampleText.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.DictionaryForm?>()) {
      return (data != null ? _i7.DictionaryForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.DictionaryImportCommitResult?>()) {
      return (data != null
              ? _i8.DictionaryImportCommitResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i9.DictionaryImportMapping?>()) {
      return (data != null ? _i9.DictionaryImportMapping.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.DictionaryImportPreview?>()) {
      return (data != null ? _i10.DictionaryImportPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.DictionaryImportPreviewRow?>()) {
      return (data != null
              ? _i11.DictionaryImportPreviewRow.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i12.DictionaryImportProfile?>()) {
      return (data != null ? _i12.DictionaryImportProfile.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.DictionaryImportProfileDetail?>()) {
      return (data != null
              ? _i13.DictionaryImportProfileDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i14.DictionaryRelation?>()) {
      return (data != null ? _i14.DictionaryRelation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.DictionaryRelationDetail?>()) {
      return (data != null
              ? _i15.DictionaryRelationDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i16.Greeting?>()) {
      return (data != null ? _i16.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.KnowledgeStateQuery?>()) {
      return (data != null ? _i17.KnowledgeStateQuery.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.KnowledgeStateResult?>()) {
      return (data != null ? _i18.KnowledgeStateResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.SubtitleCue?>()) {
      return (data != null ? _i19.SubtitleCue.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.SubtitleCueDetail?>()) {
      return (data != null ? _i20.SubtitleCueDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.SubtitlePhrase?>()) {
      return (data != null ? _i21.SubtitlePhrase.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.SubtitleToken?>()) {
      return (data != null ? _i22.SubtitleToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.SubtitleTrack?>()) {
      return (data != null ? _i23.SubtitleTrack.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.UserKnownEntry?>()) {
      return (data != null ? _i24.UserKnownEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.Video?>()) {
      return (data != null ? _i25.Video.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.VideoStatus?>()) {
      return (data != null ? _i26.VideoStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.WordList?>()) {
      return (data != null ? _i27.WordList.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.WordListDetail?>()) {
      return (data != null ? _i28.WordListDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.WordListItem?>()) {
      return (data != null ? _i29.WordListItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.WordListItemDetail?>()) {
      return (data != null ? _i30.WordListItemDetail.fromJson(data) : null)
          as T;
    }
    if (t == List<_i2.DictionaryDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i2.DictionaryDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i15.DictionaryRelationDetail>) {
      return (data as List)
              .map((e) => deserialize<_i15.DictionaryRelationDetail>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i11.DictionaryImportPreviewRow>) {
      return (data as List)
              .map((e) => deserialize<_i11.DictionaryImportPreviewRow>(e))
              .toList()
          as T;
    }
    if (t == List<_i9.DictionaryImportMapping>) {
      return (data as List)
              .map((e) => deserialize<_i9.DictionaryImportMapping>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.SubtitleToken>) {
      return (data as List)
              .map((e) => deserialize<_i22.SubtitleToken>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.SubtitlePhrase>) {
      return (data as List)
              .map((e) => deserialize<_i21.SubtitlePhrase>(e))
              .toList()
          as T;
    }
    if (t == List<_i30.WordListItemDetail>) {
      return (data as List)
              .map((e) => deserialize<_i30.WordListItemDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i31.DictionaryImportProfile>) {
      return (data as List)
              .map((e) => deserialize<_i31.DictionaryImportProfile>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i32.KnowledgeStateResult>) {
      return (data as List)
              .map((e) => deserialize<_i32.KnowledgeStateResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i33.KnowledgeStateQuery>) {
      return (data as List)
              .map((e) => deserialize<_i33.KnowledgeStateQuery>(e))
              .toList()
          as T;
    }
    if (t == List<_i34.SubtitleCueDetail>) {
      return (data as List)
              .map((e) => deserialize<_i34.SubtitleCueDetail>(e))
              .toList()
          as T;
    }
    if (t == List<_i35.Video>) {
      return (data as List).map((e) => deserialize<_i35.Video>(e)).toList()
          as T;
    }
    if (t == List<_i36.WordList>) {
      return (data as List).map((e) => deserialize<_i36.WordList>(e)).toList()
          as T;
    }
    try {
      return _i37.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i38.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.DictionaryDefinition => 'DictionaryDefinition',
      _i3.DictionaryEntry => 'DictionaryEntry',
      _i4.DictionaryEntryDetail => 'DictionaryEntryDetail',
      _i5.DictionaryExample => 'DictionaryExample',
      _i6.DictionaryExampleText => 'DictionaryExampleText',
      _i7.DictionaryForm => 'DictionaryForm',
      _i8.DictionaryImportCommitResult => 'DictionaryImportCommitResult',
      _i9.DictionaryImportMapping => 'DictionaryImportMapping',
      _i10.DictionaryImportPreview => 'DictionaryImportPreview',
      _i11.DictionaryImportPreviewRow => 'DictionaryImportPreviewRow',
      _i12.DictionaryImportProfile => 'DictionaryImportProfile',
      _i13.DictionaryImportProfileDetail => 'DictionaryImportProfileDetail',
      _i14.DictionaryRelation => 'DictionaryRelation',
      _i15.DictionaryRelationDetail => 'DictionaryRelationDetail',
      _i16.Greeting => 'Greeting',
      _i17.KnowledgeStateQuery => 'KnowledgeStateQuery',
      _i18.KnowledgeStateResult => 'KnowledgeStateResult',
      _i19.SubtitleCue => 'SubtitleCue',
      _i20.SubtitleCueDetail => 'SubtitleCueDetail',
      _i21.SubtitlePhrase => 'SubtitlePhrase',
      _i22.SubtitleToken => 'SubtitleToken',
      _i23.SubtitleTrack => 'SubtitleTrack',
      _i24.UserKnownEntry => 'UserKnownEntry',
      _i25.Video => 'Video',
      _i26.VideoStatus => 'VideoStatus',
      _i27.WordList => 'WordList',
      _i28.WordListDetail => 'WordListDetail',
      _i29.WordListItem => 'WordListItem',
      _i30.WordListItemDetail => 'WordListItemDetail',
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
      case _i2.DictionaryDefinition():
        return 'DictionaryDefinition';
      case _i3.DictionaryEntry():
        return 'DictionaryEntry';
      case _i4.DictionaryEntryDetail():
        return 'DictionaryEntryDetail';
      case _i5.DictionaryExample():
        return 'DictionaryExample';
      case _i6.DictionaryExampleText():
        return 'DictionaryExampleText';
      case _i7.DictionaryForm():
        return 'DictionaryForm';
      case _i8.DictionaryImportCommitResult():
        return 'DictionaryImportCommitResult';
      case _i9.DictionaryImportMapping():
        return 'DictionaryImportMapping';
      case _i10.DictionaryImportPreview():
        return 'DictionaryImportPreview';
      case _i11.DictionaryImportPreviewRow():
        return 'DictionaryImportPreviewRow';
      case _i12.DictionaryImportProfile():
        return 'DictionaryImportProfile';
      case _i13.DictionaryImportProfileDetail():
        return 'DictionaryImportProfileDetail';
      case _i14.DictionaryRelation():
        return 'DictionaryRelation';
      case _i15.DictionaryRelationDetail():
        return 'DictionaryRelationDetail';
      case _i16.Greeting():
        return 'Greeting';
      case _i17.KnowledgeStateQuery():
        return 'KnowledgeStateQuery';
      case _i18.KnowledgeStateResult():
        return 'KnowledgeStateResult';
      case _i19.SubtitleCue():
        return 'SubtitleCue';
      case _i20.SubtitleCueDetail():
        return 'SubtitleCueDetail';
      case _i21.SubtitlePhrase():
        return 'SubtitlePhrase';
      case _i22.SubtitleToken():
        return 'SubtitleToken';
      case _i23.SubtitleTrack():
        return 'SubtitleTrack';
      case _i24.UserKnownEntry():
        return 'UserKnownEntry';
      case _i25.Video():
        return 'Video';
      case _i26.VideoStatus():
        return 'VideoStatus';
      case _i27.WordList():
        return 'WordList';
      case _i28.WordListDetail():
        return 'WordListDetail';
      case _i29.WordListItem():
        return 'WordListItem';
      case _i30.WordListItemDetail():
        return 'WordListItemDetail';
    }
    className = _i37.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i38.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'DictionaryDefinition') {
      return deserialize<_i2.DictionaryDefinition>(data['data']);
    }
    if (dataClassName == 'DictionaryEntry') {
      return deserialize<_i3.DictionaryEntry>(data['data']);
    }
    if (dataClassName == 'DictionaryEntryDetail') {
      return deserialize<_i4.DictionaryEntryDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryExample') {
      return deserialize<_i5.DictionaryExample>(data['data']);
    }
    if (dataClassName == 'DictionaryExampleText') {
      return deserialize<_i6.DictionaryExampleText>(data['data']);
    }
    if (dataClassName == 'DictionaryForm') {
      return deserialize<_i7.DictionaryForm>(data['data']);
    }
    if (dataClassName == 'DictionaryImportCommitResult') {
      return deserialize<_i8.DictionaryImportCommitResult>(data['data']);
    }
    if (dataClassName == 'DictionaryImportMapping') {
      return deserialize<_i9.DictionaryImportMapping>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreview') {
      return deserialize<_i10.DictionaryImportPreview>(data['data']);
    }
    if (dataClassName == 'DictionaryImportPreviewRow') {
      return deserialize<_i11.DictionaryImportPreviewRow>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfile') {
      return deserialize<_i12.DictionaryImportProfile>(data['data']);
    }
    if (dataClassName == 'DictionaryImportProfileDetail') {
      return deserialize<_i13.DictionaryImportProfileDetail>(data['data']);
    }
    if (dataClassName == 'DictionaryRelation') {
      return deserialize<_i14.DictionaryRelation>(data['data']);
    }
    if (dataClassName == 'DictionaryRelationDetail') {
      return deserialize<_i15.DictionaryRelationDetail>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i16.Greeting>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateQuery') {
      return deserialize<_i17.KnowledgeStateQuery>(data['data']);
    }
    if (dataClassName == 'KnowledgeStateResult') {
      return deserialize<_i18.KnowledgeStateResult>(data['data']);
    }
    if (dataClassName == 'SubtitleCue') {
      return deserialize<_i19.SubtitleCue>(data['data']);
    }
    if (dataClassName == 'SubtitleCueDetail') {
      return deserialize<_i20.SubtitleCueDetail>(data['data']);
    }
    if (dataClassName == 'SubtitlePhrase') {
      return deserialize<_i21.SubtitlePhrase>(data['data']);
    }
    if (dataClassName == 'SubtitleToken') {
      return deserialize<_i22.SubtitleToken>(data['data']);
    }
    if (dataClassName == 'SubtitleTrack') {
      return deserialize<_i23.SubtitleTrack>(data['data']);
    }
    if (dataClassName == 'UserKnownEntry') {
      return deserialize<_i24.UserKnownEntry>(data['data']);
    }
    if (dataClassName == 'Video') {
      return deserialize<_i25.Video>(data['data']);
    }
    if (dataClassName == 'VideoStatus') {
      return deserialize<_i26.VideoStatus>(data['data']);
    }
    if (dataClassName == 'WordList') {
      return deserialize<_i27.WordList>(data['data']);
    }
    if (dataClassName == 'WordListDetail') {
      return deserialize<_i28.WordListDetail>(data['data']);
    }
    if (dataClassName == 'WordListItem') {
      return deserialize<_i29.WordListItem>(data['data']);
    }
    if (dataClassName == 'WordListItemDetail') {
      return deserialize<_i30.WordListItemDetail>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i37.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i38.Protocol().deserializeByClassName(data);
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
      return _i37.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i38.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
