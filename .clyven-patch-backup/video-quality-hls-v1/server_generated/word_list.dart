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

abstract class WordList
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WordList._({
    this.id,
    required this.name,
    required this.languageCode,
    this.description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory WordList({
    int? id,
    required String name,
    required String languageCode,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WordListImpl;

  factory WordList.fromJson(Map<String, dynamic> jsonSerialization) {
    return WordList(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      languageCode: jsonSerialization['languageCode'] as String,
      description: jsonSerialization['description'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = WordListTable();

  static const db = WordListRepository._();

  @override
  int? id;

  String name;

  String languageCode;

  String? description;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WordList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WordList copyWith({
    int? id,
    String? name,
    String? languageCode,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WordList',
      if (id != null) 'id': id,
      'name': name,
      'languageCode': languageCode,
      if (description != null) 'description': description,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WordList',
      if (id != null) 'id': id,
      'name': name,
      'languageCode': languageCode,
      if (description != null) 'description': description,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static WordListInclude include() {
    return WordListInclude._();
  }

  static WordListIncludeList includeList({
    _i1.WhereExpressionBuilder<WordListTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WordListTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WordListTable>? orderByList,
    WordListInclude? include,
  }) {
    return WordListIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WordList.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WordList.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WordListImpl extends WordList {
  _WordListImpl({
    int? id,
    required String name,
    required String languageCode,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         languageCode: languageCode,
         description: description,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WordList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WordList copyWith({
    Object? id = _Undefined,
    String? name,
    String? languageCode,
    Object? description = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WordList(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      languageCode: languageCode ?? this.languageCode,
      description: description is String? ? description : this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class WordListUpdateTable extends _i1.UpdateTable<WordListTable> {
  WordListUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> languageCode(String value) => _i1.ColumnValue(
    table.languageCode,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
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

class WordListTable extends _i1.Table<int?> {
  WordListTable({super.tableRelation}) : super(tableName: 'word_list') {
    updateTable = WordListUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    languageCode = _i1.ColumnString(
      'languageCode',
      this,
    );
    description = _i1.ColumnString(
      'description',
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

  late final WordListUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString languageCode;

  late final _i1.ColumnString description;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    languageCode,
    description,
    createdAt,
    updatedAt,
  ];
}

class WordListInclude extends _i1.IncludeObject {
  WordListInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => WordList.t;
}

class WordListIncludeList extends _i1.IncludeList {
  WordListIncludeList._({
    _i1.WhereExpressionBuilder<WordListTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WordList.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WordList.t;
}

class WordListRepository {
  const WordListRepository._();

  /// Returns a list of [WordList]s matching the given query parameters.
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
  Future<List<WordList>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WordListTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WordListTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WordListTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WordList>(
      where: where?.call(WordList.t),
      orderBy: orderBy?.call(WordList.t),
      orderByList: orderByList?.call(WordList.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WordList] matching the given query parameters.
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
  Future<WordList?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WordListTable>? where,
    int? offset,
    _i1.OrderByBuilder<WordListTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WordListTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WordList>(
      where: where?.call(WordList.t),
      orderBy: orderBy?.call(WordList.t),
      orderByList: orderByList?.call(WordList.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WordList] by its [id] or null if no such row exists.
  Future<WordList?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WordList>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WordList]s in the list and returns the inserted rows.
  ///
  /// The returned [WordList]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<WordList>> insert(
    _i1.DatabaseSession session,
    List<WordList> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<WordList>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [WordList] and returns the inserted row.
  ///
  /// The returned [WordList] will have its `id` field set.
  Future<WordList> insertRow(
    _i1.DatabaseSession session,
    WordList row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WordList>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WordList]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WordList>> update(
    _i1.DatabaseSession session,
    List<WordList> rows, {
    _i1.ColumnSelections<WordListTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WordList>(
      rows,
      columns: columns?.call(WordList.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WordList]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WordList> updateRow(
    _i1.DatabaseSession session,
    WordList row, {
    _i1.ColumnSelections<WordListTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WordList>(
      row,
      columns: columns?.call(WordList.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WordList] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WordList?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<WordListUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WordList>(
      id,
      columnValues: columnValues(WordList.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WordList]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WordList>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<WordListUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WordListTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WordListTable>? orderBy,
    _i1.OrderByListBuilder<WordListTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WordList>(
      columnValues: columnValues(WordList.t.updateTable),
      where: where(WordList.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WordList.t),
      orderByList: orderByList?.call(WordList.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WordList]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WordList>> delete(
    _i1.DatabaseSession session,
    List<WordList> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WordList>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WordList].
  Future<WordList> deleteRow(
    _i1.DatabaseSession session,
    WordList row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WordList>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WordList>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WordListTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WordList>(
      where: where(WordList.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WordListTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WordList>(
      where: where?.call(WordList.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WordList] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WordListTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WordList>(
      where: where(WordList.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
