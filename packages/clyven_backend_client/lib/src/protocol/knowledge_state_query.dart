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

abstract class KnowledgeStateQuery implements _i1.SerializableModel {
  KnowledgeStateQuery._({
    required this.languageCode,
    required this.normalizedText,
    required this.entryType,
  });

  factory KnowledgeStateQuery({
    required String languageCode,
    required String normalizedText,
    required String entryType,
  }) = _KnowledgeStateQueryImpl;

  factory KnowledgeStateQuery.fromJson(Map<String, dynamic> jsonSerialization) {
    return KnowledgeStateQuery(
      languageCode: jsonSerialization['languageCode'] as String,
      normalizedText: jsonSerialization['normalizedText'] as String,
      entryType: jsonSerialization['entryType'] as String,
    );
  }

  String languageCode;

  String normalizedText;

  String entryType;

  /// Returns a shallow copy of this [KnowledgeStateQuery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  KnowledgeStateQuery copyWith({
    String? languageCode,
    String? normalizedText,
    String? entryType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'KnowledgeStateQuery',
      'languageCode': languageCode,
      'normalizedText': normalizedText,
      'entryType': entryType,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _KnowledgeStateQueryImpl extends KnowledgeStateQuery {
  _KnowledgeStateQueryImpl({
    required String languageCode,
    required String normalizedText,
    required String entryType,
  }) : super._(
         languageCode: languageCode,
         normalizedText: normalizedText,
         entryType: entryType,
       );

  /// Returns a shallow copy of this [KnowledgeStateQuery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  KnowledgeStateQuery copyWith({
    String? languageCode,
    String? normalizedText,
    String? entryType,
  }) {
    return KnowledgeStateQuery(
      languageCode: languageCode ?? this.languageCode,
      normalizedText: normalizedText ?? this.normalizedText,
      entryType: entryType ?? this.entryType,
    );
  }
}
