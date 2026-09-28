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

abstract class DictionaryImportProfile
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DictionaryImportProfile._({
    this.id,
    required this.name,
    required this.languageCode,
    required this.sheetName,
    this.defaultEntryType,
    this.primaryScriptCode,
    this.description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DictionaryImportProfile({
    int? id,
    required String name,
    required String languageCode,
    required String sheetName,
    String? defaultEntryType,
    String? primaryScriptCode,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DictionaryImportProfileImpl;

  factory DictionaryImportProfile.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DictionaryImportProfile(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      languageCode: jsonSerialization['languageCode'] as String,
      sheetName: jsonSerialization['sheetName'] as String,
      defaultEntryType: jsonSerialization['defaultEntryType'] as String?,
      primaryScriptCode: jsonSerialization['primaryScriptCode'] as String?,
      description: jsonSerialization['description'] as String?,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = DictionaryImportProfileTable();

  static const db = DictionaryImportProfileRepository._();

  @override
  int? id;

  String name;

  String languageCode;

  String sheetName;

  String? defaultEntryType;

  String? primaryScriptCode;

  String? description;

  bool isActive;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DictionaryImportProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryImportProfile copyWith({
    int? id,
    String? name,
    String? languageCode,
    String? sheetName,
    String? defaultEntryType,
    String? primaryScriptCode,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryImportProfile',
      if (id != null) 'id': id,
      'name': name,
      'languageCode': languageCode,
      'sheetName': sheetName,
      if (defaultEntryType != null) 'defaultEntryType': defaultEntryType,
      if (primaryScriptCode != null) 'primaryScriptCode': primaryScriptCode,
      if (description != null) 'description': description,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DictionaryImportProfile',
      if (id != null) 'id': id,
      'name': name,
      'languageCode': languageCode,
      'sheetName': sheetName,
      if (defaultEntryType != null) 'defaultEntryType': defaultEntryType,
      if (primaryScriptCode != null) 'primaryScriptCode': primaryScriptCode,
      if (description != null) 'description': description,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DictionaryImportProfileInclude include() {
    return DictionaryImportProfileInclude._();
  }

  static DictionaryImportProfileIncludeList includeList({
    _i1.WhereExpressionBuilder<DictionaryImportProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryImportProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryImportProfileTable>? orderByList,
    DictionaryImportProfileInclude? include,
  }) {
    return DictionaryImportProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryImportProfile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DictionaryImportProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DictionaryImportProfileImpl extends DictionaryImportProfile {
  _DictionaryImportProfileImpl({
    int? id,
    required String name,
    required String languageCode,
    required String sheetName,
    String? defaultEntryType,
    String? primaryScriptCode,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         languageCode: languageCode,
         sheetName: sheetName,
         defaultEntryType: defaultEntryType,
         primaryScriptCode: primaryScriptCode,
         description: description,
         isActive: isActive,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DictionaryImportProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryImportProfile copyWith({
    Object? id = _Undefined,
    String? name,
    String? languageCode,
    String? sheetName,
    Object? defaultEntryType = _Undefined,
    Object? primaryScriptCode = _Undefined,
    Object? description = _Undefined,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DictionaryImportProfile(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      languageCode: languageCode ?? this.languageCode,
      sheetName: sheetName ?? this.sheetName,
      defaultEntryType: defaultEntryType is String?
          ? defaultEntryType
          : this.defaultEntryType,
      primaryScriptCode: primaryScriptCode is String?
          ? primaryScriptCode
          : this.primaryScriptCode,
      description: description is String? ? description : this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DictionaryImportProfileUpdateTable
    extends _i1.UpdateTable<DictionaryImportProfileTable> {
  DictionaryImportProfileUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> languageCode(String value) => _i1.ColumnValue(
    table.languageCode,
    value,
  );

  _i1.ColumnValue<String, String> sheetName(String value) => _i1.ColumnValue(
    table.sheetName,
    value,
  );

  _i1.ColumnValue<String, String> defaultEntryType(String? value) =>
      _i1.ColumnValue(
        table.defaultEntryType,
        value,
      );

  _i1.ColumnValue<String, String> primaryScriptCode(String? value) =>
      _i1.ColumnValue(
        table.primaryScriptCode,
        value,
      );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
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

class DictionaryImportProfileTable extends _i1.Table<int?> {
  DictionaryImportProfileTable({super.tableRelation})
    : super(tableName: 'dictionary_import_profile') {
    updateTable = DictionaryImportProfileUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    languageCode = _i1.ColumnString(
      'languageCode',
      this,
    );
    sheetName = _i1.ColumnString(
      'sheetName',
      this,
    );
    defaultEntryType = _i1.ColumnString(
      'defaultEntryType',
      this,
    );
    primaryScriptCode = _i1.ColumnString(
      'primaryScriptCode',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
      hasDefault: true,
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

  late final DictionaryImportProfileUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString languageCode;

  late final _i1.ColumnString sheetName;

  late final _i1.ColumnString defaultEntryType;

  late final _i1.ColumnString primaryScriptCode;

  late final _i1.ColumnString description;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    languageCode,
    sheetName,
    defaultEntryType,
    primaryScriptCode,
    description,
    isActive,
    createdAt,
    updatedAt,
  ];
}

class DictionaryImportProfileInclude extends _i1.IncludeObject {
  DictionaryImportProfileInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DictionaryImportProfile.t;
}

class DictionaryImportProfileIncludeList extends _i1.IncludeList {
  DictionaryImportProfileIncludeList._({
    _i1.WhereExpressionBuilder<DictionaryImportProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DictionaryImportProfile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DictionaryImportProfile.t;
}

class DictionaryImportProfileRepository {
  const DictionaryImportProfileRepository._();

  /// Returns a list of [DictionaryImportProfile]s matching the given query parameters.
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
  Future<List<DictionaryImportProfile>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryImportProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryImportProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryImportProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DictionaryImportProfile>(
      where: where?.call(DictionaryImportProfile.t),
      orderBy: orderBy?.call(DictionaryImportProfile.t),
      orderByList: orderByList?.call(DictionaryImportProfile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DictionaryImportProfile] matching the given query parameters.
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
  Future<DictionaryImportProfile?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryImportProfileTable>? where,
    int? offset,
    _i1.OrderByBuilder<DictionaryImportProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryImportProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DictionaryImportProfile>(
      where: where?.call(DictionaryImportProfile.t),
      orderBy: orderBy?.call(DictionaryImportProfile.t),
      orderByList: orderByList?.call(DictionaryImportProfile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DictionaryImportProfile] by its [id] or null if no such row exists.
  Future<DictionaryImportProfile?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DictionaryImportProfile>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DictionaryImportProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [DictionaryImportProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DictionaryImportProfile>> insert(
    _i1.DatabaseSession session,
    List<DictionaryImportProfile> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DictionaryImportProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DictionaryImportProfile] and returns the inserted row.
  ///
  /// The returned [DictionaryImportProfile] will have its `id` field set.
  Future<DictionaryImportProfile> insertRow(
    _i1.DatabaseSession session,
    DictionaryImportProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DictionaryImportProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryImportProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DictionaryImportProfile>> update(
    _i1.DatabaseSession session,
    List<DictionaryImportProfile> rows, {
    _i1.ColumnSelections<DictionaryImportProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DictionaryImportProfile>(
      rows,
      columns: columns?.call(DictionaryImportProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryImportProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DictionaryImportProfile> updateRow(
    _i1.DatabaseSession session,
    DictionaryImportProfile row, {
    _i1.ColumnSelections<DictionaryImportProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DictionaryImportProfile>(
      row,
      columns: columns?.call(DictionaryImportProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryImportProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DictionaryImportProfile?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DictionaryImportProfileUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DictionaryImportProfile>(
      id,
      columnValues: columnValues(DictionaryImportProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryImportProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DictionaryImportProfile>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DictionaryImportProfileUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DictionaryImportProfileTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryImportProfileTable>? orderBy,
    _i1.OrderByListBuilder<DictionaryImportProfileTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DictionaryImportProfile>(
      columnValues: columnValues(DictionaryImportProfile.t.updateTable),
      where: where(DictionaryImportProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryImportProfile.t),
      orderByList: orderByList?.call(DictionaryImportProfile.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DictionaryImportProfile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DictionaryImportProfile>> delete(
    _i1.DatabaseSession session,
    List<DictionaryImportProfile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DictionaryImportProfile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DictionaryImportProfile].
  Future<DictionaryImportProfile> deleteRow(
    _i1.DatabaseSession session,
    DictionaryImportProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DictionaryImportProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DictionaryImportProfile>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryImportProfileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DictionaryImportProfile>(
      where: where(DictionaryImportProfile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryImportProfileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DictionaryImportProfile>(
      where: where?.call(DictionaryImportProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DictionaryImportProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryImportProfileTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DictionaryImportProfile>(
      where: where(DictionaryImportProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
