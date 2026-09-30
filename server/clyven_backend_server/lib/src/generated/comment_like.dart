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

abstract class CommentLike
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CommentLike._({
    this.id,
    required this.commentId,
    required this.userId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory CommentLike({
    int? id,
    required int commentId,
    required String userId,
    DateTime? createdAt,
  }) = _CommentLikeImpl;

  factory CommentLike.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommentLike(
      id: jsonSerialization['id'] as int?,
      commentId: jsonSerialization['commentId'] as int,
      userId: jsonSerialization['userId'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = CommentLikeTable();

  static const db = CommentLikeRepository._();

  @override
  int? id;

  int commentId;

  String userId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CommentLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CommentLike copyWith({
    int? id,
    int? commentId,
    String? userId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CommentLike',
      if (id != null) 'id': id,
      'commentId': commentId,
      'userId': userId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CommentLike',
      if (id != null) 'id': id,
      'commentId': commentId,
      'userId': userId,
      'createdAt': createdAt.toJson(),
    };
  }

  static CommentLikeInclude include() {
    return CommentLikeInclude._();
  }

  static CommentLikeIncludeList includeList({
    _i1.WhereExpressionBuilder<CommentLikeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommentLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommentLikeTable>? orderByList,
    CommentLikeInclude? include,
  }) {
    return CommentLikeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CommentLike.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CommentLike.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommentLikeImpl extends CommentLike {
  _CommentLikeImpl({
    int? id,
    required int commentId,
    required String userId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         commentId: commentId,
         userId: userId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CommentLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CommentLike copyWith({
    Object? id = _Undefined,
    int? commentId,
    String? userId,
    DateTime? createdAt,
  }) {
    return CommentLike(
      id: id is int? ? id : this.id,
      commentId: commentId ?? this.commentId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CommentLikeUpdateTable extends _i1.UpdateTable<CommentLikeTable> {
  CommentLikeUpdateTable(super.table);

  _i1.ColumnValue<int, int> commentId(int value) => _i1.ColumnValue(
    table.commentId,
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

class CommentLikeTable extends _i1.Table<int?> {
  CommentLikeTable({super.tableRelation}) : super(tableName: 'comment_like') {
    updateTable = CommentLikeUpdateTable(this);
    commentId = _i1.ColumnInt(
      'commentId',
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

  late final CommentLikeUpdateTable updateTable;

  late final _i1.ColumnInt commentId;

  late final _i1.ColumnString userId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    commentId,
    userId,
    createdAt,
  ];
}

class CommentLikeInclude extends _i1.IncludeObject {
  CommentLikeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CommentLike.t;
}

class CommentLikeIncludeList extends _i1.IncludeList {
  CommentLikeIncludeList._({
    _i1.WhereExpressionBuilder<CommentLikeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CommentLike.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CommentLike.t;
}

class CommentLikeRepository {
  const CommentLikeRepository._();

  /// Returns a list of [CommentLike]s matching the given query parameters.
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
  Future<List<CommentLike>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CommentLikeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommentLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommentLikeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CommentLike>(
      where: where?.call(CommentLike.t),
      orderBy: orderBy?.call(CommentLike.t),
      orderByList: orderByList?.call(CommentLike.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CommentLike] matching the given query parameters.
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
  Future<CommentLike?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CommentLikeTable>? where,
    int? offset,
    _i1.OrderByBuilder<CommentLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommentLikeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CommentLike>(
      where: where?.call(CommentLike.t),
      orderBy: orderBy?.call(CommentLike.t),
      orderByList: orderByList?.call(CommentLike.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CommentLike] by its [id] or null if no such row exists.
  Future<CommentLike?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CommentLike>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CommentLike]s in the list and returns the inserted rows.
  ///
  /// The returned [CommentLike]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CommentLike>> insert(
    _i1.DatabaseSession session,
    List<CommentLike> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CommentLike>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CommentLike] and returns the inserted row.
  ///
  /// The returned [CommentLike] will have its `id` field set.
  Future<CommentLike> insertRow(
    _i1.DatabaseSession session,
    CommentLike row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CommentLike>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CommentLike]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CommentLike>> update(
    _i1.DatabaseSession session,
    List<CommentLike> rows, {
    _i1.ColumnSelections<CommentLikeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CommentLike>(
      rows,
      columns: columns?.call(CommentLike.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CommentLike]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CommentLike> updateRow(
    _i1.DatabaseSession session,
    CommentLike row, {
    _i1.ColumnSelections<CommentLikeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CommentLike>(
      row,
      columns: columns?.call(CommentLike.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CommentLike] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CommentLike?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CommentLikeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CommentLike>(
      id,
      columnValues: columnValues(CommentLike.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CommentLike]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CommentLike>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CommentLikeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CommentLikeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommentLikeTable>? orderBy,
    _i1.OrderByListBuilder<CommentLikeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CommentLike>(
      columnValues: columnValues(CommentLike.t.updateTable),
      where: where(CommentLike.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CommentLike.t),
      orderByList: orderByList?.call(CommentLike.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CommentLike]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CommentLike>> delete(
    _i1.DatabaseSession session,
    List<CommentLike> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CommentLike>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CommentLike].
  Future<CommentLike> deleteRow(
    _i1.DatabaseSession session,
    CommentLike row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CommentLike>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CommentLike>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CommentLikeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CommentLike>(
      where: where(CommentLike.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CommentLikeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CommentLike>(
      where: where?.call(CommentLike.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CommentLike] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CommentLikeTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CommentLike>(
      where: where(CommentLike.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
