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

abstract class CreatorFollow implements _i1.SerializableModel {
  CreatorFollow._({
    this.id,
    required this.followerId,
    required this.creatorId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory CreatorFollow({
    int? id,
    required String followerId,
    required String creatorId,
    DateTime? createdAt,
  }) = _CreatorFollowImpl;

  factory CreatorFollow.fromJson(Map<String, dynamic> jsonSerialization) {
    return CreatorFollow(
      id: jsonSerialization['id'] as int?,
      followerId: jsonSerialization['followerId'] as String,
      creatorId: jsonSerialization['creatorId'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String followerId;

  String creatorId;

  DateTime createdAt;

  /// Returns a shallow copy of this [CreatorFollow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreatorFollow copyWith({
    int? id,
    String? followerId,
    String? creatorId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreatorFollow',
      if (id != null) 'id': id,
      'followerId': followerId,
      'creatorId': creatorId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreatorFollowImpl extends CreatorFollow {
  _CreatorFollowImpl({
    int? id,
    required String followerId,
    required String creatorId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         followerId: followerId,
         creatorId: creatorId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CreatorFollow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreatorFollow copyWith({
    Object? id = _Undefined,
    String? followerId,
    String? creatorId,
    DateTime? createdAt,
  }) {
    return CreatorFollow(
      id: id is int? ? id : this.id,
      followerId: followerId ?? this.followerId,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
