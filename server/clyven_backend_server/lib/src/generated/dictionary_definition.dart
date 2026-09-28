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

import 'package:serverpod/serverpod.dart' as _i1;

abstract class DictionaryDefinition
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DictionaryDefinition._({
    this.id,
    required this.entryId,
    required this.explanationLanguageCode,
    required this.gloss,
    this.definition,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DictionaryDefinition({
    int? id,
    required int entryId,
    required String explanationLanguageCode,
    required String gloss,
    String? definition,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DictionaryDefinitionImpl;

  factory DictionaryDefinition.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DictionaryDefinition(
      id: jsonSerialization['id'] as int?,
      entryId: jsonSerialization['entryId'] as int,
      explanationLanguageCode:
          jsonSerialization['explanationLanguageCode'] as String,
      gloss: jsonSerialization['gloss'] as String,
      definition: jsonSerialization['definition'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = DictionaryDefinitionTable();

  static const db = DictionaryDefinitionRepository._();

  @override
  int? id;

  int entryId;

  String explanationLanguageCode;

  String gloss;

  String? definition;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DictionaryDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryDefinition copyWith({
    int? id,
    int? entryId,
    String? explanationLanguageCode,
    String? gloss,
    String? definition,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryDefinition',
      if (id != null) 'id': id,
      'entryId': entryId,
      'explanationLanguageCode': explanationLanguageCode,
      'gloss': gloss,
      if (definition != null) 'definition': definition,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DictionaryDefinition',
      if (id != null) 'id': id,
      'entryId': entryId,
      'explanationLanguageCode': explanationLanguageCode,
      'gloss': gloss,
      if (definition != null) 'definition': definition,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DictionaryDefinitionInclude include() {
    return DictionaryDefinitionInclude._();
  }

  static DictionaryDefinitionIncludeList includeList({
    _i1.WhereExpressionBuilder<DictionaryDefinitionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryDefinitionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryDefinitionTable>? orderByList,
    DictionaryDefinitionInclude? include,
  }) {
    return DictionaryDefinitionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryDefinition.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DictionaryDefinition.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DictionaryDefinitionImpl extends DictionaryDefinition {
  _DictionaryDefinitionImpl({
    int? id,
    required int entryId,
    required String explanationLanguageCode,
    required String gloss,
    String? definition,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         entryId: entryId,
         explanationLanguageCode: explanationLanguageCode,
         gloss: gloss,
         definition: definition,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DictionaryDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryDefinition copyWith({
    Object? id = _Undefined,
    int? entryId,
    String? explanationLanguageCode,
    String? gloss,
    Object? definition = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DictionaryDefinition(
      id: id is int? ? id : this.id,
      entryId: entryId ?? this.entryId,
      explanationLanguageCode:
          explanationLanguageCode ?? this.explanationLanguageCode,
      gloss: gloss ?? this.gloss,
      definition: definition is String? ? definition : this.definition,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DictionaryDefinitionUpdateTable
    extends _i1.UpdateTable<DictionaryDefinitionTable> {
  DictionaryDefinitionUpdateTable(super.table);

  _i1.ColumnValue<int, int> entryId(int value) => _i1.ColumnValue(
    table.entryId,
    value,
  );

  _i1.ColumnValue<String, String> explanationLanguageCode(String value) =>
      _i1.ColumnValue(
        table.explanationLanguageCode,
        value,
      );

  _i1.ColumnValue<String, String> gloss(String value) => _i1.ColumnValue(
    table.gloss,
    value,
  );

  _i1.ColumnValue<String, String> definition(String? value) => _i1.ColumnValue(
    table.definition,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class DictionaryDefinitionTable extends _i1.Table<int?> {
  DictionaryDefinitionTable({super.tableRelation})
    : super(tableName: 'dictionary_definition') {
    updateTable = DictionaryDefinitionUpdateTable(this);
    entryId = _i1.ColumnInt(
      'entryId',
      this,
    );
    explanationLanguageCode = _i1.ColumnString(
      'explanationLanguageCode',
      this,
    );
    gloss = _i1.ColumnString(
      'gloss',
      this,
    );
    definition = _i1.ColumnString(
      'definition',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final DictionaryDefinitionUpdateTable updateTable;

  late final _i1.ColumnInt entryId;

  late final _i1.ColumnString explanationLanguageCode;

  late final _i1.ColumnString gloss;

  late final _i1.ColumnString definition;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    entryId,
    explanationLanguageCode,
    gloss,
    definition,
    createdAt,
    updatedAt,
  ];
}

class DictionaryDefinitionInclude extends _i1.IncludeObject {
  DictionaryDefinitionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DictionaryDefinition.t;
}

class DictionaryDefinitionIncludeList extends _i1.IncludeList {
  DictionaryDefinitionIncludeList._({
    _i1.WhereExpressionBuilder<DictionaryDefinitionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DictionaryDefinition.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DictionaryDefinition.t;
}

class DictionaryDefinitionRepository {
  const DictionaryDefinitionRepository._();

  /// Returns a list of [DictionaryDefinition]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<DictionaryDefinition>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryDefinitionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryDefinitionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryDefinitionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DictionaryDefinition>(
      where: where?.call(DictionaryDefinition.t),
      orderBy: orderBy?.call(DictionaryDefinition.t),
      orderByList: orderByList?.call(DictionaryDefinition.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DictionaryDefinition] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<DictionaryDefinition?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryDefinitionTable>? where,
    int? offset,
    _i1.OrderByBuilder<DictionaryDefinitionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryDefinitionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DictionaryDefinition>(
      where: where?.call(DictionaryDefinition.t),
      orderBy: orderBy?.call(DictionaryDefinition.t),
      orderByList: orderByList?.call(DictionaryDefinition.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DictionaryDefinition] by its [id] or null if no such row exists.
  Future<DictionaryDefinition?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DictionaryDefinition>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DictionaryDefinition]s in the list and returns the inserted rows.
  ///
  /// The returned [DictionaryDefinition]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DictionaryDefinition>> insert(
    _i1.DatabaseSession session,
    List<DictionaryDefinition> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DictionaryDefinition>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DictionaryDefinition] and returns the inserted row.
  ///
  /// The returned [DictionaryDefinition] will have its `id` field set.
  Future<DictionaryDefinition> insertRow(
    _i1.DatabaseSession session,
    DictionaryDefinition row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DictionaryDefinition>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryDefinition]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DictionaryDefinition>> update(
    _i1.DatabaseSession session,
    List<DictionaryDefinition> rows, {
    _i1.ColumnSelections<DictionaryDefinitionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DictionaryDefinition>(
      rows,
      columns: columns?.call(DictionaryDefinition.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryDefinition]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DictionaryDefinition> updateRow(
    _i1.DatabaseSession session,
    DictionaryDefinition row, {
    _i1.ColumnSelections<DictionaryDefinitionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DictionaryDefinition>(
      row,
      columns: columns?.call(DictionaryDefinition.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryDefinition] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DictionaryDefinition?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DictionaryDefinitionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DictionaryDefinition>(
      id,
      columnValues: columnValues(DictionaryDefinition.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryDefinition]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DictionaryDefinition>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DictionaryDefinitionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DictionaryDefinitionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryDefinitionTable>? orderBy,
    _i1.OrderByListBuilder<DictionaryDefinitionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DictionaryDefinition>(
      columnValues: columnValues(DictionaryDefinition.t.updateTable),
      where: where(DictionaryDefinition.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryDefinition.t),
      orderByList: orderByList?.call(DictionaryDefinition.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DictionaryDefinition]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DictionaryDefinition>> delete(
    _i1.DatabaseSession session,
    List<DictionaryDefinition> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DictionaryDefinition>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DictionaryDefinition].
  Future<DictionaryDefinition> deleteRow(
    _i1.DatabaseSession session,
    DictionaryDefinition row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DictionaryDefinition>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DictionaryDefinition>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryDefinitionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DictionaryDefinition>(
      where: where(DictionaryDefinition.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryDefinitionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DictionaryDefinition>(
      where: where?.call(DictionaryDefinition.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DictionaryDefinition] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryDefinitionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DictionaryDefinition>(
      where: where(DictionaryDefinition.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
