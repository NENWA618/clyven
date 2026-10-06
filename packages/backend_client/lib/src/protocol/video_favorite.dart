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

abstract class VideoFavorite implements _i1.SerializableModel {
  VideoFavorite._({
    this.id,
    required this.userId,
    required this.videoId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory VideoFavorite({
    int? id,
    required String userId,
    required int videoId,
    DateTime? createdAt,
  }) = _VideoFavoriteImpl;

  factory VideoFavorite.fromJson(Map<String, dynamic> jsonSerialization) {
    return VideoFavorite(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      videoId: jsonSerialization['videoId'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userId;

  int videoId;

  DateTime createdAt;

  /// Returns a shallow copy of this [VideoFavorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VideoFavorite copyWith({
    int? id,
    String? userId,
    int? videoId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VideoFavorite',
      if (id != null) 'id': id,
      'userId': userId,
      'videoId': videoId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VideoFavoriteImpl extends VideoFavorite {
  _VideoFavoriteImpl({
    int? id,
    required String userId,
    required int videoId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         videoId: videoId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [VideoFavorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VideoFavorite copyWith({
    Object? id = _Undefined,
    String? userId,
    int? videoId,
    DateTime? createdAt,
  }) {
    return VideoFavorite(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      videoId: videoId ?? this.videoId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
