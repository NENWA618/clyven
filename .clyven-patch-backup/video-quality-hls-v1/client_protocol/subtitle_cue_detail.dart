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
import 'subtitle_cue.dart' as _i2;
import 'subtitle_cue_text.dart' as _i3;
import 'subtitle_token.dart' as _i4;
import 'subtitle_phrase.dart' as _i5;
import 'subtitle_karaoke_segment.dart' as _i6;
import 'package:clyven_backend_client/src/protocol/protocol.dart' as _i7;

abstract class SubtitleCueDetail implements _i1.SerializableModel {
  SubtitleCueDetail._({
    required this.cue,
    this.texts,
    required this.tokens,
    required this.phrases,
    this.karaokeSegments,
  });

  factory SubtitleCueDetail({
    required _i2.SubtitleCue cue,
    List<_i3.SubtitleCueText>? texts,
    required List<_i4.SubtitleToken> tokens,
    required List<_i5.SubtitlePhrase> phrases,
    List<_i6.SubtitleKaraokeSegment>? karaokeSegments,
  }) = _SubtitleCueDetailImpl;

  factory SubtitleCueDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtitleCueDetail(
      cue: _i7.Protocol().deserialize<_i2.SubtitleCue>(
        jsonSerialization['cue'],
      ),
      texts: jsonSerialization['texts'] == null
          ? null
          : _i7.Protocol().deserialize<List<_i3.SubtitleCueText>>(
              jsonSerialization['texts'],
            ),
      tokens: _i7.Protocol().deserialize<List<_i4.SubtitleToken>>(
        jsonSerialization['tokens'],
      ),
      phrases: _i7.Protocol().deserialize<List<_i5.SubtitlePhrase>>(
        jsonSerialization['phrases'],
      ),
      karaokeSegments: jsonSerialization['karaokeSegments'] == null
          ? null
          : _i7.Protocol().deserialize<List<_i6.SubtitleKaraokeSegment>>(
              jsonSerialization['karaokeSegments'],
            ),
    );
  }

  _i2.SubtitleCue cue;

  List<_i3.SubtitleCueText>? texts;

  List<_i4.SubtitleToken> tokens;

  List<_i5.SubtitlePhrase> phrases;

  List<_i6.SubtitleKaraokeSegment>? karaokeSegments;

  /// Returns a shallow copy of this [SubtitleCueDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleCueDetail copyWith({
    _i2.SubtitleCue? cue,
    List<_i3.SubtitleCueText>? texts,
    List<_i4.SubtitleToken>? tokens,
    List<_i5.SubtitlePhrase>? phrases,
    List<_i6.SubtitleKaraokeSegment>? karaokeSegments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleCueDetail',
      'cue': cue.toJson(),
      if (texts != null) 'texts': texts?.toJson(valueToJson: (v) => v.toJson()),
      'tokens': tokens.toJson(valueToJson: (v) => v.toJson()),
      'phrases': phrases.toJson(valueToJson: (v) => v.toJson()),
      if (karaokeSegments != null)
        'karaokeSegments': karaokeSegments?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtitleCueDetailImpl extends SubtitleCueDetail {
  _SubtitleCueDetailImpl({
    required _i2.SubtitleCue cue,
    List<_i3.SubtitleCueText>? texts,
    required List<_i4.SubtitleToken> tokens,
    required List<_i5.SubtitlePhrase> phrases,
    List<_i6.SubtitleKaraokeSegment>? karaokeSegments,
  }) : super._(
         cue: cue,
         texts: texts,
         tokens: tokens,
         phrases: phrases,
         karaokeSegments: karaokeSegments,
       );

  /// Returns a shallow copy of this [SubtitleCueDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleCueDetail copyWith({
    _i2.SubtitleCue? cue,
    Object? texts = _Undefined,
    List<_i4.SubtitleToken>? tokens,
    List<_i5.SubtitlePhrase>? phrases,
    Object? karaokeSegments = _Undefined,
  }) {
    return SubtitleCueDetail(
      cue: cue ?? this.cue.copyWith(),
      texts: texts is List<_i3.SubtitleCueText>?
          ? texts
          : this.texts?.map((e0) => e0.copyWith()).toList(),
      tokens: tokens ?? this.tokens.map((e0) => e0.copyWith()).toList(),
      phrases: phrases ?? this.phrases.map((e0) => e0.copyWith()).toList(),
      karaokeSegments: karaokeSegments is List<_i6.SubtitleKaraokeSegment>?
          ? karaokeSegments
          : this.karaokeSegments?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
