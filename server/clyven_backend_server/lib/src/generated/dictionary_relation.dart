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

abstract class DictionaryRelation
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DictionaryRelation._({
    this.id,
    required this.sourceEntryId,
    required this.targetEntryId,
    required this.relationType,
    this.position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DictionaryRelation({
    int? id,
    required int sourceEntryId,
    required int targetEntryId,
    required String relationType,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DictionaryRelationImpl;

  factory DictionaryRelation.fromJson(Map<String, dynamic> jsonSerialization) {
    return DictionaryRelation(
      id: jsonSerialization['id'] as int?,
      sourceEntryId: jsonSerialization['sourceEntryId'] as int,
      targetEntryId: jsonSerialization['targetEntryId'] as int,
      relationType: jsonSerialization['relationType'] as String,
      position: jsonSerialization['position'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = DictionaryRelationTable();

  static const db = DictionaryRelationRepository._();

  @override
  int? id;

  int sourceEntryId;

  int targetEntryId;

  String relationType;

  int? position;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DictionaryRelation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryRelation copyWith({
    int? id,
    int? sourceEntryId,
    int? targetEntryId,
    String? relationType,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryRelation',
      if (id != null) 'id': id,
      'sourceEntryId': sourceEntryId,
      'targetEntryId': targetEntryId,
      'relationType': relationType,
      if (position != null) 'position': position,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DictionaryRelation',
      if (id != null) 'id': id,
      'sourceEntryId': sourceEntryId,
      'targetEntryId': targetEntryId,
      'relationType': relationType,
      if (position != null) 'position': position,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DictionaryRelationInclude include() {
    return DictionaryRelationInclude._();
  }

  static DictionaryRelationIncludeList includeList({
    _i1.WhereExpressionBuilder<DictionaryRelationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryRelationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryRelationTable>? orderByList,
    DictionaryRelationInclude? include,
  }) {
    return DictionaryRelationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryRelation.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DictionaryRelation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DictionaryRelationImpl extends DictionaryRelation {
  _DictionaryRelationImpl({
    int? id,
    required int sourceEntryId,
    required int targetEntryId,
    required String relationType,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         sourceEntryId: sourceEntryId,
         targetEntryId: targetEntryId,
         relationType: relationType,
         position: position,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DictionaryRelation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryRelation copyWith({
    Object? id = _Undefined,
    int? sourceEntryId,
    int? targetEntryId,
    String? relationType,
    Object? position = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DictionaryRelation(
      id: id is int? ? id : this.id,
      sourceEntryId: sourceEntryId ?? this.sourceEntryId,
      targetEntryId: targetEntryId ?? this.targetEntryId,
      relationType: relationType ?? this.relationType,
      position: position is int? ? position : this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DictionaryRelationUpdateTable
    extends _i1.UpdateTable<DictionaryRelationTable> {
  DictionaryRelationUpdateTable(super.table);

  _i1.ColumnValue<int, int> sourceEntryId(int value) => _i1.ColumnValue(
    table.sourceEntryId,
    value,
  );

  _i1.ColumnValue<int, int> targetEntryId(int value) => _i1.ColumnValue(
    table.targetEntryId,
    value,
  );

  _i1.ColumnValue<String, String> relationType(String value) => _i1.ColumnValue(
    table.relationType,
    value,
  );

  _i1.ColumnValue<int, int> position(int? value) => _i1.ColumnValue(
    table.position,
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

class DictionaryRelationTable extends _i1.Table<int?> {
  DictionaryRelationTable({super.tableRelation})
    : super(tableName: 'dictionary_relation') {
    updateTable = DictionaryRelationUpdateTable(this);
    sourceEntryId = _i1.ColumnInt(
      'sourceEntryId',
      this,
    );
    targetEntryId = _i1.ColumnInt(
      'targetEntryId',
      this,
    );
    relationType = _i1.ColumnString(
      'relationType',
      this,
    );
    position = _i1.ColumnInt(
      'position',
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

  late final DictionaryRelationUpdateTable updateTable;

  late final _i1.ColumnInt sourceEntryId;

  late final _i1.ColumnInt targetEntryId;

  late final _i1.ColumnString relationType;

  late final _i1.ColumnInt position;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    sourceEntryId,
    targetEntryId,
    relationType,
    position,
    createdAt,
    updatedAt,
  ];
}

class DictionaryRelationInclude extends _i1.IncludeObject {
  DictionaryRelationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DictionaryRelation.t;
}

class DictionaryRelationIncludeList extends _i1.IncludeList {
  DictionaryRelationIncludeList._({
    _i1.WhereExpressionBuilder<DictionaryRelationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DictionaryRelation.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DictionaryRelation.t;
}

class DictionaryRelationRepository {
  const DictionaryRelationRepository._();

  /// Returns a list of [DictionaryRelation]s matching the given query parameters.
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
  Future<List<DictionaryRelation>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryRelationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryRelationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryRelationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DictionaryRelation>(
      where: where?.call(DictionaryRelation.t),
      orderBy: orderBy?.call(DictionaryRelation.t),
      orderByList: orderByList?.call(DictionaryRelation.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DictionaryRelation] matching the given query parameters.
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
  Future<DictionaryRelation?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryRelationTable>? where,
    int? offset,
    _i1.OrderByBuilder<DictionaryRelationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryRelationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DictionaryRelation>(
      where: where?.call(DictionaryRelation.t),
      orderBy: orderBy?.call(DictionaryRelation.t),
      orderByList: orderByList?.call(DictionaryRelation.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DictionaryRelation] by its [id] or null if no such row exists.
  Future<DictionaryRelation?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DictionaryRelation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DictionaryRelation]s in the list and returns the inserted rows.
  ///
  /// The returned [DictionaryRelation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DictionaryRelation>> insert(
    _i1.DatabaseSession session,
    List<DictionaryRelation> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DictionaryRelation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DictionaryRelation] and returns the inserted row.
  ///
  /// The returned [DictionaryRelation] will have its `id` field set.
  Future<DictionaryRelation> insertRow(
    _i1.DatabaseSession session,
    DictionaryRelation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DictionaryRelation>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryRelation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DictionaryRelation>> update(
    _i1.DatabaseSession session,
    List<DictionaryRelation> rows, {
    _i1.ColumnSelections<DictionaryRelationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DictionaryRelation>(
      rows,
      columns: columns?.call(DictionaryRelation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryRelation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DictionaryRelation> updateRow(
    _i1.DatabaseSession session,
    DictionaryRelation row, {
    _i1.ColumnSelections<DictionaryRelationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DictionaryRelation>(
      row,
      columns: columns?.call(DictionaryRelation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryRelation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DictionaryRelation?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DictionaryRelationUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DictionaryRelation>(
      id,
      columnValues: columnValues(DictionaryRelation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryRelation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DictionaryRelation>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DictionaryRelationUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DictionaryRelationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryRelationTable>? orderBy,
    _i1.OrderByListBuilder<DictionaryRelationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DictionaryRelation>(
      columnValues: columnValues(DictionaryRelation.t.updateTable),
      where: where(DictionaryRelation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryRelation.t),
      orderByList: orderByList?.call(DictionaryRelation.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DictionaryRelation]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DictionaryRelation>> delete(
    _i1.DatabaseSession session,
    List<DictionaryRelation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DictionaryRelation>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DictionaryRelation].
  Future<DictionaryRelation> deleteRow(
    _i1.DatabaseSession session,
    DictionaryRelation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DictionaryRelation>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DictionaryRelation>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryRelationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DictionaryRelation>(
      where: where(DictionaryRelation.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryRelationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DictionaryRelation>(
      where: where?.call(DictionaryRelation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DictionaryRelation] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryRelationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DictionaryRelation>(
      where: where(DictionaryRelation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
