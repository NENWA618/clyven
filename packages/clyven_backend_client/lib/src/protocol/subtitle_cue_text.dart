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

abstract class SubtitleCueText implements _i1.SerializableModel {
  SubtitleCueText._({
    this.id,
    required this.cueId,
    required this.scriptCode,
    required this.text,
    this.normalizedText,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isPrimary = isPrimary ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubtitleCueText({
    int? id,
    required int cueId,
    required String scriptCode,
    required String text,
    String? normalizedText,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubtitleCueTextImpl;

  factory SubtitleCueText.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtitleCueText(
      id: jsonSerialization['id'] as int?,
      cueId: jsonSerialization['cueId'] as int,
      scriptCode: jsonSerialization['scriptCode'] as String,
      text: jsonSerialization['text'] as String,
      normalizedText: jsonSerialization['normalizedText'] as String?,
      isPrimary: jsonSerialization['isPrimary'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isPrimary']),
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

  String scriptCode;

  String text;

  String? normalizedText;

  bool isPrimary;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [SubtitleCueText]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleCueText copyWith({
    int? id,
    int? cueId,
    String? scriptCode,
    String? text,
    String? normalizedText,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleCueText',
      if (id != null) 'id': id,
      'cueId': cueId,
      'scriptCode': scriptCode,
      'text': text,
      if (normalizedText != null) 'normalizedText': normalizedText,
      'isPrimary': isPrimary,
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

class _SubtitleCueTextImpl extends SubtitleCueText {
  _SubtitleCueTextImpl({
    int? id,
    required int cueId,
    required String scriptCode,
    required String text,
    String? normalizedText,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         cueId: cueId,
         scriptCode: scriptCode,
         text: text,
         normalizedText: normalizedText,
         isPrimary: isPrimary,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubtitleCueText]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleCueText copyWith({
    Object? id = _Undefined,
    int? cueId,
    String? scriptCode,
    String? text,
    Object? normalizedText = _Undefined,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubtitleCueText(
      id: id is int? ? id : this.id,
      cueId: cueId ?? this.cueId,
      scriptCode: scriptCode ?? this.scriptCode,
      text: text ?? this.text,
      normalizedText: normalizedText is String?
          ? normalizedText
          : this.normalizedText,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
