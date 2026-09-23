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
import 'package:clyven_backend_client/src/protocol/protocol.dart' as _i2;

abstract class SubtitleSrtPreview implements _i1.SerializableModel {
  SubtitleSrtPreview._({
    required this.cueCount,
    required this.errorCount,
    required this.errors,
    required this.canImport,
  });

  factory SubtitleSrtPreview({
    required int cueCount,
    required int errorCount,
    required List<String> errors,
    required bool canImport,
  }) = _SubtitleSrtPreviewImpl;

  factory SubtitleSrtPreview.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtitleSrtPreview(
      cueCount: jsonSerialization['cueCount'] as int,
      errorCount: jsonSerialization['errorCount'] as int,
      errors: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['errors'],
      ),
      canImport: _i1.BoolJsonExtension.fromJson(jsonSerialization['canImport']),
    );
  }

  int cueCount;

  int errorCount;

  List<String> errors;

  bool canImport;

  /// Returns a shallow copy of this [SubtitleSrtPreview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleSrtPreview copyWith({
    int? cueCount,
    int? errorCount,
    List<String>? errors,
    bool? canImport,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleSrtPreview',
      'cueCount': cueCount,
      'errorCount': errorCount,
      'errors': errors.toJson(),
      'canImport': canImport,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SubtitleSrtPreviewImpl extends SubtitleSrtPreview {
  _SubtitleSrtPreviewImpl({
    required int cueCount,
    required int errorCount,
    required List<String> errors,
    required bool canImport,
  }) : super._(
         cueCount: cueCount,
         errorCount: errorCount,
         errors: errors,
         canImport: canImport,
       );

  /// Returns a shallow copy of this [SubtitleSrtPreview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleSrtPreview copyWith({
    int? cueCount,
    int? errorCount,
    List<String>? errors,
    bool? canImport,
  }) {
    return SubtitleSrtPreview(
      cueCount: cueCount ?? this.cueCount,
      errorCount: errorCount ?? this.errorCount,
      errors: errors ?? this.errors.map((e0) => e0).toList(),
      canImport: canImport ?? this.canImport,
    );
  }
}
