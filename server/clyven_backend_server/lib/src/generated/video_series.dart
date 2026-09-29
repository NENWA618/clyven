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

abstract class VideoSeries
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  VideoSeries._({
    this.id,
    required this.creatorId,
    required this.title,
    required this.description,
    this.coverStorageKey,
    this.languageCode,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VideoSeries({
    int? id,
    required String creatorId,
    required String title,
    required String description,
    String? coverStorageKey,
    String? languageCode,
    required String category,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _VideoSeriesImpl;

  factory VideoSeries.fromJson(Map<String, dynamic> jsonSerialization) {
    return VideoSeries(
      id: jsonSerialization['id'] as int?,
      creatorId: jsonSerialization['creatorId'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      coverStorageKey: jsonSerialization['coverStorageKey'] as String?,
      languageCode: jsonSerialization['languageCode'] as String?,
      category: jsonSerialization['category'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = VideoSeriesTable();

  static const db = VideoSeriesRepository._();

  @override
  int? id;

  String creatorId;

  String title;

  String description;

  String? coverStorageKey;

  String? languageCode;

  String category;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [VideoSeries]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VideoSeries copyWith({
    int? id,
    String? creatorId,
    String? title,
    String? description,
    String? coverStorageKey,
    String? languageCode,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VideoSeries',
      if (id != null) 'id': id,
      'creatorId': creatorId,
      'title': title,
      'description': description,
      if (coverStorageKey != null) 'coverStorageKey': coverStorageKey,
      if (languageCode != null) 'languageCode': languageCode,
      'category': category,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VideoSeries',
      if (id != null) 'id': id,
      'creatorId': creatorId,
      'title': title,
      'description': description,
      if (coverStorageKey != null) 'coverStorageKey': coverStorageKey,
      if (languageCode != null) 'languageCode': languageCode,
      'category': category,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static VideoSeriesInclude include() {
    return VideoSeriesInclude._();
  }

  static VideoSeriesIncludeList includeList({
    _i1.WhereExpressionBuilder<VideoSeriesTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VideoSeriesTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VideoSeriesTable>? orderByList,
    VideoSeriesInclude? include,
  }) {
    return VideoSeriesIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VideoSeries.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(VideoSeries.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VideoSeriesImpl extends VideoSeries {
  _VideoSeriesImpl({
    int? id,
    required String creatorId,
    required String title,
    required String description,
    String? coverStorageKey,
    String? languageCode,
    required String category,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         creatorId: creatorId,
         title: title,
         description: description,
         coverStorageKey: coverStorageKey,
         languageCode: languageCode,
         category: category,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [VideoSeries]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VideoSeries copyWith({
    Object? id = _Undefined,
    String? creatorId,
    String? title,
    String? description,
    Object? coverStorageKey = _Undefined,
    Object? languageCode = _Undefined,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VideoSeries(
      id: id is int? ? id : this.id,
      creatorId: creatorId ?? this.creatorId,
      title: title ?? this.title,
      description: description ?? this.description,
      coverStorageKey: coverStorageKey is String?
          ? coverStorageKey
          : this.coverStorageKey,
      languageCode: languageCode is String? ? languageCode : this.languageCode,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class VideoSeriesUpdateTable extends _i1.UpdateTable<VideoSeriesTable> {
  VideoSeriesUpdateTable(super.table);

  _i1.ColumnValue<String, String> creatorId(String value) => _i1.ColumnValue(
    table.creatorId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> coverStorageKey(String? value) =>
      _i1.ColumnValue(
        table.coverStorageKey,
        value,
      );

  _i1.ColumnValue<String, String> languageCode(String? value) =>
      _i1.ColumnValue(
        table.languageCode,
        value,
      );

  _i1.ColumnValue<String, String> category(String value) => _i1.ColumnValue(
    table.category,
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

class VideoSeriesTable extends _i1.Table<int?> {
  VideoSeriesTable({super.tableRelation}) : super(tableName: 'video_series') {
    updateTable = VideoSeriesUpdateTable(this);
    creatorId = _i1.ColumnString(
      'creatorId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    coverStorageKey = _i1.ColumnString(
      'coverStorageKey',
      this,
    );
    languageCode = _i1.ColumnString(
      'languageCode',
      this,
    );
    category = _i1.ColumnString(
      'category',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final VideoSeriesUpdateTable updateTable;

  late final _i1.ColumnString creatorId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnString coverStorageKey;

  late final _i1.ColumnString languageCode;

  late final _i1.ColumnString category;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    creatorId,
    title,
    description,
    coverStorageKey,
    languageCode,
    category,
    createdAt,
    updatedAt,
  ];
}

class VideoSeriesInclude extends _i1.IncludeObject {
  VideoSeriesInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => VideoSeries.t;
}

class VideoSeriesIncludeList extends _i1.IncludeList {
  VideoSeriesIncludeList._({
    _i1.WhereExpressionBuilder<VideoSeriesTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VideoSeries.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => VideoSeries.t;
}

class VideoSeriesRepository {
  const VideoSeriesRepository._();

  /// Returns a list of [VideoSeries]s matching the given query parameters.
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
  Future<List<VideoSeries>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VideoSeriesTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VideoSeriesTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VideoSeriesTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VideoSeries>(
      where: where?.call(VideoSeries.t),
      orderBy: orderBy?.call(VideoSeries.t),
      orderByList: orderByList?.call(VideoSeries.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VideoSeries] matching the given query parameters.
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
  Future<VideoSeries?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VideoSeriesTable>? where,
    int? offset,
    _i1.OrderByBuilder<VideoSeriesTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VideoSeriesTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VideoSeries>(
      where: where?.call(VideoSeries.t),
      orderBy: orderBy?.call(VideoSeries.t),
      orderByList: orderByList?.call(VideoSeries.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VideoSeries] by its [id] or null if no such row exists.
  Future<VideoSeries?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VideoSeries>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VideoSeries]s in the list and returns the inserted rows.
  ///
  /// The returned [VideoSeries]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<VideoSeries>> insert(
    _i1.DatabaseSession session,
    List<VideoSeries> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<VideoSeries>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [VideoSeries] and returns the inserted row.
  ///
  /// The returned [VideoSeries] will have its `id` field set.
  Future<VideoSeries> insertRow(
    _i1.DatabaseSession session,
    VideoSeries row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<VideoSeries>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [VideoSeries]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<VideoSeries>> update(
    _i1.DatabaseSession session,
    List<VideoSeries> rows, {
    _i1.ColumnSelections<VideoSeriesTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<VideoSeries>(
      rows,
      columns: columns?.call(VideoSeries.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VideoSeries]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VideoSeries> updateRow(
    _i1.DatabaseSession session,
    VideoSeries row, {
    _i1.ColumnSelections<VideoSeriesTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<VideoSeries>(
      row,
      columns: columns?.call(VideoSeries.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VideoSeries] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VideoSeries?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<VideoSeriesUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<VideoSeries>(
      id,
      columnValues: columnValues(VideoSeries.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VideoSeries]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<VideoSeries>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<VideoSeriesUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<VideoSeriesTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VideoSeriesTable>? orderBy,
    _i1.OrderByListBuilder<VideoSeriesTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<VideoSeries>(
      columnValues: columnValues(VideoSeries.t.updateTable),
      where: where(VideoSeries.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VideoSeries.t),
      orderByList: orderByList?.call(VideoSeries.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [VideoSeries]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<VideoSeries>> delete(
    _i1.DatabaseSession session,
    List<VideoSeries> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<VideoSeries>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [VideoSeries].
  Future<VideoSeries> deleteRow(
    _i1.DatabaseSession session,
    VideoSeries row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VideoSeries>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<VideoSeries>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VideoSeriesTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<VideoSeries>(
      where: where(VideoSeries.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VideoSeriesTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<VideoSeries>(
      where: where?.call(VideoSeries.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VideoSeries] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VideoSeriesTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VideoSeries>(
      where: where(VideoSeries.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
