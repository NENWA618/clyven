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

abstract class ScriptConversionProfile
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ScriptConversionProfile._({
    this.id,
    required this.name,
    required this.languageCode,
    required this.sourceScriptCode,
    required this.targetScriptCode,
    this.sheetName,
    required this.sourceColumn,
    required this.targetColumn,
    this.priorityColumn,
    this.noteColumn,
    this.conversionMode,
    this.typeColumn,
    this.description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isActive = isActive ?? true,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory ScriptConversionProfile({
    int? id,
    required String name,
    required String languageCode,
    required String sourceScriptCode,
    required String targetScriptCode,
    String? sheetName,
    required String sourceColumn,
    required String targetColumn,
    String? priorityColumn,
    String? noteColumn,
    String? conversionMode,
    String? typeColumn,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ScriptConversionProfileImpl;

  factory ScriptConversionProfile.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ScriptConversionProfile(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      languageCode: jsonSerialization['languageCode'] as String,
      sourceScriptCode: jsonSerialization['sourceScriptCode'] as String,
      targetScriptCode: jsonSerialization['targetScriptCode'] as String,
      sheetName: jsonSerialization['sheetName'] as String?,
      sourceColumn: jsonSerialization['sourceColumn'] as String,
      targetColumn: jsonSerialization['targetColumn'] as String,
      priorityColumn: jsonSerialization['priorityColumn'] as String?,
      noteColumn: jsonSerialization['noteColumn'] as String?,
      conversionMode: jsonSerialization['conversionMode'] as String?,
      typeColumn: jsonSerialization['typeColumn'] as String?,
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

  static final t = ScriptConversionProfileTable();

  static const db = ScriptConversionProfileRepository._();

  @override
  int? id;

  String name;

  String languageCode;

  String sourceScriptCode;

  String targetScriptCode;

  String? sheetName;

  String sourceColumn;

  String targetColumn;

  String? priorityColumn;

  String? noteColumn;

  String? conversionMode;

  String? typeColumn;

  String? description;

  bool isActive;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ScriptConversionProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScriptConversionProfile copyWith({
    int? id,
    String? name,
    String? languageCode,
    String? sourceScriptCode,
    String? targetScriptCode,
    String? sheetName,
    String? sourceColumn,
    String? targetColumn,
    String? priorityColumn,
    String? noteColumn,
    String? conversionMode,
    String? typeColumn,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScriptConversionProfile',
      if (id != null) 'id': id,
      'name': name,
      'languageCode': languageCode,
      'sourceScriptCode': sourceScriptCode,
      'targetScriptCode': targetScriptCode,
      if (sheetName != null) 'sheetName': sheetName,
      'sourceColumn': sourceColumn,
      'targetColumn': targetColumn,
      if (priorityColumn != null) 'priorityColumn': priorityColumn,
      if (noteColumn != null) 'noteColumn': noteColumn,
      if (conversionMode != null) 'conversionMode': conversionMode,
      if (typeColumn != null) 'typeColumn': typeColumn,
      if (description != null) 'description': description,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScriptConversionProfile',
      if (id != null) 'id': id,
      'name': name,
      'languageCode': languageCode,
      'sourceScriptCode': sourceScriptCode,
      'targetScriptCode': targetScriptCode,
      if (sheetName != null) 'sheetName': sheetName,
      'sourceColumn': sourceColumn,
      'targetColumn': targetColumn,
      if (priorityColumn != null) 'priorityColumn': priorityColumn,
      if (noteColumn != null) 'noteColumn': noteColumn,
      if (conversionMode != null) 'conversionMode': conversionMode,
      if (typeColumn != null) 'typeColumn': typeColumn,
      if (description != null) 'description': description,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ScriptConversionProfileInclude include() {
    return ScriptConversionProfileInclude._();
  }

  static ScriptConversionProfileIncludeList includeList({
    _i1.WhereExpressionBuilder<ScriptConversionProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScriptConversionProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScriptConversionProfileTable>? orderByList,
    ScriptConversionProfileInclude? include,
  }) {
    return ScriptConversionProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScriptConversionProfile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ScriptConversionProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScriptConversionProfileImpl extends ScriptConversionProfile {
  _ScriptConversionProfileImpl({
    int? id,
    required String name,
    required String languageCode,
    required String sourceScriptCode,
    required String targetScriptCode,
    String? sheetName,
    required String sourceColumn,
    required String targetColumn,
    String? priorityColumn,
    String? noteColumn,
    String? conversionMode,
    String? typeColumn,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         languageCode: languageCode,
         sourceScriptCode: sourceScriptCode,
         targetScriptCode: targetScriptCode,
         sheetName: sheetName,
         sourceColumn: sourceColumn,
         targetColumn: targetColumn,
         priorityColumn: priorityColumn,
         noteColumn: noteColumn,
         conversionMode: conversionMode,
         typeColumn: typeColumn,
         description: description,
         isActive: isActive,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ScriptConversionProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScriptConversionProfile copyWith({
    Object? id = _Undefined,
    String? name,
    String? languageCode,
    String? sourceScriptCode,
    String? targetScriptCode,
    Object? sheetName = _Undefined,
    String? sourceColumn,
    String? targetColumn,
    Object? priorityColumn = _Undefined,
    Object? noteColumn = _Undefined,
    Object? conversionMode = _Undefined,
    Object? typeColumn = _Undefined,
    Object? description = _Undefined,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ScriptConversionProfile(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      languageCode: languageCode ?? this.languageCode,
      sourceScriptCode: sourceScriptCode ?? this.sourceScriptCode,
      targetScriptCode: targetScriptCode ?? this.targetScriptCode,
      sheetName: sheetName is String? ? sheetName : this.sheetName,
      sourceColumn: sourceColumn ?? this.sourceColumn,
      targetColumn: targetColumn ?? this.targetColumn,
      priorityColumn: priorityColumn is String?
          ? priorityColumn
          : this.priorityColumn,
      noteColumn: noteColumn is String? ? noteColumn : this.noteColumn,
      conversionMode: conversionMode is String?
          ? conversionMode
          : this.conversionMode,
      typeColumn: typeColumn is String? ? typeColumn : this.typeColumn,
      description: description is String? ? description : this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ScriptConversionProfileUpdateTable
    extends _i1.UpdateTable<ScriptConversionProfileTable> {
  ScriptConversionProfileUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> languageCode(String value) => _i1.ColumnValue(
    table.languageCode,
    value,
  );

  _i1.ColumnValue<String, String> sourceScriptCode(String value) =>
      _i1.ColumnValue(
        table.sourceScriptCode,
        value,
      );

  _i1.ColumnValue<String, String> targetScriptCode(String value) =>
      _i1.ColumnValue(
        table.targetScriptCode,
        value,
      );

  _i1.ColumnValue<String, String> sheetName(String? value) => _i1.ColumnValue(
    table.sheetName,
    value,
  );

  _i1.ColumnValue<String, String> sourceColumn(String value) => _i1.ColumnValue(
    table.sourceColumn,
    value,
  );

  _i1.ColumnValue<String, String> targetColumn(String value) => _i1.ColumnValue(
    table.targetColumn,
    value,
  );

  _i1.ColumnValue<String, String> priorityColumn(String? value) =>
      _i1.ColumnValue(
        table.priorityColumn,
        value,
      );

  _i1.ColumnValue<String, String> noteColumn(String? value) => _i1.ColumnValue(
    table.noteColumn,
    value,
  );

  _i1.ColumnValue<String, String> conversionMode(String? value) =>
      _i1.ColumnValue(
        table.conversionMode,
        value,
      );

  _i1.ColumnValue<String, String> typeColumn(String? value) => _i1.ColumnValue(
    table.typeColumn,
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

class ScriptConversionProfileTable extends _i1.Table<int?> {
  ScriptConversionProfileTable({super.tableRelation})
    : super(tableName: 'script_conversion_profile') {
    updateTable = ScriptConversionProfileUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    languageCode = _i1.ColumnString(
      'languageCode',
      this,
    );
    sourceScriptCode = _i1.ColumnString(
      'sourceScriptCode',
      this,
    );
    targetScriptCode = _i1.ColumnString(
      'targetScriptCode',
      this,
    );
    sheetName = _i1.ColumnString(
      'sheetName',
      this,
    );
    sourceColumn = _i1.ColumnString(
      'sourceColumn',
      this,
    );
    targetColumn = _i1.ColumnString(
      'targetColumn',
      this,
    );
    priorityColumn = _i1.ColumnString(
      'priorityColumn',
      this,
    );
    noteColumn = _i1.ColumnString(
      'noteColumn',
      this,
    );
    conversionMode = _i1.ColumnString(
      'conversionMode',
      this,
    );
    typeColumn = _i1.ColumnString(
      'typeColumn',
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

  late final ScriptConversionProfileUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString languageCode;

  late final _i1.ColumnString sourceScriptCode;

  late final _i1.ColumnString targetScriptCode;

  late final _i1.ColumnString sheetName;

  late final _i1.ColumnString sourceColumn;

  late final _i1.ColumnString targetColumn;

  late final _i1.ColumnString priorityColumn;

  late final _i1.ColumnString noteColumn;

  late final _i1.ColumnString conversionMode;

  late final _i1.ColumnString typeColumn;

  late final _i1.ColumnString description;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    languageCode,
    sourceScriptCode,
    targetScriptCode,
    sheetName,
    sourceColumn,
    targetColumn,
    priorityColumn,
    noteColumn,
    conversionMode,
    typeColumn,
    description,
    isActive,
    createdAt,
    updatedAt,
  ];
}

class ScriptConversionProfileInclude extends _i1.IncludeObject {
  ScriptConversionProfileInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ScriptConversionProfile.t;
}

class ScriptConversionProfileIncludeList extends _i1.IncludeList {
  ScriptConversionProfileIncludeList._({
    _i1.WhereExpressionBuilder<ScriptConversionProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ScriptConversionProfile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ScriptConversionProfile.t;
}

class ScriptConversionProfileRepository {
  const ScriptConversionProfileRepository._();

  /// Returns a list of [ScriptConversionProfile]s matching the given query parameters.
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
  Future<List<ScriptConversionProfile>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ScriptConversionProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScriptConversionProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScriptConversionProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ScriptConversionProfile>(
      where: where?.call(ScriptConversionProfile.t),
      orderBy: orderBy?.call(ScriptConversionProfile.t),
      orderByList: orderByList?.call(ScriptConversionProfile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ScriptConversionProfile] matching the given query parameters.
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
  Future<ScriptConversionProfile?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ScriptConversionProfileTable>? where,
    int? offset,
    _i1.OrderByBuilder<ScriptConversionProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScriptConversionProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ScriptConversionProfile>(
      where: where?.call(ScriptConversionProfile.t),
      orderBy: orderBy?.call(ScriptConversionProfile.t),
      orderByList: orderByList?.call(ScriptConversionProfile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ScriptConversionProfile] by its [id] or null if no such row exists.
  Future<ScriptConversionProfile?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ScriptConversionProfile>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ScriptConversionProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [ScriptConversionProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ScriptConversionProfile>> insert(
    _i1.DatabaseSession session,
    List<ScriptConversionProfile> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ScriptConversionProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ScriptConversionProfile] and returns the inserted row.
  ///
  /// The returned [ScriptConversionProfile] will have its `id` field set.
  Future<ScriptConversionProfile> insertRow(
    _i1.DatabaseSession session,
    ScriptConversionProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ScriptConversionProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ScriptConversionProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ScriptConversionProfile>> update(
    _i1.DatabaseSession session,
    List<ScriptConversionProfile> rows, {
    _i1.ColumnSelections<ScriptConversionProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ScriptConversionProfile>(
      rows,
      columns: columns?.call(ScriptConversionProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScriptConversionProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ScriptConversionProfile> updateRow(
    _i1.DatabaseSession session,
    ScriptConversionProfile row, {
    _i1.ColumnSelections<ScriptConversionProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ScriptConversionProfile>(
      row,
      columns: columns?.call(ScriptConversionProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScriptConversionProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ScriptConversionProfile?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ScriptConversionProfileUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ScriptConversionProfile>(
      id,
      columnValues: columnValues(ScriptConversionProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ScriptConversionProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ScriptConversionProfile>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ScriptConversionProfileUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ScriptConversionProfileTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScriptConversionProfileTable>? orderBy,
    _i1.OrderByListBuilder<ScriptConversionProfileTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ScriptConversionProfile>(
      columnValues: columnValues(ScriptConversionProfile.t.updateTable),
      where: where(ScriptConversionProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScriptConversionProfile.t),
      orderByList: orderByList?.call(ScriptConversionProfile.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ScriptConversionProfile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ScriptConversionProfile>> delete(
    _i1.DatabaseSession session,
    List<ScriptConversionProfile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ScriptConversionProfile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ScriptConversionProfile].
  Future<ScriptConversionProfile> deleteRow(
    _i1.DatabaseSession session,
    ScriptConversionProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ScriptConversionProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ScriptConversionProfile>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ScriptConversionProfileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ScriptConversionProfile>(
      where: where(ScriptConversionProfile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ScriptConversionProfileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ScriptConversionProfile>(
      where: where?.call(ScriptConversionProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ScriptConversionProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ScriptConversionProfileTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ScriptConversionProfile>(
      where: where(ScriptConversionProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
