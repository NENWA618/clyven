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
import 'subtitle_token.dart' as _i3;
import 'subtitle_phrase.dart' as _i4;
import 'package:clyven_backend_client/src/protocol/protocol.dart' as _i5;

abstract class SubtitleCueDetail implements _i1.SerializableModel {
  SubtitleCueDetail._({
    required this.cue,
    required this.tokens,
    required this.phrases,
  });

  factory SubtitleCueDetail({
    required _i2.SubtitleCue cue,
    required List<_i3.SubtitleToken> tokens,
    required List<_i4.SubtitlePhrase> phrases,
  }) = _SubtitleCueDetailImpl;

  factory SubtitleCueDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtitleCueDetail(
      cue: _i5.Protocol().deserialize<_i2.SubtitleCue>(
        jsonSerialization['cue'],
      ),
      tokens: _i5.Protocol().deserialize<List<_i3.SubtitleToken>>(
        jsonSerialization['tokens'],
      ),
      phrases: _i5.Protocol().deserialize<List<_i4.SubtitlePhrase>>(
        jsonSerialization['phrases'],
      ),
    );
  }

  _i2.SubtitleCue cue;

  List<_i3.SubtitleToken> tokens;

  List<_i4.SubtitlePhrase> phrases;

  /// Returns a shallow copy of this [SubtitleCueDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleCueDetail copyWith({
    _i2.SubtitleCue? cue,
    List<_i3.SubtitleToken>? tokens,
    List<_i4.SubtitlePhrase>? phrases,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleCueDetail',
      'cue': cue.toJson(),
      'tokens': tokens.toJson(valueToJson: (v) => v.toJson()),
      'phrases': phrases.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SubtitleCueDetailImpl extends SubtitleCueDetail {
  _SubtitleCueDetailImpl({
    required _i2.SubtitleCue cue,
    required List<_i3.SubtitleToken> tokens,
    required List<_i4.SubtitlePhrase> phrases,
  }) : super._(
         cue: cue,
         tokens: tokens,
         phrases: phrases,
       );

  /// Returns a shallow copy of this [SubtitleCueDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleCueDetail copyWith({
    _i2.SubtitleCue? cue,
    List<_i3.SubtitleToken>? tokens,
    List<_i4.SubtitlePhrase>? phrases,
  }) {
    return SubtitleCueDetail(
      cue: cue ?? this.cue.copyWith(),
      tokens: tokens ?? this.tokens.map((e0) => e0.copyWith()).toList(),
      phrases: phrases ?? this.phrases.map((e0) => e0.copyWith()).toList(),
    );
  }
}
