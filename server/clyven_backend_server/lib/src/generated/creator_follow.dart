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

abstract class CreatorFollow
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CreatorFollow._({
    this.id,
    required this.followerId,
    required this.creatorId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory CreatorFollow({
    int? id,
    required String followerId,
    required String creatorId,
    DateTime? createdAt,
  }) = _CreatorFollowImpl;

  factory CreatorFollow.fromJson(Map<String, dynamic> jsonSerialization) {
    return CreatorFollow(
      id: jsonSerialization['id'] as int?,
      followerId: jsonSerialization['followerId'] as String,
      creatorId: jsonSerialization['creatorId'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = CreatorFollowTable();

  static const db = CreatorFollowRepository._();

  @override
  int? id;

  String followerId;

  String creatorId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CreatorFollow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreatorFollow copyWith({
    int? id,
    String? followerId,
    String? creatorId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreatorFollow',
      if (id != null) 'id': id,
      'followerId': followerId,
      'creatorId': creatorId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreatorFollow',
      if (id != null) 'id': id,
      'followerId': followerId,
      'creatorId': creatorId,
      'createdAt': createdAt.toJson(),
    };
  }

  static CreatorFollowInclude include() {
    return CreatorFollowInclude._();
  }

  static CreatorFollowIncludeList includeList({
    _i1.WhereExpressionBuilder<CreatorFollowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CreatorFollowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CreatorFollowTable>? orderByList,
    CreatorFollowInclude? include,
  }) {
    return CreatorFollowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CreatorFollow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CreatorFollow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreatorFollowImpl extends CreatorFollow {
  _CreatorFollowImpl({
    int? id,
    required String followerId,
    required String creatorId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         followerId: followerId,
         creatorId: creatorId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CreatorFollow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreatorFollow copyWith({
    Object? id = _Undefined,
    String? followerId,
    String? creatorId,
    DateTime? createdAt,
  }) {
    return CreatorFollow(
      id: id is int? ? id : this.id,
      followerId: followerId ?? this.followerId,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CreatorFollowUpdateTable extends _i1.UpdateTable<CreatorFollowTable> {
  CreatorFollowUpdateTable(super.table);

  _i1.ColumnValue<String, String> followerId(String value) => _i1.ColumnValue(
    table.followerId,
    value,
  );

  _i1.ColumnValue<String, String> creatorId(String value) => _i1.ColumnValue(
    table.creatorId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class CreatorFollowTable extends _i1.Table<int?> {
  CreatorFollowTable({super.tableRelation})
    : super(tableName: 'creator_follow') {
    updateTable = CreatorFollowUpdateTable(this);
    followerId = _i1.ColumnString(
      'followerId',
      this,
    );
    creatorId = _i1.ColumnString(
      'creatorId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final CreatorFollowUpdateTable updateTable;

  late final _i1.ColumnString followerId;

  late final _i1.ColumnString creatorId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    followerId,
    creatorId,
    createdAt,
  ];
}

class CreatorFollowInclude extends _i1.IncludeObject {
  CreatorFollowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CreatorFollow.t;
}

class CreatorFollowIncludeList extends _i1.IncludeList {
  CreatorFollowIncludeList._({
    _i1.WhereExpressionBuilder<CreatorFollowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CreatorFollow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CreatorFollow.t;
}

class CreatorFollowRepository {
  const CreatorFollowRepository._();

  /// Returns a list of [CreatorFollow]s matching the given query parameters.
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
  Future<List<CreatorFollow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CreatorFollowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CreatorFollowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CreatorFollowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CreatorFollow>(
      where: where?.call(CreatorFollow.t),
      orderBy: orderBy?.call(CreatorFollow.t),
      orderByList: orderByList?.call(CreatorFollow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CreatorFollow] matching the given query parameters.
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
  Future<CreatorFollow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CreatorFollowTable>? where,
    int? offset,
    _i1.OrderByBuilder<CreatorFollowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CreatorFollowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CreatorFollow>(
      where: where?.call(CreatorFollow.t),
      orderBy: orderBy?.call(CreatorFollow.t),
      orderByList: orderByList?.call(CreatorFollow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CreatorFollow] by its [id] or null if no such row exists.
  Future<CreatorFollow?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CreatorFollow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CreatorFollow]s in the list and returns the inserted rows.
  ///
  /// The returned [CreatorFollow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CreatorFollow>> insert(
    _i1.DatabaseSession session,
    List<CreatorFollow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CreatorFollow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CreatorFollow] and returns the inserted row.
  ///
  /// The returned [CreatorFollow] will have its `id` field set.
  Future<CreatorFollow> insertRow(
    _i1.DatabaseSession session,
    CreatorFollow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CreatorFollow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CreatorFollow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CreatorFollow>> update(
    _i1.DatabaseSession session,
    List<CreatorFollow> rows, {
    _i1.ColumnSelections<CreatorFollowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CreatorFollow>(
      rows,
      columns: columns?.call(CreatorFollow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CreatorFollow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CreatorFollow> updateRow(
    _i1.DatabaseSession session,
    CreatorFollow row, {
    _i1.ColumnSelections<CreatorFollowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CreatorFollow>(
      row,
      columns: columns?.call(CreatorFollow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CreatorFollow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CreatorFollow?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CreatorFollowUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CreatorFollow>(
      id,
      columnValues: columnValues(CreatorFollow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CreatorFollow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CreatorFollow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CreatorFollowUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CreatorFollowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CreatorFollowTable>? orderBy,
    _i1.OrderByListBuilder<CreatorFollowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CreatorFollow>(
      columnValues: columnValues(CreatorFollow.t.updateTable),
      where: where(CreatorFollow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CreatorFollow.t),
      orderByList: orderByList?.call(CreatorFollow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CreatorFollow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CreatorFollow>> delete(
    _i1.DatabaseSession session,
    List<CreatorFollow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CreatorFollow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CreatorFollow].
  Future<CreatorFollow> deleteRow(
    _i1.DatabaseSession session,
    CreatorFollow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CreatorFollow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CreatorFollow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CreatorFollowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CreatorFollow>(
      where: where(CreatorFollow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CreatorFollowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CreatorFollow>(
      where: where?.call(CreatorFollow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CreatorFollow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CreatorFollowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CreatorFollow>(
      where: where(CreatorFollow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
