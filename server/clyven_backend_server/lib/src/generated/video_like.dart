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

abstract class VideoLike
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  VideoLike._({
    this.id,
    required this.userId,
    required this.videoId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory VideoLike({
    int? id,
    required String userId,
    required int videoId,
    DateTime? createdAt,
  }) = _VideoLikeImpl;

  factory VideoLike.fromJson(Map<String, dynamic> jsonSerialization) {
    return VideoLike(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      videoId: jsonSerialization['videoId'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = VideoLikeTable();

  static const db = VideoLikeRepository._();

  @override
  int? id;

  String userId;

  int videoId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [VideoLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VideoLike copyWith({
    int? id,
    String? userId,
    int? videoId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VideoLike',
      if (id != null) 'id': id,
      'userId': userId,
      'videoId': videoId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VideoLike',
      if (id != null) 'id': id,
      'userId': userId,
      'videoId': videoId,
      'createdAt': createdAt.toJson(),
    };
  }

  static VideoLikeInclude include() {
    return VideoLikeInclude._();
  }

  static VideoLikeIncludeList includeList({
    _i1.WhereExpressionBuilder<VideoLikeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VideoLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VideoLikeTable>? orderByList,
    VideoLikeInclude? include,
  }) {
    return VideoLikeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VideoLike.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(VideoLike.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VideoLikeImpl extends VideoLike {
  _VideoLikeImpl({
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

  /// Returns a shallow copy of this [VideoLike]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VideoLike copyWith({
    Object? id = _Undefined,
    String? userId,
    int? videoId,
    DateTime? createdAt,
  }) {
    return VideoLike(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      videoId: videoId ?? this.videoId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class VideoLikeUpdateTable extends _i1.UpdateTable<VideoLikeTable> {
  VideoLikeUpdateTable(super.table);

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

class VideoLikeTable extends _i1.Table<int?> {
  VideoLikeTable({super.tableRelation}) : super(tableName: 'video_like') {
    updateTable = VideoLikeUpdateTable(this);
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

  late final VideoLikeUpdateTable updateTable;

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

class VideoLikeInclude extends _i1.IncludeObject {
  VideoLikeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => VideoLike.t;
}

class VideoLikeIncludeList extends _i1.IncludeList {
  VideoLikeIncludeList._({
    _i1.WhereExpressionBuilder<VideoLikeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VideoLike.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => VideoLike.t;
}

class VideoLikeRepository {
  const VideoLikeRepository._();

  /// Returns a list of [VideoLike]s matching the given query parameters.
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
  Future<List<VideoLike>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VideoLikeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VideoLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VideoLikeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VideoLike>(
      where: where?.call(VideoLike.t),
      orderBy: orderBy?.call(VideoLike.t),
      orderByList: orderByList?.call(VideoLike.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VideoLike] matching the given query parameters.
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
  Future<VideoLike?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VideoLikeTable>? where,
    int? offset,
    _i1.OrderByBuilder<VideoLikeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VideoLikeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VideoLike>(
      where: where?.call(VideoLike.t),
      orderBy: orderBy?.call(VideoLike.t),
      orderByList: orderByList?.call(VideoLike.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VideoLike] by its [id] or null if no such row exists.
  Future<VideoLike?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VideoLike>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VideoLike]s in the list and returns the inserted rows.
  ///
  /// The returned [VideoLike]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<VideoLike>> insert(
    _i1.DatabaseSession session,
    List<VideoLike> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<VideoLike>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [VideoLike] and returns the inserted row.
  ///
  /// The returned [VideoLike] will have its `id` field set.
  Future<VideoLike> insertRow(
    _i1.DatabaseSession session,
    VideoLike row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<VideoLike>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [VideoLike]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<VideoLike>> update(
    _i1.DatabaseSession session,
    List<VideoLike> rows, {
    _i1.ColumnSelections<VideoLikeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<VideoLike>(
      rows,
      columns: columns?.call(VideoLike.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VideoLike]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VideoLike> updateRow(
    _i1.DatabaseSession session,
    VideoLike row, {
    _i1.ColumnSelections<VideoLikeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<VideoLike>(
      row,
      columns: columns?.call(VideoLike.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VideoLike] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VideoLike?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<VideoLikeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<VideoLike>(
      id,
      columnValues: columnValues(VideoLike.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VideoLike]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<VideoLike>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<VideoLikeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<VideoLikeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VideoLikeTable>? orderBy,
    _i1.OrderByListBuilder<VideoLikeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<VideoLike>(
      columnValues: columnValues(VideoLike.t.updateTable),
      where: where(VideoLike.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VideoLike.t),
      orderByList: orderByList?.call(VideoLike.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [VideoLike]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<VideoLike>> delete(
    _i1.DatabaseSession session,
    List<VideoLike> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<VideoLike>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [VideoLike].
  Future<VideoLike> deleteRow(
    _i1.DatabaseSession session,
    VideoLike row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VideoLike>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<VideoLike>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VideoLikeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<VideoLike>(
      where: where(VideoLike.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VideoLikeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<VideoLike>(
      where: where?.call(VideoLike.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VideoLike] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VideoLikeTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VideoLike>(
      where: where(VideoLike.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
