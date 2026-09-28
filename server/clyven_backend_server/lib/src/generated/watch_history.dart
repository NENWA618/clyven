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

abstract class WatchHistory
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WatchHistory._({
    this.id,
    required this.userId,
    required this.videoId,
    int? positionSeconds,
    DateTime? watchedAt,
  }) : positionSeconds = positionSeconds ?? 0,
       watchedAt = watchedAt ?? DateTime.now();

  factory WatchHistory({
    int? id,
    required String userId,
    required int videoId,
    int? positionSeconds,
    DateTime? watchedAt,
  }) = _WatchHistoryImpl;

  factory WatchHistory.fromJson(Map<String, dynamic> jsonSerialization) {
    return WatchHistory(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      videoId: jsonSerialization['videoId'] as int,
      positionSeconds: jsonSerialization['positionSeconds'] as int?,
      watchedAt: jsonSerialization['watchedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['watchedAt']),
    );
  }

  static final t = WatchHistoryTable();

  static const db = WatchHistoryRepository._();

  @override
  int? id;

  String userId;

  int videoId;

  int positionSeconds;

  DateTime watchedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WatchHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WatchHistory copyWith({
    int? id,
    String? userId,
    int? videoId,
    int? positionSeconds,
    DateTime? watchedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WatchHistory',
      if (id != null) 'id': id,
      'userId': userId,
      'videoId': videoId,
      'positionSeconds': positionSeconds,
      'watchedAt': watchedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WatchHistory',
      if (id != null) 'id': id,
      'userId': userId,
      'videoId': videoId,
      'positionSeconds': positionSeconds,
      'watchedAt': watchedAt.toJson(),
    };
  }

  static WatchHistoryInclude include() {
    return WatchHistoryInclude._();
  }

  static WatchHistoryIncludeList includeList({
    _i1.WhereExpressionBuilder<WatchHistoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WatchHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WatchHistoryTable>? orderByList,
    WatchHistoryInclude? include,
  }) {
    return WatchHistoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WatchHistory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WatchHistory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WatchHistoryImpl extends WatchHistory {
  _WatchHistoryImpl({
    int? id,
    required String userId,
    required int videoId,
    int? positionSeconds,
    DateTime? watchedAt,
  }) : super._(
         id: id,
         userId: userId,
         videoId: videoId,
         positionSeconds: positionSeconds,
         watchedAt: watchedAt,
       );

  /// Returns a shallow copy of this [WatchHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WatchHistory copyWith({
    Object? id = _Undefined,
    String? userId,
    int? videoId,
    int? positionSeconds,
    DateTime? watchedAt,
  }) {
    return WatchHistory(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      videoId: videoId ?? this.videoId,
      positionSeconds: positionSeconds ?? this.positionSeconds,
      watchedAt: watchedAt ?? this.watchedAt,
    );
  }
}

class WatchHistoryUpdateTable extends _i1.UpdateTable<WatchHistoryTable> {
  WatchHistoryUpdateTable(super.table);

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> videoId(int value) => _i1.ColumnValue(
    table.videoId,
    value,
  );

  _i1.ColumnValue<int, int> positionSeconds(int value) => _i1.ColumnValue(
    table.positionSeconds,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> watchedAt(DateTime value) =>
      _i1.ColumnValue(
        table.watchedAt,
        value,
      );
}

class WatchHistoryTable extends _i1.Table<int?> {
  WatchHistoryTable({super.tableRelation}) : super(tableName: 'watch_history') {
    updateTable = WatchHistoryUpdateTable(this);
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    videoId = _i1.ColumnInt(
      'videoId',
      this,
    );
    positionSeconds = _i1.ColumnInt(
      'positionSeconds',
      this,
      hasDefault: true,
    );
    watchedAt = _i1.ColumnDateTime(
      'watchedAt',
      this,
      hasDefault: true,
    );
  }

  late final WatchHistoryUpdateTable updateTable;

  late final _i1.ColumnString userId;

  late final _i1.ColumnInt videoId;

  late final _i1.ColumnInt positionSeconds;

  late final _i1.ColumnDateTime watchedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    videoId,
    positionSeconds,
    watchedAt,
  ];
}

class WatchHistoryInclude extends _i1.IncludeObject {
  WatchHistoryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => WatchHistory.t;
}

class WatchHistoryIncludeList extends _i1.IncludeList {
  WatchHistoryIncludeList._({
    _i1.WhereExpressionBuilder<WatchHistoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WatchHistory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WatchHistory.t;
}

class WatchHistoryRepository {
  const WatchHistoryRepository._();

  /// Returns a list of [WatchHistory]s matching the given query parameters.
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
  Future<List<WatchHistory>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WatchHistoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WatchHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WatchHistoryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WatchHistory>(
      where: where?.call(WatchHistory.t),
      orderBy: orderBy?.call(WatchHistory.t),
      orderByList: orderByList?.call(WatchHistory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WatchHistory] matching the given query parameters.
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
  Future<WatchHistory?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WatchHistoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<WatchHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WatchHistoryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WatchHistory>(
      where: where?.call(WatchHistory.t),
      orderBy: orderBy?.call(WatchHistory.t),
      orderByList: orderByList?.call(WatchHistory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WatchHistory] by its [id] or null if no such row exists.
  Future<WatchHistory?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WatchHistory>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WatchHistory]s in the list and returns the inserted rows.
  ///
  /// The returned [WatchHistory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<WatchHistory>> insert(
    _i1.DatabaseSession session,
    List<WatchHistory> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<WatchHistory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [WatchHistory] and returns the inserted row.
  ///
  /// The returned [WatchHistory] will have its `id` field set.
  Future<WatchHistory> insertRow(
    _i1.DatabaseSession session,
    WatchHistory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WatchHistory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WatchHistory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WatchHistory>> update(
    _i1.DatabaseSession session,
    List<WatchHistory> rows, {
    _i1.ColumnSelections<WatchHistoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WatchHistory>(
      rows,
      columns: columns?.call(WatchHistory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WatchHistory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WatchHistory> updateRow(
    _i1.DatabaseSession session,
    WatchHistory row, {
    _i1.ColumnSelections<WatchHistoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WatchHistory>(
      row,
      columns: columns?.call(WatchHistory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WatchHistory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WatchHistory?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<WatchHistoryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WatchHistory>(
      id,
      columnValues: columnValues(WatchHistory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WatchHistory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WatchHistory>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<WatchHistoryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WatchHistoryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WatchHistoryTable>? orderBy,
    _i1.OrderByListBuilder<WatchHistoryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WatchHistory>(
      columnValues: columnValues(WatchHistory.t.updateTable),
      where: where(WatchHistory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WatchHistory.t),
      orderByList: orderByList?.call(WatchHistory.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WatchHistory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WatchHistory>> delete(
    _i1.DatabaseSession session,
    List<WatchHistory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WatchHistory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WatchHistory].
  Future<WatchHistory> deleteRow(
    _i1.DatabaseSession session,
    WatchHistory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WatchHistory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WatchHistory>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WatchHistoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WatchHistory>(
      where: where(WatchHistory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WatchHistoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WatchHistory>(
      where: where?.call(WatchHistory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WatchHistory] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WatchHistoryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WatchHistory>(
      where: where(WatchHistory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
