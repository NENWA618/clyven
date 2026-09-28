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

abstract class DictionaryImportMapping
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DictionaryImportMapping._({
    this.id,
    required this.profileId,
    required this.sourceColumn,
    required this.targetType,
    this.targetField,
    this.languageCode,
    this.scriptCode,
    this.relationType,
    this.groupKey,
    this.transformType,
    this.transformConfig,
    required this.position,
    bool? required,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : required = required ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DictionaryImportMapping({
    int? id,
    required int profileId,
    required String sourceColumn,
    required String targetType,
    String? targetField,
    String? languageCode,
    String? scriptCode,
    String? relationType,
    String? groupKey,
    String? transformType,
    String? transformConfig,
    required int position,
    bool? required,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DictionaryImportMappingImpl;

  factory DictionaryImportMapping.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DictionaryImportMapping(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      sourceColumn: jsonSerialization['sourceColumn'] as String,
      targetType: jsonSerialization['targetType'] as String,
      targetField: jsonSerialization['targetField'] as String?,
      languageCode: jsonSerialization['languageCode'] as String?,
      scriptCode: jsonSerialization['scriptCode'] as String?,
      relationType: jsonSerialization['relationType'] as String?,
      groupKey: jsonSerialization['groupKey'] as String?,
      transformType: jsonSerialization['transformType'] as String?,
      transformConfig: jsonSerialization['transformConfig'] as String?,
      position: jsonSerialization['position'] as int,
      required: jsonSerialization['required'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['required']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = DictionaryImportMappingTable();

  static const db = DictionaryImportMappingRepository._();

  @override
  int? id;

  int profileId;

  String sourceColumn;

  String targetType;

  String? targetField;

  String? languageCode;

  String? scriptCode;

  String? relationType;

  String? groupKey;

  String? transformType;

  String? transformConfig;

  int position;

  bool required;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DictionaryImportMapping]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryImportMapping copyWith({
    int? id,
    int? profileId,
    String? sourceColumn,
    String? targetType,
    String? targetField,
    String? languageCode,
    String? scriptCode,
    String? relationType,
    String? groupKey,
    String? transformType,
    String? transformConfig,
    int? position,
    bool? required,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryImportMapping',
      if (id != null) 'id': id,
      'profileId': profileId,
      'sourceColumn': sourceColumn,
      'targetType': targetType,
      if (targetField != null) 'targetField': targetField,
      if (languageCode != null) 'languageCode': languageCode,
      if (scriptCode != null) 'scriptCode': scriptCode,
      if (relationType != null) 'relationType': relationType,
      if (groupKey != null) 'groupKey': groupKey,
      if (transformType != null) 'transformType': transformType,
      if (transformConfig != null) 'transformConfig': transformConfig,
      'position': position,
      'required': required,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DictionaryImportMapping',
      if (id != null) 'id': id,
      'profileId': profileId,
      'sourceColumn': sourceColumn,
      'targetType': targetType,
      if (targetField != null) 'targetField': targetField,
      if (languageCode != null) 'languageCode': languageCode,
      if (scriptCode != null) 'scriptCode': scriptCode,
      if (relationType != null) 'relationType': relationType,
      if (groupKey != null) 'groupKey': groupKey,
      if (transformType != null) 'transformType': transformType,
      if (transformConfig != null) 'transformConfig': transformConfig,
      'position': position,
      'required': required,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DictionaryImportMappingInclude include() {
    return DictionaryImportMappingInclude._();
  }

  static DictionaryImportMappingIncludeList includeList({
    _i1.WhereExpressionBuilder<DictionaryImportMappingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryImportMappingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryImportMappingTable>? orderByList,
    DictionaryImportMappingInclude? include,
  }) {
    return DictionaryImportMappingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryImportMapping.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DictionaryImportMapping.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DictionaryImportMappingImpl extends DictionaryImportMapping {
  _DictionaryImportMappingImpl({
    int? id,
    required int profileId,
    required String sourceColumn,
    required String targetType,
    String? targetField,
    String? languageCode,
    String? scriptCode,
    String? relationType,
    String? groupKey,
    String? transformType,
    String? transformConfig,
    required int position,
    bool? required,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         sourceColumn: sourceColumn,
         targetType: targetType,
         targetField: targetField,
         languageCode: languageCode,
         scriptCode: scriptCode,
         relationType: relationType,
         groupKey: groupKey,
         transformType: transformType,
         transformConfig: transformConfig,
         position: position,
         required: required,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DictionaryImportMapping]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryImportMapping copyWith({
    Object? id = _Undefined,
    int? profileId,
    String? sourceColumn,
    String? targetType,
    Object? targetField = _Undefined,
    Object? languageCode = _Undefined,
    Object? scriptCode = _Undefined,
    Object? relationType = _Undefined,
    Object? groupKey = _Undefined,
    Object? transformType = _Undefined,
    Object? transformConfig = _Undefined,
    int? position,
    bool? required,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DictionaryImportMapping(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      sourceColumn: sourceColumn ?? this.sourceColumn,
      targetType: targetType ?? this.targetType,
      targetField: targetField is String? ? targetField : this.targetField,
      languageCode: languageCode is String? ? languageCode : this.languageCode,
      scriptCode: scriptCode is String? ? scriptCode : this.scriptCode,
      relationType: relationType is String? ? relationType : this.relationType,
      groupKey: groupKey is String? ? groupKey : this.groupKey,
      transformType: transformType is String?
          ? transformType
          : this.transformType,
      transformConfig: transformConfig is String?
          ? transformConfig
          : this.transformConfig,
      position: position ?? this.position,
      required: required ?? this.required,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DictionaryImportMappingUpdateTable
    extends _i1.UpdateTable<DictionaryImportMappingTable> {
  DictionaryImportMappingUpdateTable(super.table);

  _i1.ColumnValue<int, int> profileId(int value) => _i1.ColumnValue(
    table.profileId,
    value,
  );

  _i1.ColumnValue<String, String> sourceColumn(String value) => _i1.ColumnValue(
    table.sourceColumn,
    value,
  );

  _i1.ColumnValue<String, String> targetType(String value) => _i1.ColumnValue(
    table.targetType,
    value,
  );

  _i1.ColumnValue<String, String> targetField(String? value) => _i1.ColumnValue(
    table.targetField,
    value,
  );

  _i1.ColumnValue<String, String> languageCode(String? value) =>
      _i1.ColumnValue(
        table.languageCode,
        value,
      );

  _i1.ColumnValue<String, String> scriptCode(String? value) => _i1.ColumnValue(
    table.scriptCode,
    value,
  );

  _i1.ColumnValue<String, String> relationType(String? value) =>
      _i1.ColumnValue(
        table.relationType,
        value,
      );

  _i1.ColumnValue<String, String> groupKey(String? value) => _i1.ColumnValue(
    table.groupKey,
    value,
  );

  _i1.ColumnValue<String, String> transformType(String? value) =>
      _i1.ColumnValue(
        table.transformType,
        value,
      );

  _i1.ColumnValue<String, String> transformConfig(String? value) =>
      _i1.ColumnValue(
        table.transformConfig,
        value,
      );

  _i1.ColumnValue<int, int> position(int value) => _i1.ColumnValue(
    table.position,
    value,
  );

  _i1.ColumnValue<bool, bool> required(bool value) => _i1.ColumnValue(
    table.required,
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

class DictionaryImportMappingTable extends _i1.Table<int?> {
  DictionaryImportMappingTable({super.tableRelation})
    : super(tableName: 'dictionary_import_mapping') {
    updateTable = DictionaryImportMappingUpdateTable(this);
    profileId = _i1.ColumnInt(
      'profileId',
      this,
    );
    sourceColumn = _i1.ColumnString(
      'sourceColumn',
      this,
    );
    targetType = _i1.ColumnString(
      'targetType',
      this,
    );
    targetField = _i1.ColumnString(
      'targetField',
      this,
    );
    languageCode = _i1.ColumnString(
      'languageCode',
      this,
    );
    scriptCode = _i1.ColumnString(
      'scriptCode',
      this,
    );
    relationType = _i1.ColumnString(
      'relationType',
      this,
    );
    groupKey = _i1.ColumnString(
      'groupKey',
      this,
    );
    transformType = _i1.ColumnString(
      'transformType',
      this,
    );
    transformConfig = _i1.ColumnString(
      'transformConfig',
      this,
    );
    position = _i1.ColumnInt(
      'position',
      this,
    );
    required = _i1.ColumnBool(
      'required',
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

  late final DictionaryImportMappingUpdateTable updateTable;

  late final _i1.ColumnInt profileId;

  late final _i1.ColumnString sourceColumn;

  late final _i1.ColumnString targetType;

  late final _i1.ColumnString targetField;

  late final _i1.ColumnString languageCode;

  late final _i1.ColumnString scriptCode;

  late final _i1.ColumnString relationType;

  late final _i1.ColumnString groupKey;

  late final _i1.ColumnString transformType;

  late final _i1.ColumnString transformConfig;

  late final _i1.ColumnInt position;

  late final _i1.ColumnBool required;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    profileId,
    sourceColumn,
    targetType,
    targetField,
    languageCode,
    scriptCode,
    relationType,
    groupKey,
    transformType,
    transformConfig,
    position,
    required,
    createdAt,
    updatedAt,
  ];
}

class DictionaryImportMappingInclude extends _i1.IncludeObject {
  DictionaryImportMappingInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DictionaryImportMapping.t;
}

class DictionaryImportMappingIncludeList extends _i1.IncludeList {
  DictionaryImportMappingIncludeList._({
    _i1.WhereExpressionBuilder<DictionaryImportMappingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DictionaryImportMapping.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DictionaryImportMapping.t;
}

class DictionaryImportMappingRepository {
  const DictionaryImportMappingRepository._();

  /// Returns a list of [DictionaryImportMapping]s matching the given query parameters.
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
  Future<List<DictionaryImportMapping>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryImportMappingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryImportMappingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryImportMappingTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DictionaryImportMapping>(
      where: where?.call(DictionaryImportMapping.t),
      orderBy: orderBy?.call(DictionaryImportMapping.t),
      orderByList: orderByList?.call(DictionaryImportMapping.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DictionaryImportMapping] matching the given query parameters.
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
  Future<DictionaryImportMapping?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryImportMappingTable>? where,
    int? offset,
    _i1.OrderByBuilder<DictionaryImportMappingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryImportMappingTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DictionaryImportMapping>(
      where: where?.call(DictionaryImportMapping.t),
      orderBy: orderBy?.call(DictionaryImportMapping.t),
      orderByList: orderByList?.call(DictionaryImportMapping.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DictionaryImportMapping] by its [id] or null if no such row exists.
  Future<DictionaryImportMapping?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DictionaryImportMapping>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DictionaryImportMapping]s in the list and returns the inserted rows.
  ///
  /// The returned [DictionaryImportMapping]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DictionaryImportMapping>> insert(
    _i1.DatabaseSession session,
    List<DictionaryImportMapping> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DictionaryImportMapping>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DictionaryImportMapping] and returns the inserted row.
  ///
  /// The returned [DictionaryImportMapping] will have its `id` field set.
  Future<DictionaryImportMapping> insertRow(
    _i1.DatabaseSession session,
    DictionaryImportMapping row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DictionaryImportMapping>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryImportMapping]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DictionaryImportMapping>> update(
    _i1.DatabaseSession session,
    List<DictionaryImportMapping> rows, {
    _i1.ColumnSelections<DictionaryImportMappingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DictionaryImportMapping>(
      rows,
      columns: columns?.call(DictionaryImportMapping.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryImportMapping]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DictionaryImportMapping> updateRow(
    _i1.DatabaseSession session,
    DictionaryImportMapping row, {
    _i1.ColumnSelections<DictionaryImportMappingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DictionaryImportMapping>(
      row,
      columns: columns?.call(DictionaryImportMapping.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryImportMapping] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DictionaryImportMapping?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DictionaryImportMappingUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DictionaryImportMapping>(
      id,
      columnValues: columnValues(DictionaryImportMapping.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryImportMapping]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DictionaryImportMapping>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DictionaryImportMappingUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DictionaryImportMappingTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryImportMappingTable>? orderBy,
    _i1.OrderByListBuilder<DictionaryImportMappingTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DictionaryImportMapping>(
      columnValues: columnValues(DictionaryImportMapping.t.updateTable),
      where: where(DictionaryImportMapping.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryImportMapping.t),
      orderByList: orderByList?.call(DictionaryImportMapping.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DictionaryImportMapping]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DictionaryImportMapping>> delete(
    _i1.DatabaseSession session,
    List<DictionaryImportMapping> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DictionaryImportMapping>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DictionaryImportMapping].
  Future<DictionaryImportMapping> deleteRow(
    _i1.DatabaseSession session,
    DictionaryImportMapping row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DictionaryImportMapping>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DictionaryImportMapping>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryImportMappingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DictionaryImportMapping>(
      where: where(DictionaryImportMapping.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryImportMappingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DictionaryImportMapping>(
      where: where?.call(DictionaryImportMapping.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DictionaryImportMapping] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryImportMappingTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DictionaryImportMapping>(
      where: where(DictionaryImportMapping.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
