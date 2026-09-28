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

abstract class DictionaryEntry
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DictionaryEntry._({
    this.id,
    required this.languageCode,
    required this.text,
    required this.normalizedText,
    required this.entryType,
    this.primaryScriptCode,
    this.partOfSpeech,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory DictionaryEntry({
    int? id,
    required String languageCode,
    required String text,
    required String normalizedText,
    required String entryType,
    String? primaryScriptCode,
    String? partOfSpeech,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DictionaryEntryImpl;

  factory DictionaryEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return DictionaryEntry(
      id: jsonSerialization['id'] as int?,
      languageCode: jsonSerialization['languageCode'] as String,
      text: jsonSerialization['text'] as String,
      normalizedText: jsonSerialization['normalizedText'] as String,
      entryType: jsonSerialization['entryType'] as String,
      primaryScriptCode: jsonSerialization['primaryScriptCode'] as String?,
      partOfSpeech: jsonSerialization['partOfSpeech'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = DictionaryEntryTable();

  static const db = DictionaryEntryRepository._();

  @override
  int? id;

  String languageCode;

  String text;

  String normalizedText;

  String entryType;

  String? primaryScriptCode;

  String? partOfSpeech;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DictionaryEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryEntry copyWith({
    int? id,
    String? languageCode,
    String? text,
    String? normalizedText,
    String? entryType,
    String? primaryScriptCode,
    String? partOfSpeech,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryEntry',
      if (id != null) 'id': id,
      'languageCode': languageCode,
      'text': text,
      'normalizedText': normalizedText,
      'entryType': entryType,
      if (primaryScriptCode != null) 'primaryScriptCode': primaryScriptCode,
      if (partOfSpeech != null) 'partOfSpeech': partOfSpeech,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DictionaryEntry',
      if (id != null) 'id': id,
      'languageCode': languageCode,
      'text': text,
      'normalizedText': normalizedText,
      'entryType': entryType,
      if (primaryScriptCode != null) 'primaryScriptCode': primaryScriptCode,
      if (partOfSpeech != null) 'partOfSpeech': partOfSpeech,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DictionaryEntryInclude include() {
    return DictionaryEntryInclude._();
  }

  static DictionaryEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<DictionaryEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryEntryTable>? orderByList,
    DictionaryEntryInclude? include,
  }) {
    return DictionaryEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryEntry.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DictionaryEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DictionaryEntryImpl extends DictionaryEntry {
  _DictionaryEntryImpl({
    int? id,
    required String languageCode,
    required String text,
    required String normalizedText,
    required String entryType,
    String? primaryScriptCode,
    String? partOfSpeech,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         languageCode: languageCode,
         text: text,
         normalizedText: normalizedText,
         entryType: entryType,
         primaryScriptCode: primaryScriptCode,
         partOfSpeech: partOfSpeech,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DictionaryEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryEntry copyWith({
    Object? id = _Undefined,
    String? languageCode,
    String? text,
    String? normalizedText,
    String? entryType,
    Object? primaryScriptCode = _Undefined,
    Object? partOfSpeech = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DictionaryEntry(
      id: id is int? ? id : this.id,
      languageCode: languageCode ?? this.languageCode,
      text: text ?? this.text,
      normalizedText: normalizedText ?? this.normalizedText,
      entryType: entryType ?? this.entryType,
      primaryScriptCode: primaryScriptCode is String?
          ? primaryScriptCode
          : this.primaryScriptCode,
      partOfSpeech: partOfSpeech is String? ? partOfSpeech : this.partOfSpeech,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DictionaryEntryUpdateTable extends _i1.UpdateTable<DictionaryEntryTable> {
  DictionaryEntryUpdateTable(super.table);

  _i1.ColumnValue<String, String> languageCode(String value) => _i1.ColumnValue(
    table.languageCode,
    value,
  );

  _i1.ColumnValue<String, String> text(String value) => _i1.ColumnValue(
    table.text,
    value,
  );

  _i1.ColumnValue<String, String> normalizedText(String value) =>
      _i1.ColumnValue(
        table.normalizedText,
        value,
      );

  _i1.ColumnValue<String, String> entryType(String value) => _i1.ColumnValue(
    table.entryType,
    value,
  );

  _i1.ColumnValue<String, String> primaryScriptCode(String? value) =>
      _i1.ColumnValue(
        table.primaryScriptCode,
        value,
      );

  _i1.ColumnValue<String, String> partOfSpeech(String? value) =>
      _i1.ColumnValue(
        table.partOfSpeech,
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

class DictionaryEntryTable extends _i1.Table<int?> {
  DictionaryEntryTable({super.tableRelation})
    : super(tableName: 'dictionary_entry') {
    updateTable = DictionaryEntryUpdateTable(this);
    languageCode = _i1.ColumnString(
      'languageCode',
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
    entryType = _i1.ColumnString(
      'entryType',
      this,
    );
    primaryScriptCode = _i1.ColumnString(
      'primaryScriptCode',
      this,
    );
    partOfSpeech = _i1.ColumnString(
      'partOfSpeech',
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

  late final DictionaryEntryUpdateTable updateTable;

  late final _i1.ColumnString languageCode;

  late final _i1.ColumnString text;

  late final _i1.ColumnString normalizedText;

  late final _i1.ColumnString entryType;

  late final _i1.ColumnString primaryScriptCode;

  late final _i1.ColumnString partOfSpeech;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    languageCode,
    text,
    normalizedText,
    entryType,
    primaryScriptCode,
    partOfSpeech,
    createdAt,
    updatedAt,
  ];
}

class DictionaryEntryInclude extends _i1.IncludeObject {
  DictionaryEntryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DictionaryEntry.t;
}

class DictionaryEntryIncludeList extends _i1.IncludeList {
  DictionaryEntryIncludeList._({
    _i1.WhereExpressionBuilder<DictionaryEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DictionaryEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DictionaryEntry.t;
}

class DictionaryEntryRepository {
  const DictionaryEntryRepository._();

  /// Returns a list of [DictionaryEntry]s matching the given query parameters.
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
  Future<List<DictionaryEntry>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryEntryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DictionaryEntry>(
      where: where?.call(DictionaryEntry.t),
      orderBy: orderBy?.call(DictionaryEntry.t),
      orderByList: orderByList?.call(DictionaryEntry.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DictionaryEntry] matching the given query parameters.
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
  Future<DictionaryEntry?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<DictionaryEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictionaryEntryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DictionaryEntry>(
      where: where?.call(DictionaryEntry.t),
      orderBy: orderBy?.call(DictionaryEntry.t),
      orderByList: orderByList?.call(DictionaryEntry.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DictionaryEntry] by its [id] or null if no such row exists.
  Future<DictionaryEntry?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DictionaryEntry>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DictionaryEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [DictionaryEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DictionaryEntry>> insert(
    _i1.DatabaseSession session,
    List<DictionaryEntry> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DictionaryEntry>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DictionaryEntry] and returns the inserted row.
  ///
  /// The returned [DictionaryEntry] will have its `id` field set.
  Future<DictionaryEntry> insertRow(
    _i1.DatabaseSession session,
    DictionaryEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DictionaryEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DictionaryEntry>> update(
    _i1.DatabaseSession session,
    List<DictionaryEntry> rows, {
    _i1.ColumnSelections<DictionaryEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DictionaryEntry>(
      rows,
      columns: columns?.call(DictionaryEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DictionaryEntry> updateRow(
    _i1.DatabaseSession session,
    DictionaryEntry row, {
    _i1.ColumnSelections<DictionaryEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DictionaryEntry>(
      row,
      columns: columns?.call(DictionaryEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictionaryEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DictionaryEntry?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DictionaryEntryUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DictionaryEntry>(
      id,
      columnValues: columnValues(DictionaryEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DictionaryEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DictionaryEntry>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DictionaryEntryUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DictionaryEntryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictionaryEntryTable>? orderBy,
    _i1.OrderByListBuilder<DictionaryEntryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DictionaryEntry>(
      columnValues: columnValues(DictionaryEntry.t.updateTable),
      where: where(DictionaryEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictionaryEntry.t),
      orderByList: orderByList?.call(DictionaryEntry.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DictionaryEntry]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DictionaryEntry>> delete(
    _i1.DatabaseSession session,
    List<DictionaryEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DictionaryEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DictionaryEntry].
  Future<DictionaryEntry> deleteRow(
    _i1.DatabaseSession session,
    DictionaryEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DictionaryEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DictionaryEntry>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryEntryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DictionaryEntry>(
      where: where(DictionaryEntry.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DictionaryEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DictionaryEntry>(
      where: where?.call(DictionaryEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DictionaryEntry] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DictionaryEntryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DictionaryEntry>(
      where: where(DictionaryEntry.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
