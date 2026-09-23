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
import 'asr_job_status.dart' as _i2;

abstract class AsrJob implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AsrJob._({
    this.id,
    required this.videoId,
    required this.requestedLanguageCode,
    this.detectedLanguageCode,
    required this.provider,
    _i2.AsrJobStatus? status,
    this.trackId,
    this.errorMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : status = status ?? _i2.AsrJobStatus.queued,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory AsrJob({
    int? id,
    required int videoId,
    required String requestedLanguageCode,
    String? detectedLanguageCode,
    required String provider,
    _i2.AsrJobStatus? status,
    int? trackId,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AsrJobImpl;

  factory AsrJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return AsrJob(
      id: jsonSerialization['id'] as int?,
      videoId: jsonSerialization['videoId'] as int,
      requestedLanguageCode:
          jsonSerialization['requestedLanguageCode'] as String,
      detectedLanguageCode:
          jsonSerialization['detectedLanguageCode'] as String?,
      provider: jsonSerialization['provider'] as String,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.AsrJobStatus.fromJson((jsonSerialization['status'] as String)),
      trackId: jsonSerialization['trackId'] as int?,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = AsrJobTable();

  static const db = AsrJobRepository._();

  @override
  int? id;

  int videoId;

  String requestedLanguageCode;

  String? detectedLanguageCode;

  String provider;

  _i2.AsrJobStatus status;

  int? trackId;

  String? errorMessage;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AsrJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AsrJob copyWith({
    int? id,
    int? videoId,
    String? requestedLanguageCode,
    String? detectedLanguageCode,
    String? provider,
    _i2.AsrJobStatus? status,
    int? trackId,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AsrJob',
      if (id != null) 'id': id,
      'videoId': videoId,
      'requestedLanguageCode': requestedLanguageCode,
      if (detectedLanguageCode != null)
        'detectedLanguageCode': detectedLanguageCode,
      'provider': provider,
      'status': status.toJson(),
      if (trackId != null) 'trackId': trackId,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AsrJob',
      if (id != null) 'id': id,
      'videoId': videoId,
      'requestedLanguageCode': requestedLanguageCode,
      if (detectedLanguageCode != null)
        'detectedLanguageCode': detectedLanguageCode,
      'provider': provider,
      'status': status.toJson(),
      if (trackId != null) 'trackId': trackId,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AsrJobInclude include() {
    return AsrJobInclude._();
  }

  static AsrJobIncludeList includeList({
    _i1.WhereExpressionBuilder<AsrJobTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AsrJobTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AsrJobTable>? orderByList,
    AsrJobInclude? include,
  }) {
    return AsrJobIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AsrJob.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AsrJob.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AsrJobImpl extends AsrJob {
  _AsrJobImpl({
    int? id,
    required int videoId,
    required String requestedLanguageCode,
    String? detectedLanguageCode,
    required String provider,
    _i2.AsrJobStatus? status,
    int? trackId,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         videoId: videoId,
         requestedLanguageCode: requestedLanguageCode,
         detectedLanguageCode: detectedLanguageCode,
         provider: provider,
         status: status,
         trackId: trackId,
         errorMessage: errorMessage,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AsrJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AsrJob copyWith({
    Object? id = _Undefined,
    int? videoId,
    String? requestedLanguageCode,
    Object? detectedLanguageCode = _Undefined,
    String? provider,
    _i2.AsrJobStatus? status,
    Object? trackId = _Undefined,
    Object? errorMessage = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AsrJob(
      id: id is int? ? id : this.id,
      videoId: videoId ?? this.videoId,
      requestedLanguageCode:
          requestedLanguageCode ?? this.requestedLanguageCode,
      detectedLanguageCode: detectedLanguageCode is String?
          ? detectedLanguageCode
          : this.detectedLanguageCode,
      provider: provider ?? this.provider,
      status: status ?? this.status,
      trackId: trackId is int? ? trackId : this.trackId,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AsrJobUpdateTable extends _i1.UpdateTable<AsrJobTable> {
  AsrJobUpdateTable(super.table);

  _i1.ColumnValue<int, int> videoId(int value) => _i1.ColumnValue(
    table.videoId,
    value,
  );

  _i1.ColumnValue<String, String> requestedLanguageCode(String value) =>
      _i1.ColumnValue(
        table.requestedLanguageCode,
        value,
      );

  _i1.ColumnValue<String, String> detectedLanguageCode(String? value) =>
      _i1.ColumnValue(
        table.detectedLanguageCode,
        value,
      );

  _i1.ColumnValue<String, String> provider(String value) => _i1.ColumnValue(
    table.provider,
    value,
  );

  _i1.ColumnValue<_i2.AsrJobStatus, _i2.AsrJobStatus> status(
    _i2.AsrJobStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> trackId(int? value) => _i1.ColumnValue(
    table.trackId,
    value,
  );

  _i1.ColumnValue<String, String> errorMessage(String? value) =>
      _i1.ColumnValue(
        table.errorMessage,
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

class AsrJobTable extends _i1.Table<int?> {
  AsrJobTable({super.tableRelation}) : super(tableName: 'asr_job') {
    updateTable = AsrJobUpdateTable(this);
    videoId = _i1.ColumnInt(
      'videoId',
      this,
    );
    requestedLanguageCode = _i1.ColumnString(
      'requestedLanguageCode',
      this,
    );
    detectedLanguageCode = _i1.ColumnString(
      'detectedLanguageCode',
      this,
    );
    provider = _i1.ColumnString(
      'provider',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    trackId = _i1.ColumnInt(
      'trackId',
      this,
    );
    errorMessage = _i1.ColumnString(
      'errorMessage',
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

  late final AsrJobUpdateTable updateTable;

  late final _i1.ColumnInt videoId;

  late final _i1.ColumnString requestedLanguageCode;

  late final _i1.ColumnString detectedLanguageCode;

  late final _i1.ColumnString provider;

  late final _i1.ColumnEnum<_i2.AsrJobStatus> status;

  late final _i1.ColumnInt trackId;

  late final _i1.ColumnString errorMessage;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    videoId,
    requestedLanguageCode,
    detectedLanguageCode,
    provider,
    status,
    trackId,
    errorMessage,
    createdAt,
    updatedAt,
  ];
}

class AsrJobInclude extends _i1.IncludeObject {
  AsrJobInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AsrJob.t;
}

class AsrJobIncludeList extends _i1.IncludeList {
  AsrJobIncludeList._({
    _i1.WhereExpressionBuilder<AsrJobTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AsrJob.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AsrJob.t;
}

class AsrJobRepository {
  const AsrJobRepository._();

  /// Returns a list of [AsrJob]s matching the given query parameters.
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
  Future<List<AsrJob>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AsrJobTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AsrJobTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AsrJobTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AsrJob>(
      where: where?.call(AsrJob.t),
      orderBy: orderBy?.call(AsrJob.t),
      orderByList: orderByList?.call(AsrJob.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AsrJob] matching the given query parameters.
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
  Future<AsrJob?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AsrJobTable>? where,
    int? offset,
    _i1.OrderByBuilder<AsrJobTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AsrJobTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AsrJob>(
      where: where?.call(AsrJob.t),
      orderBy: orderBy?.call(AsrJob.t),
      orderByList: orderByList?.call(AsrJob.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AsrJob] by its [id] or null if no such row exists.
  Future<AsrJob?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AsrJob>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AsrJob]s in the list and returns the inserted rows.
  ///
  /// The returned [AsrJob]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AsrJob>> insert(
    _i1.DatabaseSession session,
    List<AsrJob> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AsrJob>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AsrJob] and returns the inserted row.
  ///
  /// The returned [AsrJob] will have its `id` field set.
  Future<AsrJob> insertRow(
    _i1.DatabaseSession session,
    AsrJob row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AsrJob>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AsrJob]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AsrJob>> update(
    _i1.DatabaseSession session,
    List<AsrJob> rows, {
    _i1.ColumnSelections<AsrJobTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AsrJob>(
      rows,
      columns: columns?.call(AsrJob.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AsrJob]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AsrJob> updateRow(
    _i1.DatabaseSession session,
    AsrJob row, {
    _i1.ColumnSelections<AsrJobTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AsrJob>(
      row,
      columns: columns?.call(AsrJob.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AsrJob] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AsrJob?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AsrJobUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AsrJob>(
      id,
      columnValues: columnValues(AsrJob.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AsrJob]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AsrJob>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AsrJobUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AsrJobTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AsrJobTable>? orderBy,
    _i1.OrderByListBuilder<AsrJobTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AsrJob>(
      columnValues: columnValues(AsrJob.t.updateTable),
      where: where(AsrJob.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AsrJob.t),
      orderByList: orderByList?.call(AsrJob.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AsrJob]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AsrJob>> delete(
    _i1.DatabaseSession session,
    List<AsrJob> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AsrJob>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AsrJob].
  Future<AsrJob> deleteRow(
    _i1.DatabaseSession session,
    AsrJob row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AsrJob>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AsrJob>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AsrJobTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AsrJob>(
      where: where(AsrJob.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AsrJobTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AsrJob>(
      where: where?.call(AsrJob.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AsrJob] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AsrJobTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AsrJob>(
      where: where(AsrJob.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
