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

abstract class CommentReplyRow
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CommentReplyRow._({
    this.id,
    required this.commentId,
    required this.userId,
    required this.userName,
    required this.content,
    int? likeCount,
    DateTime? createdAt,
  }) : likeCount = likeCount ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory CommentReplyRow({
    int? id,
    required int commentId,
    required String userId,
    required String userName,
    required String content,
    int? likeCount,
    DateTime? createdAt,
  }) = _CommentReplyRowImpl;

  factory CommentReplyRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommentReplyRow(
      id: jsonSerialization['id'] as int?,
      commentId: jsonSerialization['commentId'] as int,
      userId: jsonSerialization['userId'] as String,
      userName: jsonSerialization['userName'] as String,
      content: jsonSerialization['content'] as String,
      likeCount: jsonSerialization['likeCount'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = CommentReplyRowTable();

  static const db = CommentReplyRowRepository._();

  @override
  int? id;

  int commentId;

  String userId;

  String userName;

  String content;

  int likeCount;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CommentReplyRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CommentReplyRow copyWith({
    int? id,
    int? commentId,
    String? userId,
    String? userName,
    String? content,
    int? likeCount,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CommentReplyRow',
      if (id != null) 'id': id,
      'commentId': commentId,
      'userId': userId,
      'userName': userName,
      'content': content,
      'likeCount': likeCount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CommentReplyRow',
      if (id != null) 'id': id,
      'commentId': commentId,
      'userId': userId,
      'userName': userName,
      'content': content,
      'likeCount': likeCount,
      'createdAt': createdAt.toJson(),
    };
  }

  static CommentReplyRowInclude include() {
    return CommentReplyRowInclude._();
  }

  static CommentReplyRowIncludeList includeList({
    _i1.WhereExpressionBuilder<CommentReplyRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommentReplyRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommentReplyRowTable>? orderByList,
    CommentReplyRowInclude? include,
  }) {
    return CommentReplyRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CommentReplyRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CommentReplyRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommentReplyRowImpl extends CommentReplyRow {
  _CommentReplyRowImpl({
    int? id,
    required int commentId,
    required String userId,
    required String userName,
    required String content,
    int? likeCount,
    DateTime? createdAt,
  }) : super._(
         id: id,
         commentId: commentId,
         userId: userId,
         userName: userName,
         content: content,
         likeCount: likeCount,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CommentReplyRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CommentReplyRow copyWith({
    Object? id = _Undefined,
    int? commentId,
    String? userId,
    String? userName,
    String? content,
    int? likeCount,
    DateTime? createdAt,
  }) {
    return CommentReplyRow(
      id: id is int? ? id : this.id,
      commentId: commentId ?? this.commentId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      content: content ?? this.content,
      likeCount: likeCount ?? this.likeCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CommentReplyRowUpdateTable extends _i1.UpdateTable<CommentReplyRowTable> {
  CommentReplyRowUpdateTable(super.table);

  _i1.ColumnValue<int, int> commentId(int value) => _i1.ColumnValue(
    table.commentId,
    value,
  );

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> userName(String value) => _i1.ColumnValue(
    table.userName,
    value,
  );

  _i1.ColumnValue<String, String> content(String value) => _i1.ColumnValue(
    table.content,
    value,
  );

  _i1.ColumnValue<int, int> likeCount(int value) => _i1.ColumnValue(
    table.likeCount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class CommentReplyRowTable extends _i1.Table<int?> {
  CommentReplyRowTable({super.tableRelation})
    : super(tableName: 'comment_reply') {
    updateTable = CommentReplyRowUpdateTable(this);
    commentId = _i1.ColumnInt(
      'commentId',
      this,
    );
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    userName = _i1.ColumnString(
      'userName',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    likeCount = _i1.ColumnInt(
      'likeCount',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final CommentReplyRowUpdateTable updateTable;

  late final _i1.ColumnInt commentId;

  late final _i1.ColumnString userId;

  late final _i1.ColumnString userName;

  late final _i1.ColumnString content;

  late final _i1.ColumnInt likeCount;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    commentId,
    userId,
    userName,
    content,
    likeCount,
    createdAt,
  ];
}

class CommentReplyRowInclude extends _i1.IncludeObject {
  CommentReplyRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CommentReplyRow.t;
}

class CommentReplyRowIncludeList extends _i1.IncludeList {
  CommentReplyRowIncludeList._({
    _i1.WhereExpressionBuilder<CommentReplyRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CommentReplyRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CommentReplyRow.t;
}

class CommentReplyRowRepository {
  const CommentReplyRowRepository._();

  /// Returns a list of [CommentReplyRow]s matching the given query parameters.
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
  Future<List<CommentReplyRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CommentReplyRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommentReplyRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommentReplyRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CommentReplyRow>(
      where: where?.call(CommentReplyRow.t),
      orderBy: orderBy?.call(CommentReplyRow.t),
      orderByList: orderByList?.call(CommentReplyRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CommentReplyRow] matching the given query parameters.
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
  Future<CommentReplyRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CommentReplyRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<CommentReplyRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommentReplyRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CommentReplyRow>(
      where: where?.call(CommentReplyRow.t),
      orderBy: orderBy?.call(CommentReplyRow.t),
      orderByList: orderByList?.call(CommentReplyRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CommentReplyRow] by its [id] or null if no such row exists.
  Future<CommentReplyRow?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CommentReplyRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CommentReplyRow]s in the list and returns the inserted rows.
  ///
  /// The returned [CommentReplyRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CommentReplyRow>> insert(
    _i1.DatabaseSession session,
    List<CommentReplyRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CommentReplyRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CommentReplyRow] and returns the inserted row.
  ///
  /// The returned [CommentReplyRow] will have its `id` field set.
  Future<CommentReplyRow> insertRow(
    _i1.DatabaseSession session,
    CommentReplyRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CommentReplyRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CommentReplyRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CommentReplyRow>> update(
    _i1.DatabaseSession session,
    List<CommentReplyRow> rows, {
    _i1.ColumnSelections<CommentReplyRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CommentReplyRow>(
      rows,
      columns: columns?.call(CommentReplyRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CommentReplyRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CommentReplyRow> updateRow(
    _i1.DatabaseSession session,
    CommentReplyRow row, {
    _i1.ColumnSelections<CommentReplyRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CommentReplyRow>(
      row,
      columns: columns?.call(CommentReplyRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CommentReplyRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CommentReplyRow?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CommentReplyRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CommentReplyRow>(
      id,
      columnValues: columnValues(CommentReplyRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CommentReplyRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CommentReplyRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CommentReplyRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<CommentReplyRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommentReplyRowTable>? orderBy,
    _i1.OrderByListBuilder<CommentReplyRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CommentReplyRow>(
      columnValues: columnValues(CommentReplyRow.t.updateTable),
      where: where(CommentReplyRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CommentReplyRow.t),
      orderByList: orderByList?.call(CommentReplyRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CommentReplyRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CommentReplyRow>> delete(
    _i1.DatabaseSession session,
    List<CommentReplyRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CommentReplyRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CommentReplyRow].
  Future<CommentReplyRow> deleteRow(
    _i1.DatabaseSession session,
    CommentReplyRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CommentReplyRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CommentReplyRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CommentReplyRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CommentReplyRow>(
      where: where(CommentReplyRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CommentReplyRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CommentReplyRow>(
      where: where?.call(CommentReplyRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CommentReplyRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CommentReplyRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CommentReplyRow>(
      where: where(CommentReplyRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
