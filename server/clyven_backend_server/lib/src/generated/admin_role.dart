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

abstract class AdminRole
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AdminRole._({
    this.id,
    required this.workspaceId,
    required this.key,
    required this.name,
    bool? isSystem,
    DateTime? createdAt,
  }) : isSystem = isSystem ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory AdminRole({
    int? id,
    required int workspaceId,
    required String key,
    required String name,
    bool? isSystem,
    DateTime? createdAt,
  }) = _AdminRoleImpl;

  factory AdminRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminRole(
      id: jsonSerialization['id'] as int?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      key: jsonSerialization['key'] as String,
      name: jsonSerialization['name'] as String,
      isSystem: jsonSerialization['isSystem'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isSystem']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = AdminRoleTable();

  static const db = AdminRoleRepository._();

  @override
  int? id;

  int workspaceId;

  String key;

  String name;

  bool isSystem;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AdminRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminRole copyWith({
    int? id,
    int? workspaceId,
    String? key,
    String? name,
    bool? isSystem,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminRole',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'key': key,
      'name': name,
      'isSystem': isSystem,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminRole',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'key': key,
      'name': name,
      'isSystem': isSystem,
      'createdAt': createdAt.toJson(),
    };
  }

  static AdminRoleInclude include() {
    return AdminRoleInclude._();
  }

  static AdminRoleIncludeList includeList({
    _i1.WhereExpressionBuilder<AdminRoleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminRoleTable>? orderByList,
    AdminRoleInclude? include,
  }) {
    return AdminRoleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminRole.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AdminRole.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminRoleImpl extends AdminRole {
  _AdminRoleImpl({
    int? id,
    required int workspaceId,
    required String key,
    required String name,
    bool? isSystem,
    DateTime? createdAt,
  }) : super._(
         id: id,
         workspaceId: workspaceId,
         key: key,
         name: name,
         isSystem: isSystem,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AdminRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminRole copyWith({
    Object? id = _Undefined,
    int? workspaceId,
    String? key,
    String? name,
    bool? isSystem,
    DateTime? createdAt,
  }) {
    return AdminRole(
      id: id is int? ? id : this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      key: key ?? this.key,
      name: name ?? this.name,
      isSystem: isSystem ?? this.isSystem,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AdminRoleUpdateTable extends _i1.UpdateTable<AdminRoleTable> {
  AdminRoleUpdateTable(super.table);

  _i1.ColumnValue<int, int> workspaceId(int value) => _i1.ColumnValue(
    table.workspaceId,
    value,
  );

  _i1.ColumnValue<String, String> key(String value) => _i1.ColumnValue(
    table.key,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<bool, bool> isSystem(bool value) => _i1.ColumnValue(
    table.isSystem,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class AdminRoleTable extends _i1.Table<int?> {
  AdminRoleTable({super.tableRelation}) : super(tableName: 'admin_role') {
    updateTable = AdminRoleUpdateTable(this);
    workspaceId = _i1.ColumnInt(
      'workspaceId',
      this,
    );
    key = _i1.ColumnString(
      'key',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    isSystem = _i1.ColumnBool(
      'isSystem',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final AdminRoleUpdateTable updateTable;

  late final _i1.ColumnInt workspaceId;

  late final _i1.ColumnString key;

  late final _i1.ColumnString name;

  late final _i1.ColumnBool isSystem;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    workspaceId,
    key,
    name,
    isSystem,
    createdAt,
  ];
}

class AdminRoleInclude extends _i1.IncludeObject {
  AdminRoleInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AdminRole.t;
}

class AdminRoleIncludeList extends _i1.IncludeList {
  AdminRoleIncludeList._({
    _i1.WhereExpressionBuilder<AdminRoleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AdminRole.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AdminRole.t;
}

class AdminRoleRepository {
  const AdminRoleRepository._();

  /// Returns a list of [AdminRole]s matching the given query parameters.
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
  Future<List<AdminRole>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminRoleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminRoleTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AdminRole>(
      where: where?.call(AdminRole.t),
      orderBy: orderBy?.call(AdminRole.t),
      orderByList: orderByList?.call(AdminRole.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AdminRole] matching the given query parameters.
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
  Future<AdminRole?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminRoleTable>? where,
    int? offset,
    _i1.OrderByBuilder<AdminRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminRoleTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AdminRole>(
      where: where?.call(AdminRole.t),
      orderBy: orderBy?.call(AdminRole.t),
      orderByList: orderByList?.call(AdminRole.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AdminRole] by its [id] or null if no such row exists.
  Future<AdminRole?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AdminRole>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AdminRole]s in the list and returns the inserted rows.
  ///
  /// The returned [AdminRole]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AdminRole>> insert(
    _i1.DatabaseSession session,
    List<AdminRole> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AdminRole>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AdminRole] and returns the inserted row.
  ///
  /// The returned [AdminRole] will have its `id` field set.
  Future<AdminRole> insertRow(
    _i1.DatabaseSession session,
    AdminRole row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AdminRole>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AdminRole]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AdminRole>> update(
    _i1.DatabaseSession session,
    List<AdminRole> rows, {
    _i1.ColumnSelections<AdminRoleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AdminRole>(
      rows,
      columns: columns?.call(AdminRole.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminRole]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AdminRole> updateRow(
    _i1.DatabaseSession session,
    AdminRole row, {
    _i1.ColumnSelections<AdminRoleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AdminRole>(
      row,
      columns: columns?.call(AdminRole.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminRole] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AdminRole?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AdminRoleUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AdminRole>(
      id,
      columnValues: columnValues(AdminRole.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AdminRole]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AdminRole>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AdminRoleUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AdminRoleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminRoleTable>? orderBy,
    _i1.OrderByListBuilder<AdminRoleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AdminRole>(
      columnValues: columnValues(AdminRole.t.updateTable),
      where: where(AdminRole.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminRole.t),
      orderByList: orderByList?.call(AdminRole.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AdminRole]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AdminRole>> delete(
    _i1.DatabaseSession session,
    List<AdminRole> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AdminRole>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AdminRole].
  Future<AdminRole> deleteRow(
    _i1.DatabaseSession session,
    AdminRole row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AdminRole>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AdminRole>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AdminRoleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AdminRole>(
      where: where(AdminRole.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminRoleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AdminRole>(
      where: where?.call(AdminRole.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AdminRole] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AdminRoleTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AdminRole>(
      where: where(AdminRole.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
