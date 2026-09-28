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

abstract class SubtitlePublishState
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SubtitlePublishState._({
    this.id,
    required this.trackId,
    this.publishedPayload,
    this.publishedAt,
    int? draftRevision,
    int? publishedRevision,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : draftRevision = draftRevision ?? 0,
       publishedRevision = publishedRevision ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubtitlePublishState({
    int? id,
    required int trackId,
    String? publishedPayload,
    DateTime? publishedAt,
    int? draftRevision,
    int? publishedRevision,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubtitlePublishStateImpl;

  factory SubtitlePublishState.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SubtitlePublishState(
      id: jsonSerialization['id'] as int?,
      trackId: jsonSerialization['trackId'] as int,
      publishedPayload: jsonSerialization['publishedPayload'] as String?,
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
      draftRevision: jsonSerialization['draftRevision'] as int?,
      publishedRevision: jsonSerialization['publishedRevision'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SubtitlePublishStateTable();

  static const db = SubtitlePublishStateRepository._();

  @override
  int? id;

  int trackId;

  String? publishedPayload;

  DateTime? publishedAt;

  int draftRevision;

  int publishedRevision;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubtitlePublishState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitlePublishState copyWith({
    int? id,
    int? trackId,
    String? publishedPayload,
    DateTime? publishedAt,
    int? draftRevision,
    int? publishedRevision,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitlePublishState',
      if (id != null) 'id': id,
      'trackId': trackId,
      if (publishedPayload != null) 'publishedPayload': publishedPayload,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'draftRevision': draftRevision,
      'publishedRevision': publishedRevision,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubtitlePublishState',
      if (id != null) 'id': id,
      'trackId': trackId,
      if (publishedPayload != null) 'publishedPayload': publishedPayload,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'draftRevision': draftRevision,
      'publishedRevision': publishedRevision,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SubtitlePublishStateInclude include() {
    return SubtitlePublishStateInclude._();
  }

  static SubtitlePublishStateIncludeList includeList({
    _i1.WhereExpressionBuilder<SubtitlePublishStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitlePublishStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitlePublishStateTable>? orderByList,
    SubtitlePublishStateInclude? include,
  }) {
    return SubtitlePublishStateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitlePublishState.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SubtitlePublishState.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtitlePublishStateImpl extends SubtitlePublishState {
  _SubtitlePublishStateImpl({
    int? id,
    required int trackId,
    String? publishedPayload,
    DateTime? publishedAt,
    int? draftRevision,
    int? publishedRevision,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         trackId: trackId,
         publishedPayload: publishedPayload,
         publishedAt: publishedAt,
         draftRevision: draftRevision,
         publishedRevision: publishedRevision,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubtitlePublishState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitlePublishState copyWith({
    Object? id = _Undefined,
    int? trackId,
    Object? publishedPayload = _Undefined,
    Object? publishedAt = _Undefined,
    int? draftRevision,
    int? publishedRevision,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubtitlePublishState(
      id: id is int? ? id : this.id,
      trackId: trackId ?? this.trackId,
      publishedPayload: publishedPayload is String?
          ? publishedPayload
          : this.publishedPayload,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
      draftRevision: draftRevision ?? this.draftRevision,
      publishedRevision: publishedRevision ?? this.publishedRevision,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SubtitlePublishStateUpdateTable
    extends _i1.UpdateTable<SubtitlePublishStateTable> {
  SubtitlePublishStateUpdateTable(super.table);

  _i1.ColumnValue<int, int> trackId(int value) => _i1.ColumnValue(
    table.trackId,
    value,
  );

  _i1.ColumnValue<String, String> publishedPayload(String? value) =>
      _i1.ColumnValue(
        table.publishedPayload,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> publishedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.publishedAt,
        value,
      );

  _i1.ColumnValue<int, int> draftRevision(int value) => _i1.ColumnValue(
    table.draftRevision,
    value,
  );

  _i1.ColumnValue<int, int> publishedRevision(int value) => _i1.ColumnValue(
    table.publishedRevision,
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

class SubtitlePublishStateTable extends _i1.Table<int?> {
  SubtitlePublishStateTable({super.tableRelation})
    : super(tableName: 'subtitle_publish_state') {
    updateTable = SubtitlePublishStateUpdateTable(this);
    trackId = _i1.ColumnInt(
      'trackId',
      this,
    );
    publishedPayload = _i1.ColumnString(
      'publishedPayload',
      this,
    );
    publishedAt = _i1.ColumnDateTime(
      'publishedAt',
      this,
    );
    draftRevision = _i1.ColumnInt(
      'draftRevision',
      this,
      hasDefault: true,
    );
    publishedRevision = _i1.ColumnInt(
      'publishedRevision',
      this,
      hasDefault: true,
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

  late final SubtitlePublishStateUpdateTable updateTable;

  late final _i1.ColumnInt trackId;

  late final _i1.ColumnString publishedPayload;

  late final _i1.ColumnDateTime publishedAt;

  late final _i1.ColumnInt draftRevision;

  late final _i1.ColumnInt publishedRevision;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    trackId,
    publishedPayload,
    publishedAt,
    draftRevision,
    publishedRevision,
    createdAt,
    updatedAt,
  ];
}

class SubtitlePublishStateInclude extends _i1.IncludeObject {
  SubtitlePublishStateInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SubtitlePublishState.t;
}

class SubtitlePublishStateIncludeList extends _i1.IncludeList {
  SubtitlePublishStateIncludeList._({
    _i1.WhereExpressionBuilder<SubtitlePublishStateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubtitlePublishState.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SubtitlePublishState.t;
}

class SubtitlePublishStateRepository {
  const SubtitlePublishStateRepository._();

  /// Returns a list of [SubtitlePublishState]s matching the given query parameters.
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
  Future<List<SubtitlePublishState>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitlePublishStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitlePublishStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitlePublishStateTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SubtitlePublishState>(
      where: where?.call(SubtitlePublishState.t),
      orderBy: orderBy?.call(SubtitlePublishState.t),
      orderByList: orderByList?.call(SubtitlePublishState.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SubtitlePublishState] matching the given query parameters.
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
  Future<SubtitlePublishState?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitlePublishStateTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubtitlePublishStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitlePublishStateTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SubtitlePublishState>(
      where: where?.call(SubtitlePublishState.t),
      orderBy: orderBy?.call(SubtitlePublishState.t),
      orderByList: orderByList?.call(SubtitlePublishState.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SubtitlePublishState] by its [id] or null if no such row exists.
  Future<SubtitlePublishState?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SubtitlePublishState>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SubtitlePublishState]s in the list and returns the inserted rows.
  ///
  /// The returned [SubtitlePublishState]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SubtitlePublishState>> insert(
    _i1.DatabaseSession session,
    List<SubtitlePublishState> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SubtitlePublishState>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SubtitlePublishState] and returns the inserted row.
  ///
  /// The returned [SubtitlePublishState] will have its `id` field set.
  Future<SubtitlePublishState> insertRow(
    _i1.DatabaseSession session,
    SubtitlePublishState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubtitlePublishState>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SubtitlePublishState]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SubtitlePublishState>> update(
    _i1.DatabaseSession session,
    List<SubtitlePublishState> rows, {
    _i1.ColumnSelections<SubtitlePublishStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SubtitlePublishState>(
      rows,
      columns: columns?.call(SubtitlePublishState.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitlePublishState]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubtitlePublishState> updateRow(
    _i1.DatabaseSession session,
    SubtitlePublishState row, {
    _i1.ColumnSelections<SubtitlePublishStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubtitlePublishState>(
      row,
      columns: columns?.call(SubtitlePublishState.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitlePublishState] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SubtitlePublishState?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SubtitlePublishStateUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SubtitlePublishState>(
      id,
      columnValues: columnValues(SubtitlePublishState.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SubtitlePublishState]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SubtitlePublishState>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SubtitlePublishStateUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<SubtitlePublishStateTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitlePublishStateTable>? orderBy,
    _i1.OrderByListBuilder<SubtitlePublishStateTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SubtitlePublishState>(
      columnValues: columnValues(SubtitlePublishState.t.updateTable),
      where: where(SubtitlePublishState.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitlePublishState.t),
      orderByList: orderByList?.call(SubtitlePublishState.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SubtitlePublishState]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SubtitlePublishState>> delete(
    _i1.DatabaseSession session,
    List<SubtitlePublishState> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SubtitlePublishState>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SubtitlePublishState].
  Future<SubtitlePublishState> deleteRow(
    _i1.DatabaseSession session,
    SubtitlePublishState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubtitlePublishState>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SubtitlePublishState>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitlePublishStateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SubtitlePublishState>(
      where: where(SubtitlePublishState.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitlePublishStateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SubtitlePublishState>(
      where: where?.call(SubtitlePublishState.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SubtitlePublishState] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitlePublishStateTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SubtitlePublishState>(
      where: where(SubtitlePublishState.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
