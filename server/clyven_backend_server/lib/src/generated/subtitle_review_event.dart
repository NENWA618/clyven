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

abstract class SubtitleReviewEvent
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SubtitleReviewEvent._({
    this.id,
    required this.taskId,
    this.actorUserId,
    this.actorDisplayName,
    required this.action,
    this.note,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory SubtitleReviewEvent({
    int? id,
    required int taskId,
    String? actorUserId,
    String? actorDisplayName,
    required String action,
    String? note,
    DateTime? createdAt,
  }) = _SubtitleReviewEventImpl;

  factory SubtitleReviewEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtitleReviewEvent(
      id: jsonSerialization['id'] as int?,
      taskId: jsonSerialization['taskId'] as int,
      actorUserId: jsonSerialization['actorUserId'] as String?,
      actorDisplayName: jsonSerialization['actorDisplayName'] as String?,
      action: jsonSerialization['action'] as String,
      note: jsonSerialization['note'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = SubtitleReviewEventTable();

  static const db = SubtitleReviewEventRepository._();

  @override
  int? id;

  int taskId;

  String? actorUserId;

  String? actorDisplayName;

  String action;

  String? note;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubtitleReviewEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleReviewEvent copyWith({
    int? id,
    int? taskId,
    String? actorUserId,
    String? actorDisplayName,
    String? action,
    String? note,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleReviewEvent',
      if (id != null) 'id': id,
      'taskId': taskId,
      if (actorUserId != null) 'actorUserId': actorUserId,
      if (actorDisplayName != null) 'actorDisplayName': actorDisplayName,
      'action': action,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubtitleReviewEvent',
      if (id != null) 'id': id,
      'taskId': taskId,
      if (actorUserId != null) 'actorUserId': actorUserId,
      if (actorDisplayName != null) 'actorDisplayName': actorDisplayName,
      'action': action,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  static SubtitleReviewEventInclude include() {
    return SubtitleReviewEventInclude._();
  }

  static SubtitleReviewEventIncludeList includeList({
    _i1.WhereExpressionBuilder<SubtitleReviewEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleReviewEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleReviewEventTable>? orderByList,
    SubtitleReviewEventInclude? include,
  }) {
    return SubtitleReviewEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitleReviewEvent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SubtitleReviewEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtitleReviewEventImpl extends SubtitleReviewEvent {
  _SubtitleReviewEventImpl({
    int? id,
    required int taskId,
    String? actorUserId,
    String? actorDisplayName,
    required String action,
    String? note,
    DateTime? createdAt,
  }) : super._(
         id: id,
         taskId: taskId,
         actorUserId: actorUserId,
         actorDisplayName: actorDisplayName,
         action: action,
         note: note,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SubtitleReviewEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleReviewEvent copyWith({
    Object? id = _Undefined,
    int? taskId,
    Object? actorUserId = _Undefined,
    Object? actorDisplayName = _Undefined,
    String? action,
    Object? note = _Undefined,
    DateTime? createdAt,
  }) {
    return SubtitleReviewEvent(
      id: id is int? ? id : this.id,
      taskId: taskId ?? this.taskId,
      actorUserId: actorUserId is String? ? actorUserId : this.actorUserId,
      actorDisplayName: actorDisplayName is String?
          ? actorDisplayName
          : this.actorDisplayName,
      action: action ?? this.action,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class SubtitleReviewEventUpdateTable
    extends _i1.UpdateTable<SubtitleReviewEventTable> {
  SubtitleReviewEventUpdateTable(super.table);

  _i1.ColumnValue<int, int> taskId(int value) => _i1.ColumnValue(
    table.taskId,
    value,
  );

  _i1.ColumnValue<String, String> actorUserId(String? value) => _i1.ColumnValue(
    table.actorUserId,
    value,
  );

  _i1.ColumnValue<String, String> actorDisplayName(String? value) =>
      _i1.ColumnValue(
        table.actorDisplayName,
        value,
      );

  _i1.ColumnValue<String, String> action(String value) => _i1.ColumnValue(
    table.action,
    value,
  );

  _i1.ColumnValue<String, String> note(String? value) => _i1.ColumnValue(
    table.note,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class SubtitleReviewEventTable extends _i1.Table<int?> {
  SubtitleReviewEventTable({super.tableRelation})
    : super(tableName: 'subtitle_review_event') {
    updateTable = SubtitleReviewEventUpdateTable(this);
    taskId = _i1.ColumnInt(
      'taskId',
      this,
    );
    actorUserId = _i1.ColumnString(
      'actorUserId',
      this,
    );
    actorDisplayName = _i1.ColumnString(
      'actorDisplayName',
      this,
    );
    action = _i1.ColumnString(
      'action',
      this,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final SubtitleReviewEventUpdateTable updateTable;

  late final _i1.ColumnInt taskId;

  late final _i1.ColumnString actorUserId;

  late final _i1.ColumnString actorDisplayName;

  late final _i1.ColumnString action;

  late final _i1.ColumnString note;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    taskId,
    actorUserId,
    actorDisplayName,
    action,
    note,
    createdAt,
  ];
}

class SubtitleReviewEventInclude extends _i1.IncludeObject {
  SubtitleReviewEventInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SubtitleReviewEvent.t;
}

class SubtitleReviewEventIncludeList extends _i1.IncludeList {
  SubtitleReviewEventIncludeList._({
    _i1.WhereExpressionBuilder<SubtitleReviewEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubtitleReviewEvent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SubtitleReviewEvent.t;
}

class SubtitleReviewEventRepository {
  const SubtitleReviewEventRepository._();

  /// Returns a list of [SubtitleReviewEvent]s matching the given query parameters.
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
  Future<List<SubtitleReviewEvent>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleReviewEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleReviewEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleReviewEventTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SubtitleReviewEvent>(
      where: where?.call(SubtitleReviewEvent.t),
      orderBy: orderBy?.call(SubtitleReviewEvent.t),
      orderByList: orderByList?.call(SubtitleReviewEvent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SubtitleReviewEvent] matching the given query parameters.
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
  Future<SubtitleReviewEvent?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleReviewEventTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubtitleReviewEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleReviewEventTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SubtitleReviewEvent>(
      where: where?.call(SubtitleReviewEvent.t),
      orderBy: orderBy?.call(SubtitleReviewEvent.t),
      orderByList: orderByList?.call(SubtitleReviewEvent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SubtitleReviewEvent] by its [id] or null if no such row exists.
  Future<SubtitleReviewEvent?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SubtitleReviewEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SubtitleReviewEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [SubtitleReviewEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SubtitleReviewEvent>> insert(
    _i1.DatabaseSession session,
    List<SubtitleReviewEvent> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SubtitleReviewEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SubtitleReviewEvent] and returns the inserted row.
  ///
  /// The returned [SubtitleReviewEvent] will have its `id` field set.
  Future<SubtitleReviewEvent> insertRow(
    _i1.DatabaseSession session,
    SubtitleReviewEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubtitleReviewEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SubtitleReviewEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SubtitleReviewEvent>> update(
    _i1.DatabaseSession session,
    List<SubtitleReviewEvent> rows, {
    _i1.ColumnSelections<SubtitleReviewEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SubtitleReviewEvent>(
      rows,
      columns: columns?.call(SubtitleReviewEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitleReviewEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubtitleReviewEvent> updateRow(
    _i1.DatabaseSession session,
    SubtitleReviewEvent row, {
    _i1.ColumnSelections<SubtitleReviewEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubtitleReviewEvent>(
      row,
      columns: columns?.call(SubtitleReviewEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitleReviewEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SubtitleReviewEvent?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SubtitleReviewEventUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SubtitleReviewEvent>(
      id,
      columnValues: columnValues(SubtitleReviewEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SubtitleReviewEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SubtitleReviewEvent>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SubtitleReviewEventUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<SubtitleReviewEventTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleReviewEventTable>? orderBy,
    _i1.OrderByListBuilder<SubtitleReviewEventTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SubtitleReviewEvent>(
      columnValues: columnValues(SubtitleReviewEvent.t.updateTable),
      where: where(SubtitleReviewEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitleReviewEvent.t),
      orderByList: orderByList?.call(SubtitleReviewEvent.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SubtitleReviewEvent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SubtitleReviewEvent>> delete(
    _i1.DatabaseSession session,
    List<SubtitleReviewEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SubtitleReviewEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SubtitleReviewEvent].
  Future<SubtitleReviewEvent> deleteRow(
    _i1.DatabaseSession session,
    SubtitleReviewEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubtitleReviewEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SubtitleReviewEvent>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitleReviewEventTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SubtitleReviewEvent>(
      where: where(SubtitleReviewEvent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleReviewEventTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SubtitleReviewEvent>(
      where: where?.call(SubtitleReviewEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SubtitleReviewEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitleReviewEventTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SubtitleReviewEvent>(
      where: where(SubtitleReviewEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
