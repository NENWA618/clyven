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

abstract class SubtitleSearchResult implements _i1.SerializableModel {
  SubtitleSearchResult._({
    required this.videoId,
    required this.videoTitle,
    required this.authorName,
    required this.languageCode,
    this.cueId,
    required this.startMs,
    required this.endMs,
    required this.text,
  });

  factory SubtitleSearchResult({
    required int videoId,
    required String videoTitle,
    required String authorName,
    required String languageCode,
    int? cueId,
    required int startMs,
    required int endMs,
    required String text,
  }) = _SubtitleSearchResultImpl;

  factory SubtitleSearchResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SubtitleSearchResult(
      videoId: jsonSerialization['videoId'] as int,
      videoTitle: jsonSerialization['videoTitle'] as String,
      authorName: jsonSerialization['authorName'] as String,
      languageCode: jsonSerialization['languageCode'] as String,
      cueId: jsonSerialization['cueId'] as int?,
      startMs: jsonSerialization['startMs'] as int,
      endMs: jsonSerialization['endMs'] as int,
      text: jsonSerialization['text'] as String,
    );
  }

  int videoId;

  String videoTitle;

  String authorName;

  String languageCode;

  int? cueId;

  int startMs;

  int endMs;

  String text;

  /// Returns a shallow copy of this [SubtitleSearchResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleSearchResult copyWith({
    int? videoId,
    String? videoTitle,
    String? authorName,
    String? languageCode,
    int? cueId,
    int? startMs,
    int? endMs,
    String? text,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleSearchResult',
      'videoId': videoId,
      'videoTitle': videoTitle,
      'authorName': authorName,
      'languageCode': languageCode,
      if (cueId != null) 'cueId': cueId,
      'startMs': startMs,
      'endMs': endMs,
      'text': text,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtitleSearchResultImpl extends SubtitleSearchResult {
  _SubtitleSearchResultImpl({
    required int videoId,
    required String videoTitle,
    required String authorName,
    required String languageCode,
    int? cueId,
    required int startMs,
    required int endMs,
    required String text,
  }) : super._(
         videoId: videoId,
         videoTitle: videoTitle,
         authorName: authorName,
         languageCode: languageCode,
         cueId: cueId,
         startMs: startMs,
         endMs: endMs,
         text: text,
       );

  /// Returns a shallow copy of this [SubtitleSearchResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleSearchResult copyWith({
    int? videoId,
    String? videoTitle,
    String? authorName,
    String? languageCode,
    Object? cueId = _Undefined,
    int? startMs,
    int? endMs,
    String? text,
  }) {
    return SubtitleSearchResult(
      videoId: videoId ?? this.videoId,
      videoTitle: videoTitle ?? this.videoTitle,
      authorName: authorName ?? this.authorName,
      languageCode: languageCode ?? this.languageCode,
      cueId: cueId is int? ? cueId : this.cueId,
      startMs: startMs ?? this.startMs,
      endMs: endMs ?? this.endMs,
      text: text ?? this.text,
    );
  }
}
