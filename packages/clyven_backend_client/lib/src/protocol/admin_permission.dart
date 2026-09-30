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

abstract class AdminPermission implements _i1.SerializableModel {
  AdminPermission._({
    this.id,
    required this.code,
    required this.name,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AdminPermission({
    int? id,
    required String code,
    required String name,
    DateTime? createdAt,
  }) = _AdminPermissionImpl;

  factory AdminPermission.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminPermission(
      id: jsonSerialization['id'] as int?,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String code;

  String name;

  DateTime createdAt;

  /// Returns a shallow copy of this [AdminPermission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminPermission copyWith({
    int? id,
    String? code,
    String? name,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminPermission',
      if (id != null) 'id': id,
      'code': code,
      'name': name,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminPermissionImpl extends AdminPermission {
  _AdminPermissionImpl({
    int? id,
    required String code,
    required String name,
    DateTime? createdAt,
  }) : super._(
         id: id,
         code: code,
         name: name,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AdminPermission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminPermission copyWith({
    Object? id = _Undefined,
    String? code,
    String? name,
    DateTime? createdAt,
  }) {
    return AdminPermission(
      id: id is int? ? id : this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
