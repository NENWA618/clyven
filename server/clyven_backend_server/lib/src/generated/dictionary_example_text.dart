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

abstract class DictionaryExampleText
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DictionaryExampleText._({
    this.id,
    required this.exampleId,
    required this.languageCode,
    required this.scriptCode,
    required this.text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DictionaryExampleText({
    int? id,
    required int exampleId,
    required String languageCode,
    required String scriptCode,
    required String text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DictionaryExampleTextImpl;

  factory DictionaryExampleText.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DictionaryExampleText(
      id: jsonSerialization['id'] as int?,
      exampleId: jsonSerialization['exampleId'] as int,
      languageCode: jsonSerialization['languageCode'] as String,
      scriptCode: jsonSerialization['scriptCode'] as String,
      text: jsonSerialization['text'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = DictionaryExampleTextTable();

  static const db = DictionaryExampleTextRepository._();

  @override
  int? id;

  int exampleId;

  String languageCode;

  String scriptCode;

  String text;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DictionaryExampleText]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryExampleText copyWith({
    int? id,
    int? exampleId,
    String? languageCode,
    String? scriptCode,
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryExampleText',
      if (id != null) 'id': id,
      'exampleId': exampleId,
      'languageCode': languageCode,
      'scriptCode': scriptCode,
      'text': text,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DictionaryExampleText',
      if (id != null) 'id': id,
      'exampleId': exampleId,
      'languageCode': languageCode,
      'scriptCode': scriptCode,
      'text': text,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DictionaryExampleTextInclude include() {
    return DictionaryExampleTextInclude._();
  }

  static DictionaryExampleTextIncludeList includeList({
    _i1.WhereExpressionBuilder<DictionaryExampleTextTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryExampleTextTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryExampleTextTable>? orderByList,
    DictionaryExampleTextInclude? include,
  }) {
    return DictionaryExampleTextIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryExampleText.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DictionaryExampleText.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DictionaryExampleTextImpl extends DictionaryExampleText {
  _DictionaryExampleTextImpl({
    int? id,
    required int exampleId,
    required String languageCode,
    required String scriptCode,
    required String text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         exampleId: exampleId,
         languageCode: languageCode,
         scriptCode: scriptCode,
         text: text,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DictionaryExampleText]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryExampleText copyWith({
    Object? id = _Undefined,
    int? exampleId,
    String? languageCode,
    String? scriptCode,
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DictionaryExampleText(
      id: id is int? ? id : this.id,
      exampleId: exampleId ?? this.exampleId,
      languageCode: languageCode ?? this.languageCode,
      scriptCode: scriptCode ?? this.scriptCode,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DictionaryExampleTextUpdateTable
    extends _i1.UpdateTable<DictionaryExampleTextTable> {
  DictionaryExampleTextUpdateTable(super.table);

  _i1.ColumnValue<int, int> exampleId(int value) => _i1.ColumnValue(
    table.exampleId,
    value,
  );

  _i1.ColumnValue<String, String> languageCode(String value) => _i1.ColumnValue(
    table.languageCode,
    value,
  );

  _i1.ColumnValue<String, String> scriptCode(String value) => _i1.ColumnValue(
    table.scriptCode,
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

class DictionaryExampleTextTable extends _i1.Table<int?> {
  DictionaryExampleTextTable({super.tableRelation})
    : super(tableName: 'dictionary_example_text') {
    updateTable = DictionaryExampleTextUpdateTable(this);
    exampleId = _i1.ColumnInt(
      'exampleId',
      this,
    );
    languageCode = _i1.ColumnString(
      'languageCode',
      this,
    );
    scriptCode = _i1.ColumnString(
      'scriptCode',
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

  late final DictionaryExampleTextUpdateTable updateTable;

  late final _i1.ColumnInt exampleId;

  late final _i1.ColumnString languageCode;

  late final _i1.ColumnString scriptCode;

  late final _i1.ColumnString text;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    exampleId,
    languageCode,
    scriptCode,
    text,
    createdAt,
    updatedAt,
  ];
}

class DictionaryExampleTextInclude extends _i1.IncludeObject {
  DictionaryExampleTextInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DictionaryExampleText.t;
}

class DictionaryExampleTextIncludeList extends _i1.IncludeList {
  DictionaryExampleTextIncludeList._({
    _i1.WhereExpressionBuilder<DictionaryExampleTextTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DictionaryExampleText.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DictionaryExampleText.t;
}

class DictionaryExampleTextRepository {
  const DictionaryExampleTextRepository._();

  /// Returns a list of [DictionaryExampleText]s matching the given query parameters.
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
  Future<List<DictionaryExampleText>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryExampleTextTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryExampleTextTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryExampleTextTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DictionaryExampleText>(
      where: where?.call(DictionaryExampleText.t),
      orderBy: orderBy?.call(DictionaryExampleText.t),
      orderByList: orderByList?.call(DictionaryExampleText.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DictionaryExampleText] matching the given query parameters.
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
  Future<DictionaryExampleText?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryExampleTextTable>? where,
    int? offset,
    _i1.OrderByBuilder<DictionaryExampleTextTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryExampleTextTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DictionaryExampleText>(
      where: where?.call(DictionaryExampleText.t),
      orderBy: orderBy?.call(DictionaryExampleText.t),
      orderByList: orderByList?.call(DictionaryExampleText.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DictionaryExampleText] by its [id] or null if no such row exists.
  Future<DictionaryExampleText?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DictionaryExampleText>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DictionaryExampleText]s in the list and returns the inserted rows.
  ///
  /// The returned [DictionaryExampleText]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DictionaryExampleText>> insert(
    _i1.DatabaseSession session,
    List<DictionaryExampleText> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DictionaryExampleText>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DictionaryExampleText] and returns the inserted row.
  ///
  /// The returned [DictionaryExampleText] will have its `id` field set.
  Future<DictionaryExampleText> insertRow(
    _i1.DatabaseSession session,
    DictionaryExampleText row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DictionaryExampleText>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryExampleText]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DictionaryExampleText>> update(
    _i1.DatabaseSession session,
    List<DictionaryExampleText> rows, {
    _i1.ColumnSelections<DictionaryExampleTextTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DictionaryExampleText>(
      rows,
      columns: columns?.call(DictionaryExampleText.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryExampleText]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DictionaryExampleText> updateRow(
    _i1.DatabaseSession session,
    DictionaryExampleText row, {
    _i1.ColumnSelections<DictionaryExampleTextTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DictionaryExampleText>(
      row,
      columns: columns?.call(DictionaryExampleText.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryExampleText] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DictionaryExampleText?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DictionaryExampleTextUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DictionaryExampleText>(
      id,
      columnValues: columnValues(DictionaryExampleText.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryExampleText]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DictionaryExampleText>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DictionaryExampleTextUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DictionaryExampleTextTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryExampleTextTable>? orderBy,
    _i1.OrderByListBuilder<DictionaryExampleTextTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DictionaryExampleText>(
      columnValues: columnValues(DictionaryExampleText.t.updateTable),
      where: where(DictionaryExampleText.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryExampleText.t),
      orderByList: orderByList?.call(DictionaryExampleText.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DictionaryExampleText]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DictionaryExampleText>> delete(
    _i1.DatabaseSession session,
    List<DictionaryExampleText> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DictionaryExampleText>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DictionaryExampleText].
  Future<DictionaryExampleText> deleteRow(
    _i1.DatabaseSession session,
    DictionaryExampleText row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DictionaryExampleText>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DictionaryExampleText>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryExampleTextTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DictionaryExampleText>(
      where: where(DictionaryExampleText.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryExampleTextTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DictionaryExampleText>(
      where: where?.call(DictionaryExampleText.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DictionaryExampleText] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryExampleTextTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DictionaryExampleText>(
      where: where(DictionaryExampleText.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
