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
import 'asr_job_status.dart' as _i2;

abstract class AsrJob implements _i1.SerializableModel {
  AsrJob._({
    this.id,
    required this.videoId,
    required this.requestedLanguageCode,
    this.detectedLanguageCode,
    required this.provider,
    _i2.AsrJobStatus? status,
    this.trackId,
    this.errorMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : status = status ?? _i2.AsrJobStatus.queued,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory AsrJob({
    int? id,
    required int videoId,
    required String requestedLanguageCode,
    String? detectedLanguageCode,
    required String provider,
    _i2.AsrJobStatus? status,
    int? trackId,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AsrJobImpl;

  factory AsrJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return AsrJob(
      id: jsonSerialization['id'] as int?,
      videoId: jsonSerialization['videoId'] as int,
      requestedLanguageCode:
          jsonSerialization['requestedLanguageCode'] as String,
      detectedLanguageCode:
          jsonSerialization['detectedLanguageCode'] as String?,
      provider: jsonSerialization['provider'] as String,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.AsrJobStatus.fromJson((jsonSerialization['status'] as String)),
      trackId: jsonSerialization['trackId'] as int?,
      errorMessage: jsonSerialization['errorMessage'] as String?,
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

  String requestedLanguageCode;

  String? detectedLanguageCode;

  String provider;

  _i2.AsrJobStatus status;

  int? trackId;

  String? errorMessage;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [AsrJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AsrJob copyWith({
    int? id,
    int? videoId,
    String? requestedLanguageCode,
    String? detectedLanguageCode,
    String? provider,
    _i2.AsrJobStatus? status,
    int? trackId,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AsrJob',
      if (id != null) 'id': id,
      'videoId': videoId,
      'requestedLanguageCode': requestedLanguageCode,
      if (detectedLanguageCode != null)
        'detectedLanguageCode': detectedLanguageCode,
      'provider': provider,
      'status': status.toJson(),
      if (trackId != null) 'trackId': trackId,
      if (errorMessage != null) 'errorMessage': errorMessage,
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

class _AsrJobImpl extends AsrJob {
  _AsrJobImpl({
    int? id,
    required int videoId,
    required String requestedLanguageCode,
    String? detectedLanguageCode,
    required String provider,
    _i2.AsrJobStatus? status,
    int? trackId,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         videoId: videoId,
         requestedLanguageCode: requestedLanguageCode,
         detectedLanguageCode: detectedLanguageCode,
         provider: provider,
         status: status,
         trackId: trackId,
         errorMessage: errorMessage,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AsrJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AsrJob copyWith({
    Object? id = _Undefined,
    int? videoId,
    String? requestedLanguageCode,
    Object? detectedLanguageCode = _Undefined,
    String? provider,
    _i2.AsrJobStatus? status,
    Object? trackId = _Undefined,
    Object? errorMessage = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AsrJob(
      id: id is int? ? id : this.id,
      videoId: videoId ?? this.videoId,
      requestedLanguageCode:
          requestedLanguageCode ?? this.requestedLanguageCode,
      detectedLanguageCode: detectedLanguageCode is String?
          ? detectedLanguageCode
          : this.detectedLanguageCode,
      provider: provider ?? this.provider,
      status: status ?? this.status,
      trackId: trackId is int? ? trackId : this.trackId,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
