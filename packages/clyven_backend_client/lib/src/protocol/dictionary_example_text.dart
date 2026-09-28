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

abstract class DictionaryExampleText implements _i1.SerializableModel {
  DictionaryExampleText._({
    this.id,
    required this.exampleId,
    required this.languageCode,
    required this.scriptCode,
    required this.text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DictionaryExampleText({
    int? id,
    required int exampleId,
    required String languageCode,
    required String scriptCode,
    required String text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DictionaryExampleTextImpl;

  factory DictionaryExampleText.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DictionaryExampleText(
      id: jsonSerialization['id'] as int?,
      exampleId: jsonSerialization['exampleId'] as int,
      languageCode: jsonSerialization['languageCode'] as String,
      scriptCode: jsonSerialization['scriptCode'] as String,
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

  int exampleId;

  String languageCode;

  String scriptCode;

  String text;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DictionaryExampleText]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryExampleText copyWith({
    int? id,
    int? exampleId,
    String? languageCode,
    String? scriptCode,
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryExampleText',
      if (id != null) 'id': id,
      'exampleId': exampleId,
      'languageCode': languageCode,
      'scriptCode': scriptCode,
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

class _DictionaryExampleTextImpl extends DictionaryExampleText {
  _DictionaryExampleTextImpl({
    int? id,
    required int exampleId,
    required String languageCode,
    required String scriptCode,
    required String text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         exampleId: exampleId,
         languageCode: languageCode,
         scriptCode: scriptCode,
         text: text,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DictionaryExampleText]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryExampleText copyWith({
    Object? id = _Undefined,
    int? exampleId,
    String? languageCode,
    String? scriptCode,
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DictionaryExampleText(
      id: id is int? ? id : this.id,
      exampleId: exampleId ?? this.exampleId,
      languageCode: languageCode ?? this.languageCode,
      scriptCode: scriptCode ?? this.scriptCode,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
