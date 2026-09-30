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

abstract class SubtitleTrack implements _i1.SerializableModel {
  SubtitleTrack._({
    this.id,
    required this.videoId,
    required this.languageCode,
    this.variantCode,
    required this.label,
    this.defaultScriptCode,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isDefault = isDefault ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubtitleTrack({
    int? id,
    required int videoId,
    required String languageCode,
    String? variantCode,
    required String label,
    String? defaultScriptCode,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubtitleTrackImpl;

  factory SubtitleTrack.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtitleTrack(
      id: jsonSerialization['id'] as int?,
      videoId: jsonSerialization['videoId'] as int,
      languageCode: jsonSerialization['languageCode'] as String,
      variantCode: jsonSerialization['variantCode'] as String?,
      label: jsonSerialization['label'] as String,
      defaultScriptCode: jsonSerialization['defaultScriptCode'] as String?,
      isDefault: jsonSerialization['isDefault'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isDefault']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int videoId;

  String languageCode;

  String? variantCode;

  String label;

  String? defaultScriptCode;

  bool isDefault;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [SubtitleTrack]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleTrack copyWith({
    int? id,
    int? videoId,
    String? languageCode,
    String? variantCode,
    String? label,
    String? defaultScriptCode,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleTrack',
      if (id != null) 'id': id,
      'videoId': videoId,
      'languageCode': languageCode,
      if (variantCode != null) 'variantCode': variantCode,
      'label': label,
      if (defaultScriptCode != null) 'defaultScriptCode': defaultScriptCode,
      'isDefault': isDefault,
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

class _SubtitleTrackImpl extends SubtitleTrack {
  _SubtitleTrackImpl({
    int? id,
    required int videoId,
    required String languageCode,
    String? variantCode,
    required String label,
    String? defaultScriptCode,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         videoId: videoId,
         languageCode: languageCode,
         variantCode: variantCode,
         label: label,
         defaultScriptCode: defaultScriptCode,
         isDefault: isDefault,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubtitleTrack]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleTrack copyWith({
    Object? id = _Undefined,
    int? videoId,
    String? languageCode,
    Object? variantCode = _Undefined,
    String? label,
    Object? defaultScriptCode = _Undefined,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubtitleTrack(
      id: id is int? ? id : this.id,
      videoId: videoId ?? this.videoId,
      languageCode: languageCode ?? this.languageCode,
      variantCode: variantCode is String? ? variantCode : this.variantCode,
      label: label ?? this.label,
      defaultScriptCode: defaultScriptCode is String?
          ? defaultScriptCode
          : this.defaultScriptCode,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
