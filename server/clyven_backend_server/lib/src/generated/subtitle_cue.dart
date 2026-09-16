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

abstract class SubtitleCue
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SubtitleCue._({
    this.id,
    required this.trackId,
    required this.startMs,
    required this.endMs,
    required this.text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubtitleCue({
    int? id,
    required int trackId,
    required int startMs,
    required int endMs,
    required String text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubtitleCueImpl;

  factory SubtitleCue.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtitleCue(
      id: jsonSerialization['id'] as int?,
      trackId: jsonSerialization['trackId'] as int,
      startMs: jsonSerialization['startMs'] as int,
      endMs: jsonSerialization['endMs'] as int,
      text: jsonSerialization['text'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SubtitleCueTable();

  static const db = SubtitleCueRepository._();

  @override
  int? id;

  int trackId;

  int startMs;

  int endMs;

  String text;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubtitleCue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleCue copyWith({
    int? id,
    int? trackId,
    int? startMs,
    int? endMs,
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleCue',
      if (id != null) 'id': id,
      'trackId': trackId,
      'startMs': startMs,
      'endMs': endMs,
      'text': text,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubtitleCue',
      if (id != null) 'id': id,
      'trackId': trackId,
      'startMs': startMs,
      'endMs': endMs,
      'text': text,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SubtitleCueInclude include() {
    return SubtitleCueInclude._();
  }

  static SubtitleCueIncludeList includeList({
    _i1.WhereExpressionBuilder<SubtitleCueTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleCueTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleCueTable>? orderByList,
    SubtitleCueInclude? include,
  }) {
    return SubtitleCueIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitleCue.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SubtitleCue.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtitleCueImpl extends SubtitleCue {
  _SubtitleCueImpl({
    int? id,
    required int trackId,
    required int startMs,
    required int endMs,
    required String text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         trackId: trackId,
         startMs: startMs,
         endMs: endMs,
         text: text,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubtitleCue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleCue copyWith({
    Object? id = _Undefined,
    int? trackId,
    int? startMs,
    int? endMs,
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubtitleCue(
      id: id is int? ? id : this.id,
      trackId: trackId ?? this.trackId,
      startMs: startMs ?? this.startMs,
      endMs: endMs ?? this.endMs,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SubtitleCueUpdateTable extends _i1.UpdateTable<SubtitleCueTable> {
  SubtitleCueUpdateTable(super.table);

  _i1.ColumnValue<int, int> trackId(int value) => _i1.ColumnValue(
    table.trackId,
    value,
  );

  _i1.ColumnValue<int, int> startMs(int value) => _i1.ColumnValue(
    table.startMs,
    value,
  );

  _i1.ColumnValue<int, int> endMs(int value) => _i1.ColumnValue(
    table.endMs,
    value,
  );

  _i1.ColumnValue<String, String> text(String value) => _i1.ColumnValue(
    table.text,
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

class SubtitleCueTable extends _i1.Table<int?> {
  SubtitleCueTable({super.tableRelation}) : super(tableName: 'subtitle_cue') {
    updateTable = SubtitleCueUpdateTable(this);
    trackId = _i1.ColumnInt(
      'trackId',
      this,
    );
    startMs = _i1.ColumnInt(
      'startMs',
      this,
    );
    endMs = _i1.ColumnInt(
      'endMs',
      this,
    );
    text = _i1.ColumnString(
      'text',
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

  late final SubtitleCueUpdateTable updateTable;

  late final _i1.ColumnInt trackId;

  late final _i1.ColumnInt startMs;

  late final _i1.ColumnInt endMs;

  late final _i1.ColumnString text;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    trackId,
    startMs,
    endMs,
    text,
    createdAt,
    updatedAt,
  ];
}

class SubtitleCueInclude extends _i1.IncludeObject {
  SubtitleCueInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SubtitleCue.t;
}

class SubtitleCueIncludeList extends _i1.IncludeList {
  SubtitleCueIncludeList._({
    _i1.WhereExpressionBuilder<SubtitleCueTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubtitleCue.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SubtitleCue.t;
}

class SubtitleCueRepository {
  const SubtitleCueRepository._();

  /// Returns a list of [SubtitleCue]s matching the given query parameters.
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
  Future<List<SubtitleCue>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleCueTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleCueTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleCueTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SubtitleCue>(
      where: where?.call(SubtitleCue.t),
      orderBy: orderBy?.call(SubtitleCue.t),
      orderByList: orderByList?.call(SubtitleCue.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SubtitleCue] matching the given query parameters.
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
  Future<SubtitleCue?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleCueTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubtitleCueTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleCueTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SubtitleCue>(
      where: where?.call(SubtitleCue.t),
      orderBy: orderBy?.call(SubtitleCue.t),
      orderByList: orderByList?.call(SubtitleCue.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SubtitleCue] by its [id] or null if no such row exists.
  Future<SubtitleCue?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SubtitleCue>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SubtitleCue]s in the list and returns the inserted rows.
  ///
  /// The returned [SubtitleCue]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SubtitleCue>> insert(
    _i1.DatabaseSession session,
    List<SubtitleCue> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SubtitleCue>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SubtitleCue] and returns the inserted row.
  ///
  /// The returned [SubtitleCue] will have its `id` field set.
  Future<SubtitleCue> insertRow(
    _i1.DatabaseSession session,
    SubtitleCue row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubtitleCue>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SubtitleCue]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SubtitleCue>> update(
    _i1.DatabaseSession session,
    List<SubtitleCue> rows, {
    _i1.ColumnSelections<SubtitleCueTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SubtitleCue>(
      rows,
      columns: columns?.call(SubtitleCue.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitleCue]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubtitleCue> updateRow(
    _i1.DatabaseSession session,
    SubtitleCue row, {
    _i1.ColumnSelections<SubtitleCueTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubtitleCue>(
      row,
      columns: columns?.call(SubtitleCue.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitleCue] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SubtitleCue?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SubtitleCueUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SubtitleCue>(
      id,
      columnValues: columnValues(SubtitleCue.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SubtitleCue]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SubtitleCue>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SubtitleCueUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SubtitleCueTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleCueTable>? orderBy,
    _i1.OrderByListBuilder<SubtitleCueTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SubtitleCue>(
      columnValues: columnValues(SubtitleCue.t.updateTable),
      where: where(SubtitleCue.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitleCue.t),
      orderByList: orderByList?.call(SubtitleCue.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SubtitleCue]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SubtitleCue>> delete(
    _i1.DatabaseSession session,
    List<SubtitleCue> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SubtitleCue>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SubtitleCue].
  Future<SubtitleCue> deleteRow(
    _i1.DatabaseSession session,
    SubtitleCue row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubtitleCue>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SubtitleCue>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitleCueTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SubtitleCue>(
      where: where(SubtitleCue.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleCueTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SubtitleCue>(
      where: where?.call(SubtitleCue.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SubtitleCue] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitleCueTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SubtitleCue>(
      where: where(SubtitleCue.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
