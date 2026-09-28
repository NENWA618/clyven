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

abstract class CommentReplyRow implements _i1.SerializableModel {
  CommentReplyRow._({
    this.id,
    required this.commentId,
    required this.userId,
    required this.userName,
    required this.content,
    int? likeCount,
    DateTime? createdAt,
  }) : likeCount = likeCount ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory CommentReplyRow({
    int? id,
    required int commentId,
    required String userId,
    required String userName,
    required String content,
    int? likeCount,
    DateTime? createdAt,
  }) = _CommentReplyRowImpl;

  factory CommentReplyRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommentReplyRow(
      id: jsonSerialization['id'] as int?,
      commentId: jsonSerialization['commentId'] as int,
      userId: jsonSerialization['userId'] as String,
      userName: jsonSerialization['userName'] as String,
      content: jsonSerialization['content'] as String,
      likeCount: jsonSerialization['likeCount'] as int?,
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

  String userName;

  String content;

  int likeCount;

  DateTime createdAt;

  /// Returns a shallow copy of this [CommentReplyRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CommentReplyRow copyWith({
    int? id,
    int? commentId,
    String? userId,
    String? userName,
    String? content,
    int? likeCount,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CommentReplyRow',
      if (id != null) 'id': id,
      'commentId': commentId,
      'userId': userId,
      'userName': userName,
      'content': content,
      'likeCount': likeCount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommentReplyRowImpl extends CommentReplyRow {
  _CommentReplyRowImpl({
    int? id,
    required int commentId,
    required String userId,
    required String userName,
    required String content,
    int? likeCount,
    DateTime? createdAt,
  }) : super._(
         id: id,
         commentId: commentId,
         userId: userId,
         userName: userName,
         content: content,
         likeCount: likeCount,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CommentReplyRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CommentReplyRow copyWith({
    Object? id = _Undefined,
    int? commentId,
    String? userId,
    String? userName,
    String? content,
    int? likeCount,
    DateTime? createdAt,
  }) {
    return CommentReplyRow(
      id: id is int? ? id : this.id,
      commentId: commentId ?? this.commentId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      content: content ?? this.content,
      likeCount: likeCount ?? this.likeCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
