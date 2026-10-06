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

abstract class ScriptConversionEntry
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ScriptConversionEntry._({
    this.id,
    required this.profileId,
    required this.sourceText,
    required this.targetText,
    int? priority,
    this.note,
    this.metadataJson,
    this.entryType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : priority = priority ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory ScriptConversionEntry({
    int? id,
    required int profileId,
    required String sourceText,
    required String targetText,
    int? priority,
    String? note,
    String? metadataJson,
    String? entryType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ScriptConversionEntryImpl;

  factory ScriptConversionEntry.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ScriptConversionEntry(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      sourceText: jsonSerialization['sourceText'] as String,
      targetText: jsonSerialization['targetText'] as String,
      priority: jsonSerialization['priority'] as int?,
      note: jsonSerialization['note'] as String?,
      metadataJson: jsonSerialization['metadataJson'] as String?,
      entryType: jsonSerialization['entryType'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ScriptConversionEntryTable();

  static const db = ScriptConversionEntryRepository._();

  @override
  int? id;

  int profileId;

  String sourceText;

  String targetText;

  int priority;

  String? note;

  String? metadataJson;

  String? entryType;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ScriptConversionEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScriptConversionEntry copyWith({
    int? id,
    int? profileId,
    String? sourceText,
    String? targetText,
    int? priority,
    String? note,
    String? metadataJson,
    String? entryType,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScriptConversionEntry',
      if (id != null) 'id': id,
      'profileId': profileId,
      'sourceText': sourceText,
      'targetText': targetText,
      'priority': priority,
      if (note != null) 'note': note,
      if (metadataJson != null) 'metadataJson': metadataJson,
      if (entryType != null) 'entryType': entryType,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScriptConversionEntry',
      if (id != null) 'id': id,
      'profileId': profileId,
      'sourceText': sourceText,
      'targetText': targetText,
      'priority': priority,
      if (note != null) 'note': note,
      if (metadataJson != null) 'metadataJson': metadataJson,
      if (entryType != null) 'entryType': entryType,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ScriptConversionEntryInclude include() {
    return ScriptConversionEntryInclude._();
  }

  static ScriptConversionEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<ScriptConversionEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScriptConversionEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScriptConversionEntryTable>? orderByList,
    ScriptConversionEntryInclude? include,
  }) {
    return ScriptConversionEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScriptConversionEntry.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ScriptConversionEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScriptConversionEntryImpl extends ScriptConversionEntry {
  _ScriptConversionEntryImpl({
    int? id,
    required int profileId,
    required String sourceText,
    required String targetText,
    int? priority,
    String? note,
    String? metadataJson,
    String? entryType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         sourceText: sourceText,
         targetText: targetText,
         priority: priority,
         note: note,
         metadataJson: metadataJson,
         entryType: entryType,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ScriptConversionEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScriptConversionEntry copyWith({
    Object? id = _Undefined,
    int? profileId,
    String? sourceText,
    String? targetText,
    int? priority,
    Object? note = _Undefined,
    Object? metadataJson = _Undefined,
    Object? entryType = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ScriptConversionEntry(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      sourceText: sourceText ?? this.sourceText,
      targetText: targetText ?? this.targetText,
      priority: priority ?? this.priority,
      note: note is String? ? note : this.note,
      metadataJson: metadataJson is String? ? metadataJson : this.metadataJson,
      entryType: entryType is String? ? entryType : this.entryType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ScriptConversionEntryUpdateTable
    extends _i1.UpdateTable<ScriptConversionEntryTable> {
  ScriptConversionEntryUpdateTable(super.table);

  _i1.ColumnValue<int, int> profileId(int value) => _i1.ColumnValue(
    table.profileId,
    value,
  );

  _i1.ColumnValue<String, String> sourceText(String value) => _i1.ColumnValue(
    table.sourceText,
    value,
  );

  _i1.ColumnValue<String, String> targetText(String value) => _i1.ColumnValue(
    table.targetText,
    value,
  );

  _i1.ColumnValue<int, int> priority(int value) => _i1.ColumnValue(
    table.priority,
    value,
  );

  _i1.ColumnValue<String, String> note(String? value) => _i1.ColumnValue(
    table.note,
    value,
  );

  _i1.ColumnValue<String, String> metadataJson(String? value) =>
      _i1.ColumnValue(
        table.metadataJson,
        value,
      );

  _i1.ColumnValue<String, String> entryType(String? value) => _i1.ColumnValue(
    table.entryType,
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

class ScriptConversionEntryTable extends _i1.Table<int?> {
  ScriptConversionEntryTable({super.tableRelation})
    : super(tableName: 'script_conversion_entry') {
    updateTable = ScriptConversionEntryUpdateTable(this);
    profileId = _i1.ColumnInt(
      'profileId',
      this,
    );
    sourceText = _i1.ColumnString(
      'sourceText',
      this,
    );
    targetText = _i1.ColumnString(
      'targetText',
      this,
    );
    priority = _i1.ColumnInt(
      'priority',
      this,
      hasDefault: true,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
    metadataJson = _i1.ColumnString(
      'metadataJson',
      this,
    );
    entryType = _i1.ColumnString(
      'entryType',
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

  late final ScriptConversionEntryUpdateTable updateTable;

  late final _i1.ColumnInt profileId;

  late final _i1.ColumnString sourceText;

  late final _i1.ColumnString targetText;

  late final _i1.ColumnInt priority;

  late final _i1.ColumnString note;

  late final _i1.ColumnString metadataJson;

  late final _i1.ColumnString entryType;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    profileId,
    sourceText,
    targetText,
    priority,
    note,
    metadataJson,
    entryType,
    createdAt,
    updatedAt,
  ];
}

class ScriptConversionEntryInclude extends _i1.IncludeObject {
  ScriptConversionEntryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ScriptConversionEntry.t;
}

class ScriptConversionEntryIncludeList extends _i1.IncludeList {
  ScriptConversionEntryIncludeList._({
    _i1.WhereExpressionBuilder<ScriptConversionEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ScriptConversionEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ScriptConversionEntry.t;
}

class ScriptConversionEntryRepository {
  const ScriptConversionEntryRepository._();

  /// Returns a list of [ScriptConversionEntry]s matching the given query parameters.
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
  Future<List<ScriptConversionEntry>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ScriptConversionEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScriptConversionEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScriptConversionEntryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ScriptConversionEntry>(
      where: where?.call(ScriptConversionEntry.t),
      orderBy: orderBy?.call(ScriptConversionEntry.t),
      orderByList: orderByList?.call(ScriptConversionEntry.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ScriptConversionEntry] matching the given query parameters.
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
  Future<ScriptConversionEntry?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ScriptConversionEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<ScriptConversionEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScriptConversionEntryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ScriptConversionEntry>(
      where: where?.call(ScriptConversionEntry.t),
      orderBy: orderBy?.call(ScriptConversionEntry.t),
      orderByList: orderByList?.call(ScriptConversionEntry.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ScriptConversionEntry] by its [id] or null if no such row exists.
  Future<ScriptConversionEntry?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ScriptConversionEntry>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ScriptConversionEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [ScriptConversionEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ScriptConversionEntry>> insert(
    _i1.DatabaseSession session,
    List<ScriptConversionEntry> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ScriptConversionEntry>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ScriptConversionEntry] and returns the inserted row.
  ///
  /// The returned [ScriptConversionEntry] will have its `id` field set.
  Future<ScriptConversionEntry> insertRow(
    _i1.DatabaseSession session,
    ScriptConversionEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ScriptConversionEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ScriptConversionEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ScriptConversionEntry>> update(
    _i1.DatabaseSession session,
    List<ScriptConversionEntry> rows, {
    _i1.ColumnSelections<ScriptConversionEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ScriptConversionEntry>(
      rows,
      columns: columns?.call(ScriptConversionEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScriptConversionEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ScriptConversionEntry> updateRow(
    _i1.DatabaseSession session,
    ScriptConversionEntry row, {
    _i1.ColumnSelections<ScriptConversionEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ScriptConversionEntry>(
      row,
      columns: columns?.call(ScriptConversionEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScriptConversionEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ScriptConversionEntry?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ScriptConversionEntryUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ScriptConversionEntry>(
      id,
      columnValues: columnValues(ScriptConversionEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ScriptConversionEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ScriptConversionEntry>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ScriptConversionEntryUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ScriptConversionEntryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScriptConversionEntryTable>? orderBy,
    _i1.OrderByListBuilder<ScriptConversionEntryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ScriptConversionEntry>(
      columnValues: columnValues(ScriptConversionEntry.t.updateTable),
      where: where(ScriptConversionEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScriptConversionEntry.t),
      orderByList: orderByList?.call(ScriptConversionEntry.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ScriptConversionEntry]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ScriptConversionEntry>> delete(
    _i1.DatabaseSession session,
    List<ScriptConversionEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ScriptConversionEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ScriptConversionEntry].
  Future<ScriptConversionEntry> deleteRow(
    _i1.DatabaseSession session,
    ScriptConversionEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ScriptConversionEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ScriptConversionEntry>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ScriptConversionEntryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ScriptConversionEntry>(
      where: where(ScriptConversionEntry.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ScriptConversionEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ScriptConversionEntry>(
      where: where?.call(ScriptConversionEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ScriptConversionEntry] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ScriptConversionEntryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ScriptConversionEntry>(
      where: where(ScriptConversionEntry.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
