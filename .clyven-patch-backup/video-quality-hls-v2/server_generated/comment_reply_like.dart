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

abstract class CommentReplyLike
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CommentReplyLike._({
    this.id,
    required this.replyId,
    required this.userId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory CommentReplyLike({
    int? id,
    required int replyId,
    required String userId,
    DateTime? createdAt,
  }) = _CommentReplyLikeImpl;

  factory CommentReplyLike.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommentReplyLike(
      id: jsonSerialization['id'] as int?,
      replyId: jsonSerialization['replyId'] as int,
      userId: jsonSerialization['userId'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = CommentReplyLikeTable();

  static const db = CommentReplyLikeRepository._();

  @override
  int? id;

  int replyId;

  String userId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CommentReplyLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CommentReplyLike copyWith({
    int? id,
    int? replyId,
    String? userId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CommentReplyLike',
      if (id != null) 'id': id,
      'replyId': replyId,
      'userId': userId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CommentReplyLike',
      if (id != null) 'id': id,
      'replyId': replyId,
      'userId': userId,
      'createdAt': createdAt.toJson(),
    };
  }

  static CommentReplyLikeInclude include() {
    return CommentReplyLikeInclude._();
  }

  static CommentReplyLikeIncludeList includeList({
    _i1.WhereExpressionBuilder<CommentReplyLikeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommentReplyLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommentReplyLikeTable>? orderByList,
    CommentReplyLikeInclude? include,
  }) {
    return CommentReplyLikeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CommentReplyLike.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CommentReplyLike.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommentReplyLikeImpl extends CommentReplyLike {
  _CommentReplyLikeImpl({
    int? id,
    required int replyId,
    required String userId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         replyId: replyId,
         userId: userId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CommentReplyLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CommentReplyLike copyWith({
    Object? id = _Undefined,
    int? replyId,
    String? userId,
    DateTime? createdAt,
  }) {
    return CommentReplyLike(
      id: id is int? ? id : this.id,
      replyId: replyId ?? this.replyId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CommentReplyLikeUpdateTable
    extends _i1.UpdateTable<CommentReplyLikeTable> {
  CommentReplyLikeUpdateTable(super.table);

  _i1.ColumnValue<int, int> replyId(int value) => _i1.ColumnValue(
    table.replyId,
    value,
  );

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class CommentReplyLikeTable extends _i1.Table<int?> {
  CommentReplyLikeTable({super.tableRelation})
    : super(tableName: 'comment_reply_like') {
    updateTable = CommentReplyLikeUpdateTable(this);
    replyId = _i1.ColumnInt(
      'replyId',
      this,
    );
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final CommentReplyLikeUpdateTable updateTable;

  late final _i1.ColumnInt replyId;

  late final _i1.ColumnString userId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    replyId,
    userId,
    createdAt,
  ];
}

class CommentReplyLikeInclude extends _i1.IncludeObject {
  CommentReplyLikeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CommentReplyLike.t;
}

class CommentReplyLikeIncludeList extends _i1.IncludeList {
  CommentReplyLikeIncludeList._({
    _i1.WhereExpressionBuilder<CommentReplyLikeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CommentReplyLike.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CommentReplyLike.t;
}

class CommentReplyLikeRepository {
  const CommentReplyLikeRepository._();

  /// Returns a list of [CommentReplyLike]s matching the given query parameters.
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
  Future<List<CommentReplyLike>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CommentReplyLikeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommentReplyLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommentReplyLikeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CommentReplyLike>(
      where: where?.call(CommentReplyLike.t),
      orderBy: orderBy?.call(CommentReplyLike.t),
      orderByList: orderByList?.call(CommentReplyLike.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CommentReplyLike] matching the given query parameters.
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
  Future<CommentReplyLike?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CommentReplyLikeTable>? where,
    int? offset,
    _i1.OrderByBuilder<CommentReplyLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommentReplyLikeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CommentReplyLike>(
      where: where?.call(CommentReplyLike.t),
      orderBy: orderBy?.call(CommentReplyLike.t),
      orderByList: orderByList?.call(CommentReplyLike.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CommentReplyLike] by its [id] or null if no such row exists.
  Future<CommentReplyLike?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CommentReplyLike>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CommentReplyLike]s in the list and returns the inserted rows.
  ///
  /// The returned [CommentReplyLike]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CommentReplyLike>> insert(
    _i1.DatabaseSession session,
    List<CommentReplyLike> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CommentReplyLike>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CommentReplyLike] and returns the inserted row.
  ///
  /// The returned [CommentReplyLike] will have its `id` field set.
  Future<CommentReplyLike> insertRow(
    _i1.DatabaseSession session,
    CommentReplyLike row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CommentReplyLike>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CommentReplyLike]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CommentReplyLike>> update(
    _i1.DatabaseSession session,
    List<CommentReplyLike> rows, {
    _i1.ColumnSelections<CommentReplyLikeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CommentReplyLike>(
      rows,
      columns: columns?.call(CommentReplyLike.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CommentReplyLike]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CommentReplyLike> updateRow(
    _i1.DatabaseSession session,
    CommentReplyLike row, {
    _i1.ColumnSelections<CommentReplyLikeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CommentReplyLike>(
      row,
      columns: columns?.call(CommentReplyLike.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CommentReplyLike] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CommentReplyLike?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CommentReplyLikeUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CommentReplyLike>(
      id,
      columnValues: columnValues(CommentReplyLike.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CommentReplyLike]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CommentReplyLike>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CommentReplyLikeUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<CommentReplyLikeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommentReplyLikeTable>? orderBy,
    _i1.OrderByListBuilder<CommentReplyLikeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CommentReplyLike>(
      columnValues: columnValues(CommentReplyLike.t.updateTable),
      where: where(CommentReplyLike.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CommentReplyLike.t),
      orderByList: orderByList?.call(CommentReplyLike.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CommentReplyLike]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CommentReplyLike>> delete(
    _i1.DatabaseSession session,
    List<CommentReplyLike> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CommentReplyLike>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CommentReplyLike].
  Future<CommentReplyLike> deleteRow(
    _i1.DatabaseSession session,
    CommentReplyLike row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CommentReplyLike>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CommentReplyLike>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CommentReplyLikeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CommentReplyLike>(
      where: where(CommentReplyLike.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CommentReplyLikeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CommentReplyLike>(
      where: where?.call(CommentReplyLike.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CommentReplyLike] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CommentReplyLikeTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CommentReplyLike>(
      where: where(CommentReplyLike.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
