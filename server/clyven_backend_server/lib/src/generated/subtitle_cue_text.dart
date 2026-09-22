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

abstract class SubtitleCueText
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SubtitleCueText._({
    this.id,
    required this.cueId,
    required this.scriptCode,
    required this.text,
    this.normalizedText,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isPrimary = isPrimary ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubtitleCueText({
    int? id,
    required int cueId,
    required String scriptCode,
    required String text,
    String? normalizedText,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubtitleCueTextImpl;

  factory SubtitleCueText.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtitleCueText(
      id: jsonSerialization['id'] as int?,
      cueId: jsonSerialization['cueId'] as int,
      scriptCode: jsonSerialization['scriptCode'] as String,
      text: jsonSerialization['text'] as String,
      normalizedText: jsonSerialization['normalizedText'] as String?,
      isPrimary: jsonSerialization['isPrimary'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isPrimary']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SubtitleCueTextTable();

  static const db = SubtitleCueTextRepository._();

  @override
  int? id;

  int cueId;

  String scriptCode;

  String text;

  String? normalizedText;

  bool isPrimary;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubtitleCueText]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleCueText copyWith({
    int? id,
    int? cueId,
    String? scriptCode,
    String? text,
    String? normalizedText,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleCueText',
      if (id != null) 'id': id,
      'cueId': cueId,
      'scriptCode': scriptCode,
      'text': text,
      if (normalizedText != null) 'normalizedText': normalizedText,
      'isPrimary': isPrimary,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubtitleCueText',
      if (id != null) 'id': id,
      'cueId': cueId,
      'scriptCode': scriptCode,
      'text': text,
      if (normalizedText != null) 'normalizedText': normalizedText,
      'isPrimary': isPrimary,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SubtitleCueTextInclude include() {
    return SubtitleCueTextInclude._();
  }

  static SubtitleCueTextIncludeList includeList({
    _i1.WhereExpressionBuilder<SubtitleCueTextTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleCueTextTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleCueTextTable>? orderByList,
    SubtitleCueTextInclude? include,
  }) {
    return SubtitleCueTextIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitleCueText.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SubtitleCueText.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtitleCueTextImpl extends SubtitleCueText {
  _SubtitleCueTextImpl({
    int? id,
    required int cueId,
    required String scriptCode,
    required String text,
    String? normalizedText,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         cueId: cueId,
         scriptCode: scriptCode,
         text: text,
         normalizedText: normalizedText,
         isPrimary: isPrimary,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubtitleCueText]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleCueText copyWith({
    Object? id = _Undefined,
    int? cueId,
    String? scriptCode,
    String? text,
    Object? normalizedText = _Undefined,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubtitleCueText(
      id: id is int? ? id : this.id,
      cueId: cueId ?? this.cueId,
      scriptCode: scriptCode ?? this.scriptCode,
      text: text ?? this.text,
      normalizedText: normalizedText is String?
          ? normalizedText
          : this.normalizedText,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SubtitleCueTextUpdateTable extends _i1.UpdateTable<SubtitleCueTextTable> {
  SubtitleCueTextUpdateTable(super.table);

  _i1.ColumnValue<int, int> cueId(int value) => _i1.ColumnValue(
    table.cueId,
    value,
  );

  _i1.ColumnValue<String, String> scriptCode(String value) => _i1.ColumnValue(
    table.scriptCode,
    value,
  );

  _i1.ColumnValue<String, String> text(String value) => _i1.ColumnValue(
    table.text,
    value,
  );

  _i1.ColumnValue<String, String> normalizedText(String? value) =>
      _i1.ColumnValue(
        table.normalizedText,
        value,
      );

  _i1.ColumnValue<bool, bool> isPrimary(bool value) => _i1.ColumnValue(
    table.isPrimary,
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

class SubtitleCueTextTable extends _i1.Table<int?> {
  SubtitleCueTextTable({super.tableRelation})
    : super(tableName: 'subtitle_cue_text') {
    updateTable = SubtitleCueTextUpdateTable(this);
    cueId = _i1.ColumnInt(
      'cueId',
      this,
    );
    scriptCode = _i1.ColumnString(
      'scriptCode',
      this,
    );
    text = _i1.ColumnString(
      'text',
      this,
    );
    normalizedText = _i1.ColumnString(
      'normalizedText',
      this,
    );
    isPrimary = _i1.ColumnBool(
      'isPrimary',
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

  late final SubtitleCueTextUpdateTable updateTable;

  late final _i1.ColumnInt cueId;

  late final _i1.ColumnString scriptCode;

  late final _i1.ColumnString text;

  late final _i1.ColumnString normalizedText;

  late final _i1.ColumnBool isPrimary;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    cueId,
    scriptCode,
    text,
    normalizedText,
    isPrimary,
    createdAt,
    updatedAt,
  ];
}

class SubtitleCueTextInclude extends _i1.IncludeObject {
  SubtitleCueTextInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SubtitleCueText.t;
}

class SubtitleCueTextIncludeList extends _i1.IncludeList {
  SubtitleCueTextIncludeList._({
    _i1.WhereExpressionBuilder<SubtitleCueTextTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubtitleCueText.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SubtitleCueText.t;
}

class SubtitleCueTextRepository {
  const SubtitleCueTextRepository._();

  /// Returns a list of [SubtitleCueText]s matching the given query parameters.
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
  Future<List<SubtitleCueText>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleCueTextTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleCueTextTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleCueTextTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SubtitleCueText>(
      where: where?.call(SubtitleCueText.t),
      orderBy: orderBy?.call(SubtitleCueText.t),
      orderByList: orderByList?.call(SubtitleCueText.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SubtitleCueText] matching the given query parameters.
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
  Future<SubtitleCueText?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleCueTextTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubtitleCueTextTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubtitleCueTextTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SubtitleCueText>(
      where: where?.call(SubtitleCueText.t),
      orderBy: orderBy?.call(SubtitleCueText.t),
      orderByList: orderByList?.call(SubtitleCueText.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SubtitleCueText] by its [id] or null if no such row exists.
  Future<SubtitleCueText?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SubtitleCueText>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SubtitleCueText]s in the list and returns the inserted rows.
  ///
  /// The returned [SubtitleCueText]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SubtitleCueText>> insert(
    _i1.DatabaseSession session,
    List<SubtitleCueText> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SubtitleCueText>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SubtitleCueText] and returns the inserted row.
  ///
  /// The returned [SubtitleCueText] will have its `id` field set.
  Future<SubtitleCueText> insertRow(
    _i1.DatabaseSession session,
    SubtitleCueText row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubtitleCueText>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SubtitleCueText]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SubtitleCueText>> update(
    _i1.DatabaseSession session,
    List<SubtitleCueText> rows, {
    _i1.ColumnSelections<SubtitleCueTextTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SubtitleCueText>(
      rows,
      columns: columns?.call(SubtitleCueText.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitleCueText]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubtitleCueText> updateRow(
    _i1.DatabaseSession session,
    SubtitleCueText row, {
    _i1.ColumnSelections<SubtitleCueTextTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubtitleCueText>(
      row,
      columns: columns?.call(SubtitleCueText.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubtitleCueText] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SubtitleCueText?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SubtitleCueTextUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SubtitleCueText>(
      id,
      columnValues: columnValues(SubtitleCueText.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SubtitleCueText]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SubtitleCueText>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SubtitleCueTextUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<SubtitleCueTextTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubtitleCueTextTable>? orderBy,
    _i1.OrderByListBuilder<SubtitleCueTextTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SubtitleCueText>(
      columnValues: columnValues(SubtitleCueText.t.updateTable),
      where: where(SubtitleCueText.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubtitleCueText.t),
      orderByList: orderByList?.call(SubtitleCueText.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SubtitleCueText]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SubtitleCueText>> delete(
    _i1.DatabaseSession session,
    List<SubtitleCueText> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SubtitleCueText>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SubtitleCueText].
  Future<SubtitleCueText> deleteRow(
    _i1.DatabaseSession session,
    SubtitleCueText row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubtitleCueText>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SubtitleCueText>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitleCueTextTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SubtitleCueText>(
      where: where(SubtitleCueText.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubtitleCueTextTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SubtitleCueText>(
      where: where?.call(SubtitleCueText.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SubtitleCueText] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubtitleCueTextTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SubtitleCueText>(
      where: where(SubtitleCueText.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
