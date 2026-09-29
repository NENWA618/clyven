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

abstract class DictionaryEntry implements _i1.SerializableModel {
  DictionaryEntry._({
    this.id,
    required this.languageCode,
    required this.text,
    required this.normalizedText,
    required this.entryType,
    this.primaryScriptCode,
    this.partOfSpeech,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DictionaryEntry({
    int? id,
    required String languageCode,
    required String text,
    required String normalizedText,
    required String entryType,
    String? primaryScriptCode,
    String? partOfSpeech,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DictionaryEntryImpl;

  factory DictionaryEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return DictionaryEntry(
      id: jsonSerialization['id'] as int?,
      languageCode: jsonSerialization['languageCode'] as String,
      text: jsonSerialization['text'] as String,
      normalizedText: jsonSerialization['normalizedText'] as String,
      entryType: jsonSerialization['entryType'] as String,
      primaryScriptCode: jsonSerialization['primaryScriptCode'] as String?,
      partOfSpeech: jsonSerialization['partOfSpeech'] as String?,
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

  String languageCode;

  String text;

  String normalizedText;

  String entryType;

  String? primaryScriptCode;

  String? partOfSpeech;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DictionaryEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryEntry copyWith({
    int? id,
    String? languageCode,
    String? text,
    String? normalizedText,
    String? entryType,
    String? primaryScriptCode,
    String? partOfSpeech,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryEntry',
      if (id != null) 'id': id,
      'languageCode': languageCode,
      'text': text,
      'normalizedText': normalizedText,
      'entryType': entryType,
      if (primaryScriptCode != null) 'primaryScriptCode': primaryScriptCode,
      if (partOfSpeech != null) 'partOfSpeech': partOfSpeech,
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

class _DictionaryEntryImpl extends DictionaryEntry {
  _DictionaryEntryImpl({
    int? id,
    required String languageCode,
    required String text,
    required String normalizedText,
    required String entryType,
    String? primaryScriptCode,
    String? partOfSpeech,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         languageCode: languageCode,
         text: text,
         normalizedText: normalizedText,
         entryType: entryType,
         primaryScriptCode: primaryScriptCode,
         partOfSpeech: partOfSpeech,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DictionaryEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryEntry copyWith({
    Object? id = _Undefined,
    String? languageCode,
    String? text,
    String? normalizedText,
    String? entryType,
    Object? primaryScriptCode = _Undefined,
    Object? partOfSpeech = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DictionaryEntry(
      id: id is int? ? id : this.id,
      languageCode: languageCode ?? this.languageCode,
      text: text ?? this.text,
      normalizedText: normalizedText ?? this.normalizedText,
      entryType: entryType ?? this.entryType,
      primaryScriptCode: primaryScriptCode is String?
          ? primaryScriptCode
          : this.primaryScriptCode,
      partOfSpeech: partOfSpeech is String? ? partOfSpeech : this.partOfSpeech,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
