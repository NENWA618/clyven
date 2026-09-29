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

abstract class DictionaryRelation implements _i1.SerializableModel {
  DictionaryRelation._({
    this.id,
    required this.sourceEntryId,
    required this.targetEntryId,
    required this.relationType,
    this.position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DictionaryRelation({
    int? id,
    required int sourceEntryId,
    required int targetEntryId,
    required String relationType,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DictionaryRelationImpl;

  factory DictionaryRelation.fromJson(Map<String, dynamic> jsonSerialization) {
    return DictionaryRelation(
      id: jsonSerialization['id'] as int?,
      sourceEntryId: jsonSerialization['sourceEntryId'] as int,
      targetEntryId: jsonSerialization['targetEntryId'] as int,
      relationType: jsonSerialization['relationType'] as String,
      position: jsonSerialization['position'] as int?,
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

  int sourceEntryId;

  int targetEntryId;

  String relationType;

  int? position;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DictionaryRelation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryRelation copyWith({
    int? id,
    int? sourceEntryId,
    int? targetEntryId,
    String? relationType,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryRelation',
      if (id != null) 'id': id,
      'sourceEntryId': sourceEntryId,
      'targetEntryId': targetEntryId,
      'relationType': relationType,
      if (position != null) 'position': position,
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

class _DictionaryRelationImpl extends DictionaryRelation {
  _DictionaryRelationImpl({
    int? id,
    required int sourceEntryId,
    required int targetEntryId,
    required String relationType,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         sourceEntryId: sourceEntryId,
         targetEntryId: targetEntryId,
         relationType: relationType,
         position: position,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DictionaryRelation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryRelation copyWith({
    Object? id = _Undefined,
    int? sourceEntryId,
    int? targetEntryId,
    String? relationType,
    Object? position = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DictionaryRelation(
      id: id is int? ? id : this.id,
      sourceEntryId: sourceEntryId ?? this.sourceEntryId,
      targetEntryId: targetEntryId ?? this.targetEntryId,
      relationType: relationType ?? this.relationType,
      position: position is int? ? position : this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
