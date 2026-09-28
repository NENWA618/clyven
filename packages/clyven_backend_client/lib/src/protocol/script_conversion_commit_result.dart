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

abstract class ScriptConversionCommitResult implements _i1.SerializableModel {
  ScriptConversionCommitResult._({
    required this.profileId,
    required this.totalRows,
    required this.insertedRows,
    required this.updatedRows,
    required this.skippedRows,
  });

  factory ScriptConversionCommitResult({
    required int profileId,
    required int totalRows,
    required int insertedRows,
    required int updatedRows,
    required int skippedRows,
  }) = _ScriptConversionCommitResultImpl;

  factory ScriptConversionCommitResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ScriptConversionCommitResult(
      profileId: jsonSerialization['profileId'] as int,
      totalRows: jsonSerialization['totalRows'] as int,
      insertedRows: jsonSerialization['insertedRows'] as int,
      updatedRows: jsonSerialization['updatedRows'] as int,
      skippedRows: jsonSerialization['skippedRows'] as int,
    );
  }

  int profileId;

  int totalRows;

  int insertedRows;

  int updatedRows;

  int skippedRows;

  /// Returns a shallow copy of this [ScriptConversionCommitResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScriptConversionCommitResult copyWith({
    int? profileId,
    int? totalRows,
    int? insertedRows,
    int? updatedRows,
    int? skippedRows,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScriptConversionCommitResult',
      'profileId': profileId,
      'totalRows': totalRows,
      'insertedRows': insertedRows,
      'updatedRows': updatedRows,
      'skippedRows': skippedRows,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ScriptConversionCommitResultImpl extends ScriptConversionCommitResult {
  _ScriptConversionCommitResultImpl({
    required int profileId,
    required int totalRows,
    required int insertedRows,
    required int updatedRows,
    required int skippedRows,
  }) : super._(
         profileId: profileId,
         totalRows: totalRows,
         insertedRows: insertedRows,
         updatedRows: updatedRows,
         skippedRows: skippedRows,
       );

  /// Returns a shallow copy of this [ScriptConversionCommitResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScriptConversionCommitResult copyWith({
    int? profileId,
    int? totalRows,
    int? insertedRows,
    int? updatedRows,
    int? skippedRows,
  }) {
    return ScriptConversionCommitResult(
      profileId: profileId ?? this.profileId,
      totalRows: totalRows ?? this.totalRows,
      insertedRows: insertedRows ?? this.insertedRows,
      updatedRows: updatedRows ?? this.updatedRows,
      skippedRows: skippedRows ?? this.skippedRows,
    );
  }
}
