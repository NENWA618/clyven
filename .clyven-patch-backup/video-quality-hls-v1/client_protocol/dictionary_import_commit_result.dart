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

abstract class DictionaryImportCommitResult implements _i1.SerializableModel {
  DictionaryImportCommitResult._({
    required this.totalRows,
    required this.insertedEntries,
    required this.mergedEntries,
    required this.skippedRows,
    required this.failedRows,
    required this.messages,
  });

  factory DictionaryImportCommitResult({
    required int totalRows,
    required int insertedEntries,
    required int mergedEntries,
    required int skippedRows,
    required int failedRows,
    required List<String> messages,
  }) = _DictionaryImportCommitResultImpl;

  factory DictionaryImportCommitResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DictionaryImportCommitResult(
      totalRows: jsonSerialization['totalRows'] as int,
      insertedEntries: jsonSerialization['insertedEntries'] as int,
      mergedEntries: jsonSerialization['mergedEntries'] as int,
      skippedRows: jsonSerialization['skippedRows'] as int,
      failedRows: jsonSerialization['failedRows'] as int,
      messages: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['messages'],
      ),
    );
  }

  int totalRows;

  int insertedEntries;

  int mergedEntries;

  int skippedRows;

  int failedRows;

  List<String> messages;

  /// Returns a shallow copy of this [DictionaryImportCommitResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryImportCommitResult copyWith({
    int? totalRows,
    int? insertedEntries,
    int? mergedEntries,
    int? skippedRows,
    int? failedRows,
    List<String>? messages,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryImportCommitResult',
      'totalRows': totalRows,
      'insertedEntries': insertedEntries,
      'mergedEntries': mergedEntries,
      'skippedRows': skippedRows,
      'failedRows': failedRows,
      'messages': messages.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DictionaryImportCommitResultImpl extends DictionaryImportCommitResult {
  _DictionaryImportCommitResultImpl({
    required int totalRows,
    required int insertedEntries,
    required int mergedEntries,
    required int skippedRows,
    required int failedRows,
    required List<String> messages,
  }) : super._(
         totalRows: totalRows,
         insertedEntries: insertedEntries,
         mergedEntries: mergedEntries,
         skippedRows: skippedRows,
         failedRows: failedRows,
         messages: messages,
       );

  /// Returns a shallow copy of this [DictionaryImportCommitResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryImportCommitResult copyWith({
    int? totalRows,
    int? insertedEntries,
    int? mergedEntries,
    int? skippedRows,
    int? failedRows,
    List<String>? messages,
  }) {
    return DictionaryImportCommitResult(
      totalRows: totalRows ?? this.totalRows,
      insertedEntries: insertedEntries ?? this.insertedEntries,
      mergedEntries: mergedEntries ?? this.mergedEntries,
      skippedRows: skippedRows ?? this.skippedRows,
      failedRows: failedRows ?? this.failedRows,
      messages: messages ?? this.messages.map((e0) => e0).toList(),
    );
  }
}
