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

abstract class AppProfile
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AppProfile._({
    this.id,
    required this.userId,
    String? bio,
    DateTime? updatedAt,
  }) : bio = bio ?? '',
       updatedAt = updatedAt ?? DateTime.now();

  factory AppProfile({
    int? id,
    required String userId,
    String? bio,
    DateTime? updatedAt,
  }) = _AppProfileImpl;

  factory AppProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppProfile(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      bio: jsonSerialization['bio'] as String?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = AppProfileTable();

  static const db = AppProfileRepository._();

  @override
  int? id;

  String userId;

  String bio;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AppProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppProfile copyWith({
    int? id,
    String? userId,
    String? bio,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppProfile',
      if (id != null) 'id': id,
      'userId': userId,
      'bio': bio,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppProfile',
      if (id != null) 'id': id,
      'userId': userId,
      'bio': bio,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AppProfileInclude include() {
    return AppProfileInclude._();
  }

  static AppProfileIncludeList includeList({
    _i1.WhereExpressionBuilder<AppProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppProfileTable>? orderByList,
    AppProfileInclude? include,
  }) {
    return AppProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppProfile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AppProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppProfileImpl extends AppProfile {
  _AppProfileImpl({
    int? id,
    required String userId,
    String? bio,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         bio: bio,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AppProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppProfile copyWith({
    Object? id = _Undefined,
    String? userId,
    String? bio,
    DateTime? updatedAt,
  }) {
    return AppProfile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      bio: bio ?? this.bio,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AppProfileUpdateTable extends _i1.UpdateTable<AppProfileTable> {
  AppProfileUpdateTable(super.table);

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> bio(String value) => _i1.ColumnValue(
    table.bio,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class AppProfileTable extends _i1.Table<int?> {
  AppProfileTable({super.tableRelation}) : super(tableName: 'app_profile') {
    updateTable = AppProfileUpdateTable(this);
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    bio = _i1.ColumnString(
      'bio',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final AppProfileUpdateTable updateTable;

  late final _i1.ColumnString userId;

  late final _i1.ColumnString bio;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    bio,
    updatedAt,
  ];
}

class AppProfileInclude extends _i1.IncludeObject {
  AppProfileInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AppProfile.t;
}

class AppProfileIncludeList extends _i1.IncludeList {
  AppProfileIncludeList._({
    _i1.WhereExpressionBuilder<AppProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AppProfile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AppProfile.t;
}

class AppProfileRepository {
  const AppProfileRepository._();

  /// Returns a list of [AppProfile]s matching the given query parameters.
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
  Future<List<AppProfile>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AppProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AppProfile>(
      where: where?.call(AppProfile.t),
      orderBy: orderBy?.call(AppProfile.t),
      orderByList: orderByList?.call(AppProfile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AppProfile] matching the given query parameters.
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
  Future<AppProfile?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AppProfileTable>? where,
    int? offset,
    _i1.OrderByBuilder<AppProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AppProfile>(
      where: where?.call(AppProfile.t),
      orderBy: orderBy?.call(AppProfile.t),
      orderByList: orderByList?.call(AppProfile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AppProfile] by its [id] or null if no such row exists.
  Future<AppProfile?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AppProfile>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AppProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [AppProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AppProfile>> insert(
    _i1.DatabaseSession session,
    List<AppProfile> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AppProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AppProfile] and returns the inserted row.
  ///
  /// The returned [AppProfile] will have its `id` field set.
  Future<AppProfile> insertRow(
    _i1.DatabaseSession session,
    AppProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AppProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AppProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AppProfile>> update(
    _i1.DatabaseSession session,
    List<AppProfile> rows, {
    _i1.ColumnSelections<AppProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AppProfile>(
      rows,
      columns: columns?.call(AppProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AppProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AppProfile> updateRow(
    _i1.DatabaseSession session,
    AppProfile row, {
    _i1.ColumnSelections<AppProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AppProfile>(
      row,
      columns: columns?.call(AppProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AppProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AppProfile?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AppProfileUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AppProfile>(
      id,
      columnValues: columnValues(AppProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AppProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AppProfile>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AppProfileUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AppProfileTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppProfileTable>? orderBy,
    _i1.OrderByListBuilder<AppProfileTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AppProfile>(
      columnValues: columnValues(AppProfile.t.updateTable),
      where: where(AppProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppProfile.t),
      orderByList: orderByList?.call(AppProfile.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AppProfile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AppProfile>> delete(
    _i1.DatabaseSession session,
    List<AppProfile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AppProfile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AppProfile].
  Future<AppProfile> deleteRow(
    _i1.DatabaseSession session,
    AppProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AppProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AppProfile>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AppProfileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AppProfile>(
      where: where(AppProfile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AppProfileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AppProfile>(
      where: where?.call(AppProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AppProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AppProfileTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AppProfile>(
      where: where(AppProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
