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

abstract class SubtitleKaraokeSegment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SubtitleKaraokeSegment._({
    this.id,
    required this.cueId,
    this.scriptCode,
    required this.position,
    required this.startOffsetMs,
    required this.endOffsetMs,
    required this.text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubtitleKaraokeSegment({
    int? id,
    required int cueId,
    String? scriptCode,
    required int position,
    required int startOffsetMs,
    required int endOffsetMs,
    required String text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubtitleKaraokeSegmentImpl;

  factory SubtitleKaraokeSegment.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SubtitleKaraokeSegment(
      id: jsonSerialization['id'] as int?,
      cueId: jsonSerialization['cueId'] as int,
      scriptCode: jsonSerialization['scriptCode'] as String?,
      position: jsonSerialization['position'] as int,
      startOffsetMs: jsonSerialization['startOffsetMs'] as int,
      endOffsetMs: jsonSerialization['endOffsetMs'] as int,
      text: jsonSerialization['text'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SubtitleKaraokeSegmentTable();

  static const db = SubtitleKaraokeSegmentRepository._();

  @override
  int? id;

  int cueId;

  String? scriptCode;

  int position;

  int startOffsetMs;

  int endOffsetMs;

  String text;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubtitleKaraokeSegment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleKaraokeSegment copyWith({
    int? id,
    int? cueId,
    String? scriptCode,
    int? position,
    int? startOffsetMs,
    int? endOffsetMs,
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleKaraokeSegment',
      if (id != null) 'id': id,
      'cueId': cueId,
      if (scriptCode != null) 'scriptCode': scriptCode,
      'position': position,
      'startOffsetMs': startOffsetMs,
      'endOffsetMs': endOffsetMs,
      'text': text,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubtitleKaraokeSegment',
      if (id != null) 'id': id,
      'cueId': cueId,
      if (scriptCode != null) 'scriptCode': scriptCode,
      'position': position,
      'startOffsetMs': startOffsetMs,
      'endOffsetMs': endOffsetMs,
      'text': text,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SubtitleKaraokeSegmentInclude include() {
    return SubtitleKaraokeSegmentInclude._();
  }

  static SubtitleKaraokeSegmentIncludeList includeList({
    _i1.WhereExpressionBuilder<SubtitleKaraokeSegmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleKaraokeSegmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleKaraokeSegmentTable>? orderByList,
    SubtitleKaraokeSegmentInclude? include,
  }) {
    return SubtitleKaraokeSegmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitleKaraokeSegment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SubtitleKaraokeSegment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtitleKaraokeSegmentImpl extends SubtitleKaraokeSegment {
  _SubtitleKaraokeSegmentImpl({
    int? id,
    required int cueId,
    String? scriptCode,
    required int position,
    required int startOffsetMs,
    required int endOffsetMs,
    required String text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         cueId: cueId,
         scriptCode: scriptCode,
         position: position,
         startOffsetMs: startOffsetMs,
         endOffsetMs: endOffsetMs,
         text: text,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubtitleKaraokeSegment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleKaraokeSegment copyWith({
    Object? id = _Undefined,
    int? cueId,
    Object? scriptCode = _Undefined,
    int? position,
    int? startOffsetMs,
    int? endOffsetMs,
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubtitleKaraokeSegment(
      id: id is int? ? id : this.id,
      cueId: cueId ?? this.cueId,
      scriptCode: scriptCode is String? ? scriptCode : this.scriptCode,
      position: position ?? this.position,
      startOffsetMs: startOffsetMs ?? this.startOffsetMs,
      endOffsetMs: endOffsetMs ?? this.endOffsetMs,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SubtitleKaraokeSegmentUpdateTable
    extends _i1.UpdateTable<SubtitleKaraokeSegmentTable> {
  SubtitleKaraokeSegmentUpdateTable(super.table);

  _i1.ColumnValue<int, int> cueId(int value) => _i1.ColumnValue(
    table.cueId,
    value,
  );

  _i1.ColumnValue<String, String> scriptCode(String? value) => _i1.ColumnValue(
    table.scriptCode,
    value,
  );

  _i1.ColumnValue<int, int> position(int value) => _i1.ColumnValue(
    table.position,
    value,
  );

  _i1.ColumnValue<int, int> startOffsetMs(int value) => _i1.ColumnValue(
    table.startOffsetMs,
    value,
  );

  _i1.ColumnValue<int, int> endOffsetMs(int value) => _i1.ColumnValue(
    table.endOffsetMs,
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

class SubtitleKaraokeSegmentTable extends _i1.Table<int?> {
  SubtitleKaraokeSegmentTable({super.tableRelation})
    : super(tableName: 'subtitle_karaoke_segment') {
    updateTable = SubtitleKaraokeSegmentUpdateTable(this);
    cueId = _i1.ColumnInt(
      'cueId',
      this,
    );
    scriptCode = _i1.ColumnString(
      'scriptCode',
      this,
    );
    position = _i1.ColumnInt(
      'position',
      this,
    );
    startOffsetMs = _i1.ColumnInt(
      'startOffsetMs',
      this,
    );
    endOffsetMs = _i1.ColumnInt(
      'endOffsetMs',
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

  late final SubtitleKaraokeSegmentUpdateTable updateTable;

  late final _i1.ColumnInt cueId;

  late final _i1.ColumnString scriptCode;

  late final _i1.ColumnInt position;

  late final _i1.ColumnInt startOffsetMs;

  late final _i1.ColumnInt endOffsetMs;

  late final _i1.ColumnString text;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    cueId,
    scriptCode,
    position,
    startOffsetMs,
    endOffsetMs,
    text,
    createdAt,
    updatedAt,
  ];
}

class SubtitleKaraokeSegmentInclude extends _i1.IncludeObject {
  SubtitleKaraokeSegmentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SubtitleKaraokeSegment.t;
}

class SubtitleKaraokeSegmentIncludeList extends _i1.IncludeList {
  SubtitleKaraokeSegmentIncludeList._({
    _i1.WhereExpressionBuilder<SubtitleKaraokeSegmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubtitleKaraokeSegment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SubtitleKaraokeSegment.t;
}

class SubtitleKaraokeSegmentRepository {
  const SubtitleKaraokeSegmentRepository._();

  /// Returns a list of [SubtitleKaraokeSegment]s matching the given query parameters.
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
  Future<List<SubtitleKaraokeSegment>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleKaraokeSegmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleKaraokeSegmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleKaraokeSegmentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SubtitleKaraokeSegment>(
      where: where?.call(SubtitleKaraokeSegment.t),
      orderBy: orderBy?.call(SubtitleKaraokeSegment.t),
      orderByList: orderByList?.call(SubtitleKaraokeSegment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SubtitleKaraokeSegment] matching the given query parameters.
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
  Future<SubtitleKaraokeSegment?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleKaraokeSegmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubtitleKaraokeSegmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleKaraokeSegmentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SubtitleKaraokeSegment>(
      where: where?.call(SubtitleKaraokeSegment.t),
      orderBy: orderBy?.call(SubtitleKaraokeSegment.t),
      orderByList: orderByList?.call(SubtitleKaraokeSegment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SubtitleKaraokeSegment] by its [id] or null if no such row exists.
  Future<SubtitleKaraokeSegment?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SubtitleKaraokeSegment>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SubtitleKaraokeSegment]s in the list and returns the inserted rows.
  ///
  /// The returned [SubtitleKaraokeSegment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SubtitleKaraokeSegment>> insert(
    _i1.DatabaseSession session,
    List<SubtitleKaraokeSegment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SubtitleKaraokeSegment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SubtitleKaraokeSegment] and returns the inserted row.
  ///
  /// The returned [SubtitleKaraokeSegment] will have its `id` field set.
  Future<SubtitleKaraokeSegment> insertRow(
    _i1.DatabaseSession session,
    SubtitleKaraokeSegment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubtitleKaraokeSegment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SubtitleKaraokeSegment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SubtitleKaraokeSegment>> update(
    _i1.DatabaseSession session,
    List<SubtitleKaraokeSegment> rows, {
    _i1.ColumnSelections<SubtitleKaraokeSegmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SubtitleKaraokeSegment>(
      rows,
      columns: columns?.call(SubtitleKaraokeSegment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitleKaraokeSegment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubtitleKaraokeSegment> updateRow(
    _i1.DatabaseSession session,
    SubtitleKaraokeSegment row, {
    _i1.ColumnSelections<SubtitleKaraokeSegmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubtitleKaraokeSegment>(
      row,
      columns: columns?.call(SubtitleKaraokeSegment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitleKaraokeSegment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SubtitleKaraokeSegment?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SubtitleKaraokeSegmentUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SubtitleKaraokeSegment>(
      id,
      columnValues: columnValues(SubtitleKaraokeSegment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SubtitleKaraokeSegment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SubtitleKaraokeSegment>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SubtitleKaraokeSegmentUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<SubtitleKaraokeSegmentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleKaraokeSegmentTable>? orderBy,
    _i1.OrderByListBuilder<SubtitleKaraokeSegmentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SubtitleKaraokeSegment>(
      columnValues: columnValues(SubtitleKaraokeSegment.t.updateTable),
      where: where(SubtitleKaraokeSegment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitleKaraokeSegment.t),
      orderByList: orderByList?.call(SubtitleKaraokeSegment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SubtitleKaraokeSegment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SubtitleKaraokeSegment>> delete(
    _i1.DatabaseSession session,
    List<SubtitleKaraokeSegment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SubtitleKaraokeSegment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SubtitleKaraokeSegment].
  Future<SubtitleKaraokeSegment> deleteRow(
    _i1.DatabaseSession session,
    SubtitleKaraokeSegment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubtitleKaraokeSegment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SubtitleKaraokeSegment>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitleKaraokeSegmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SubtitleKaraokeSegment>(
      where: where(SubtitleKaraokeSegment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleKaraokeSegmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SubtitleKaraokeSegment>(
      where: where?.call(SubtitleKaraokeSegment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SubtitleKaraokeSegment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitleKaraokeSegmentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SubtitleKaraokeSegment>(
      where: where(SubtitleKaraokeSegment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
