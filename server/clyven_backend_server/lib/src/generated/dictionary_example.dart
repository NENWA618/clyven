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

abstract class DictionaryExample
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DictionaryExample._({
    this.id,
    required this.entryId,
    required this.position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DictionaryExample({
    int? id,
    required int entryId,
    required int position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DictionaryExampleImpl;

  factory DictionaryExample.fromJson(Map<String, dynamic> jsonSerialization) {
    return DictionaryExample(
      id: jsonSerialization['id'] as int?,
      entryId: jsonSerialization['entryId'] as int,
      position: jsonSerialization['position'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = DictionaryExampleTable();

  static const db = DictionaryExampleRepository._();

  @override
  int? id;

  int entryId;

  int position;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DictionaryExample]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryExample copyWith({
    int? id,
    int? entryId,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryExample',
      if (id != null) 'id': id,
      'entryId': entryId,
      'position': position,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DictionaryExample',
      if (id != null) 'id': id,
      'entryId': entryId,
      'position': position,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DictionaryExampleInclude include() {
    return DictionaryExampleInclude._();
  }

  static DictionaryExampleIncludeList includeList({
    _i1.WhereExpressionBuilder<DictionaryExampleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryExampleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryExampleTable>? orderByList,
    DictionaryExampleInclude? include,
  }) {
    return DictionaryExampleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryExample.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DictionaryExample.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DictionaryExampleImpl extends DictionaryExample {
  _DictionaryExampleImpl({
    int? id,
    required int entryId,
    required int position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         entryId: entryId,
         position: position,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DictionaryExample]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryExample copyWith({
    Object? id = _Undefined,
    int? entryId,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DictionaryExample(
      id: id is int? ? id : this.id,
      entryId: entryId ?? this.entryId,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DictionaryExampleUpdateTable
    extends _i1.UpdateTable<DictionaryExampleTable> {
  DictionaryExampleUpdateTable(super.table);

  _i1.ColumnValue<int, int> entryId(int value) => _i1.ColumnValue(
    table.entryId,
    value,
  );

  _i1.ColumnValue<int, int> position(int value) => _i1.ColumnValue(
    table.position,
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

class DictionaryExampleTable extends _i1.Table<int?> {
  DictionaryExampleTable({super.tableRelation})
    : super(tableName: 'dictionary_example') {
    updateTable = DictionaryExampleUpdateTable(this);
    entryId = _i1.ColumnInt(
      'entryId',
      this,
    );
    position = _i1.ColumnInt(
      'position',
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

  late final DictionaryExampleUpdateTable updateTable;

  late final _i1.ColumnInt entryId;

  late final _i1.ColumnInt position;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    entryId,
    position,
    createdAt,
    updatedAt,
  ];
}

class DictionaryExampleInclude extends _i1.IncludeObject {
  DictionaryExampleInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DictionaryExample.t;
}

class DictionaryExampleIncludeList extends _i1.IncludeList {
  DictionaryExampleIncludeList._({
    _i1.WhereExpressionBuilder<DictionaryExampleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DictionaryExample.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DictionaryExample.t;
}

class DictionaryExampleRepository {
  const DictionaryExampleRepository._();

  /// Returns a list of [DictionaryExample]s matching the given query parameters.
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
  Future<List<DictionaryExample>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryExampleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryExampleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryExampleTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DictionaryExample>(
      where: where?.call(DictionaryExample.t),
      orderBy: orderBy?.call(DictionaryExample.t),
      orderByList: orderByList?.call(DictionaryExample.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DictionaryExample] matching the given query parameters.
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
  Future<DictionaryExample?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryExampleTable>? where,
    int? offset,
    _i1.OrderByBuilder<DictionaryExampleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryExampleTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DictionaryExample>(
      where: where?.call(DictionaryExample.t),
      orderBy: orderBy?.call(DictionaryExample.t),
      orderByList: orderByList?.call(DictionaryExample.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DictionaryExample] by its [id] or null if no such row exists.
  Future<DictionaryExample?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DictionaryExample>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DictionaryExample]s in the list and returns the inserted rows.
  ///
  /// The returned [DictionaryExample]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DictionaryExample>> insert(
    _i1.DatabaseSession session,
    List<DictionaryExample> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DictionaryExample>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DictionaryExample] and returns the inserted row.
  ///
  /// The returned [DictionaryExample] will have its `id` field set.
  Future<DictionaryExample> insertRow(
    _i1.DatabaseSession session,
    DictionaryExample row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DictionaryExample>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryExample]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DictionaryExample>> update(
    _i1.DatabaseSession session,
    List<DictionaryExample> rows, {
    _i1.ColumnSelections<DictionaryExampleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DictionaryExample>(
      rows,
      columns: columns?.call(DictionaryExample.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryExample]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DictionaryExample> updateRow(
    _i1.DatabaseSession session,
    DictionaryExample row, {
    _i1.ColumnSelections<DictionaryExampleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DictionaryExample>(
      row,
      columns: columns?.call(DictionaryExample.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryExample] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DictionaryExample?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DictionaryExampleUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DictionaryExample>(
      id,
      columnValues: columnValues(DictionaryExample.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryExample]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DictionaryExample>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DictionaryExampleUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DictionaryExampleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryExampleTable>? orderBy,
    _i1.OrderByListBuilder<DictionaryExampleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DictionaryExample>(
      columnValues: columnValues(DictionaryExample.t.updateTable),
      where: where(DictionaryExample.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryExample.t),
      orderByList: orderByList?.call(DictionaryExample.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DictionaryExample]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DictionaryExample>> delete(
    _i1.DatabaseSession session,
    List<DictionaryExample> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DictionaryExample>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DictionaryExample].
  Future<DictionaryExample> deleteRow(
    _i1.DatabaseSession session,
    DictionaryExample row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DictionaryExample>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DictionaryExample>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryExampleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DictionaryExample>(
      where: where(DictionaryExample.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryExampleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DictionaryExample>(
      where: where?.call(DictionaryExample.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DictionaryExample] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryExampleTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DictionaryExample>(
      where: where(DictionaryExample.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
