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

abstract class SubtitleTrack
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SubtitleTrack._({
    this.id,
    required this.videoId,
    required this.languageCode,
    required this.label,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isDefault = isDefault ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubtitleTrack({
    int? id,
    required int videoId,
    required String languageCode,
    required String label,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubtitleTrackImpl;

  factory SubtitleTrack.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtitleTrack(
      id: jsonSerialization['id'] as int?,
      videoId: jsonSerialization['videoId'] as int,
      languageCode: jsonSerialization['languageCode'] as String,
      label: jsonSerialization['label'] as String,
      isDefault: jsonSerialization['isDefault'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isDefault']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SubtitleTrackTable();

  static const db = SubtitleTrackRepository._();

  @override
  int? id;

  int videoId;

  String languageCode;

  String label;

  bool isDefault;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubtitleTrack]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleTrack copyWith({
    int? id,
    int? videoId,
    String? languageCode,
    String? label,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleTrack',
      if (id != null) 'id': id,
      'videoId': videoId,
      'languageCode': languageCode,
      'label': label,
      'isDefault': isDefault,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubtitleTrack',
      if (id != null) 'id': id,
      'videoId': videoId,
      'languageCode': languageCode,
      'label': label,
      'isDefault': isDefault,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SubtitleTrackInclude include() {
    return SubtitleTrackInclude._();
  }

  static SubtitleTrackIncludeList includeList({
    _i1.WhereExpressionBuilder<SubtitleTrackTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleTrackTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleTrackTable>? orderByList,
    SubtitleTrackInclude? include,
  }) {
    return SubtitleTrackIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitleTrack.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SubtitleTrack.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtitleTrackImpl extends SubtitleTrack {
  _SubtitleTrackImpl({
    int? id,
    required int videoId,
    required String languageCode,
    required String label,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         videoId: videoId,
         languageCode: languageCode,
         label: label,
         isDefault: isDefault,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubtitleTrack]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleTrack copyWith({
    Object? id = _Undefined,
    int? videoId,
    String? languageCode,
    String? label,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubtitleTrack(
      id: id is int? ? id : this.id,
      videoId: videoId ?? this.videoId,
      languageCode: languageCode ?? this.languageCode,
      label: label ?? this.label,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SubtitleTrackUpdateTable extends _i1.UpdateTable<SubtitleTrackTable> {
  SubtitleTrackUpdateTable(super.table);

  _i1.ColumnValue<int, int> videoId(int value) => _i1.ColumnValue(
    table.videoId,
    value,
  );

  _i1.ColumnValue<String, String> languageCode(String value) => _i1.ColumnValue(
    table.languageCode,
    value,
  );

  _i1.ColumnValue<String, String> label(String value) => _i1.ColumnValue(
    table.label,
    value,
  );

  _i1.ColumnValue<bool, bool> isDefault(bool value) => _i1.ColumnValue(
    table.isDefault,
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

class SubtitleTrackTable extends _i1.Table<int?> {
  SubtitleTrackTable({super.tableRelation})
    : super(tableName: 'subtitle_track') {
    updateTable = SubtitleTrackUpdateTable(this);
    videoId = _i1.ColumnInt(
      'videoId',
      this,
    );
    languageCode = _i1.ColumnString(
      'languageCode',
      this,
    );
    label = _i1.ColumnString(
      'label',
      this,
    );
    isDefault = _i1.ColumnBool(
      'isDefault',
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

  late final SubtitleTrackUpdateTable updateTable;

  late final _i1.ColumnInt videoId;

  late final _i1.ColumnString languageCode;

  late final _i1.ColumnString label;

  late final _i1.ColumnBool isDefault;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    videoId,
    languageCode,
    label,
    isDefault,
    createdAt,
    updatedAt,
  ];
}

class SubtitleTrackInclude extends _i1.IncludeObject {
  SubtitleTrackInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SubtitleTrack.t;
}

class SubtitleTrackIncludeList extends _i1.IncludeList {
  SubtitleTrackIncludeList._({
    _i1.WhereExpressionBuilder<SubtitleTrackTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubtitleTrack.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SubtitleTrack.t;
}

class SubtitleTrackRepository {
  const SubtitleTrackRepository._();

  /// Returns a list of [SubtitleTrack]s matching the given query parameters.
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
  Future<List<SubtitleTrack>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleTrackTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleTrackTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleTrackTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SubtitleTrack>(
      where: where?.call(SubtitleTrack.t),
      orderBy: orderBy?.call(SubtitleTrack.t),
      orderByList: orderByList?.call(SubtitleTrack.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SubtitleTrack] matching the given query parameters.
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
  Future<SubtitleTrack?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleTrackTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubtitleTrackTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleTrackTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SubtitleTrack>(
      where: where?.call(SubtitleTrack.t),
      orderBy: orderBy?.call(SubtitleTrack.t),
      orderByList: orderByList?.call(SubtitleTrack.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SubtitleTrack] by its [id] or null if no such row exists.
  Future<SubtitleTrack?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SubtitleTrack>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SubtitleTrack]s in the list and returns the inserted rows.
  ///
  /// The returned [SubtitleTrack]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SubtitleTrack>> insert(
    _i1.DatabaseSession session,
    List<SubtitleTrack> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SubtitleTrack>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SubtitleTrack] and returns the inserted row.
  ///
  /// The returned [SubtitleTrack] will have its `id` field set.
  Future<SubtitleTrack> insertRow(
    _i1.DatabaseSession session,
    SubtitleTrack row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubtitleTrack>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SubtitleTrack]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SubtitleTrack>> update(
    _i1.DatabaseSession session,
    List<SubtitleTrack> rows, {
    _i1.ColumnSelections<SubtitleTrackTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SubtitleTrack>(
      rows,
      columns: columns?.call(SubtitleTrack.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitleTrack]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubtitleTrack> updateRow(
    _i1.DatabaseSession session,
    SubtitleTrack row, {
    _i1.ColumnSelections<SubtitleTrackTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubtitleTrack>(
      row,
      columns: columns?.call(SubtitleTrack.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitleTrack] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SubtitleTrack?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SubtitleTrackUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SubtitleTrack>(
      id,
      columnValues: columnValues(SubtitleTrack.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SubtitleTrack]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SubtitleTrack>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SubtitleTrackUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SubtitleTrackTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleTrackTable>? orderBy,
    _i1.OrderByListBuilder<SubtitleTrackTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SubtitleTrack>(
      columnValues: columnValues(SubtitleTrack.t.updateTable),
      where: where(SubtitleTrack.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitleTrack.t),
      orderByList: orderByList?.call(SubtitleTrack.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SubtitleTrack]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SubtitleTrack>> delete(
    _i1.DatabaseSession session,
    List<SubtitleTrack> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SubtitleTrack>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SubtitleTrack].
  Future<SubtitleTrack> deleteRow(
    _i1.DatabaseSession session,
    SubtitleTrack row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubtitleTrack>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SubtitleTrack>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitleTrackTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SubtitleTrack>(
      where: where(SubtitleTrack.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleTrackTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SubtitleTrack>(
      where: where?.call(SubtitleTrack.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SubtitleTrack] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitleTrackTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SubtitleTrack>(
      where: where(SubtitleTrack.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
