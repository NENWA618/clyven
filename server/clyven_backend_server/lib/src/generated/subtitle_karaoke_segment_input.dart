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

abstract class SubtitleKaraokeSegmentInput
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SubtitleKaraokeSegmentInput._({
    required this.startOffsetMs,
    required this.endOffsetMs,
    required this.text,
  });

  factory SubtitleKaraokeSegmentInput({
    required int startOffsetMs,
    required int endOffsetMs,
    required String text,
  }) = _SubtitleKaraokeSegmentInputImpl;

  factory SubtitleKaraokeSegmentInput.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SubtitleKaraokeSegmentInput(
      startOffsetMs: jsonSerialization['startOffsetMs'] as int,
      endOffsetMs: jsonSerialization['endOffsetMs'] as int,
      text: jsonSerialization['text'] as String,
    );
  }

  int startOffsetMs;

  int endOffsetMs;

  String text;

  /// Returns a shallow copy of this [SubtitleKaraokeSegmentInput]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleKaraokeSegmentInput copyWith({
    int? startOffsetMs,
    int? endOffsetMs,
    String? text,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleKaraokeSegmentInput',
      'startOffsetMs': startOffsetMs,
      'endOffsetMs': endOffsetMs,
      'text': text,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubtitleKaraokeSegmentInput',
      'startOffsetMs': startOffsetMs,
      'endOffsetMs': endOffsetMs,
      'text': text,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SubtitleKaraokeSegmentInputImpl extends SubtitleKaraokeSegmentInput {
  _SubtitleKaraokeSegmentInputImpl({
    required int startOffsetMs,
    required int endOffsetMs,
    required String text,
  }) : super._(
         startOffsetMs: startOffsetMs,
         endOffsetMs: endOffsetMs,
         text: text,
       );

  /// Returns a shallow copy of this [SubtitleKaraokeSegmentInput]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleKaraokeSegmentInput copyWith({
    int? startOffsetMs,
    int? endOffsetMs,
    String? text,
  }) {
    return SubtitleKaraokeSegmentInput(
      startOffsetMs: startOffsetMs ?? this.startOffsetMs,
      endOffsetMs: endOffsetMs ?? this.endOffsetMs,
      text: text ?? this.text,
    );
  }
}
