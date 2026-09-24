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

abstract class AppProfile implements _i1.SerializableModel {
  AppProfile._({
    this.id,
    required this.userId,
    String? bio,
    DateTime? updatedAt,
  }) : bio = bio ?? '',
       updatedAt = updatedAt ?? DateTime.now();

  factory AppProfile({
    int? id,
    required String userId,
    String? bio,
    DateTime? updatedAt,
  }) = _AppProfileImpl;

  factory AppProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppProfile(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      bio: jsonSerialization['bio'] as String?,
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

  String bio;

  DateTime updatedAt;

  /// Returns a shallow copy of this [AppProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppProfile copyWith({
    int? id,
    String? userId,
    String? bio,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppProfile',
      if (id != null) 'id': id,
      'userId': userId,
      'bio': bio,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppProfileImpl extends AppProfile {
  _AppProfileImpl({
    int? id,
    required String userId,
    String? bio,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         bio: bio,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AppProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppProfile copyWith({
    Object? id = _Undefined,
    String? userId,
    String? bio,
    DateTime? updatedAt,
  }) {
    return AppProfile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      bio: bio ?? this.bio,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
