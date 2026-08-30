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
import 'video_status.dart' as _i2;
import 'package:shipin_backend_server/src/generated/protocol.dart' as _i3;

abstract class Video implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Video._({
    this.id,
    required this.authorId,
    required this.authorName,
    required this.title,
    required this.description,
    required this.category,
    required this.tags,
    required this.videoStorageKey,
    this.coverStorageKey,
    required this.durationSeconds,
    int? viewCount,
    int? likeCount,
    int? favoriteCount,
    int? commentCount,
    _i2.VideoStatus? status,
    this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
  }) : viewCount = viewCount ?? 0,
       likeCount = likeCount ?? 0,
       favoriteCount = favoriteCount ?? 0,
       commentCount = commentCount ?? 0,
       status = status ?? _i2.VideoStatus.uploading;

  factory Video({
    int? id,
    required String authorId,
    required String authorName,
    required String title,
    required String description,
    required String category,
    required List<String> tags,
    required String videoStorageKey,
    String? coverStorageKey,
    required int durationSeconds,
    int? viewCount,
    int? likeCount,
    int? favoriteCount,
    int? commentCount,
    _i2.VideoStatus? status,
    DateTime? publishedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _VideoImpl;

  factory Video.fromJson(Map<String, dynamic> jsonSerialization) {
    return Video(
      id: jsonSerialization['id'] as int?,
      authorId: jsonSerialization['authorId'] as String,
      authorName: jsonSerialization['authorName'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      category: jsonSerialization['category'] as String,
      tags: _i3.Protocol().deserialize<List<String>>(jsonSerialization['tags']),
      videoStorageKey: jsonSerialization['videoStorageKey'] as String,
      coverStorageKey: jsonSerialization['coverStorageKey'] as String?,
      durationSeconds: jsonSerialization['durationSeconds'] as int,
      viewCount: jsonSerialization['viewCount'] as int?,
      likeCount: jsonSerialization['likeCount'] as int?,
      favoriteCount: jsonSerialization['favoriteCount'] as int?,
      commentCount: jsonSerialization['commentCount'] as int?,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.VideoStatus.fromJson((jsonSerialization['status'] as String)),
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = VideoTable();

  static const db = VideoRepository._();

  @override
  int? id;

  String authorId;

  String authorName;

  String title;

  String description;

  String category;

  List<String> tags;

  String videoStorageKey;

  String? coverStorageKey;

  int durationSeconds;

  int viewCount;

  int likeCount;

  int favoriteCount;

  int commentCount;

  _i2.VideoStatus status;

  DateTime? publishedAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Video]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Video copyWith({
    int? id,
    String? authorId,
    String? authorName,
    String? title,
    String? description,
    String? category,
    List<String>? tags,
    String? videoStorageKey,
    String? coverStorageKey,
    int? durationSeconds,
    int? viewCount,
    int? likeCount,
    int? favoriteCount,
    int? commentCount,
    _i2.VideoStatus? status,
    DateTime? publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Video',
      if (id != null) 'id': id,
      'authorId': authorId,
      'authorName': authorName,
      'title': title,
      'description': description,
      'category': category,
      'tags': tags.toJson(),
      'videoStorageKey': videoStorageKey,
      if (coverStorageKey != null) 'coverStorageKey': coverStorageKey,
      'durationSeconds': durationSeconds,
      'viewCount': viewCount,
      'likeCount': likeCount,
      'favoriteCount': favoriteCount,
      'commentCount': commentCount,
      'status': status.toJson(),
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Video',
      if (id != null) 'id': id,
      'authorId': authorId,
      'authorName': authorName,
      'title': title,
      'description': description,
      'category': category,
      'tags': tags.toJson(),
      'videoStorageKey': videoStorageKey,
      if (coverStorageKey != null) 'coverStorageKey': coverStorageKey,
      'durationSeconds': durationSeconds,
      'viewCount': viewCount,
      'likeCount': likeCount,
      'favoriteCount': favoriteCount,
      'commentCount': commentCount,
      'status': status.toJson(),
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static VideoInclude include() {
    return VideoInclude._();
  }

  static VideoIncludeList includeList({
    _i1.WhereExpressionBuilder<VideoTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VideoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VideoTable>? orderByList,
    VideoInclude? include,
  }) {
    return VideoIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Video.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Video.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VideoImpl extends Video {
  _VideoImpl({
    int? id,
    required String authorId,
    required String authorName,
    required String title,
    required String description,
    required String category,
    required List<String> tags,
    required String videoStorageKey,
    String? coverStorageKey,
    required int durationSeconds,
    int? viewCount,
    int? likeCount,
    int? favoriteCount,
    int? commentCount,
    _i2.VideoStatus? status,
    DateTime? publishedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         authorId: authorId,
         authorName: authorName,
         title: title,
         description: description,
         category: category,
         tags: tags,
         videoStorageKey: videoStorageKey,
         coverStorageKey: coverStorageKey,
         durationSeconds: durationSeconds,
         viewCount: viewCount,
         likeCount: likeCount,
         favoriteCount: favoriteCount,
         commentCount: commentCount,
         status: status,
         publishedAt: publishedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Video]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Video copyWith({
    Object? id = _Undefined,
    String? authorId,
    String? authorName,
    String? title,
    String? description,
    String? category,
    List<String>? tags,
    String? videoStorageKey,
    Object? coverStorageKey = _Undefined,
    int? durationSeconds,
    int? viewCount,
    int? likeCount,
    int? favoriteCount,
    int? commentCount,
    _i2.VideoStatus? status,
    Object? publishedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Video(
      id: id is int? ? id : this.id,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      tags: tags ?? this.tags.map((e0) => e0).toList(),
      videoStorageKey: videoStorageKey ?? this.videoStorageKey,
      coverStorageKey: coverStorageKey is String?
          ? coverStorageKey
          : this.coverStorageKey,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      viewCount: viewCount ?? this.viewCount,
      likeCount: likeCount ?? this.likeCount,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      commentCount: commentCount ?? this.commentCount,
      status: status ?? this.status,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class VideoUpdateTable extends _i1.UpdateTable<VideoTable> {
  VideoUpdateTable(super.table);

  _i1.ColumnValue<String, String> authorId(String value) => _i1.ColumnValue(
    table.authorId,
    value,
  );

  _i1.ColumnValue<String, String> authorName(String value) => _i1.ColumnValue(
    table.authorName,
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

  _i1.ColumnValue<String, String> category(String value) => _i1.ColumnValue(
    table.category,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> tags(List<String> value) =>
      _i1.ColumnValue(
        table.tags,
        value,
      );

  _i1.ColumnValue<String, String> videoStorageKey(String value) =>
      _i1.ColumnValue(
        table.videoStorageKey,
        value,
      );

  _i1.ColumnValue<String, String> coverStorageKey(String? value) =>
      _i1.ColumnValue(
        table.coverStorageKey,
        value,
      );

  _i1.ColumnValue<int, int> durationSeconds(int value) => _i1.ColumnValue(
    table.durationSeconds,
    value,
  );

  _i1.ColumnValue<int, int> viewCount(int value) => _i1.ColumnValue(
    table.viewCount,
    value,
  );

  _i1.ColumnValue<int, int> likeCount(int value) => _i1.ColumnValue(
    table.likeCount,
    value,
  );

  _i1.ColumnValue<int, int> favoriteCount(int value) => _i1.ColumnValue(
    table.favoriteCount,
    value,
  );

  _i1.ColumnValue<int, int> commentCount(int value) => _i1.ColumnValue(
    table.commentCount,
    value,
  );

  _i1.ColumnValue<_i2.VideoStatus, _i2.VideoStatus> status(
    _i2.VideoStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> publishedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.publishedAt,
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

class VideoTable extends _i1.Table<int?> {
  VideoTable({super.tableRelation}) : super(tableName: 'video') {
    updateTable = VideoUpdateTable(this);
    authorId = _i1.ColumnString(
      'authorId',
      this,
    );
    authorName = _i1.ColumnString(
      'authorName',
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
    category = _i1.ColumnString(
      'category',
      this,
    );
    tags = _i1.ColumnSerializable<List<String>>(
      'tags',
      this,
    );
    videoStorageKey = _i1.ColumnString(
      'videoStorageKey',
      this,
    );
    coverStorageKey = _i1.ColumnString(
      'coverStorageKey',
      this,
    );
    durationSeconds = _i1.ColumnInt(
      'durationSeconds',
      this,
    );
    viewCount = _i1.ColumnInt(
      'viewCount',
      this,
      hasDefault: true,
    );
    likeCount = _i1.ColumnInt(
      'likeCount',
      this,
      hasDefault: true,
    );
    favoriteCount = _i1.ColumnInt(
      'favoriteCount',
      this,
      hasDefault: true,
    );
    commentCount = _i1.ColumnInt(
      'commentCount',
      this,
      hasDefault: true,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    publishedAt = _i1.ColumnDateTime(
      'publishedAt',
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

  late final VideoUpdateTable updateTable;

  late final _i1.ColumnString authorId;

  late final _i1.ColumnString authorName;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnString category;

  late final _i1.ColumnSerializable<List<String>> tags;

  late final _i1.ColumnString videoStorageKey;

  late final _i1.ColumnString coverStorageKey;

  late final _i1.ColumnInt durationSeconds;

  late final _i1.ColumnInt viewCount;

  late final _i1.ColumnInt likeCount;

  late final _i1.ColumnInt favoriteCount;

  late final _i1.ColumnInt commentCount;

  late final _i1.ColumnEnum<_i2.VideoStatus> status;

  late final _i1.ColumnDateTime publishedAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    authorId,
    authorName,
    title,
    description,
    category,
    tags,
    videoStorageKey,
    coverStorageKey,
    durationSeconds,
    viewCount,
    likeCount,
    favoriteCount,
    commentCount,
    status,
    publishedAt,
    createdAt,
    updatedAt,
  ];
}

class VideoInclude extends _i1.IncludeObject {
  VideoInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Video.t;
}

class VideoIncludeList extends _i1.IncludeList {
  VideoIncludeList._({
    _i1.WhereExpressionBuilder<VideoTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Video.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Video.t;
}

class VideoRepository {
  const VideoRepository._();

  /// Returns a list of [Video]s matching the given query parameters.
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
  Future<List<Video>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VideoTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VideoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VideoTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Video>(
      where: where?.call(Video.t),
      orderBy: orderBy?.call(Video.t),
      orderByList: orderByList?.call(Video.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Video] matching the given query parameters.
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
  Future<Video?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VideoTable>? where,
    int? offset,
    _i1.OrderByBuilder<VideoTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VideoTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Video>(
      where: where?.call(Video.t),
      orderBy: orderBy?.call(Video.t),
      orderByList: orderByList?.call(Video.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Video] by its [id] or null if no such row exists.
  Future<Video?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Video>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Video]s in the list and returns the inserted rows.
  ///
  /// The returned [Video]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Video>> insert(
    _i1.DatabaseSession session,
    List<Video> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Video>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Video] and returns the inserted row.
  ///
  /// The returned [Video] will have its `id` field set.
  Future<Video> insertRow(
    _i1.DatabaseSession session,
    Video row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Video>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Video]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Video>> update(
    _i1.DatabaseSession session,
    List<Video> rows, {
    _i1.ColumnSelections<VideoTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Video>(
      rows,
      columns: columns?.call(Video.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Video]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Video> updateRow(
    _i1.DatabaseSession session,
    Video row, {
    _i1.ColumnSelections<VideoTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Video>(
      row,
      columns: columns?.call(Video.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Video] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Video?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<VideoUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Video>(
      id,
      columnValues: columnValues(Video.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Video]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Video>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<VideoUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<VideoTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VideoTable>? orderBy,
    _i1.OrderByListBuilder<VideoTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Video>(
      columnValues: columnValues(Video.t.updateTable),
      where: where(Video.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Video.t),
      orderByList: orderByList?.call(Video.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Video]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Video>> delete(
    _i1.DatabaseSession session,
    List<Video> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Video>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Video].
  Future<Video> deleteRow(
    _i1.DatabaseSession session,
    Video row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Video>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Video>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VideoTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Video>(
      where: where(Video.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VideoTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Video>(
      where: where?.call(Video.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Video] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VideoTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Video>(
      where: where(Video.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
