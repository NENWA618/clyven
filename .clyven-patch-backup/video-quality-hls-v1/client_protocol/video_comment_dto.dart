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
import 'comment_reply_dto.dart' as _i2;
import 'package:clyven_backend_client/src/protocol/protocol.dart' as _i3;

abstract class VideoCommentDto implements _i1.SerializableModel {
  VideoCommentDto._({
    required this.id,
    required this.userId,
    required this.userName,
    required this.content,
    required this.createdAt,
    required this.likeCount,
    required this.isLiked,
    required this.replies,
  });

  factory VideoCommentDto({
    required int id,
    required String userId,
    required String userName,
    required String content,
    required DateTime createdAt,
    required int likeCount,
    required bool isLiked,
    required List<_i2.CommentReplyDto> replies,
  }) = _VideoCommentDtoImpl;

  factory VideoCommentDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return VideoCommentDto(
      id: jsonSerialization['id'] as int,
      userId: jsonSerialization['userId'] as String,
      userName: jsonSerialization['userName'] as String,
      content: jsonSerialization['content'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      likeCount: jsonSerialization['likeCount'] as int,
      isLiked: _i1.BoolJsonExtension.fromJson(jsonSerialization['isLiked']),
      replies: _i3.Protocol().deserialize<List<_i2.CommentReplyDto>>(
        jsonSerialization['replies'],
      ),
    );
  }

  int id;

  String userId;

  String userName;

  String content;

  DateTime createdAt;

  int likeCount;

  bool isLiked;

  List<_i2.CommentReplyDto> replies;

  /// Returns a shallow copy of this [VideoCommentDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VideoCommentDto copyWith({
    int? id,
    String? userId,
    String? userName,
    String? content,
    DateTime? createdAt,
    int? likeCount,
    bool? isLiked,
    List<_i2.CommentReplyDto>? replies,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VideoCommentDto',
      'id': id,
      'userId': userId,
      'userName': userName,
      'content': content,
      'createdAt': createdAt.toJson(),
      'likeCount': likeCount,
      'isLiked': isLiked,
      'replies': replies.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _VideoCommentDtoImpl extends VideoCommentDto {
  _VideoCommentDtoImpl({
    required int id,
    required String userId,
    required String userName,
    required String content,
    required DateTime createdAt,
    required int likeCount,
    required bool isLiked,
    required List<_i2.CommentReplyDto> replies,
  }) : super._(
         id: id,
         userId: userId,
         userName: userName,
         content: content,
         createdAt: createdAt,
         likeCount: likeCount,
         isLiked: isLiked,
         replies: replies,
       );

  /// Returns a shallow copy of this [VideoCommentDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VideoCommentDto copyWith({
    int? id,
    String? userId,
    String? userName,
    String? content,
    DateTime? createdAt,
    int? likeCount,
    bool? isLiked,
    List<_i2.CommentReplyDto>? replies,
  }) {
    return VideoCommentDto(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      replies: replies ?? this.replies.map((e0) => e0.copyWith()).toList(),
    );
  }
}
