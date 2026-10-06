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

abstract class AdminMember implements _i1.SerializableModel {
  AdminMember._({
    this.id,
    required this.workspaceId,
    required this.userId,
    required this.email,
    required this.roleId,
    String? status,
    this.invitedByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : status = status ?? 'active',
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory AdminMember({
    int? id,
    required int workspaceId,
    required String userId,
    required String email,
    required int roleId,
    String? status,
    String? invitedByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AdminMemberImpl;

  factory AdminMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminMember(
      id: jsonSerialization['id'] as int?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      userId: jsonSerialization['userId'] as String,
      email: jsonSerialization['email'] as String,
      roleId: jsonSerialization['roleId'] as int,
      status: jsonSerialization['status'] as String?,
      invitedByUserId: jsonSerialization['invitedByUserId'] as String?,
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

  int workspaceId;

  String userId;

  String email;

  int roleId;

  String status;

  String? invitedByUserId;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [AdminMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminMember copyWith({
    int? id,
    int? workspaceId,
    String? userId,
    String? email,
    int? roleId,
    String? status,
    String? invitedByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminMember',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'userId': userId,
      'email': email,
      'roleId': roleId,
      'status': status,
      if (invitedByUserId != null) 'invitedByUserId': invitedByUserId,
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

class _AdminMemberImpl extends AdminMember {
  _AdminMemberImpl({
    int? id,
    required int workspaceId,
    required String userId,
    required String email,
    required int roleId,
    String? status,
    String? invitedByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         workspaceId: workspaceId,
         userId: userId,
         email: email,
         roleId: roleId,
         status: status,
         invitedByUserId: invitedByUserId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AdminMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminMember copyWith({
    Object? id = _Undefined,
    int? workspaceId,
    String? userId,
    String? email,
    int? roleId,
    String? status,
    Object? invitedByUserId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AdminMember(
      id: id is int? ? id : this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      roleId: roleId ?? this.roleId,
      status: status ?? this.status,
      invitedByUserId: invitedByUserId is String?
          ? invitedByUserId
          : this.invitedByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
