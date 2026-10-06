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

abstract class AdminRolePermission implements _i1.SerializableModel {
  AdminRolePermission._({
    this.id,
    required this.roleId,
    required this.permissionCode,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AdminRolePermission({
    int? id,
    required int roleId,
    required String permissionCode,
    DateTime? createdAt,
  }) = _AdminRolePermissionImpl;

  factory AdminRolePermission.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminRolePermission(
      id: jsonSerialization['id'] as int?,
      roleId: jsonSerialization['roleId'] as int,
      permissionCode: jsonSerialization['permissionCode'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roleId;

  String permissionCode;

  DateTime createdAt;

  /// Returns a shallow copy of this [AdminRolePermission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminRolePermission copyWith({
    int? id,
    int? roleId,
    String? permissionCode,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminRolePermission',
      if (id != null) 'id': id,
      'roleId': roleId,
      'permissionCode': permissionCode,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminRolePermissionImpl extends AdminRolePermission {
  _AdminRolePermissionImpl({
    int? id,
    required int roleId,
    required String permissionCode,
    DateTime? createdAt,
  }) : super._(
         id: id,
         roleId: roleId,
         permissionCode: permissionCode,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AdminRolePermission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminRolePermission copyWith({
    Object? id = _Undefined,
    int? roleId,
    String? permissionCode,
    DateTime? createdAt,
  }) {
    return AdminRolePermission(
      id: id is int? ? id : this.id,
      roleId: roleId ?? this.roleId,
      permissionCode: permissionCode ?? this.permissionCode,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
