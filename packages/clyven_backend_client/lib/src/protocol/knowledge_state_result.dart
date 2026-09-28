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

abstract class KnowledgeStateResult implements _i1.SerializableModel {
  KnowledgeStateResult._({
    required this.languageCode,
    required this.normalizedText,
    required this.entryType,
    required this.state,
  });

  factory KnowledgeStateResult({
    required String languageCode,
    required String normalizedText,
    required String entryType,
    required String state,
  }) = _KnowledgeStateResultImpl;

  factory KnowledgeStateResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return KnowledgeStateResult(
      languageCode: jsonSerialization['languageCode'] as String,
      normalizedText: jsonSerialization['normalizedText'] as String,
      entryType: jsonSerialization['entryType'] as String,
      state: jsonSerialization['state'] as String,
    );
  }

  String languageCode;

  String normalizedText;

  String entryType;

  String state;

  /// Returns a shallow copy of this [KnowledgeStateResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  KnowledgeStateResult copyWith({
    String? languageCode,
    String? normalizedText,
    String? entryType,
    String? state,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'KnowledgeStateResult',
      'languageCode': languageCode,
      'normalizedText': normalizedText,
      'entryType': entryType,
      'state': state,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _KnowledgeStateResultImpl extends KnowledgeStateResult {
  _KnowledgeStateResultImpl({
    required String languageCode,
    required String normalizedText,
    required String entryType,
    required String state,
  }) : super._(
         languageCode: languageCode,
         normalizedText: normalizedText,
         entryType: entryType,
         state: state,
       );

  /// Returns a shallow copy of this [KnowledgeStateResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  KnowledgeStateResult copyWith({
    String? languageCode,
    String? normalizedText,
    String? entryType,
    String? state,
  }) {
    return KnowledgeStateResult(
      languageCode: languageCode ?? this.languageCode,
      normalizedText: normalizedText ?? this.normalizedText,
      entryType: entryType ?? this.entryType,
      state: state ?? this.state,
    );
  }
}
