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

abstract class DictionaryForm
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DictionaryForm._({
    this.id,
    required this.entryId,
    required this.scriptCode,
    required this.text,
    required this.normalizedText,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isPrimary = isPrimary ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DictionaryForm({
    int? id,
    required int entryId,
    required String scriptCode,
    required String text,
    required String normalizedText,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DictionaryFormImpl;

  factory DictionaryForm.fromJson(Map<String, dynamic> jsonSerialization) {
    return DictionaryForm(
      id: jsonSerialization['id'] as int?,
      entryId: jsonSerialization['entryId'] as int,
      scriptCode: jsonSerialization['scriptCode'] as String,
      text: jsonSerialization['text'] as String,
      normalizedText: jsonSerialization['normalizedText'] as String,
      isPrimary: jsonSerialization['isPrimary'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isPrimary']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = DictionaryFormTable();

  static const db = DictionaryFormRepository._();

  @override
  int? id;

  int entryId;

  String scriptCode;

  String text;

  String normalizedText;

  bool isPrimary;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DictionaryForm]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryForm copyWith({
    int? id,
    int? entryId,
    String? scriptCode,
    String? text,
    String? normalizedText,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryForm',
      if (id != null) 'id': id,
      'entryId': entryId,
      'scriptCode': scriptCode,
      'text': text,
      'normalizedText': normalizedText,
      'isPrimary': isPrimary,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DictionaryForm',
      if (id != null) 'id': id,
      'entryId': entryId,
      'scriptCode': scriptCode,
      'text': text,
      'normalizedText': normalizedText,
      'isPrimary': isPrimary,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DictionaryFormInclude include() {
    return DictionaryFormInclude._();
  }

  static DictionaryFormIncludeList includeList({
    _i1.WhereExpressionBuilder<DictionaryFormTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryFormTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryFormTable>? orderByList,
    DictionaryFormInclude? include,
  }) {
    return DictionaryFormIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryForm.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DictionaryForm.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DictionaryFormImpl extends DictionaryForm {
  _DictionaryFormImpl({
    int? id,
    required int entryId,
    required String scriptCode,
    required String text,
    required String normalizedText,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         entryId: entryId,
         scriptCode: scriptCode,
         text: text,
         normalizedText: normalizedText,
         isPrimary: isPrimary,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DictionaryForm]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryForm copyWith({
    Object? id = _Undefined,
    int? entryId,
    String? scriptCode,
    String? text,
    String? normalizedText,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DictionaryForm(
      id: id is int? ? id : this.id,
      entryId: entryId ?? this.entryId,
      scriptCode: scriptCode ?? this.scriptCode,
      text: text ?? this.text,
      normalizedText: normalizedText ?? this.normalizedText,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DictionaryFormUpdateTable extends _i1.UpdateTable<DictionaryFormTable> {
  DictionaryFormUpdateTable(super.table);

  _i1.ColumnValue<int, int> entryId(int value) => _i1.ColumnValue(
    table.entryId,
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

  _i1.ColumnValue<String, String> normalizedText(String value) =>
      _i1.ColumnValue(
        table.normalizedText,
        value,
      );

  _i1.ColumnValue<bool, bool> isPrimary(bool value) => _i1.ColumnValue(
    table.isPrimary,
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

class DictionaryFormTable extends _i1.Table<int?> {
  DictionaryFormTable({super.tableRelation})
    : super(tableName: 'dictionary_form') {
    updateTable = DictionaryFormUpdateTable(this);
    entryId = _i1.ColumnInt(
      'entryId',
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
    normalizedText = _i1.ColumnString(
      'normalizedText',
      this,
    );
    isPrimary = _i1.ColumnBool(
      'isPrimary',
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

  late final DictionaryFormUpdateTable updateTable;

  late final _i1.ColumnInt entryId;

  late final _i1.ColumnString scriptCode;

  late final _i1.ColumnString text;

  late final _i1.ColumnString normalizedText;

  late final _i1.ColumnBool isPrimary;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    entryId,
    scriptCode,
    text,
    normalizedText,
    isPrimary,
    createdAt,
    updatedAt,
  ];
}

class DictionaryFormInclude extends _i1.IncludeObject {
  DictionaryFormInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DictionaryForm.t;
}

class DictionaryFormIncludeList extends _i1.IncludeList {
  DictionaryFormIncludeList._({
    _i1.WhereExpressionBuilder<DictionaryFormTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DictionaryForm.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DictionaryForm.t;
}

class DictionaryFormRepository {
  const DictionaryFormRepository._();

  /// Returns a list of [DictionaryForm]s matching the given query parameters.
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
  Future<List<DictionaryForm>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryFormTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryFormTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryFormTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DictionaryForm>(
      where: where?.call(DictionaryForm.t),
      orderBy: orderBy?.call(DictionaryForm.t),
      orderByList: orderByList?.call(DictionaryForm.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DictionaryForm] matching the given query parameters.
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
  Future<DictionaryForm?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryFormTable>? where,
    int? offset,
    _i1.OrderByBuilder<DictionaryFormTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryFormTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DictionaryForm>(
      where: where?.call(DictionaryForm.t),
      orderBy: orderBy?.call(DictionaryForm.t),
      orderByList: orderByList?.call(DictionaryForm.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DictionaryForm] by its [id] or null if no such row exists.
  Future<DictionaryForm?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DictionaryForm>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DictionaryForm]s in the list and returns the inserted rows.
  ///
  /// The returned [DictionaryForm]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DictionaryForm>> insert(
    _i1.DatabaseSession session,
    List<DictionaryForm> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DictionaryForm>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DictionaryForm] and returns the inserted row.
  ///
  /// The returned [DictionaryForm] will have its `id` field set.
  Future<DictionaryForm> insertRow(
    _i1.DatabaseSession session,
    DictionaryForm row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DictionaryForm>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryForm]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DictionaryForm>> update(
    _i1.DatabaseSession session,
    List<DictionaryForm> rows, {
    _i1.ColumnSelections<DictionaryFormTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DictionaryForm>(
      rows,
      columns: columns?.call(DictionaryForm.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryForm]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DictionaryForm> updateRow(
    _i1.DatabaseSession session,
    DictionaryForm row, {
    _i1.ColumnSelections<DictionaryFormTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DictionaryForm>(
      row,
      columns: columns?.call(DictionaryForm.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryForm] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DictionaryForm?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DictionaryFormUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DictionaryForm>(
      id,
      columnValues: columnValues(DictionaryForm.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryForm]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DictionaryForm>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DictionaryFormUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DictionaryFormTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryFormTable>? orderBy,
    _i1.OrderByListBuilder<DictionaryFormTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DictionaryForm>(
      columnValues: columnValues(DictionaryForm.t.updateTable),
      where: where(DictionaryForm.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryForm.t),
      orderByList: orderByList?.call(DictionaryForm.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DictionaryForm]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DictionaryForm>> delete(
    _i1.DatabaseSession session,
    List<DictionaryForm> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DictionaryForm>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DictionaryForm].
  Future<DictionaryForm> deleteRow(
    _i1.DatabaseSession session,
    DictionaryForm row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DictionaryForm>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DictionaryForm>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryFormTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DictionaryForm>(
      where: where(DictionaryForm.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryFormTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DictionaryForm>(
      where: where?.call(DictionaryForm.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DictionaryForm] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryFormTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DictionaryForm>(
      where: where(DictionaryForm.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
