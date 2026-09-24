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

abstract class EntryKnowledgeState implements _i1.SerializableModel {
  EntryKnowledgeState._({
    required this.entryId,
    required this.state,
  });

  factory EntryKnowledgeState({
    required int entryId,
    required String state,
  }) = _EntryKnowledgeStateImpl;

  factory EntryKnowledgeState.fromJson(Map<String, dynamic> jsonSerialization) {
    return EntryKnowledgeState(
      entryId: jsonSerialization['entryId'] as int,
      state: jsonSerialization['state'] as String,
    );
  }

  int entryId;

  String state;

  /// Returns a shallow copy of this [EntryKnowledgeState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EntryKnowledgeState copyWith({
    int? entryId,
    String? state,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EntryKnowledgeState',
      'entryId': entryId,
      'state': state,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _EntryKnowledgeStateImpl extends EntryKnowledgeState {
  _EntryKnowledgeStateImpl({
    required int entryId,
    required String state,
  }) : super._(
         entryId: entryId,
         state: state,
       );

  /// Returns a shallow copy of this [EntryKnowledgeState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EntryKnowledgeState copyWith({
    int? entryId,
    String? state,
  }) {
    return EntryKnowledgeState(
      entryId: entryId ?? this.entryId,
      state: state ?? this.state,
    );
  }
}
