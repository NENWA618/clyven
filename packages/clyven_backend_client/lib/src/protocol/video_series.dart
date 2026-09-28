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

abstract class VideoSeries implements _i1.SerializableModel {
  VideoSeries._({
    this.id,
    required this.creatorId,
    required this.title,
    required this.description,
    this.coverStorageKey,
    this.languageCode,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VideoSeries({
    int? id,
    required String creatorId,
    required String title,
    required String description,
    String? coverStorageKey,
    String? languageCode,
    required String category,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _VideoSeriesImpl;

  factory VideoSeries.fromJson(Map<String, dynamic> jsonSerialization) {
    return VideoSeries(
      id: jsonSerialization['id'] as int?,
      creatorId: jsonSerialization['creatorId'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      coverStorageKey: jsonSerialization['coverStorageKey'] as String?,
      languageCode: jsonSerialization['languageCode'] as String?,
      category: jsonSerialization['category'] as String,
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

  String creatorId;

  String title;

  String description;

  String? coverStorageKey;

  String? languageCode;

  String category;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [VideoSeries]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VideoSeries copyWith({
    int? id,
    String? creatorId,
    String? title,
    String? description,
    String? coverStorageKey,
    String? languageCode,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VideoSeries',
      if (id != null) 'id': id,
      'creatorId': creatorId,
      'title': title,
      'description': description,
      if (coverStorageKey != null) 'coverStorageKey': coverStorageKey,
      if (languageCode != null) 'languageCode': languageCode,
      'category': category,
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

class _VideoSeriesImpl extends VideoSeries {
  _VideoSeriesImpl({
    int? id,
    required String creatorId,
    required String title,
    required String description,
    String? coverStorageKey,
    String? languageCode,
    required String category,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         creatorId: creatorId,
         title: title,
         description: description,
         coverStorageKey: coverStorageKey,
         languageCode: languageCode,
         category: category,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [VideoSeries]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VideoSeries copyWith({
    Object? id = _Undefined,
    String? creatorId,
    String? title,
    String? description,
    Object? coverStorageKey = _Undefined,
    Object? languageCode = _Undefined,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VideoSeries(
      id: id is int? ? id : this.id,
      creatorId: creatorId ?? this.creatorId,
      title: title ?? this.title,
      description: description ?? this.description,
      coverStorageKey: coverStorageKey is String?
          ? coverStorageKey
          : this.coverStorageKey,
      languageCode: languageCode is String? ? languageCode : this.languageCode,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
