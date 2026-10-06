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

abstract class VideoFavorite
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  VideoFavorite._({
    this.id,
    required this.userId,
    required this.videoId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory VideoFavorite({
    int? id,
    required String userId,
    required int videoId,
    DateTime? createdAt,
  }) = _VideoFavoriteImpl;

  factory VideoFavorite.fromJson(Map<String, dynamic> jsonSerialization) {
    return VideoFavorite(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      videoId: jsonSerialization['videoId'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = VideoFavoriteTable();

  static const db = VideoFavoriteRepository._();

  @override
  int? id;

  String userId;

  int videoId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [VideoFavorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VideoFavorite copyWith({
    int? id,
    String? userId,
    int? videoId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VideoFavorite',
      if (id != null) 'id': id,
      'userId': userId,
      'videoId': videoId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VideoFavorite',
      if (id != null) 'id': id,
      'userId': userId,
      'videoId': videoId,
      'createdAt': createdAt.toJson(),
    };
  }

  static VideoFavoriteInclude include() {
    return VideoFavoriteInclude._();
  }

  static VideoFavoriteIncludeList includeList({
    _i1.WhereExpressionBuilder<VideoFavoriteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VideoFavoriteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VideoFavoriteTable>? orderByList,
    VideoFavoriteInclude? include,
  }) {
    return VideoFavoriteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VideoFavorite.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(VideoFavorite.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VideoFavoriteImpl extends VideoFavorite {
  _VideoFavoriteImpl({
    int? id,
    required String userId,
    required int videoId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         videoId: videoId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [VideoFavorite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VideoFavorite copyWith({
    Object? id = _Undefined,
    String? userId,
    int? videoId,
    DateTime? createdAt,
  }) {
    return VideoFavorite(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      videoId: videoId ?? this.videoId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class VideoFavoriteUpdateTable extends _i1.UpdateTable<VideoFavoriteTable> {
  VideoFavoriteUpdateTable(super.table);

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> videoId(int value) => _i1.ColumnValue(
    table.videoId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class VideoFavoriteTable extends _i1.Table<int?> {
  VideoFavoriteTable({super.tableRelation})
    : super(tableName: 'video_favorite') {
    updateTable = VideoFavoriteUpdateTable(this);
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    videoId = _i1.ColumnInt(
      'videoId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final VideoFavoriteUpdateTable updateTable;

  late final _i1.ColumnString userId;

  late final _i1.ColumnInt videoId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    videoId,
    createdAt,
  ];
}

class VideoFavoriteInclude extends _i1.IncludeObject {
  VideoFavoriteInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => VideoFavorite.t;
}

class VideoFavoriteIncludeList extends _i1.IncludeList {
  VideoFavoriteIncludeList._({
    _i1.WhereExpressionBuilder<VideoFavoriteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VideoFavorite.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => VideoFavorite.t;
}

class VideoFavoriteRepository {
  const VideoFavoriteRepository._();

  /// Returns a list of [VideoFavorite]s matching the given query parameters.
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
  Future<List<VideoFavorite>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VideoFavoriteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VideoFavoriteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VideoFavoriteTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VideoFavorite>(
      where: where?.call(VideoFavorite.t),
      orderBy: orderBy?.call(VideoFavorite.t),
      orderByList: orderByList?.call(VideoFavorite.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VideoFavorite] matching the given query parameters.
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
  Future<VideoFavorite?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VideoFavoriteTable>? where,
    int? offset,
    _i1.OrderByBuilder<VideoFavoriteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VideoFavoriteTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VideoFavorite>(
      where: where?.call(VideoFavorite.t),
      orderBy: orderBy?.call(VideoFavorite.t),
      orderByList: orderByList?.call(VideoFavorite.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VideoFavorite] by its [id] or null if no such row exists.
  Future<VideoFavorite?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VideoFavorite>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VideoFavorite]s in the list and returns the inserted rows.
  ///
  /// The returned [VideoFavorite]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<VideoFavorite>> insert(
    _i1.DatabaseSession session,
    List<VideoFavorite> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<VideoFavorite>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [VideoFavorite] and returns the inserted row.
  ///
  /// The returned [VideoFavorite] will have its `id` field set.
  Future<VideoFavorite> insertRow(
    _i1.DatabaseSession session,
    VideoFavorite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<VideoFavorite>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [VideoFavorite]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<VideoFavorite>> update(
    _i1.DatabaseSession session,
    List<VideoFavorite> rows, {
    _i1.ColumnSelections<VideoFavoriteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<VideoFavorite>(
      rows,
      columns: columns?.call(VideoFavorite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VideoFavorite]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VideoFavorite> updateRow(
    _i1.DatabaseSession session,
    VideoFavorite row, {
    _i1.ColumnSelections<VideoFavoriteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<VideoFavorite>(
      row,
      columns: columns?.call(VideoFavorite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VideoFavorite] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VideoFavorite?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<VideoFavoriteUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<VideoFavorite>(
      id,
      columnValues: columnValues(VideoFavorite.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VideoFavorite]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<VideoFavorite>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<VideoFavoriteUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<VideoFavoriteTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VideoFavoriteTable>? orderBy,
    _i1.OrderByListBuilder<VideoFavoriteTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<VideoFavorite>(
      columnValues: columnValues(VideoFavorite.t.updateTable),
      where: where(VideoFavorite.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VideoFavorite.t),
      orderByList: orderByList?.call(VideoFavorite.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [VideoFavorite]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<VideoFavorite>> delete(
    _i1.DatabaseSession session,
    List<VideoFavorite> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<VideoFavorite>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [VideoFavorite].
  Future<VideoFavorite> deleteRow(
    _i1.DatabaseSession session,
    VideoFavorite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VideoFavorite>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<VideoFavorite>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VideoFavoriteTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<VideoFavorite>(
      where: where(VideoFavorite.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VideoFavoriteTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<VideoFavorite>(
      where: where?.call(VideoFavorite.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VideoFavorite] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VideoFavoriteTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VideoFavorite>(
      where: where(VideoFavorite.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
