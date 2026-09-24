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
import 'video_content_type.dart' as _i2;
import 'video_status.dart' as _i3;
import 'package:clyven_backend_client/src/protocol/protocol.dart' as _i4;

abstract class Video implements _i1.SerializableModel {
  Video._({
    this.id,
    required this.authorId,
    required this.authorName,
    this.seriesTitle,
    required this.title,
    required this.description,
    required this.category,
    _i2.VideoContentType? contentType,
    this.languageCode,
    required this.tags,
    required this.videoStorageKey,
    this.coverStorageKey,
    this.hlsManifestStorageKey,
    this.transcoderJobName,
    this.transcodeState,
    required this.durationSeconds,
    int? viewCount,
    int? likeCount,
    int? favoriteCount,
    int? commentCount,
    _i3.VideoStatus? status,
    bool? isPublic,
    this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
  }) : contentType = contentType ?? _i2.VideoContentType.video,
       viewCount = viewCount ?? 0,
       likeCount = likeCount ?? 0,
       favoriteCount = favoriteCount ?? 0,
       commentCount = commentCount ?? 0,
       status = status ?? _i3.VideoStatus.uploading,
       isPublic = isPublic ?? true;

  factory Video({
    int? id,
    required String authorId,
    required String authorName,
    String? seriesTitle,
    required String title,
    required String description,
    required String category,
    _i2.VideoContentType? contentType,
    String? languageCode,
    required List<String> tags,
    required String videoStorageKey,
    String? coverStorageKey,
    String? hlsManifestStorageKey,
    String? transcoderJobName,
    String? transcodeState,
    required int durationSeconds,
    int? viewCount,
    int? likeCount,
    int? favoriteCount,
    int? commentCount,
    _i3.VideoStatus? status,
    bool? isPublic,
    DateTime? publishedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _VideoImpl;

  factory Video.fromJson(Map<String, dynamic> jsonSerialization) {
    return Video(
      id: jsonSerialization['id'] as int?,
      authorId: jsonSerialization['authorId'] as String,
      authorName: jsonSerialization['authorName'] as String,
      seriesTitle: jsonSerialization['seriesTitle'] as String?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      category: jsonSerialization['category'] as String,
      contentType: jsonSerialization['contentType'] == null
          ? null
          : _i2.VideoContentType.fromJson(
              (jsonSerialization['contentType'] as String),
            ),
      languageCode: jsonSerialization['languageCode'] as String?,
      tags: _i4.Protocol().deserialize<List<String>>(jsonSerialization['tags']),
      videoStorageKey: jsonSerialization['videoStorageKey'] as String,
      coverStorageKey: jsonSerialization['coverStorageKey'] as String?,
      hlsManifestStorageKey:
          jsonSerialization['hlsManifestStorageKey'] as String?,
      transcoderJobName: jsonSerialization['transcoderJobName'] as String?,
      transcodeState: jsonSerialization['transcodeState'] as String?,
      durationSeconds: jsonSerialization['durationSeconds'] as int,
      viewCount: jsonSerialization['viewCount'] as int?,
      likeCount: jsonSerialization['likeCount'] as int?,
      favoriteCount: jsonSerialization['favoriteCount'] as int?,
      commentCount: jsonSerialization['commentCount'] as int?,
      status: jsonSerialization['status'] == null
          ? null
          : _i3.VideoStatus.fromJson((jsonSerialization['status'] as String)),
      isPublic: jsonSerialization['isPublic'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isPublic']),
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String authorId;

  String authorName;

  String? seriesTitle;

  String title;

  String description;

  String category;

  _i2.VideoContentType contentType;

  String? languageCode;

  List<String> tags;

  String videoStorageKey;

  String? coverStorageKey;

  String? hlsManifestStorageKey;

  String? transcoderJobName;

  String? transcodeState;

  int durationSeconds;

  int viewCount;

  int likeCount;

  int favoriteCount;

  int commentCount;

  _i3.VideoStatus status;

  bool isPublic;

  DateTime? publishedAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Video]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Video copyWith({
    int? id,
    String? authorId,
    String? authorName,
    String? seriesTitle,
    String? title,
    String? description,
    String? category,
    _i2.VideoContentType? contentType,
    String? languageCode,
    List<String>? tags,
    String? videoStorageKey,
    String? coverStorageKey,
    String? hlsManifestStorageKey,
    String? transcoderJobName,
    String? transcodeState,
    int? durationSeconds,
    int? viewCount,
    int? likeCount,
    int? favoriteCount,
    int? commentCount,
    _i3.VideoStatus? status,
    bool? isPublic,
    DateTime? publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Video',
      if (id != null) 'id': id,
      'authorId': authorId,
      'authorName': authorName,
      if (seriesTitle != null) 'seriesTitle': seriesTitle,
      'title': title,
      'description': description,
      'category': category,
      'contentType': contentType.toJson(),
      if (languageCode != null) 'languageCode': languageCode,
      'tags': tags.toJson(),
      'videoStorageKey': videoStorageKey,
      if (coverStorageKey != null) 'coverStorageKey': coverStorageKey,
      if (hlsManifestStorageKey != null)
        'hlsManifestStorageKey': hlsManifestStorageKey,
      if (transcoderJobName != null) 'transcoderJobName': transcoderJobName,
      if (transcodeState != null) 'transcodeState': transcodeState,
      'durationSeconds': durationSeconds,
      'viewCount': viewCount,
      'likeCount': likeCount,
      'favoriteCount': favoriteCount,
      'commentCount': commentCount,
      'status': status.toJson(),
      'isPublic': isPublic,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
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

class _VideoImpl extends Video {
  _VideoImpl({
    int? id,
    required String authorId,
    required String authorName,
    String? seriesTitle,
    required String title,
    required String description,
    required String category,
    _i2.VideoContentType? contentType,
    String? languageCode,
    required List<String> tags,
    required String videoStorageKey,
    String? coverStorageKey,
    String? hlsManifestStorageKey,
    String? transcoderJobName,
    String? transcodeState,
    required int durationSeconds,
    int? viewCount,
    int? likeCount,
    int? favoriteCount,
    int? commentCount,
    _i3.VideoStatus? status,
    bool? isPublic,
    DateTime? publishedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authorId: authorId,
         authorName: authorName,
         seriesTitle: seriesTitle,
         title: title,
         description: description,
         category: category,
         contentType: contentType,
         languageCode: languageCode,
         tags: tags,
         videoStorageKey: videoStorageKey,
         coverStorageKey: coverStorageKey,
         hlsManifestStorageKey: hlsManifestStorageKey,
         transcoderJobName: transcoderJobName,
         transcodeState: transcodeState,
         durationSeconds: durationSeconds,
         viewCount: viewCount,
         likeCount: likeCount,
         favoriteCount: favoriteCount,
         commentCount: commentCount,
         status: status,
         isPublic: isPublic,
         publishedAt: publishedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Video]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Video copyWith({
    Object? id = _Undefined,
    String? authorId,
    String? authorName,
    Object? seriesTitle = _Undefined,
    String? title,
    String? description,
    String? category,
    _i2.VideoContentType? contentType,
    Object? languageCode = _Undefined,
    List<String>? tags,
    String? videoStorageKey,
    Object? coverStorageKey = _Undefined,
    Object? hlsManifestStorageKey = _Undefined,
    Object? transcoderJobName = _Undefined,
    Object? transcodeState = _Undefined,
    int? durationSeconds,
    int? viewCount,
    int? likeCount,
    int? favoriteCount,
    int? commentCount,
    _i3.VideoStatus? status,
    bool? isPublic,
    Object? publishedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Video(
      id: id is int? ? id : this.id,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      seriesTitle: seriesTitle is String? ? seriesTitle : this.seriesTitle,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      contentType: contentType ?? this.contentType,
      languageCode: languageCode is String? ? languageCode : this.languageCode,
      tags: tags ?? this.tags.map((e0) => e0).toList(),
      videoStorageKey: videoStorageKey ?? this.videoStorageKey,
      coverStorageKey: coverStorageKey is String?
          ? coverStorageKey
          : this.coverStorageKey,
      hlsManifestStorageKey: hlsManifestStorageKey is String?
          ? hlsManifestStorageKey
          : this.hlsManifestStorageKey,
      transcoderJobName: transcoderJobName is String?
          ? transcoderJobName
          : this.transcoderJobName,
      transcodeState: transcodeState is String?
          ? transcodeState
          : this.transcodeState,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      viewCount: viewCount ?? this.viewCount,
      likeCount: likeCount ?? this.likeCount,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      commentCount: commentCount ?? this.commentCount,
      status: status ?? this.status,
      isPublic: isPublic ?? this.isPublic,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
