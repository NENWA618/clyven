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

abstract class SubtitleToken
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SubtitleToken._({
    this.id,
    required this.cueId,
    required this.text,
    this.normalizedText,
    this.startMs,
    this.endMs,
    required this.position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubtitleToken({
    int? id,
    required int cueId,
    required String text,
    String? normalizedText,
    int? startMs,
    int? endMs,
    required int position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubtitleTokenImpl;

  factory SubtitleToken.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtitleToken(
      id: jsonSerialization['id'] as int?,
      cueId: jsonSerialization['cueId'] as int,
      text: jsonSerialization['text'] as String,
      normalizedText: jsonSerialization['normalizedText'] as String?,
      startMs: jsonSerialization['startMs'] as int?,
      endMs: jsonSerialization['endMs'] as int?,
      position: jsonSerialization['position'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SubtitleTokenTable();

  static const db = SubtitleTokenRepository._();

  @override
  int? id;

  int cueId;

  String text;

  String? normalizedText;

  int? startMs;

  int? endMs;

  int position;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubtitleToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleToken copyWith({
    int? id,
    int? cueId,
    String? text,
    String? normalizedText,
    int? startMs,
    int? endMs,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleToken',
      if (id != null) 'id': id,
      'cueId': cueId,
      'text': text,
      if (normalizedText != null) 'normalizedText': normalizedText,
      if (startMs != null) 'startMs': startMs,
      if (endMs != null) 'endMs': endMs,
      'position': position,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubtitleToken',
      if (id != null) 'id': id,
      'cueId': cueId,
      'text': text,
      if (normalizedText != null) 'normalizedText': normalizedText,
      if (startMs != null) 'startMs': startMs,
      if (endMs != null) 'endMs': endMs,
      'position': position,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SubtitleTokenInclude include() {
    return SubtitleTokenInclude._();
  }

  static SubtitleTokenIncludeList includeList({
    _i1.WhereExpressionBuilder<SubtitleTokenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleTokenTable>? orderByList,
    SubtitleTokenInclude? include,
  }) {
    return SubtitleTokenIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitleToken.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SubtitleToken.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtitleTokenImpl extends SubtitleToken {
  _SubtitleTokenImpl({
    int? id,
    required int cueId,
    required String text,
    String? normalizedText,
    int? startMs,
    int? endMs,
    required int position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         cueId: cueId,
         text: text,
         normalizedText: normalizedText,
         startMs: startMs,
         endMs: endMs,
         position: position,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubtitleToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleToken copyWith({
    Object? id = _Undefined,
    int? cueId,
    String? text,
    Object? normalizedText = _Undefined,
    Object? startMs = _Undefined,
    Object? endMs = _Undefined,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubtitleToken(
      id: id is int? ? id : this.id,
      cueId: cueId ?? this.cueId,
      text: text ?? this.text,
      normalizedText: normalizedText is String?
          ? normalizedText
          : this.normalizedText,
      startMs: startMs is int? ? startMs : this.startMs,
      endMs: endMs is int? ? endMs : this.endMs,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SubtitleTokenUpdateTable extends _i1.UpdateTable<SubtitleTokenTable> {
  SubtitleTokenUpdateTable(super.table);

  _i1.ColumnValue<int, int> cueId(int value) => _i1.ColumnValue(
    table.cueId,
    value,
  );

  _i1.ColumnValue<String, String> text(String value) => _i1.ColumnValue(
    table.text,
    value,
  );

  _i1.ColumnValue<String, String> normalizedText(String? value) =>
      _i1.ColumnValue(
        table.normalizedText,
        value,
      );

  _i1.ColumnValue<int, int> startMs(int? value) => _i1.ColumnValue(
    table.startMs,
    value,
  );

  _i1.ColumnValue<int, int> endMs(int? value) => _i1.ColumnValue(
    table.endMs,
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

class SubtitleTokenTable extends _i1.Table<int?> {
  SubtitleTokenTable({super.tableRelation})
    : super(tableName: 'subtitle_token') {
    updateTable = SubtitleTokenUpdateTable(this);
    cueId = _i1.ColumnInt(
      'cueId',
      this,
    );
    text = _i1.ColumnString(
      'text',
      this,
    );
    normalizedText = _i1.ColumnString(
      'normalizedText',
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

  late final SubtitleTokenUpdateTable updateTable;

  late final _i1.ColumnInt cueId;

  late final _i1.ColumnString text;

  late final _i1.ColumnString normalizedText;

  late final _i1.ColumnInt startMs;

  late final _i1.ColumnInt endMs;

  late final _i1.ColumnInt position;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    cueId,
    text,
    normalizedText,
    startMs,
    endMs,
    position,
    createdAt,
    updatedAt,
  ];
}

class SubtitleTokenInclude extends _i1.IncludeObject {
  SubtitleTokenInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SubtitleToken.t;
}

class SubtitleTokenIncludeList extends _i1.IncludeList {
  SubtitleTokenIncludeList._({
    _i1.WhereExpressionBuilder<SubtitleTokenTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubtitleToken.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SubtitleToken.t;
}

class SubtitleTokenRepository {
  const SubtitleTokenRepository._();

  /// Returns a list of [SubtitleToken]s matching the given query parameters.
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
  Future<List<SubtitleToken>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleTokenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleTokenTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SubtitleToken>(
      where: where?.call(SubtitleToken.t),
      orderBy: orderBy?.call(SubtitleToken.t),
      orderByList: orderByList?.call(SubtitleToken.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SubtitleToken] matching the given query parameters.
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
  Future<SubtitleToken?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleTokenTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubtitleTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleTokenTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SubtitleToken>(
      where: where?.call(SubtitleToken.t),
      orderBy: orderBy?.call(SubtitleToken.t),
      orderByList: orderByList?.call(SubtitleToken.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SubtitleToken] by its [id] or null if no such row exists.
  Future<SubtitleToken?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SubtitleToken>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SubtitleToken]s in the list and returns the inserted rows.
  ///
  /// The returned [SubtitleToken]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SubtitleToken>> insert(
    _i1.DatabaseSession session,
    List<SubtitleToken> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SubtitleToken>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SubtitleToken] and returns the inserted row.
  ///
  /// The returned [SubtitleToken] will have its `id` field set.
  Future<SubtitleToken> insertRow(
    _i1.DatabaseSession session,
    SubtitleToken row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubtitleToken>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SubtitleToken]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SubtitleToken>> update(
    _i1.DatabaseSession session,
    List<SubtitleToken> rows, {
    _i1.ColumnSelections<SubtitleTokenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SubtitleToken>(
      rows,
      columns: columns?.call(SubtitleToken.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitleToken]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubtitleToken> updateRow(
    _i1.DatabaseSession session,
    SubtitleToken row, {
    _i1.ColumnSelections<SubtitleTokenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubtitleToken>(
      row,
      columns: columns?.call(SubtitleToken.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitleToken] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SubtitleToken?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SubtitleTokenUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SubtitleToken>(
      id,
      columnValues: columnValues(SubtitleToken.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SubtitleToken]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SubtitleToken>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SubtitleTokenUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SubtitleTokenTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleTokenTable>? orderBy,
    _i1.OrderByListBuilder<SubtitleTokenTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SubtitleToken>(
      columnValues: columnValues(SubtitleToken.t.updateTable),
      where: where(SubtitleToken.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitleToken.t),
      orderByList: orderByList?.call(SubtitleToken.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SubtitleToken]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SubtitleToken>> delete(
    _i1.DatabaseSession session,
    List<SubtitleToken> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SubtitleToken>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SubtitleToken].
  Future<SubtitleToken> deleteRow(
    _i1.DatabaseSession session,
    SubtitleToken row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubtitleToken>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SubtitleToken>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitleTokenTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SubtitleToken>(
      where: where(SubtitleToken.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleTokenTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SubtitleToken>(
      where: where?.call(SubtitleToken.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SubtitleToken] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitleTokenTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SubtitleToken>(
      where: where(SubtitleToken.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
