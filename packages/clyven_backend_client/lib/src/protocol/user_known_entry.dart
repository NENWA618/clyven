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

abstract class UserKnownEntry implements _i1.SerializableModel {
  UserKnownEntry._({
    this.id,
    required this.userId,
    required this.entryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory UserKnownEntry({
    int? id,
    required String userId,
    required int entryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserKnownEntryImpl;

  factory UserKnownEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserKnownEntry(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      entryId: jsonSerialization['entryId'] as int,
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

  String userId;

  int entryId;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [UserKnownEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserKnownEntry copyWith({
    int? id,
    String? userId,
    int? entryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserKnownEntry',
      if (id != null) 'id': id,
      'userId': userId,
      'entryId': entryId,
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

class _UserKnownEntryImpl extends UserKnownEntry {
  _UserKnownEntryImpl({
    int? id,
    required String userId,
    required int entryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         entryId: entryId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [UserKnownEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserKnownEntry copyWith({
    Object? id = _Undefined,
    String? userId,
    int? entryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserKnownEntry(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      entryId: entryId ?? this.entryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
