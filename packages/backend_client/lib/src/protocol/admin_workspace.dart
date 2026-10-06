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

abstract class AdminWorkspace implements _i1.SerializableModel {
  AdminWorkspace._({
    this.id,
    required this.name,
    this.ownerMemberId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory AdminWorkspace({
    int? id,
    required String name,
    int? ownerMemberId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AdminWorkspaceImpl;

  factory AdminWorkspace.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminWorkspace(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      ownerMemberId: jsonSerialization['ownerMemberId'] as int?,
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

  int? ownerMemberId;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [AdminWorkspace]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminWorkspace copyWith({
    int? id,
    String? name,
    int? ownerMemberId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminWorkspace',
      if (id != null) 'id': id,
      'name': name,
      if (ownerMemberId != null) 'ownerMemberId': ownerMemberId,
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

class _AdminWorkspaceImpl extends AdminWorkspace {
  _AdminWorkspaceImpl({
    int? id,
    required String name,
    int? ownerMemberId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         ownerMemberId: ownerMemberId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AdminWorkspace]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminWorkspace copyWith({
    Object? id = _Undefined,
    String? name,
    Object? ownerMemberId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AdminWorkspace(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      ownerMemberId: ownerMemberId is int? ? ownerMemberId : this.ownerMemberId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
