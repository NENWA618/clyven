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

abstract class UserKnownEntry
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserKnownEntry._({
    this.id,
    required this.userId,
    required this.entryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory UserKnownEntry({
    int? id,
    required String userId,
    required int entryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserKnownEntryImpl;

  factory UserKnownEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserKnownEntry(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      entryId: jsonSerialization['entryId'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = UserKnownEntryTable();

  static const db = UserKnownEntryRepository._();

  @override
  int? id;

  String userId;

  int entryId;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserKnownEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserKnownEntry copyWith({
    int? id,
    String? userId,
    int? entryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserKnownEntry',
      if (id != null) 'id': id,
      'userId': userId,
      'entryId': entryId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserKnownEntry',
      if (id != null) 'id': id,
      'userId': userId,
      'entryId': entryId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static UserKnownEntryInclude include() {
    return UserKnownEntryInclude._();
  }

  static UserKnownEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<UserKnownEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserKnownEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserKnownEntryTable>? orderByList,
    UserKnownEntryInclude? include,
  }) {
    return UserKnownEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserKnownEntry.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserKnownEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserKnownEntryImpl extends UserKnownEntry {
  _UserKnownEntryImpl({
    int? id,
    required String userId,
    required int entryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         entryId: entryId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [UserKnownEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserKnownEntry copyWith({
    Object? id = _Undefined,
    String? userId,
    int? entryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserKnownEntry(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      entryId: entryId ?? this.entryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class UserKnownEntryUpdateTable extends _i1.UpdateTable<UserKnownEntryTable> {
  UserKnownEntryUpdateTable(super.table);

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> entryId(int value) => _i1.ColumnValue(
    table.entryId,
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

class UserKnownEntryTable extends _i1.Table<int?> {
  UserKnownEntryTable({super.tableRelation})
    : super(tableName: 'user_known_entry') {
    updateTable = UserKnownEntryUpdateTable(this);
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    entryId = _i1.ColumnInt(
      'entryId',
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

  late final UserKnownEntryUpdateTable updateTable;

  late final _i1.ColumnString userId;

  late final _i1.ColumnInt entryId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    entryId,
    createdAt,
    updatedAt,
  ];
}

class UserKnownEntryInclude extends _i1.IncludeObject {
  UserKnownEntryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserKnownEntry.t;
}

class UserKnownEntryIncludeList extends _i1.IncludeList {
  UserKnownEntryIncludeList._({
    _i1.WhereExpressionBuilder<UserKnownEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserKnownEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserKnownEntry.t;
}

class UserKnownEntryRepository {
  const UserKnownEntryRepository._();

  /// Returns a list of [UserKnownEntry]s matching the given query parameters.
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
  Future<List<UserKnownEntry>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserKnownEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserKnownEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserKnownEntryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserKnownEntry>(
      where: where?.call(UserKnownEntry.t),
      orderBy: orderBy?.call(UserKnownEntry.t),
      orderByList: orderByList?.call(UserKnownEntry.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserKnownEntry] matching the given query parameters.
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
  Future<UserKnownEntry?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserKnownEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserKnownEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserKnownEntryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserKnownEntry>(
      where: where?.call(UserKnownEntry.t),
      orderBy: orderBy?.call(UserKnownEntry.t),
      orderByList: orderByList?.call(UserKnownEntry.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserKnownEntry] by its [id] or null if no such row exists.
  Future<UserKnownEntry?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserKnownEntry>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserKnownEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [UserKnownEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<UserKnownEntry>> insert(
    _i1.DatabaseSession session,
    List<UserKnownEntry> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<UserKnownEntry>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [UserKnownEntry] and returns the inserted row.
  ///
  /// The returned [UserKnownEntry] will have its `id` field set.
  Future<UserKnownEntry> insertRow(
    _i1.DatabaseSession session,
    UserKnownEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserKnownEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserKnownEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserKnownEntry>> update(
    _i1.DatabaseSession session,
    List<UserKnownEntry> rows, {
    _i1.ColumnSelections<UserKnownEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserKnownEntry>(
      rows,
      columns: columns?.call(UserKnownEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserKnownEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserKnownEntry> updateRow(
    _i1.DatabaseSession session,
    UserKnownEntry row, {
    _i1.ColumnSelections<UserKnownEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserKnownEntry>(
      row,
      columns: columns?.call(UserKnownEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserKnownEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserKnownEntry?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<UserKnownEntryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserKnownEntry>(
      id,
      columnValues: columnValues(UserKnownEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserKnownEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserKnownEntry>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<UserKnownEntryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserKnownEntryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserKnownEntryTable>? orderBy,
    _i1.OrderByListBuilder<UserKnownEntryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserKnownEntry>(
      columnValues: columnValues(UserKnownEntry.t.updateTable),
      where: where(UserKnownEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserKnownEntry.t),
      orderByList: orderByList?.call(UserKnownEntry.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserKnownEntry]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserKnownEntry>> delete(
    _i1.DatabaseSession session,
    List<UserKnownEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserKnownEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserKnownEntry].
  Future<UserKnownEntry> deleteRow(
    _i1.DatabaseSession session,
    UserKnownEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserKnownEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserKnownEntry>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserKnownEntryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserKnownEntry>(
      where: where(UserKnownEntry.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserKnownEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserKnownEntry>(
      where: where?.call(UserKnownEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserKnownEntry] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserKnownEntryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserKnownEntry>(
      where: where(UserKnownEntry.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
