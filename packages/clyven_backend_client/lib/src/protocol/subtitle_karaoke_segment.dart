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

abstract class SubtitleKaraokeSegment implements _i1.SerializableModel {
  SubtitleKaraokeSegment._({
    this.id,
    required this.cueId,
    this.scriptCode,
    required this.position,
    required this.startOffsetMs,
    required this.endOffsetMs,
    required this.text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubtitleKaraokeSegment({
    int? id,
    required int cueId,
    String? scriptCode,
    required int position,
    required int startOffsetMs,
    required int endOffsetMs,
    required String text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubtitleKaraokeSegmentImpl;

  factory SubtitleKaraokeSegment.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SubtitleKaraokeSegment(
      id: jsonSerialization['id'] as int?,
      cueId: jsonSerialization['cueId'] as int,
      scriptCode: jsonSerialization['scriptCode'] as String?,
      position: jsonSerialization['position'] as int,
      startOffsetMs: jsonSerialization['startOffsetMs'] as int,
      endOffsetMs: jsonSerialization['endOffsetMs'] as int,
      text: jsonSerialization['text'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int cueId;

  String? scriptCode;

  int position;

  int startOffsetMs;

  int endOffsetMs;

  String text;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [SubtitleKaraokeSegment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleKaraokeSegment copyWith({
    int? id,
    int? cueId,
    String? scriptCode,
    int? position,
    int? startOffsetMs,
    int? endOffsetMs,
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleKaraokeSegment',
      if (id != null) 'id': id,
      'cueId': cueId,
      if (scriptCode != null) 'scriptCode': scriptCode,
      'position': position,
      'startOffsetMs': startOffsetMs,
      'endOffsetMs': endOffsetMs,
      'text': text,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtitleKaraokeSegmentImpl extends SubtitleKaraokeSegment {
  _SubtitleKaraokeSegmentImpl({
    int? id,
    required int cueId,
    String? scriptCode,
    required int position,
    required int startOffsetMs,
    required int endOffsetMs,
    required String text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         cueId: cueId,
         scriptCode: scriptCode,
         position: position,
         startOffsetMs: startOffsetMs,
         endOffsetMs: endOffsetMs,
         text: text,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubtitleKaraokeSegment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleKaraokeSegment copyWith({
    Object? id = _Undefined,
    int? cueId,
    Object? scriptCode = _Undefined,
    int? position,
    int? startOffsetMs,
    int? endOffsetMs,
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubtitleKaraokeSegment(
      id: id is int? ? id : this.id,
      cueId: cueId ?? this.cueId,
      scriptCode: scriptCode is String? ? scriptCode : this.scriptCode,
      position: position ?? this.position,
      startOffsetMs: startOffsetMs ?? this.startOffsetMs,
      endOffsetMs: endOffsetMs ?? this.endOffsetMs,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
