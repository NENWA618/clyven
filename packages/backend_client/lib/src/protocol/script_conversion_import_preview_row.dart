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

abstract class ScriptConversionImportPreviewRow
    implements _i1.SerializableModel {
  ScriptConversionImportPreviewRow._({
    required this.rowNumber,
    this.sourceText,
    this.targetText,
    required this.priority,
    required this.entryType,
    required this.status,
    this.message,
  });

  factory ScriptConversionImportPreviewRow({
    required int rowNumber,
    String? sourceText,
    String? targetText,
    required int priority,
    required String entryType,
    required String status,
    String? message,
  }) = _ScriptConversionImportPreviewRowImpl;

  factory ScriptConversionImportPreviewRow.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ScriptConversionImportPreviewRow(
      rowNumber: jsonSerialization['rowNumber'] as int,
      sourceText: jsonSerialization['sourceText'] as String?,
      targetText: jsonSerialization['targetText'] as String?,
      priority: jsonSerialization['priority'] as int,
      entryType: jsonSerialization['entryType'] as String,
      status: jsonSerialization['status'] as String,
      message: jsonSerialization['message'] as String?,
    );
  }

  int rowNumber;

  String? sourceText;

  String? targetText;

  int priority;

  String entryType;

  String status;

  String? message;

  /// Returns a shallow copy of this [ScriptConversionImportPreviewRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScriptConversionImportPreviewRow copyWith({
    int? rowNumber,
    String? sourceText,
    String? targetText,
    int? priority,
    String? entryType,
    String? status,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScriptConversionImportPreviewRow',
      'rowNumber': rowNumber,
      if (sourceText != null) 'sourceText': sourceText,
      if (targetText != null) 'targetText': targetText,
      'priority': priority,
      'entryType': entryType,
      'status': status,
      if (message != null) 'message': message,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScriptConversionImportPreviewRowImpl
    extends ScriptConversionImportPreviewRow {
  _ScriptConversionImportPreviewRowImpl({
    required int rowNumber,
    String? sourceText,
    String? targetText,
    required int priority,
    required String entryType,
    required String status,
    String? message,
  }) : super._(
         rowNumber: rowNumber,
         sourceText: sourceText,
         targetText: targetText,
         priority: priority,
         entryType: entryType,
         status: status,
         message: message,
       );

  /// Returns a shallow copy of this [ScriptConversionImportPreviewRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScriptConversionImportPreviewRow copyWith({
    int? rowNumber,
    Object? sourceText = _Undefined,
    Object? targetText = _Undefined,
    int? priority,
    String? entryType,
    String? status,
    Object? message = _Undefined,
  }) {
    return ScriptConversionImportPreviewRow(
      rowNumber: rowNumber ?? this.rowNumber,
      sourceText: sourceText is String? ? sourceText : this.sourceText,
      targetText: targetText is String? ? targetText : this.targetText,
      priority: priority ?? this.priority,
      entryType: entryType ?? this.entryType,
      status: status ?? this.status,
      message: message is String? ? message : this.message,
    );
  }
}
