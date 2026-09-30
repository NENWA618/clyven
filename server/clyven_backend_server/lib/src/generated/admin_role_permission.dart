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

abstract class AdminRolePermission
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AdminRolePermission._({
    this.id,
    required this.roleId,
    required this.permissionCode,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AdminRolePermission({
    int? id,
    required int roleId,
    required String permissionCode,
    DateTime? createdAt,
  }) = _AdminRolePermissionImpl;

  factory AdminRolePermission.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminRolePermission(
      id: jsonSerialization['id'] as int?,
      roleId: jsonSerialization['roleId'] as int,
      permissionCode: jsonSerialization['permissionCode'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = AdminRolePermissionTable();

  static const db = AdminRolePermissionRepository._();

  @override
  int? id;

  int roleId;

  String permissionCode;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AdminRolePermission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminRolePermission copyWith({
    int? id,
    int? roleId,
    String? permissionCode,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminRolePermission',
      if (id != null) 'id': id,
      'roleId': roleId,
      'permissionCode': permissionCode,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminRolePermission',
      if (id != null) 'id': id,
      'roleId': roleId,
      'permissionCode': permissionCode,
      'createdAt': createdAt.toJson(),
    };
  }

  static AdminRolePermissionInclude include() {
    return AdminRolePermissionInclude._();
  }

  static AdminRolePermissionIncludeList includeList({
    _i1.WhereExpressionBuilder<AdminRolePermissionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminRolePermissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminRolePermissionTable>? orderByList,
    AdminRolePermissionInclude? include,
  }) {
    return AdminRolePermissionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminRolePermission.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AdminRolePermission.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminRolePermissionImpl extends AdminRolePermission {
  _AdminRolePermissionImpl({
    int? id,
    required int roleId,
    required String permissionCode,
    DateTime? createdAt,
  }) : super._(
         id: id,
         roleId: roleId,
         permissionCode: permissionCode,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AdminRolePermission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminRolePermission copyWith({
    Object? id = _Undefined,
    int? roleId,
    String? permissionCode,
    DateTime? createdAt,
  }) {
    return AdminRolePermission(
      id: id is int? ? id : this.id,
      roleId: roleId ?? this.roleId,
      permissionCode: permissionCode ?? this.permissionCode,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AdminRolePermissionUpdateTable
    extends _i1.UpdateTable<AdminRolePermissionTable> {
  AdminRolePermissionUpdateTable(super.table);

  _i1.ColumnValue<int, int> roleId(int value) => _i1.ColumnValue(
    table.roleId,
    value,
  );

  _i1.ColumnValue<String, String> permissionCode(String value) =>
      _i1.ColumnValue(
        table.permissionCode,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class AdminRolePermissionTable extends _i1.Table<int?> {
  AdminRolePermissionTable({super.tableRelation})
    : super(tableName: 'admin_role_permission') {
    updateTable = AdminRolePermissionUpdateTable(this);
    roleId = _i1.ColumnInt(
      'roleId',
      this,
    );
    permissionCode = _i1.ColumnString(
      'permissionCode',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final AdminRolePermissionUpdateTable updateTable;

  late final _i1.ColumnInt roleId;

  late final _i1.ColumnString permissionCode;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    roleId,
    permissionCode,
    createdAt,
  ];
}

class AdminRolePermissionInclude extends _i1.IncludeObject {
  AdminRolePermissionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AdminRolePermission.t;
}

class AdminRolePermissionIncludeList extends _i1.IncludeList {
  AdminRolePermissionIncludeList._({
    _i1.WhereExpressionBuilder<AdminRolePermissionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AdminRolePermission.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AdminRolePermission.t;
}

class AdminRolePermissionRepository {
  const AdminRolePermissionRepository._();

  /// Returns a list of [AdminRolePermission]s matching the given query parameters.
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
  Future<List<AdminRolePermission>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminRolePermissionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminRolePermissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminRolePermissionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AdminRolePermission>(
      where: where?.call(AdminRolePermission.t),
      orderBy: orderBy?.call(AdminRolePermission.t),
      orderByList: orderByList?.call(AdminRolePermission.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AdminRolePermission] matching the given query parameters.
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
  Future<AdminRolePermission?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminRolePermissionTable>? where,
    int? offset,
    _i1.OrderByBuilder<AdminRolePermissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminRolePermissionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AdminRolePermission>(
      where: where?.call(AdminRolePermission.t),
      orderBy: orderBy?.call(AdminRolePermission.t),
      orderByList: orderByList?.call(AdminRolePermission.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AdminRolePermission] by its [id] or null if no such row exists.
  Future<AdminRolePermission?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AdminRolePermission>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AdminRolePermission]s in the list and returns the inserted rows.
  ///
  /// The returned [AdminRolePermission]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AdminRolePermission>> insert(
    _i1.DatabaseSession session,
    List<AdminRolePermission> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AdminRolePermission>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AdminRolePermission] and returns the inserted row.
  ///
  /// The returned [AdminRolePermission] will have its `id` field set.
  Future<AdminRolePermission> insertRow(
    _i1.DatabaseSession session,
    AdminRolePermission row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AdminRolePermission>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AdminRolePermission]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AdminRolePermission>> update(
    _i1.DatabaseSession session,
    List<AdminRolePermission> rows, {
    _i1.ColumnSelections<AdminRolePermissionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AdminRolePermission>(
      rows,
      columns: columns?.call(AdminRolePermission.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminRolePermission]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AdminRolePermission> updateRow(
    _i1.DatabaseSession session,
    AdminRolePermission row, {
    _i1.ColumnSelections<AdminRolePermissionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AdminRolePermission>(
      row,
      columns: columns?.call(AdminRolePermission.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminRolePermission] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AdminRolePermission?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AdminRolePermissionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AdminRolePermission>(
      id,
      columnValues: columnValues(AdminRolePermission.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AdminRolePermission]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AdminRolePermission>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AdminRolePermissionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<AdminRolePermissionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminRolePermissionTable>? orderBy,
    _i1.OrderByListBuilder<AdminRolePermissionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AdminRolePermission>(
      columnValues: columnValues(AdminRolePermission.t.updateTable),
      where: where(AdminRolePermission.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminRolePermission.t),
      orderByList: orderByList?.call(AdminRolePermission.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AdminRolePermission]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AdminRolePermission>> delete(
    _i1.DatabaseSession session,
    List<AdminRolePermission> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AdminRolePermission>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AdminRolePermission].
  Future<AdminRolePermission> deleteRow(
    _i1.DatabaseSession session,
    AdminRolePermission row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AdminRolePermission>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AdminRolePermission>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AdminRolePermissionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AdminRolePermission>(
      where: where(AdminRolePermission.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminRolePermissionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AdminRolePermission>(
      where: where?.call(AdminRolePermission.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AdminRolePermission] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AdminRolePermissionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AdminRolePermission>(
      where: where(AdminRolePermission.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
