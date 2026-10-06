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

abstract class AdminMember
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AdminMember._({
    this.id,
    required this.workspaceId,
    required this.userId,
    required this.email,
    required this.roleId,
    String? status,
    this.invitedByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : status = status ?? 'active',
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory AdminMember({
    int? id,
    required int workspaceId,
    required String userId,
    required String email,
    required int roleId,
    String? status,
    String? invitedByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AdminMemberImpl;

  factory AdminMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminMember(
      id: jsonSerialization['id'] as int?,
      workspaceId: jsonSerialization['workspaceId'] as int,
      userId: jsonSerialization['userId'] as String,
      email: jsonSerialization['email'] as String,
      roleId: jsonSerialization['roleId'] as int,
      status: jsonSerialization['status'] as String?,
      invitedByUserId: jsonSerialization['invitedByUserId'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = AdminMemberTable();

  static const db = AdminMemberRepository._();

  @override
  int? id;

  int workspaceId;

  String userId;

  String email;

  int roleId;

  String status;

  String? invitedByUserId;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AdminMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminMember copyWith({
    int? id,
    int? workspaceId,
    String? userId,
    String? email,
    int? roleId,
    String? status,
    String? invitedByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminMember',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'userId': userId,
      'email': email,
      'roleId': roleId,
      'status': status,
      if (invitedByUserId != null) 'invitedByUserId': invitedByUserId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminMember',
      if (id != null) 'id': id,
      'workspaceId': workspaceId,
      'userId': userId,
      'email': email,
      'roleId': roleId,
      'status': status,
      if (invitedByUserId != null) 'invitedByUserId': invitedByUserId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AdminMemberInclude include() {
    return AdminMemberInclude._();
  }

  static AdminMemberIncludeList includeList({
    _i1.WhereExpressionBuilder<AdminMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminMemberTable>? orderByList,
    AdminMemberInclude? include,
  }) {
    return AdminMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminMember.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AdminMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminMemberImpl extends AdminMember {
  _AdminMemberImpl({
    int? id,
    required int workspaceId,
    required String userId,
    required String email,
    required int roleId,
    String? status,
    String? invitedByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         workspaceId: workspaceId,
         userId: userId,
         email: email,
         roleId: roleId,
         status: status,
         invitedByUserId: invitedByUserId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AdminMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminMember copyWith({
    Object? id = _Undefined,
    int? workspaceId,
    String? userId,
    String? email,
    int? roleId,
    String? status,
    Object? invitedByUserId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AdminMember(
      id: id is int? ? id : this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      roleId: roleId ?? this.roleId,
      status: status ?? this.status,
      invitedByUserId: invitedByUserId is String?
          ? invitedByUserId
          : this.invitedByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AdminMemberUpdateTable extends _i1.UpdateTable<AdminMemberTable> {
  AdminMemberUpdateTable(super.table);

  _i1.ColumnValue<int, int> workspaceId(int value) => _i1.ColumnValue(
    table.workspaceId,
    value,
  );

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> email(String value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<int, int> roleId(int value) => _i1.ColumnValue(
    table.roleId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> invitedByUserId(String? value) =>
      _i1.ColumnValue(
        table.invitedByUserId,
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

class AdminMemberTable extends _i1.Table<int?> {
  AdminMemberTable({super.tableRelation}) : super(tableName: 'admin_member') {
    updateTable = AdminMemberUpdateTable(this);
    workspaceId = _i1.ColumnInt(
      'workspaceId',
      this,
    );
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    roleId = _i1.ColumnInt(
      'roleId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    invitedByUserId = _i1.ColumnString(
      'invitedByUserId',
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

  late final AdminMemberUpdateTable updateTable;

  late final _i1.ColumnInt workspaceId;

  late final _i1.ColumnString userId;

  late final _i1.ColumnString email;

  late final _i1.ColumnInt roleId;

  late final _i1.ColumnString status;

  late final _i1.ColumnString invitedByUserId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    workspaceId,
    userId,
    email,
    roleId,
    status,
    invitedByUserId,
    createdAt,
    updatedAt,
  ];
}

class AdminMemberInclude extends _i1.IncludeObject {
  AdminMemberInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AdminMember.t;
}

class AdminMemberIncludeList extends _i1.IncludeList {
  AdminMemberIncludeList._({
    _i1.WhereExpressionBuilder<AdminMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AdminMember.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AdminMember.t;
}

class AdminMemberRepository {
  const AdminMemberRepository._();

  /// Returns a list of [AdminMember]s matching the given query parameters.
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
  Future<List<AdminMember>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminMemberTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AdminMember>(
      where: where?.call(AdminMember.t),
      orderBy: orderBy?.call(AdminMember.t),
      orderByList: orderByList?.call(AdminMember.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AdminMember] matching the given query parameters.
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
  Future<AdminMember?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminMemberTable>? where,
    int? offset,
    _i1.OrderByBuilder<AdminMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminMemberTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AdminMember>(
      where: where?.call(AdminMember.t),
      orderBy: orderBy?.call(AdminMember.t),
      orderByList: orderByList?.call(AdminMember.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AdminMember] by its [id] or null if no such row exists.
  Future<AdminMember?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AdminMember>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AdminMember]s in the list and returns the inserted rows.
  ///
  /// The returned [AdminMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AdminMember>> insert(
    _i1.DatabaseSession session,
    List<AdminMember> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AdminMember>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AdminMember] and returns the inserted row.
  ///
  /// The returned [AdminMember] will have its `id` field set.
  Future<AdminMember> insertRow(
    _i1.DatabaseSession session,
    AdminMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AdminMember>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AdminMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AdminMember>> update(
    _i1.DatabaseSession session,
    List<AdminMember> rows, {
    _i1.ColumnSelections<AdminMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AdminMember>(
      rows,
      columns: columns?.call(AdminMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AdminMember> updateRow(
    _i1.DatabaseSession session,
    AdminMember row, {
    _i1.ColumnSelections<AdminMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AdminMember>(
      row,
      columns: columns?.call(AdminMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminMember] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AdminMember?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AdminMemberUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AdminMember>(
      id,
      columnValues: columnValues(AdminMember.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AdminMember]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AdminMember>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AdminMemberUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AdminMemberTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminMemberTable>? orderBy,
    _i1.OrderByListBuilder<AdminMemberTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AdminMember>(
      columnValues: columnValues(AdminMember.t.updateTable),
      where: where(AdminMember.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminMember.t),
      orderByList: orderByList?.call(AdminMember.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AdminMember]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AdminMember>> delete(
    _i1.DatabaseSession session,
    List<AdminMember> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AdminMember>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AdminMember].
  Future<AdminMember> deleteRow(
    _i1.DatabaseSession session,
    AdminMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AdminMember>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AdminMember>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AdminMemberTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AdminMember>(
      where: where(AdminMember.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminMemberTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AdminMember>(
      where: where?.call(AdminMember.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AdminMember] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AdminMemberTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AdminMember>(
      where: where(AdminMember.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
