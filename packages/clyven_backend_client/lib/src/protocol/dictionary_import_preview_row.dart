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

abstract class DictionaryImportPreviewRow implements _i1.SerializableModel {
  DictionaryImportPreviewRow._({
    required this.rowNumber,
    this.headword,
    this.entryType,
    required this.status,
    this.message,
    required this.normalizedJson,
  });

  factory DictionaryImportPreviewRow({
    required int rowNumber,
    String? headword,
    String? entryType,
    required String status,
    String? message,
    required String normalizedJson,
  }) = _DictionaryImportPreviewRowImpl;

  factory DictionaryImportPreviewRow.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DictionaryImportPreviewRow(
      rowNumber: jsonSerialization['rowNumber'] as int,
      headword: jsonSerialization['headword'] as String?,
      entryType: jsonSerialization['entryType'] as String?,
      status: jsonSerialization['status'] as String,
      message: jsonSerialization['message'] as String?,
      normalizedJson: jsonSerialization['normalizedJson'] as String,
    );
  }

  int rowNumber;

  String? headword;

  String? entryType;

  String status;

  String? message;

  String normalizedJson;

  /// Returns a shallow copy of this [DictionaryImportPreviewRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryImportPreviewRow copyWith({
    int? rowNumber,
    String? headword,
    String? entryType,
    String? status,
    String? message,
    String? normalizedJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryImportPreviewRow',
      'rowNumber': rowNumber,
      if (headword != null) 'headword': headword,
      if (entryType != null) 'entryType': entryType,
      'status': status,
      if (message != null) 'message': message,
      'normalizedJson': normalizedJson,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DictionaryImportPreviewRowImpl extends DictionaryImportPreviewRow {
  _DictionaryImportPreviewRowImpl({
    required int rowNumber,
    String? headword,
    String? entryType,
    required String status,
    String? message,
    required String normalizedJson,
  }) : super._(
         rowNumber: rowNumber,
         headword: headword,
         entryType: entryType,
         status: status,
         message: message,
         normalizedJson: normalizedJson,
       );

  /// Returns a shallow copy of this [DictionaryImportPreviewRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryImportPreviewRow copyWith({
    int? rowNumber,
    Object? headword = _Undefined,
    Object? entryType = _Undefined,
    String? status,
    Object? message = _Undefined,
    String? normalizedJson,
  }) {
    return DictionaryImportPreviewRow(
      rowNumber: rowNumber ?? this.rowNumber,
      headword: headword is String? ? headword : this.headword,
      entryType: entryType is String? ? entryType : this.entryType,
      status: status ?? this.status,
      message: message is String? ? message : this.message,
      normalizedJson: normalizedJson ?? this.normalizedJson,
    );
  }
}
