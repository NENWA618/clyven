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

abstract class CommentLike implements _i1.SerializableModel {
  CommentLike._({
    this.id,
    required this.commentId,
    required this.userId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory CommentLike({
    int? id,
    required int commentId,
    required String userId,
    DateTime? createdAt,
  }) = _CommentLikeImpl;

  factory CommentLike.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommentLike(
      id: jsonSerialization['id'] as int?,
      commentId: jsonSerialization['commentId'] as int,
      userId: jsonSerialization['userId'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int commentId;

  String userId;

  DateTime createdAt;

  /// Returns a shallow copy of this [CommentLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CommentLike copyWith({
    int? id,
    int? commentId,
    String? userId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CommentLike',
      if (id != null) 'id': id,
      'commentId': commentId,
      'userId': userId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommentLikeImpl extends CommentLike {
  _CommentLikeImpl({
    int? id,
    required int commentId,
    required String userId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         commentId: commentId,
         userId: userId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CommentLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CommentLike copyWith({
    Object? id = _Undefined,
    int? commentId,
    String? userId,
    DateTime? createdAt,
  }) {
    return CommentLike(
      id: id is int? ? id : this.id,
      commentId: commentId ?? this.commentId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
