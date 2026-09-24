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

abstract class ScriptConversionProfile implements _i1.SerializableModel {
  ScriptConversionProfile._({
    this.id,
    required this.name,
    required this.languageCode,
    required this.sourceScriptCode,
    required this.targetScriptCode,
    this.sheetName,
    required this.sourceColumn,
    required this.targetColumn,
    this.priorityColumn,
    this.noteColumn,
    this.conversionMode,
    this.typeColumn,
    this.description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory ScriptConversionProfile({
    int? id,
    required String name,
    required String languageCode,
    required String sourceScriptCode,
    required String targetScriptCode,
    String? sheetName,
    required String sourceColumn,
    required String targetColumn,
    String? priorityColumn,
    String? noteColumn,
    String? conversionMode,
    String? typeColumn,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ScriptConversionProfileImpl;

  factory ScriptConversionProfile.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ScriptConversionProfile(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      languageCode: jsonSerialization['languageCode'] as String,
      sourceScriptCode: jsonSerialization['sourceScriptCode'] as String,
      targetScriptCode: jsonSerialization['targetScriptCode'] as String,
      sheetName: jsonSerialization['sheetName'] as String?,
      sourceColumn: jsonSerialization['sourceColumn'] as String,
      targetColumn: jsonSerialization['targetColumn'] as String,
      priorityColumn: jsonSerialization['priorityColumn'] as String?,
      noteColumn: jsonSerialization['noteColumn'] as String?,
      conversionMode: jsonSerialization['conversionMode'] as String?,
      typeColumn: jsonSerialization['typeColumn'] as String?,
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

  String sourceScriptCode;

  String targetScriptCode;

  String? sheetName;

  String sourceColumn;

  String targetColumn;

  String? priorityColumn;

  String? noteColumn;

  String? conversionMode;

  String? typeColumn;

  String? description;

  bool isActive;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ScriptConversionProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScriptConversionProfile copyWith({
    int? id,
    String? name,
    String? languageCode,
    String? sourceScriptCode,
    String? targetScriptCode,
    String? sheetName,
    String? sourceColumn,
    String? targetColumn,
    String? priorityColumn,
    String? noteColumn,
    String? conversionMode,
    String? typeColumn,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScriptConversionProfile',
      if (id != null) 'id': id,
      'name': name,
      'languageCode': languageCode,
      'sourceScriptCode': sourceScriptCode,
      'targetScriptCode': targetScriptCode,
      if (sheetName != null) 'sheetName': sheetName,
      'sourceColumn': sourceColumn,
      'targetColumn': targetColumn,
      if (priorityColumn != null) 'priorityColumn': priorityColumn,
      if (noteColumn != null) 'noteColumn': noteColumn,
      if (conversionMode != null) 'conversionMode': conversionMode,
      if (typeColumn != null) 'typeColumn': typeColumn,
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

class _ScriptConversionProfileImpl extends ScriptConversionProfile {
  _ScriptConversionProfileImpl({
    int? id,
    required String name,
    required String languageCode,
    required String sourceScriptCode,
    required String targetScriptCode,
    String? sheetName,
    required String sourceColumn,
    required String targetColumn,
    String? priorityColumn,
    String? noteColumn,
    String? conversionMode,
    String? typeColumn,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         languageCode: languageCode,
         sourceScriptCode: sourceScriptCode,
         targetScriptCode: targetScriptCode,
         sheetName: sheetName,
         sourceColumn: sourceColumn,
         targetColumn: targetColumn,
         priorityColumn: priorityColumn,
         noteColumn: noteColumn,
         conversionMode: conversionMode,
         typeColumn: typeColumn,
         description: description,
         isActive: isActive,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ScriptConversionProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScriptConversionProfile copyWith({
    Object? id = _Undefined,
    String? name,
    String? languageCode,
    String? sourceScriptCode,
    String? targetScriptCode,
    Object? sheetName = _Undefined,
    String? sourceColumn,
    String? targetColumn,
    Object? priorityColumn = _Undefined,
    Object? noteColumn = _Undefined,
    Object? conversionMode = _Undefined,
    Object? typeColumn = _Undefined,
    Object? description = _Undefined,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ScriptConversionProfile(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      languageCode: languageCode ?? this.languageCode,
      sourceScriptCode: sourceScriptCode ?? this.sourceScriptCode,
      targetScriptCode: targetScriptCode ?? this.targetScriptCode,
      sheetName: sheetName is String? ? sheetName : this.sheetName,
      sourceColumn: sourceColumn ?? this.sourceColumn,
      targetColumn: targetColumn ?? this.targetColumn,
      priorityColumn: priorityColumn is String?
          ? priorityColumn
          : this.priorityColumn,
      noteColumn: noteColumn is String? ? noteColumn : this.noteColumn,
      conversionMode: conversionMode is String?
          ? conversionMode
          : this.conversionMode,
      typeColumn: typeColumn is String? ? typeColumn : this.typeColumn,
      description: description is String? ? description : this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
