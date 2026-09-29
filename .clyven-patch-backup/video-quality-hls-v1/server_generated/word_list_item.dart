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

abstract class WordListItem
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WordListItem._({
    this.id,
    required this.listId,
    required this.entryId,
    required this.position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory WordListItem({
    int? id,
    required int listId,
    required int entryId,
    required int position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WordListItemImpl;

  factory WordListItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return WordListItem(
      id: jsonSerialization['id'] as int?,
      listId: jsonSerialization['listId'] as int,
      entryId: jsonSerialization['entryId'] as int,
      position: jsonSerialization['position'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = WordListItemTable();

  static const db = WordListItemRepository._();

  @override
  int? id;

  int listId;

  int entryId;

  int position;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WordListItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WordListItem copyWith({
    int? id,
    int? listId,
    int? entryId,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WordListItem',
      if (id != null) 'id': id,
      'listId': listId,
      'entryId': entryId,
      'position': position,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WordListItem',
      if (id != null) 'id': id,
      'listId': listId,
      'entryId': entryId,
      'position': position,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static WordListItemInclude include() {
    return WordListItemInclude._();
  }

  static WordListItemIncludeList includeList({
    _i1.WhereExpressionBuilder<WordListItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WordListItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WordListItemTable>? orderByList,
    WordListItemInclude? include,
  }) {
    return WordListItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WordListItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WordListItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WordListItemImpl extends WordListItem {
  _WordListItemImpl({
    int? id,
    required int listId,
    required int entryId,
    required int position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         listId: listId,
         entryId: entryId,
         position: position,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WordListItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WordListItem copyWith({
    Object? id = _Undefined,
    int? listId,
    int? entryId,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WordListItem(
      id: id is int? ? id : this.id,
      listId: listId ?? this.listId,
      entryId: entryId ?? this.entryId,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class WordListItemUpdateTable extends _i1.UpdateTable<WordListItemTable> {
  WordListItemUpdateTable(super.table);

  _i1.ColumnValue<int, int> listId(int value) => _i1.ColumnValue(
    table.listId,
    value,
  );

  _i1.ColumnValue<int, int> entryId(int value) => _i1.ColumnValue(
    table.entryId,
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

class WordListItemTable extends _i1.Table<int?> {
  WordListItemTable({super.tableRelation})
    : super(tableName: 'word_list_item') {
    updateTable = WordListItemUpdateTable(this);
    listId = _i1.ColumnInt(
      'listId',
      this,
    );
    entryId = _i1.ColumnInt(
      'entryId',
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

  late final WordListItemUpdateTable updateTable;

  late final _i1.ColumnInt listId;

  late final _i1.ColumnInt entryId;

  late final _i1.ColumnInt position;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    listId,
    entryId,
    position,
    createdAt,
    updatedAt,
  ];
}

class WordListItemInclude extends _i1.IncludeObject {
  WordListItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => WordListItem.t;
}

class WordListItemIncludeList extends _i1.IncludeList {
  WordListItemIncludeList._({
    _i1.WhereExpressionBuilder<WordListItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WordListItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WordListItem.t;
}

class WordListItemRepository {
  const WordListItemRepository._();

  /// Returns a list of [WordListItem]s matching the given query parameters.
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
  Future<List<WordListItem>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WordListItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WordListItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WordListItemTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WordListItem>(
      where: where?.call(WordListItem.t),
      orderBy: orderBy?.call(WordListItem.t),
      orderByList: orderByList?.call(WordListItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [WordListItem] matching the given query parameters.
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
  Future<WordListItem?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WordListItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<WordListItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WordListItemTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WordListItem>(
      where: where?.call(WordListItem.t),
      orderBy: orderBy?.call(WordListItem.t),
      orderByList: orderByList?.call(WordListItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WordListItem] by its [id] or null if no such row exists.
  Future<WordListItem?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WordListItem>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WordListItem]s in the list and returns the inserted rows.
  ///
  /// The returned [WordListItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<WordListItem>> insert(
    _i1.DatabaseSession session,
    List<WordListItem> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<WordListItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [WordListItem] and returns the inserted row.
  ///
  /// The returned [WordListItem] will have its `id` field set.
  Future<WordListItem> insertRow(
    _i1.DatabaseSession session,
    WordListItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WordListItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WordListItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WordListItem>> update(
    _i1.DatabaseSession session,
    List<WordListItem> rows, {
    _i1.ColumnSelections<WordListItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WordListItem>(
      rows,
      columns: columns?.call(WordListItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WordListItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WordListItem> updateRow(
    _i1.DatabaseSession session,
    WordListItem row, {
    _i1.ColumnSelections<WordListItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WordListItem>(
      row,
      columns: columns?.call(WordListItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WordListItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WordListItem?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<WordListItemUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WordListItem>(
      id,
      columnValues: columnValues(WordListItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WordListItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WordListItem>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<WordListItemUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WordListItemTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WordListItemTable>? orderBy,
    _i1.OrderByListBuilder<WordListItemTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WordListItem>(
      columnValues: columnValues(WordListItem.t.updateTable),
      where: where(WordListItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WordListItem.t),
      orderByList: orderByList?.call(WordListItem.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WordListItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WordListItem>> delete(
    _i1.DatabaseSession session,
    List<WordListItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WordListItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WordListItem].
  Future<WordListItem> deleteRow(
    _i1.DatabaseSession session,
    WordListItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WordListItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WordListItem>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WordListItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WordListItem>(
      where: where(WordListItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<WordListItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WordListItem>(
      where: where?.call(WordListItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WordListItem] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<WordListItemTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WordListItem>(
      where: where(WordListItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
