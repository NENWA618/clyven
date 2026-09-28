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

import 'package:serverpod/serverpod.dart' as _i1;

abstract class CommentReplyDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CommentReplyDto._({
    required this.id,
    required this.userId,
    required this.userName,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    required this.isLiked,
  });

  factory CommentReplyDto({
    required int id,
    required String userId,
    required String userName,
    required String content,
    required DateTime createdAt,
    required int likeCount,
    required bool isLiked,
  }) = _CommentReplyDtoImpl;

  factory CommentReplyDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommentReplyDto(
      id: jsonSerialization['id'] as int,
      userId: jsonSerialization['userId'] as String,
      userName: jsonSerialization['userName'] as String,
      content: jsonSerialization['content'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      likeCount: jsonSerialization['likeCount'] as int,
      isLiked: _i1.BoolJsonExtension.fromJson(jsonSerialization['isLiked']),
    );
  }

  int id;

  String userId;

  String userName;

  String content;

  DateTime createdAt;

  int likeCount;

  bool isLiked;

  /// Returns a shallow copy of this [CommentReplyDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CommentReplyDto copyWith({
    int? id,
    String? userId,
    String? userName,
    String? content,
    DateTime? createdAt,
    int? likeCount,
    bool? isLiked,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CommentReplyDto',
      'id': id,
      'userId': userId,
      'userName': userName,
      'content': content,
      'createdAt': createdAt.toJson(),
      'likeCount': likeCount,
      'isLiked': isLiked,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CommentReplyDto',
      'id': id,
      'userId': userId,
      'userName': userName,
      'content': content,
      'createdAt': createdAt.toJson(),
      'likeCount': likeCount,
      'isLiked': isLiked,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CommentReplyDtoImpl extends CommentReplyDto {
  _CommentReplyDtoImpl({
    required int id,
    required String userId,
    required String userName,
    required String content,
    required DateTime createdAt,
    required int likeCount,
    required bool isLiked,
  }) : super._(
         id: id,
         userId: userId,
         userName: userName,
         content: content,
         createdAt: createdAt,
         likeCount: likeCount,
         isLiked: isLiked,
       );

  /// Returns a shallow copy of this [CommentReplyDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CommentReplyDto copyWith({
    int? id,
    String? userId,
    String? userName,
    String? content,
    DateTime? createdAt,
    int? likeCount,
    bool? isLiked,
  }) {
    return CommentReplyDto(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
