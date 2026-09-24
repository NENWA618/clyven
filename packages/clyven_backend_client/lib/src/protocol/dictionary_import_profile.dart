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

abstract class DictionaryImportProfile implements _i1.SerializableModel {
  DictionaryImportProfile._({
    this.id,
    required this.name,
    required this.languageCode,
    required this.sheetName,
    this.defaultEntryType,
    this.primaryScriptCode,
    this.description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DictionaryImportProfile({
    int? id,
    required String name,
    required String languageCode,
    required String sheetName,
    String? defaultEntryType,
    String? primaryScriptCode,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DictionaryImportProfileImpl;

  factory DictionaryImportProfile.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DictionaryImportProfile(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      languageCode: jsonSerialization['languageCode'] as String,
      sheetName: jsonSerialization['sheetName'] as String,
      defaultEntryType: jsonSerialization['defaultEntryType'] as String?,
      primaryScriptCode: jsonSerialization['primaryScriptCode'] as String?,
      description: jsonSerialization['description'] as String?,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
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

  String name;

  String languageCode;

  String sheetName;

  String? defaultEntryType;

  String? primaryScriptCode;

  String? description;

  bool isActive;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DictionaryImportProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryImportProfile copyWith({
    int? id,
    String? name,
    String? languageCode,
    String? sheetName,
    String? defaultEntryType,
    String? primaryScriptCode,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryImportProfile',
      if (id != null) 'id': id,
      'name': name,
      'languageCode': languageCode,
      'sheetName': sheetName,
      if (defaultEntryType != null) 'defaultEntryType': defaultEntryType,
      if (primaryScriptCode != null) 'primaryScriptCode': primaryScriptCode,
      if (description != null) 'description': description,
      'isActive': isActive,
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

class _DictionaryImportProfileImpl extends DictionaryImportProfile {
  _DictionaryImportProfileImpl({
    int? id,
    required String name,
    required String languageCode,
    required String sheetName,
    String? defaultEntryType,
    String? primaryScriptCode,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         languageCode: languageCode,
         sheetName: sheetName,
         defaultEntryType: defaultEntryType,
         primaryScriptCode: primaryScriptCode,
         description: description,
         isActive: isActive,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DictionaryImportProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryImportProfile copyWith({
    Object? id = _Undefined,
    String? name,
    String? languageCode,
    String? sheetName,
    Object? defaultEntryType = _Undefined,
    Object? primaryScriptCode = _Undefined,
    Object? description = _Undefined,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DictionaryImportProfile(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      languageCode: languageCode ?? this.languageCode,
      sheetName: sheetName ?? this.sheetName,
      defaultEntryType: defaultEntryType is String?
          ? defaultEntryType
          : this.defaultEntryType,
      primaryScriptCode: primaryScriptCode is String?
          ? primaryScriptCode
          : this.primaryScriptCode,
      description: description is String? ? description : this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
