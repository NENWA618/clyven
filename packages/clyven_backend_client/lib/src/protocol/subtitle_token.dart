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

abstract class SubtitleToken implements _i1.SerializableModel {
  SubtitleToken._({
    this.id,
    required this.cueId,
    this.scriptCode,
    required this.text,
    this.normalizedText,
    this.entryId,
    this.startMs,
    this.endMs,
    required this.position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubtitleToken({
    int? id,
    required int cueId,
    String? scriptCode,
    required String text,
    String? normalizedText,
    int? entryId,
    int? startMs,
    int? endMs,
    required int position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubtitleTokenImpl;

  factory SubtitleToken.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtitleToken(
      id: jsonSerialization['id'] as int?,
      cueId: jsonSerialization['cueId'] as int,
      scriptCode: jsonSerialization['scriptCode'] as String?,
      text: jsonSerialization['text'] as String,
      normalizedText: jsonSerialization['normalizedText'] as String?,
      entryId: jsonSerialization['entryId'] as int?,
      startMs: jsonSerialization['startMs'] as int?,
      endMs: jsonSerialization['endMs'] as int?,
      position: jsonSerialization['position'] as int,
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

  String text;

  String? normalizedText;

  int? entryId;

  int? startMs;

  int? endMs;

  int position;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [SubtitleToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleToken copyWith({
    int? id,
    int? cueId,
    String? scriptCode,
    String? text,
    String? normalizedText,
    int? entryId,
    int? startMs,
    int? endMs,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleToken',
      if (id != null) 'id': id,
      'cueId': cueId,
      if (scriptCode != null) 'scriptCode': scriptCode,
      'text': text,
      if (normalizedText != null) 'normalizedText': normalizedText,
      if (entryId != null) 'entryId': entryId,
      if (startMs != null) 'startMs': startMs,
      if (endMs != null) 'endMs': endMs,
      'position': position,
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

class _SubtitleTokenImpl extends SubtitleToken {
  _SubtitleTokenImpl({
    int? id,
    required int cueId,
    String? scriptCode,
    required String text,
    String? normalizedText,
    int? entryId,
    int? startMs,
    int? endMs,
    required int position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         cueId: cueId,
         scriptCode: scriptCode,
         text: text,
         normalizedText: normalizedText,
         entryId: entryId,
         startMs: startMs,
         endMs: endMs,
         position: position,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubtitleToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleToken copyWith({
    Object? id = _Undefined,
    int? cueId,
    Object? scriptCode = _Undefined,
    String? text,
    Object? normalizedText = _Undefined,
    Object? entryId = _Undefined,
    Object? startMs = _Undefined,
    Object? endMs = _Undefined,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubtitleToken(
      id: id is int? ? id : this.id,
      cueId: cueId ?? this.cueId,
      scriptCode: scriptCode is String? ? scriptCode : this.scriptCode,
      text: text ?? this.text,
      normalizedText: normalizedText is String?
          ? normalizedText
          : this.normalizedText,
      entryId: entryId is int? ? entryId : this.entryId,
      startMs: startMs is int? ? startMs : this.startMs,
      endMs: endMs is int? ? endMs : this.endMs,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
