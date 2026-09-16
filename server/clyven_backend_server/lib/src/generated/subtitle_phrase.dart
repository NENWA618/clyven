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

abstract class SubtitlePhrase
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SubtitlePhrase._({
    this.id,
    required this.cueId,
    required this.text,
    this.normalizedText,
    required this.startPosition,
    required this.endPosition,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubtitlePhrase({
    int? id,
    required int cueId,
    required String text,
    String? normalizedText,
    required int startPosition,
    required int endPosition,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubtitlePhraseImpl;

  factory SubtitlePhrase.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtitlePhrase(
      id: jsonSerialization['id'] as int?,
      cueId: jsonSerialization['cueId'] as int,
      text: jsonSerialization['text'] as String,
      normalizedText: jsonSerialization['normalizedText'] as String?,
      startPosition: jsonSerialization['startPosition'] as int,
      endPosition: jsonSerialization['endPosition'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SubtitlePhraseTable();

  static const db = SubtitlePhraseRepository._();

  @override
  int? id;

  int cueId;

  String text;

  String? normalizedText;

  int startPosition;

  int endPosition;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubtitlePhrase]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitlePhrase copyWith({
    int? id,
    int? cueId,
    String? text,
    String? normalizedText,
    int? startPosition,
    int? endPosition,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitlePhrase',
      if (id != null) 'id': id,
      'cueId': cueId,
      'text': text,
      if (normalizedText != null) 'normalizedText': normalizedText,
      'startPosition': startPosition,
      'endPosition': endPosition,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubtitlePhrase',
      if (id != null) 'id': id,
      'cueId': cueId,
      'text': text,
      if (normalizedText != null) 'normalizedText': normalizedText,
      'startPosition': startPosition,
      'endPosition': endPosition,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SubtitlePhraseInclude include() {
    return SubtitlePhraseInclude._();
  }

  static SubtitlePhraseIncludeList includeList({
    _i1.WhereExpressionBuilder<SubtitlePhraseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitlePhraseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitlePhraseTable>? orderByList,
    SubtitlePhraseInclude? include,
  }) {
    return SubtitlePhraseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitlePhrase.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SubtitlePhrase.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtitlePhraseImpl extends SubtitlePhrase {
  _SubtitlePhraseImpl({
    int? id,
    required int cueId,
    required String text,
    String? normalizedText,
    required int startPosition,
    required int endPosition,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         cueId: cueId,
         text: text,
         normalizedText: normalizedText,
         startPosition: startPosition,
         endPosition: endPosition,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubtitlePhrase]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitlePhrase copyWith({
    Object? id = _Undefined,
    int? cueId,
    String? text,
    Object? normalizedText = _Undefined,
    int? startPosition,
    int? endPosition,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubtitlePhrase(
      id: id is int? ? id : this.id,
      cueId: cueId ?? this.cueId,
      text: text ?? this.text,
      normalizedText: normalizedText is String?
          ? normalizedText
          : this.normalizedText,
      startPosition: startPosition ?? this.startPosition,
      endPosition: endPosition ?? this.endPosition,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SubtitlePhraseUpdateTable extends _i1.UpdateTable<SubtitlePhraseTable> {
  SubtitlePhraseUpdateTable(super.table);

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

  _i1.ColumnValue<int, int> startPosition(int value) => _i1.ColumnValue(
    table.startPosition,
    value,
  );

  _i1.ColumnValue<int, int> endPosition(int value) => _i1.ColumnValue(
    table.endPosition,
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

class SubtitlePhraseTable extends _i1.Table<int?> {
  SubtitlePhraseTable({super.tableRelation})
    : super(tableName: 'subtitle_phrase') {
    updateTable = SubtitlePhraseUpdateTable(this);
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
    startPosition = _i1.ColumnInt(
      'startPosition',
      this,
    );
    endPosition = _i1.ColumnInt(
      'endPosition',
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

  late final SubtitlePhraseUpdateTable updateTable;

  late final _i1.ColumnInt cueId;

  late final _i1.ColumnString text;

  late final _i1.ColumnString normalizedText;

  late final _i1.ColumnInt startPosition;

  late final _i1.ColumnInt endPosition;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    cueId,
    text,
    normalizedText,
    startPosition,
    endPosition,
    createdAt,
    updatedAt,
  ];
}

class SubtitlePhraseInclude extends _i1.IncludeObject {
  SubtitlePhraseInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SubtitlePhrase.t;
}

class SubtitlePhraseIncludeList extends _i1.IncludeList {
  SubtitlePhraseIncludeList._({
    _i1.WhereExpressionBuilder<SubtitlePhraseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubtitlePhrase.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SubtitlePhrase.t;
}

class SubtitlePhraseRepository {
  const SubtitlePhraseRepository._();

  /// Returns a list of [SubtitlePhrase]s matching the given query parameters.
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
  Future<List<SubtitlePhrase>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitlePhraseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitlePhraseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitlePhraseTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SubtitlePhrase>(
      where: where?.call(SubtitlePhrase.t),
      orderBy: orderBy?.call(SubtitlePhrase.t),
      orderByList: orderByList?.call(SubtitlePhrase.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SubtitlePhrase] matching the given query parameters.
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
  Future<SubtitlePhrase?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitlePhraseTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubtitlePhraseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitlePhraseTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SubtitlePhrase>(
      where: where?.call(SubtitlePhrase.t),
      orderBy: orderBy?.call(SubtitlePhrase.t),
      orderByList: orderByList?.call(SubtitlePhrase.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SubtitlePhrase] by its [id] or null if no such row exists.
  Future<SubtitlePhrase?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SubtitlePhrase>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SubtitlePhrase]s in the list and returns the inserted rows.
  ///
  /// The returned [SubtitlePhrase]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SubtitlePhrase>> insert(
    _i1.DatabaseSession session,
    List<SubtitlePhrase> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SubtitlePhrase>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SubtitlePhrase] and returns the inserted row.
  ///
  /// The returned [SubtitlePhrase] will have its `id` field set.
  Future<SubtitlePhrase> insertRow(
    _i1.DatabaseSession session,
    SubtitlePhrase row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubtitlePhrase>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SubtitlePhrase]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SubtitlePhrase>> update(
    _i1.DatabaseSession session,
    List<SubtitlePhrase> rows, {
    _i1.ColumnSelections<SubtitlePhraseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SubtitlePhrase>(
      rows,
      columns: columns?.call(SubtitlePhrase.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitlePhrase]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubtitlePhrase> updateRow(
    _i1.DatabaseSession session,
    SubtitlePhrase row, {
    _i1.ColumnSelections<SubtitlePhraseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubtitlePhrase>(
      row,
      columns: columns?.call(SubtitlePhrase.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitlePhrase] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SubtitlePhrase?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SubtitlePhraseUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SubtitlePhrase>(
      id,
      columnValues: columnValues(SubtitlePhrase.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SubtitlePhrase]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SubtitlePhrase>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SubtitlePhraseUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SubtitlePhraseTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitlePhraseTable>? orderBy,
    _i1.OrderByListBuilder<SubtitlePhraseTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SubtitlePhrase>(
      columnValues: columnValues(SubtitlePhrase.t.updateTable),
      where: where(SubtitlePhrase.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitlePhrase.t),
      orderByList: orderByList?.call(SubtitlePhrase.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SubtitlePhrase]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SubtitlePhrase>> delete(
    _i1.DatabaseSession session,
    List<SubtitlePhrase> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SubtitlePhrase>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SubtitlePhrase].
  Future<SubtitlePhrase> deleteRow(
    _i1.DatabaseSession session,
    SubtitlePhrase row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubtitlePhrase>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SubtitlePhrase>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitlePhraseTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SubtitlePhrase>(
      where: where(SubtitlePhrase.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitlePhraseTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SubtitlePhrase>(
      where: where?.call(SubtitlePhrase.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SubtitlePhrase] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitlePhraseTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SubtitlePhrase>(
      where: where(SubtitlePhrase.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
