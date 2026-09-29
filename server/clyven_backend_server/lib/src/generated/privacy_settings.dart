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

abstract class PrivacySettings
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PrivacySettings._({
    this.id,
    required this.userId,
    bool? privateAccount,
    bool? allowComments,
    bool? showActivityStatus,
    DateTime? updatedAt,
  }) : privateAccount = privateAccount ?? false,
       allowComments = allowComments ?? true,
       showActivityStatus = showActivityStatus ?? true,
       updatedAt = updatedAt ?? DateTime.now();

  factory PrivacySettings({
    int? id,
    required String userId,
    bool? privateAccount,
    bool? allowComments,
    bool? showActivityStatus,
    DateTime? updatedAt,
  }) = _PrivacySettingsImpl;

  factory PrivacySettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return PrivacySettings(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      privateAccount: jsonSerialization['privateAccount'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['privateAccount']),
      allowComments: jsonSerialization['allowComments'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['allowComments']),
      showActivityStatus: jsonSerialization['showActivityStatus'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['showActivityStatus'],
            ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = PrivacySettingsTable();

  static const db = PrivacySettingsRepository._();

  @override
  int? id;

  String userId;

  bool privateAccount;

  bool allowComments;

  bool showActivityStatus;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PrivacySettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PrivacySettings copyWith({
    int? id,
    String? userId,
    bool? privateAccount,
    bool? allowComments,
    bool? showActivityStatus,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PrivacySettings',
      if (id != null) 'id': id,
      'userId': userId,
      'privateAccount': privateAccount,
      'allowComments': allowComments,
      'showActivityStatus': showActivityStatus,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PrivacySettings',
      if (id != null) 'id': id,
      'userId': userId,
      'privateAccount': privateAccount,
      'allowComments': allowComments,
      'showActivityStatus': showActivityStatus,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static PrivacySettingsInclude include() {
    return PrivacySettingsInclude._();
  }

  static PrivacySettingsIncludeList includeList({
    _i1.WhereExpressionBuilder<PrivacySettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PrivacySettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PrivacySettingsTable>? orderByList,
    PrivacySettingsInclude? include,
  }) {
    return PrivacySettingsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PrivacySettings.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PrivacySettings.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PrivacySettingsImpl extends PrivacySettings {
  _PrivacySettingsImpl({
    int? id,
    required String userId,
    bool? privateAccount,
    bool? allowComments,
    bool? showActivityStatus,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         privateAccount: privateAccount,
         allowComments: allowComments,
         showActivityStatus: showActivityStatus,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [PrivacySettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PrivacySettings copyWith({
    Object? id = _Undefined,
    String? userId,
    bool? privateAccount,
    bool? allowComments,
    bool? showActivityStatus,
    DateTime? updatedAt,
  }) {
    return PrivacySettings(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      privateAccount: privateAccount ?? this.privateAccount,
      allowComments: allowComments ?? this.allowComments,
      showActivityStatus: showActivityStatus ?? this.showActivityStatus,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class PrivacySettingsUpdateTable extends _i1.UpdateTable<PrivacySettingsTable> {
  PrivacySettingsUpdateTable(super.table);

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<bool, bool> privateAccount(bool value) => _i1.ColumnValue(
    table.privateAccount,
    value,
  );

  _i1.ColumnValue<bool, bool> allowComments(bool value) => _i1.ColumnValue(
    table.allowComments,
    value,
  );

  _i1.ColumnValue<bool, bool> showActivityStatus(bool value) => _i1.ColumnValue(
    table.showActivityStatus,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class PrivacySettingsTable extends _i1.Table<int?> {
  PrivacySettingsTable({super.tableRelation})
    : super(tableName: 'privacy_settings') {
    updateTable = PrivacySettingsUpdateTable(this);
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    privateAccount = _i1.ColumnBool(
      'privateAccount',
      this,
      hasDefault: true,
    );
    allowComments = _i1.ColumnBool(
      'allowComments',
      this,
      hasDefault: true,
    );
    showActivityStatus = _i1.ColumnBool(
      'showActivityStatus',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final PrivacySettingsUpdateTable updateTable;

  late final _i1.ColumnString userId;

  late final _i1.ColumnBool privateAccount;

  late final _i1.ColumnBool allowComments;

  late final _i1.ColumnBool showActivityStatus;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    privateAccount,
    allowComments,
    showActivityStatus,
    updatedAt,
  ];
}

class PrivacySettingsInclude extends _i1.IncludeObject {
  PrivacySettingsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => PrivacySettings.t;
}

class PrivacySettingsIncludeList extends _i1.IncludeList {
  PrivacySettingsIncludeList._({
    _i1.WhereExpressionBuilder<PrivacySettingsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PrivacySettings.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PrivacySettings.t;
}

class PrivacySettingsRepository {
  const PrivacySettingsRepository._();

  /// Returns a list of [PrivacySettings]s matching the given query parameters.
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
  Future<List<PrivacySettings>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PrivacySettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PrivacySettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PrivacySettingsTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PrivacySettings>(
      where: where?.call(PrivacySettings.t),
      orderBy: orderBy?.call(PrivacySettings.t),
      orderByList: orderByList?.call(PrivacySettings.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PrivacySettings] matching the given query parameters.
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
  Future<PrivacySettings?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PrivacySettingsTable>? where,
    int? offset,
    _i1.OrderByBuilder<PrivacySettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PrivacySettingsTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PrivacySettings>(
      where: where?.call(PrivacySettings.t),
      orderBy: orderBy?.call(PrivacySettings.t),
      orderByList: orderByList?.call(PrivacySettings.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PrivacySettings] by its [id] or null if no such row exists.
  Future<PrivacySettings?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PrivacySettings>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PrivacySettings]s in the list and returns the inserted rows.
  ///
  /// The returned [PrivacySettings]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PrivacySettings>> insert(
    _i1.DatabaseSession session,
    List<PrivacySettings> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PrivacySettings>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PrivacySettings] and returns the inserted row.
  ///
  /// The returned [PrivacySettings] will have its `id` field set.
  Future<PrivacySettings> insertRow(
    _i1.DatabaseSession session,
    PrivacySettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PrivacySettings>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PrivacySettings]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PrivacySettings>> update(
    _i1.DatabaseSession session,
    List<PrivacySettings> rows, {
    _i1.ColumnSelections<PrivacySettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PrivacySettings>(
      rows,
      columns: columns?.call(PrivacySettings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PrivacySettings]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PrivacySettings> updateRow(
    _i1.DatabaseSession session,
    PrivacySettings row, {
    _i1.ColumnSelections<PrivacySettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PrivacySettings>(
      row,
      columns: columns?.call(PrivacySettings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PrivacySettings] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PrivacySettings?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<PrivacySettingsUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PrivacySettings>(
      id,
      columnValues: columnValues(PrivacySettings.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PrivacySettings]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PrivacySettings>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PrivacySettingsUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<PrivacySettingsTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PrivacySettingsTable>? orderBy,
    _i1.OrderByListBuilder<PrivacySettingsTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PrivacySettings>(
      columnValues: columnValues(PrivacySettings.t.updateTable),
      where: where(PrivacySettings.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PrivacySettings.t),
      orderByList: orderByList?.call(PrivacySettings.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PrivacySettings]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PrivacySettings>> delete(
    _i1.DatabaseSession session,
    List<PrivacySettings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PrivacySettings>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PrivacySettings].
  Future<PrivacySettings> deleteRow(
    _i1.DatabaseSession session,
    PrivacySettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PrivacySettings>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PrivacySettings>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PrivacySettingsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PrivacySettings>(
      where: where(PrivacySettings.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PrivacySettingsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PrivacySettings>(
      where: where?.call(PrivacySettings.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PrivacySettings] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PrivacySettingsTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PrivacySettings>(
      where: where(PrivacySettings.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
