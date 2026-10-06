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

abstract class ScriptConversionEntry implements _i1.SerializableModel {
  ScriptConversionEntry._({
    this.id,
    required this.profileId,
    required this.sourceText,
    required this.targetText,
    int? priority,
    this.note,
    this.metadataJson,
    this.entryType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : priority = priority ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory ScriptConversionEntry({
    int? id,
    required int profileId,
    required String sourceText,
    required String targetText,
    int? priority,
    String? note,
    String? metadataJson,
    String? entryType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ScriptConversionEntryImpl;

  factory ScriptConversionEntry.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ScriptConversionEntry(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      sourceText: jsonSerialization['sourceText'] as String,
      targetText: jsonSerialization['targetText'] as String,
      priority: jsonSerialization['priority'] as int?,
      note: jsonSerialization['note'] as String?,
      metadataJson: jsonSerialization['metadataJson'] as String?,
      entryType: jsonSerialization['entryType'] as String?,
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

  String sourceText;

  String targetText;

  int priority;

  String? note;

  String? metadataJson;

  String? entryType;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ScriptConversionEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScriptConversionEntry copyWith({
    int? id,
    int? profileId,
    String? sourceText,
    String? targetText,
    int? priority,
    String? note,
    String? metadataJson,
    String? entryType,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScriptConversionEntry',
      if (id != null) 'id': id,
      'profileId': profileId,
      'sourceText': sourceText,
      'targetText': targetText,
      'priority': priority,
      if (note != null) 'note': note,
      if (metadataJson != null) 'metadataJson': metadataJson,
      if (entryType != null) 'entryType': entryType,
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

class _ScriptConversionEntryImpl extends ScriptConversionEntry {
  _ScriptConversionEntryImpl({
    int? id,
    required int profileId,
    required String sourceText,
    required String targetText,
    int? priority,
    String? note,
    String? metadataJson,
    String? entryType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         sourceText: sourceText,
         targetText: targetText,
         priority: priority,
         note: note,
         metadataJson: metadataJson,
         entryType: entryType,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ScriptConversionEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScriptConversionEntry copyWith({
    Object? id = _Undefined,
    int? profileId,
    String? sourceText,
    String? targetText,
    int? priority,
    Object? note = _Undefined,
    Object? metadataJson = _Undefined,
    Object? entryType = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ScriptConversionEntry(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      sourceText: sourceText ?? this.sourceText,
      targetText: targetText ?? this.targetText,
      priority: priority ?? this.priority,
      note: note is String? ? note : this.note,
      metadataJson: metadataJson is String? ? metadataJson : this.metadataJson,
      entryType: entryType is String? ? entryType : this.entryType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
