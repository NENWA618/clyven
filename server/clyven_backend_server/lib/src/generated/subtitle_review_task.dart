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
import 'subtitle_review_task_status.dart' as _i2;

abstract class SubtitleReviewTask
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SubtitleReviewTask._({
    this.id,
    required this.videoId,
    required this.trackId,
    required this.languageCode,
    this.scriptCode,
    _i2.SubtitleReviewTaskStatus? status,
    int? priority,
    this.assignedUserId,
    this.assignedDisplayName,
    this.editedByUserId,
    this.editedByDisplayName,
    this.reviewedByUserId,
    this.reviewedByDisplayName,
    this.approvedByUserId,
    this.approvedByDisplayName,
    this.claimedAt,
    this.startedAt,
    this.submittedAt,
    this.reviewedAt,
    this.completedAt,
    this.publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : status = status ?? _i2.SubtitleReviewTaskStatus.readyForReview,
       priority = priority ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubtitleReviewTask({
    int? id,
    required int videoId,
    required int trackId,
    required String languageCode,
    String? scriptCode,
    _i2.SubtitleReviewTaskStatus? status,
    int? priority,
    String? assignedUserId,
    String? assignedDisplayName,
    String? editedByUserId,
    String? editedByDisplayName,
    String? reviewedByUserId,
    String? reviewedByDisplayName,
    String? approvedByUserId,
    String? approvedByDisplayName,
    DateTime? claimedAt,
    DateTime? startedAt,
    DateTime? submittedAt,
    DateTime? reviewedAt,
    DateTime? completedAt,
    DateTime? publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubtitleReviewTaskImpl;

  factory SubtitleReviewTask.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtitleReviewTask(
      id: jsonSerialization['id'] as int?,
      videoId: jsonSerialization['videoId'] as int,
      trackId: jsonSerialization['trackId'] as int,
      languageCode: jsonSerialization['languageCode'] as String,
      scriptCode: jsonSerialization['scriptCode'] as String?,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.SubtitleReviewTaskStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      priority: jsonSerialization['priority'] as int?,
      assignedUserId: jsonSerialization['assignedUserId'] as String?,
      assignedDisplayName: jsonSerialization['assignedDisplayName'] as String?,
      editedByUserId: jsonSerialization['editedByUserId'] as String?,
      editedByDisplayName: jsonSerialization['editedByDisplayName'] as String?,
      reviewedByUserId: jsonSerialization['reviewedByUserId'] as String?,
      reviewedByDisplayName:
          jsonSerialization['reviewedByDisplayName'] as String?,
      approvedByUserId: jsonSerialization['approvedByUserId'] as String?,
      approvedByDisplayName:
          jsonSerialization['approvedByDisplayName'] as String?,
      claimedAt: jsonSerialization['claimedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['claimedAt']),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      submittedAt: jsonSerialization['submittedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['submittedAt'],
            ),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SubtitleReviewTaskTable();

  static const db = SubtitleReviewTaskRepository._();

  @override
  int? id;

  int videoId;

  int trackId;

  String languageCode;

  String? scriptCode;

  _i2.SubtitleReviewTaskStatus status;

  int priority;

  String? assignedUserId;

  String? assignedDisplayName;

  String? editedByUserId;

  String? editedByDisplayName;

  String? reviewedByUserId;

  String? reviewedByDisplayName;

  String? approvedByUserId;

  String? approvedByDisplayName;

  DateTime? claimedAt;

  DateTime? startedAt;

  DateTime? submittedAt;

  DateTime? reviewedAt;

  DateTime? completedAt;

  DateTime? publishedAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubtitleReviewTask]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleReviewTask copyWith({
    int? id,
    int? videoId,
    int? trackId,
    String? languageCode,
    String? scriptCode,
    _i2.SubtitleReviewTaskStatus? status,
    int? priority,
    String? assignedUserId,
    String? assignedDisplayName,
    String? editedByUserId,
    String? editedByDisplayName,
    String? reviewedByUserId,
    String? reviewedByDisplayName,
    String? approvedByUserId,
    String? approvedByDisplayName,
    DateTime? claimedAt,
    DateTime? startedAt,
    DateTime? submittedAt,
    DateTime? reviewedAt,
    DateTime? completedAt,
    DateTime? publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleReviewTask',
      if (id != null) 'id': id,
      'videoId': videoId,
      'trackId': trackId,
      'languageCode': languageCode,
      if (scriptCode != null) 'scriptCode': scriptCode,
      'status': status.toJson(),
      'priority': priority,
      if (assignedUserId != null) 'assignedUserId': assignedUserId,
      if (assignedDisplayName != null)
        'assignedDisplayName': assignedDisplayName,
      if (editedByUserId != null) 'editedByUserId': editedByUserId,
      if (editedByDisplayName != null)
        'editedByDisplayName': editedByDisplayName,
      if (reviewedByUserId != null) 'reviewedByUserId': reviewedByUserId,
      if (reviewedByDisplayName != null)
        'reviewedByDisplayName': reviewedByDisplayName,
      if (approvedByUserId != null) 'approvedByUserId': approvedByUserId,
      if (approvedByDisplayName != null)
        'approvedByDisplayName': approvedByDisplayName,
      if (claimedAt != null) 'claimedAt': claimedAt?.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubtitleReviewTask',
      if (id != null) 'id': id,
      'videoId': videoId,
      'trackId': trackId,
      'languageCode': languageCode,
      if (scriptCode != null) 'scriptCode': scriptCode,
      'status': status.toJson(),
      'priority': priority,
      if (assignedUserId != null) 'assignedUserId': assignedUserId,
      if (assignedDisplayName != null)
        'assignedDisplayName': assignedDisplayName,
      if (editedByUserId != null) 'editedByUserId': editedByUserId,
      if (editedByDisplayName != null)
        'editedByDisplayName': editedByDisplayName,
      if (reviewedByUserId != null) 'reviewedByUserId': reviewedByUserId,
      if (reviewedByDisplayName != null)
        'reviewedByDisplayName': reviewedByDisplayName,
      if (approvedByUserId != null) 'approvedByUserId': approvedByUserId,
      if (approvedByDisplayName != null)
        'approvedByDisplayName': approvedByDisplayName,
      if (claimedAt != null) 'claimedAt': claimedAt?.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SubtitleReviewTaskInclude include() {
    return SubtitleReviewTaskInclude._();
  }

  static SubtitleReviewTaskIncludeList includeList({
    _i1.WhereExpressionBuilder<SubtitleReviewTaskTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleReviewTaskTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleReviewTaskTable>? orderByList,
    SubtitleReviewTaskInclude? include,
  }) {
    return SubtitleReviewTaskIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitleReviewTask.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SubtitleReviewTask.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtitleReviewTaskImpl extends SubtitleReviewTask {
  _SubtitleReviewTaskImpl({
    int? id,
    required int videoId,
    required int trackId,
    required String languageCode,
    String? scriptCode,
    _i2.SubtitleReviewTaskStatus? status,
    int? priority,
    String? assignedUserId,
    String? assignedDisplayName,
    String? editedByUserId,
    String? editedByDisplayName,
    String? reviewedByUserId,
    String? reviewedByDisplayName,
    String? approvedByUserId,
    String? approvedByDisplayName,
    DateTime? claimedAt,
    DateTime? startedAt,
    DateTime? submittedAt,
    DateTime? reviewedAt,
    DateTime? completedAt,
    DateTime? publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         videoId: videoId,
         trackId: trackId,
         languageCode: languageCode,
         scriptCode: scriptCode,
         status: status,
         priority: priority,
         assignedUserId: assignedUserId,
         assignedDisplayName: assignedDisplayName,
         editedByUserId: editedByUserId,
         editedByDisplayName: editedByDisplayName,
         reviewedByUserId: reviewedByUserId,
         reviewedByDisplayName: reviewedByDisplayName,
         approvedByUserId: approvedByUserId,
         approvedByDisplayName: approvedByDisplayName,
         claimedAt: claimedAt,
         startedAt: startedAt,
         submittedAt: submittedAt,
         reviewedAt: reviewedAt,
         completedAt: completedAt,
         publishedAt: publishedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubtitleReviewTask]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleReviewTask copyWith({
    Object? id = _Undefined,
    int? videoId,
    int? trackId,
    String? languageCode,
    Object? scriptCode = _Undefined,
    _i2.SubtitleReviewTaskStatus? status,
    int? priority,
    Object? assignedUserId = _Undefined,
    Object? assignedDisplayName = _Undefined,
    Object? editedByUserId = _Undefined,
    Object? editedByDisplayName = _Undefined,
    Object? reviewedByUserId = _Undefined,
    Object? reviewedByDisplayName = _Undefined,
    Object? approvedByUserId = _Undefined,
    Object? approvedByDisplayName = _Undefined,
    Object? claimedAt = _Undefined,
    Object? startedAt = _Undefined,
    Object? submittedAt = _Undefined,
    Object? reviewedAt = _Undefined,
    Object? completedAt = _Undefined,
    Object? publishedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubtitleReviewTask(
      id: id is int? ? id : this.id,
      videoId: videoId ?? this.videoId,
      trackId: trackId ?? this.trackId,
      languageCode: languageCode ?? this.languageCode,
      scriptCode: scriptCode is String? ? scriptCode : this.scriptCode,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assignedUserId: assignedUserId is String?
          ? assignedUserId
          : this.assignedUserId,
      assignedDisplayName: assignedDisplayName is String?
          ? assignedDisplayName
          : this.assignedDisplayName,
      editedByUserId: editedByUserId is String?
          ? editedByUserId
          : this.editedByUserId,
      editedByDisplayName: editedByDisplayName is String?
          ? editedByDisplayName
          : this.editedByDisplayName,
      reviewedByUserId: reviewedByUserId is String?
          ? reviewedByUserId
          : this.reviewedByUserId,
      reviewedByDisplayName: reviewedByDisplayName is String?
          ? reviewedByDisplayName
          : this.reviewedByDisplayName,
      approvedByUserId: approvedByUserId is String?
          ? approvedByUserId
          : this.approvedByUserId,
      approvedByDisplayName: approvedByDisplayName is String?
          ? approvedByDisplayName
          : this.approvedByDisplayName,
      claimedAt: claimedAt is DateTime? ? claimedAt : this.claimedAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      submittedAt: submittedAt is DateTime? ? submittedAt : this.submittedAt,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SubtitleReviewTaskUpdateTable
    extends _i1.UpdateTable<SubtitleReviewTaskTable> {
  SubtitleReviewTaskUpdateTable(super.table);

  _i1.ColumnValue<int, int> videoId(int value) => _i1.ColumnValue(
    table.videoId,
    value,
  );

  _i1.ColumnValue<int, int> trackId(int value) => _i1.ColumnValue(
    table.trackId,
    value,
  );

  _i1.ColumnValue<String, String> languageCode(String value) => _i1.ColumnValue(
    table.languageCode,
    value,
  );

  _i1.ColumnValue<String, String> scriptCode(String? value) => _i1.ColumnValue(
    table.scriptCode,
    value,
  );

  _i1.ColumnValue<_i2.SubtitleReviewTaskStatus, _i2.SubtitleReviewTaskStatus>
  status(_i2.SubtitleReviewTaskStatus value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> priority(int value) => _i1.ColumnValue(
    table.priority,
    value,
  );

  _i1.ColumnValue<String, String> assignedUserId(String? value) =>
      _i1.ColumnValue(
        table.assignedUserId,
        value,
      );

  _i1.ColumnValue<String, String> assignedDisplayName(String? value) =>
      _i1.ColumnValue(
        table.assignedDisplayName,
        value,
      );

  _i1.ColumnValue<String, String> editedByUserId(String? value) =>
      _i1.ColumnValue(
        table.editedByUserId,
        value,
      );

  _i1.ColumnValue<String, String> editedByDisplayName(String? value) =>
      _i1.ColumnValue(
        table.editedByDisplayName,
        value,
      );

  _i1.ColumnValue<String, String> reviewedByUserId(String? value) =>
      _i1.ColumnValue(
        table.reviewedByUserId,
        value,
      );

  _i1.ColumnValue<String, String> reviewedByDisplayName(String? value) =>
      _i1.ColumnValue(
        table.reviewedByDisplayName,
        value,
      );

  _i1.ColumnValue<String, String> approvedByUserId(String? value) =>
      _i1.ColumnValue(
        table.approvedByUserId,
        value,
      );

  _i1.ColumnValue<String, String> approvedByDisplayName(String? value) =>
      _i1.ColumnValue(
        table.approvedByDisplayName,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> claimedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.claimedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.startedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> submittedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.submittedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> reviewedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.reviewedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
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

class SubtitleReviewTaskTable extends _i1.Table<int?> {
  SubtitleReviewTaskTable({super.tableRelation})
    : super(tableName: 'subtitle_review_task') {
    updateTable = SubtitleReviewTaskUpdateTable(this);
    videoId = _i1.ColumnInt(
      'videoId',
      this,
    );
    trackId = _i1.ColumnInt(
      'trackId',
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
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    priority = _i1.ColumnInt(
      'priority',
      this,
      hasDefault: true,
    );
    assignedUserId = _i1.ColumnString(
      'assignedUserId',
      this,
    );
    assignedDisplayName = _i1.ColumnString(
      'assignedDisplayName',
      this,
    );
    editedByUserId = _i1.ColumnString(
      'editedByUserId',
      this,
    );
    editedByDisplayName = _i1.ColumnString(
      'editedByDisplayName',
      this,
    );
    reviewedByUserId = _i1.ColumnString(
      'reviewedByUserId',
      this,
    );
    reviewedByDisplayName = _i1.ColumnString(
      'reviewedByDisplayName',
      this,
    );
    approvedByUserId = _i1.ColumnString(
      'approvedByUserId',
      this,
    );
    approvedByDisplayName = _i1.ColumnString(
      'approvedByDisplayName',
      this,
    );
    claimedAt = _i1.ColumnDateTime(
      'claimedAt',
      this,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
    );
    submittedAt = _i1.ColumnDateTime(
      'submittedAt',
      this,
    );
    reviewedAt = _i1.ColumnDateTime(
      'reviewedAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
    publishedAt = _i1.ColumnDateTime(
      'publishedAt',
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

  late final SubtitleReviewTaskUpdateTable updateTable;

  late final _i1.ColumnInt videoId;

  late final _i1.ColumnInt trackId;

  late final _i1.ColumnString languageCode;

  late final _i1.ColumnString scriptCode;

  late final _i1.ColumnEnum<_i2.SubtitleReviewTaskStatus> status;

  late final _i1.ColumnInt priority;

  late final _i1.ColumnString assignedUserId;

  late final _i1.ColumnString assignedDisplayName;

  late final _i1.ColumnString editedByUserId;

  late final _i1.ColumnString editedByDisplayName;

  late final _i1.ColumnString reviewedByUserId;

  late final _i1.ColumnString reviewedByDisplayName;

  late final _i1.ColumnString approvedByUserId;

  late final _i1.ColumnString approvedByDisplayName;

  late final _i1.ColumnDateTime claimedAt;

  late final _i1.ColumnDateTime startedAt;

  late final _i1.ColumnDateTime submittedAt;

  late final _i1.ColumnDateTime reviewedAt;

  late final _i1.ColumnDateTime completedAt;

  late final _i1.ColumnDateTime publishedAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    videoId,
    trackId,
    languageCode,
    scriptCode,
    status,
    priority,
    assignedUserId,
    assignedDisplayName,
    editedByUserId,
    editedByDisplayName,
    reviewedByUserId,
    reviewedByDisplayName,
    approvedByUserId,
    approvedByDisplayName,
    claimedAt,
    startedAt,
    submittedAt,
    reviewedAt,
    completedAt,
    publishedAt,
    createdAt,
    updatedAt,
  ];
}

class SubtitleReviewTaskInclude extends _i1.IncludeObject {
  SubtitleReviewTaskInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SubtitleReviewTask.t;
}

class SubtitleReviewTaskIncludeList extends _i1.IncludeList {
  SubtitleReviewTaskIncludeList._({
    _i1.WhereExpressionBuilder<SubtitleReviewTaskTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubtitleReviewTask.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SubtitleReviewTask.t;
}

class SubtitleReviewTaskRepository {
  const SubtitleReviewTaskRepository._();

  /// Returns a list of [SubtitleReviewTask]s matching the given query parameters.
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
  Future<List<SubtitleReviewTask>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleReviewTaskTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleReviewTaskTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleReviewTaskTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SubtitleReviewTask>(
      where: where?.call(SubtitleReviewTask.t),
      orderBy: orderBy?.call(SubtitleReviewTask.t),
      orderByList: orderByList?.call(SubtitleReviewTask.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SubtitleReviewTask] matching the given query parameters.
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
  Future<SubtitleReviewTask?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleReviewTaskTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubtitleReviewTaskTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleReviewTaskTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SubtitleReviewTask>(
      where: where?.call(SubtitleReviewTask.t),
      orderBy: orderBy?.call(SubtitleReviewTask.t),
      orderByList: orderByList?.call(SubtitleReviewTask.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SubtitleReviewTask] by its [id] or null if no such row exists.
  Future<SubtitleReviewTask?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SubtitleReviewTask>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SubtitleReviewTask]s in the list and returns the inserted rows.
  ///
  /// The returned [SubtitleReviewTask]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SubtitleReviewTask>> insert(
    _i1.DatabaseSession session,
    List<SubtitleReviewTask> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SubtitleReviewTask>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SubtitleReviewTask] and returns the inserted row.
  ///
  /// The returned [SubtitleReviewTask] will have its `id` field set.
  Future<SubtitleReviewTask> insertRow(
    _i1.DatabaseSession session,
    SubtitleReviewTask row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubtitleReviewTask>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SubtitleReviewTask]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SubtitleReviewTask>> update(
    _i1.DatabaseSession session,
    List<SubtitleReviewTask> rows, {
    _i1.ColumnSelections<SubtitleReviewTaskTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SubtitleReviewTask>(
      rows,
      columns: columns?.call(SubtitleReviewTask.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitleReviewTask]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubtitleReviewTask> updateRow(
    _i1.DatabaseSession session,
    SubtitleReviewTask row, {
    _i1.ColumnSelections<SubtitleReviewTaskTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubtitleReviewTask>(
      row,
      columns: columns?.call(SubtitleReviewTask.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitleReviewTask] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SubtitleReviewTask?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SubtitleReviewTaskUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SubtitleReviewTask>(
      id,
      columnValues: columnValues(SubtitleReviewTask.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SubtitleReviewTask]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SubtitleReviewTask>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SubtitleReviewTaskUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<SubtitleReviewTaskTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleReviewTaskTable>? orderBy,
    _i1.OrderByListBuilder<SubtitleReviewTaskTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SubtitleReviewTask>(
      columnValues: columnValues(SubtitleReviewTask.t.updateTable),
      where: where(SubtitleReviewTask.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitleReviewTask.t),
      orderByList: orderByList?.call(SubtitleReviewTask.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SubtitleReviewTask]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SubtitleReviewTask>> delete(
    _i1.DatabaseSession session,
    List<SubtitleReviewTask> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SubtitleReviewTask>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SubtitleReviewTask].
  Future<SubtitleReviewTask> deleteRow(
    _i1.DatabaseSession session,
    SubtitleReviewTask row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubtitleReviewTask>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SubtitleReviewTask>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitleReviewTaskTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SubtitleReviewTask>(
      where: where(SubtitleReviewTask.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleReviewTaskTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SubtitleReviewTask>(
      where: where?.call(SubtitleReviewTask.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SubtitleReviewTask] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitleReviewTaskTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SubtitleReviewTask>(
      where: where(SubtitleReviewTask.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
