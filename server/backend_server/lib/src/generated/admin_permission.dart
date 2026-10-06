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

abstract class AdminPermission
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AdminPermission._({
    this.id,
    required this.code,
    required this.name,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AdminPermission({
    int? id,
    required String code,
    required String name,
    DateTime? createdAt,
  }) = _AdminPermissionImpl;

  factory AdminPermission.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminPermission(
      id: jsonSerialization['id'] as int?,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = AdminPermissionTable();

  static const db = AdminPermissionRepository._();

  @override
  int? id;

  String code;

  String name;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AdminPermission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminPermission copyWith({
    int? id,
    String? code,
    String? name,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminPermission',
      if (id != null) 'id': id,
      'code': code,
      'name': name,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminPermission',
      if (id != null) 'id': id,
      'code': code,
      'name': name,
      'createdAt': createdAt.toJson(),
    };
  }

  static AdminPermissionInclude include() {
    return AdminPermissionInclude._();
  }

  static AdminPermissionIncludeList includeList({
    _i1.WhereExpressionBuilder<AdminPermissionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminPermissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminPermissionTable>? orderByList,
    AdminPermissionInclude? include,
  }) {
    return AdminPermissionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminPermission.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AdminPermission.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminPermissionImpl extends AdminPermission {
  _AdminPermissionImpl({
    int? id,
    required String code,
    required String name,
    DateTime? createdAt,
  }) : super._(
         id: id,
         code: code,
         name: name,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AdminPermission]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminPermission copyWith({
    Object? id = _Undefined,
    String? code,
    String? name,
    DateTime? createdAt,
  }) {
    return AdminPermission(
      id: id is int? ? id : this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AdminPermissionUpdateTable extends _i1.UpdateTable<AdminPermissionTable> {
  AdminPermissionUpdateTable(super.table);

  _i1.ColumnValue<String, String> code(String value) => _i1.ColumnValue(
    table.code,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class AdminPermissionTable extends _i1.Table<int?> {
  AdminPermissionTable({super.tableRelation})
    : super(tableName: 'admin_permission') {
    updateTable = AdminPermissionUpdateTable(this);
    code = _i1.ColumnString(
      'code',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final AdminPermissionUpdateTable updateTable;

  late final _i1.ColumnString code;

  late final _i1.ColumnString name;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    code,
    name,
    createdAt,
  ];
}

class AdminPermissionInclude extends _i1.IncludeObject {
  AdminPermissionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AdminPermission.t;
}

class AdminPermissionIncludeList extends _i1.IncludeList {
  AdminPermissionIncludeList._({
    _i1.WhereExpressionBuilder<AdminPermissionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AdminPermission.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AdminPermission.t;
}

class AdminPermissionRepository {
  const AdminPermissionRepository._();

  /// Returns a list of [AdminPermission]s matching the given query parameters.
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
  Future<List<AdminPermission>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminPermissionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminPermissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminPermissionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AdminPermission>(
      where: where?.call(AdminPermission.t),
      orderBy: orderBy?.call(AdminPermission.t),
      orderByList: orderByList?.call(AdminPermission.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AdminPermission] matching the given query parameters.
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
  Future<AdminPermission?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminPermissionTable>? where,
    int? offset,
    _i1.OrderByBuilder<AdminPermissionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminPermissionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AdminPermission>(
      where: where?.call(AdminPermission.t),
      orderBy: orderBy?.call(AdminPermission.t),
      orderByList: orderByList?.call(AdminPermission.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AdminPermission] by its [id] or null if no such row exists.
  Future<AdminPermission?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AdminPermission>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AdminPermission]s in the list and returns the inserted rows.
  ///
  /// The returned [AdminPermission]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AdminPermission>> insert(
    _i1.DatabaseSession session,
    List<AdminPermission> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AdminPermission>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AdminPermission] and returns the inserted row.
  ///
  /// The returned [AdminPermission] will have its `id` field set.
  Future<AdminPermission> insertRow(
    _i1.DatabaseSession session,
    AdminPermission row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AdminPermission>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AdminPermission]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AdminPermission>> update(
    _i1.DatabaseSession session,
    List<AdminPermission> rows, {
    _i1.ColumnSelections<AdminPermissionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AdminPermission>(
      rows,
      columns: columns?.call(AdminPermission.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminPermission]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AdminPermission> updateRow(
    _i1.DatabaseSession session,
    AdminPermission row, {
    _i1.ColumnSelections<AdminPermissionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AdminPermission>(
      row,
      columns: columns?.call(AdminPermission.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminPermission] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AdminPermission?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AdminPermissionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AdminPermission>(
      id,
      columnValues: columnValues(AdminPermission.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AdminPermission]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AdminPermission>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AdminPermissionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<AdminPermissionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminPermissionTable>? orderBy,
    _i1.OrderByListBuilder<AdminPermissionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AdminPermission>(
      columnValues: columnValues(AdminPermission.t.updateTable),
      where: where(AdminPermission.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminPermission.t),
      orderByList: orderByList?.call(AdminPermission.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AdminPermission]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AdminPermission>> delete(
    _i1.DatabaseSession session,
    List<AdminPermission> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AdminPermission>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AdminPermission].
  Future<AdminPermission> deleteRow(
    _i1.DatabaseSession session,
    AdminPermission row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AdminPermission>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AdminPermission>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AdminPermissionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AdminPermission>(
      where: where(AdminPermission.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminPermissionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AdminPermission>(
      where: where?.call(AdminPermission.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AdminPermission] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AdminPermissionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AdminPermission>(
      where: where(AdminPermission.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
