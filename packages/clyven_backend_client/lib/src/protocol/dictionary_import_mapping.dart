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

abstract class DictionaryImportMapping implements _i1.SerializableModel {
  DictionaryImportMapping._({
    this.id,
    required this.profileId,
    required this.sourceColumn,
    required this.targetType,
    this.targetField,
    this.languageCode,
    this.scriptCode,
    this.relationType,
    this.groupKey,
    this.transformType,
    this.transformConfig,
    required this.position,
    bool? required,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : required = required ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DictionaryImportMapping({
    int? id,
    required int profileId,
    required String sourceColumn,
    required String targetType,
    String? targetField,
    String? languageCode,
    String? scriptCode,
    String? relationType,
    String? groupKey,
    String? transformType,
    String? transformConfig,
    required int position,
    bool? required,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DictionaryImportMappingImpl;

  factory DictionaryImportMapping.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DictionaryImportMapping(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      sourceColumn: jsonSerialization['sourceColumn'] as String,
      targetType: jsonSerialization['targetType'] as String,
      targetField: jsonSerialization['targetField'] as String?,
      languageCode: jsonSerialization['languageCode'] as String?,
      scriptCode: jsonSerialization['scriptCode'] as String?,
      relationType: jsonSerialization['relationType'] as String?,
      groupKey: jsonSerialization['groupKey'] as String?,
      transformType: jsonSerialization['transformType'] as String?,
      transformConfig: jsonSerialization['transformConfig'] as String?,
      position: jsonSerialization['position'] as int,
      required: jsonSerialization['required'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['required']),
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

  int profileId;

  String sourceColumn;

  String targetType;

  String? targetField;

  String? languageCode;

  String? scriptCode;

  String? relationType;

  String? groupKey;

  String? transformType;

  String? transformConfig;

  int position;

  bool required;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DictionaryImportMapping]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryImportMapping copyWith({
    int? id,
    int? profileId,
    String? sourceColumn,
    String? targetType,
    String? targetField,
    String? languageCode,
    String? scriptCode,
    String? relationType,
    String? groupKey,
    String? transformType,
    String? transformConfig,
    int? position,
    bool? required,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryImportMapping',
      if (id != null) 'id': id,
      'profileId': profileId,
      'sourceColumn': sourceColumn,
      'targetType': targetType,
      if (targetField != null) 'targetField': targetField,
      if (languageCode != null) 'languageCode': languageCode,
      if (scriptCode != null) 'scriptCode': scriptCode,
      if (relationType != null) 'relationType': relationType,
      if (groupKey != null) 'groupKey': groupKey,
      if (transformType != null) 'transformType': transformType,
      if (transformConfig != null) 'transformConfig': transformConfig,
      'position': position,
      'required': required,
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

class _DictionaryImportMappingImpl extends DictionaryImportMapping {
  _DictionaryImportMappingImpl({
    int? id,
    required int profileId,
    required String sourceColumn,
    required String targetType,
    String? targetField,
    String? languageCode,
    String? scriptCode,
    String? relationType,
    String? groupKey,
    String? transformType,
    String? transformConfig,
    required int position,
    bool? required,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         sourceColumn: sourceColumn,
         targetType: targetType,
         targetField: targetField,
         languageCode: languageCode,
         scriptCode: scriptCode,
         relationType: relationType,
         groupKey: groupKey,
         transformType: transformType,
         transformConfig: transformConfig,
         position: position,
         required: required,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DictionaryImportMapping]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryImportMapping copyWith({
    Object? id = _Undefined,
    int? profileId,
    String? sourceColumn,
    String? targetType,
    Object? targetField = _Undefined,
    Object? languageCode = _Undefined,
    Object? scriptCode = _Undefined,
    Object? relationType = _Undefined,
    Object? groupKey = _Undefined,
    Object? transformType = _Undefined,
    Object? transformConfig = _Undefined,
    int? position,
    bool? required,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DictionaryImportMapping(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      sourceColumn: sourceColumn ?? this.sourceColumn,
      targetType: targetType ?? this.targetType,
      targetField: targetField is String? ? targetField : this.targetField,
      languageCode: languageCode is String? ? languageCode : this.languageCode,
      scriptCode: scriptCode is String? ? scriptCode : this.scriptCode,
      relationType: relationType is String? ? relationType : this.relationType,
      groupKey: groupKey is String? ? groupKey : this.groupKey,
      transformType: transformType is String?
          ? transformType
          : this.transformType,
      transformConfig: transformConfig is String?
          ? transformConfig
          : this.transformConfig,
      position: position ?? this.position,
      required: required ?? this.required,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
