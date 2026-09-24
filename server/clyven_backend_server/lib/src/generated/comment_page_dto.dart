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
import 'video_comment_dto.dart' as _i2;
import 'package:clyven_backend_server/src/generated/protocol.dart' as _i3;

abstract class CommentPageDto
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CommentPageDto._({
    required this.comments,
    required this.page,
    required this.hasMore,
  });

  factory CommentPageDto({
    required List<_i2.VideoCommentDto> comments,
    required int page,
    required bool hasMore,
  }) = _CommentPageDtoImpl;

  factory CommentPageDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommentPageDto(
      comments: _i3.Protocol().deserialize<List<_i2.VideoCommentDto>>(
        jsonSerialization['comments'],
      ),
      page: jsonSerialization['page'] as int,
      hasMore: _i1.BoolJsonExtension.fromJson(jsonSerialization['hasMore']),
    );
  }

  List<_i2.VideoCommentDto> comments;

  int page;

  bool hasMore;

  /// Returns a shallow copy of this [CommentPageDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CommentPageDto copyWith({
    List<_i2.VideoCommentDto>? comments,
    int? page,
    bool? hasMore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CommentPageDto',
      'comments': comments.toJson(valueToJson: (v) => v.toJson()),
      'page': page,
      'hasMore': hasMore,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CommentPageDto',
      'comments': comments.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'page': page,
      'hasMore': hasMore,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CommentPageDtoImpl extends CommentPageDto {
  _CommentPageDtoImpl({
    required List<_i2.VideoCommentDto> comments,
    required int page,
    required bool hasMore,
  }) : super._(
         comments: comments,
         page: page,
         hasMore: hasMore,
       );

  /// Returns a shallow copy of this [CommentPageDto]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CommentPageDto copyWith({
    List<_i2.VideoCommentDto>? comments,
    int? page,
    bool? hasMore,
  }) {
    return CommentPageDto(
      comments: comments ?? this.comments.map((e0) => e0.copyWith()).toList(),
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
