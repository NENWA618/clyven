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

abstract class AdminRole implements _i1.SerializableModel {
  AdminRole._({
    this.id,
    required this.workspaceId,
    required this.key,
    required this.name,
    bool? isSystem,
    DateTime? createdAt,
  }) : isSystem = isSystem ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory AdminRole({
    int? id,
    required int workspaceId,
    required String key,
    required String name,
    bool? isSystem,
    DateTime? createdAt,
  }) = _AdminRoleImpl;

  factory AdminRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminRole(
      id: jsonSerialization['id'] as int?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      key: jsonSerialization['key'] as String,
      name: jsonSerialization['name'] as String,
      isSystem: jsonSerialization['isSystem'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isSystem']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int workspaceId;

  String key;

  String name;

  bool isSystem;

  DateTime createdAt;

  /// Returns a shallow copy of this [AdminRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminRole copyWith({
    int? id,
    int? workspaceId,
    String? key,
    String? name,
    bool? isSystem,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminRole',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'key': key,
      'name': name,
      'isSystem': isSystem,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminRoleImpl extends AdminRole {
  _AdminRoleImpl({
    int? id,
    required int workspaceId,
    required String key,
    required String name,
    bool? isSystem,
    DateTime? createdAt,
  }) : super._(
         id: id,
         workspaceId: workspaceId,
         key: key,
         name: name,
         isSystem: isSystem,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AdminRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminRole copyWith({
    Object? id = _Undefined,
    int? workspaceId,
    String? key,
    String? name,
    bool? isSystem,
    DateTime? createdAt,
  }) {
    return AdminRole(
      id: id is int? ? id : this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      key: key ?? this.key,
      name: name ?? this.name,
      isSystem: isSystem ?? this.isSystem,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
