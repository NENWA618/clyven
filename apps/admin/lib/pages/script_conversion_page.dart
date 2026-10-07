import 'package:glyphora_web_l10n/web_l10n.dart';
import 'dart:convert';

import 'package:glyphora_backend_client/backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../services/admin_client.dart';
import '../services/excel_file_reader.dart';

class ScriptConversionPage extends StatefulComponent {
  const ScriptConversionPage({super.key});

  @override
  State<ScriptConversionPage> createState() => _ScriptConversionPageState();
}

class _ScriptConversionPageState extends State<ScriptConversionPage> {
  final client = adminClient;

  List<ScriptConversionProfile> profiles = [];
  int? selectedProfileId;
  bool loadingProfiles = true;
  String? loadError;

  String name = '';
  String languageCode = '';
  String sourceScriptCode = '';
  String targetScriptCode = '';
  String sheetName = '';
  String sourceColumn = 'source';
  String targetColumn = 'target';
  String priorityColumn = 'priority';
  String noteColumn = 'note';
  String conversionMode = 'dictionary';
  String typeColumn = '';
  bool creating = false;
  String? createError;

  String editName = '';
  String editLanguageCode = '';
  String editSourceScriptCode = '';
  String editTargetScriptCode = '';
  String editSheetName = '';
  String editSourceColumn = '';
  String editTargetColumn = '';
  String editPriorityColumn = '';
  String editNoteColumn = '';
  String editConversionMode = 'dictionary';
  String editTypeColumn = '';
  bool savingProfile = false;
  bool deletingProfile = false;
  String? profileActionError;
  String? profileActionMessage;

  bool previewLoading = false;
  String? previewError;
  ScriptConversionImportPreview? preview;
  String? excelBase64;

  bool commitLoading = false;
  String? commitError;
  ScriptConversionCommitResult? commitResult;

  String testInput = '';
  String testOutput = '';
  bool testReverse = false;
  bool testLoading = false;
  String? testError;

  List<ScriptConversionEntry> entries = [];
  bool entriesLoading = false;
  String? entriesError;
  int? editingEntryId;
  String entrySource = '';
  String entryTarget = '';
  String entryPriority = '0';
  String entryNote = '';
  String entryType = 'dictionary';
  bool entrySaving = false;
  int? deletingEntryId;
  String? entryActionError;

  @override
  void initState() {
    super.initState();
    _loadProfiles();
  }

  ScriptConversionProfile? get selectedProfile {
    final id = selectedProfileId;
    if (id == null) return null;
    for (final profile in profiles) {
      if (profile.id == id) return profile;
    }
    return null;
  }

  Future<void> _loadProfiles({int? selectId}) async {
    setState(() {
      loadingProfiles = true;
      loadError = null;
    });

    try {
      final result = await client.scriptConversion.listProfiles();
      ScriptConversionProfile? selected;

      final desiredId = selectId ?? selectedProfileId;
      if (desiredId != null) {
        for (final profile in result) {
          if (profile.id == desiredId) {
            selected = profile;
            break;
          }
        }
      }
      if (selected == null && result.isNotEmpty) {
        selected = result.first;
      }

      setState(() {
        profiles = result;
        selectedProfileId = selected?.id;
        loadingProfiles = false;
        if (selected != null) {
          _copyProfileToEditor(selected);
        }
      });

      if (selected?.id != null) {
        await _loadEntries(selected!.id!);
      } else {
        setState(() {
          entries = [];
        });
      }
    } catch (e) {
      setState(() {
        loadError = e.toString();
        loadingProfiles = false;
      });
    }
  }

  void _copyProfileToEditor(ScriptConversionProfile profile) {
    editName = profile.name;
    editLanguageCode = profile.languageCode;
    editSourceScriptCode = profile.sourceScriptCode;
    editTargetScriptCode = profile.targetScriptCode;
    editSheetName = profile.sheetName ?? '';
    editSourceColumn = profile.sourceColumn;
    editTargetColumn = profile.targetColumn;
    editPriorityColumn = profile.priorityColumn ?? '';
    editNoteColumn = profile.noteColumn ?? '';
    editConversionMode = profile.conversionMode ?? 'dictionary';
    editTypeColumn = profile.typeColumn ?? '';
  }

  Future<void> _selectProfile(ScriptConversionProfile profile) async {
    setState(() {
      selectedProfileId = profile.id;
      _copyProfileToEditor(profile);
      preview = null;
      excelBase64 = null;
      commitResult = null;
      testOutput = '';
      profileActionError = null;
      profileActionMessage = null;
      editingEntryId = null;
      entryActionError = null;
    });
    if (profile.id != null) {
      await _loadEntries(profile.id!);
    }
  }

  Future<void> _createProfile() async {
    if (name.trim().isEmpty ||
        languageCode.trim().isEmpty ||
        sourceScriptCode.trim().isEmpty ||
        targetScriptCode.trim().isEmpty ||
        sourceColumn.trim().isEmpty ||
        targetColumn.trim().isEmpty) {
      setState(() {
        createError =
            context.tr('Name, language, scripts and source/target columns are required.', '名称、语言、文字以及源/目标列均为必填。');
      });
      return;
    }

    setState(() {
      creating = true;
      createError = null;
    });

    try {
      final created = await client.scriptConversion.createProfile(
        name: name.trim(),
        languageCode: languageCode.trim(),
        sourceScriptCode: sourceScriptCode.trim(),
        targetScriptCode: targetScriptCode.trim(),
        sourceColumn: sourceColumn.trim(),
        targetColumn: targetColumn.trim(),
        sheetName: sheetName.trim().isEmpty ? null : sheetName.trim(),
        priorityColumn: priorityColumn.trim().isEmpty
            ? null
            : priorityColumn.trim(),
        noteColumn: noteColumn.trim().isEmpty ? null : noteColumn.trim(),
        conversionMode: conversionMode.trim().isEmpty
            ? 'dictionary'
            : conversionMode.trim(),
        typeColumn: typeColumn.trim().isEmpty ? null : typeColumn.trim(),
      );

      setState(() {
        creating = false;
        name = '';
      });
      await _loadProfiles(selectId: created.id);
    } catch (e) {
      setState(() {
        creating = false;
        createError = e.toString();
      });
    }
  }

  Future<void> _saveProfile() async {
    final id = selectedProfileId;
    if (id == null) return;

    setState(() {
      savingProfile = true;
      profileActionError = null;
      profileActionMessage = null;
    });

    try {
      final updated = await client.scriptConversion.updateProfile(
        profileId: id,
        name: editName,
        languageCode: editLanguageCode,
        sourceScriptCode: editSourceScriptCode,
        targetScriptCode: editTargetScriptCode,
        sourceColumn: editSourceColumn,
        targetColumn: editTargetColumn,
        sheetName: editSheetName.trim().isEmpty ? null : editSheetName,
        priorityColumn: editPriorityColumn.trim().isEmpty
            ? null
            : editPriorityColumn,
        noteColumn: editNoteColumn.trim().isEmpty ? null : editNoteColumn,
        conversionMode: editConversionMode.trim().isEmpty
            ? 'dictionary'
            : editConversionMode.trim(),
        typeColumn: editTypeColumn.trim().isEmpty ? null : editTypeColumn,
      );

      setState(() {
        savingProfile = false;
        profileActionMessage = context.tr('Profile saved.', '方案已保存。');
      });
      await _loadProfiles(selectId: updated.id);
    } catch (e) {
      setState(() {
        savingProfile = false;
        profileActionError = e.toString();
      });
    }
  }

  Future<void> _deleteProfile() async {
    final id = selectedProfileId;
    if (id == null) return;

    setState(() {
      deletingProfile = true;
      profileActionError = null;
      profileActionMessage = null;
    });

    try {
      await client.scriptConversion.deleteProfile(profileId: id);
      setState(() {
        deletingProfile = false;
        preview = null;
        excelBase64 = null;
        commitResult = null;
        testOutput = '';
        entries = [];
      });
      await _loadProfiles(selectId: null);
    } catch (e) {
      setState(() {
        deletingProfile = false;
        profileActionError = e.toString();
      });
    }
  }

  Future<void> _loadEntries(int profileId) async {
    setState(() {
      entriesLoading = true;
      entriesError = null;
    });

    try {
      final result = await client.scriptConversion.listEntries(
        profileId: profileId,
        limit: 200,
      );
      setState(() {
        entries = result;
        entriesLoading = false;
      });
    } catch (e) {
      setState(() {
        entriesLoading = false;
        entriesError = e.toString();
      });
    }
  }

  void _startEditEntry(ScriptConversionEntry entry) {
    setState(() {
      editingEntryId = entry.id;
      entrySource = entry.sourceText;
      entryTarget = entry.targetText;
      entryPriority = '${entry.priority}';
      entryNote = entry.note ?? '';
      entryType = entry.entryType ?? 'dictionary';
      entryActionError = null;
    });
  }

  Future<void> _saveEntry() async {
    final id = editingEntryId;
    final profileId = selectedProfileId;
    if (id == null || profileId == null) return;

    setState(() {
      entrySaving = true;
      entryActionError = null;
    });

    try {
      await client.scriptConversion.updateEntry(
        entryId: id,
        sourceText: entrySource,
        targetText: entryTarget,
        priority: int.tryParse(entryPriority.trim()) ?? 0,
        note: entryNote.trim().isEmpty ? null : entryNote,
        entryType: entryType.trim().isEmpty ? 'dictionary' : entryType.trim(),
      );

      setState(() {
        entrySaving = false;
        editingEntryId = null;
      });
      await _loadEntries(profileId);
    } catch (e) {
      setState(() {
        entrySaving = false;
        entryActionError = e.toString();
      });
    }
  }

  Future<void> _deleteEntry(int entryId) async {
    final profileId = selectedProfileId;
    if (profileId == null) return;

    setState(() {
      deletingEntryId = entryId;
      entryActionError = null;
    });

    try {
      await client.scriptConversion.deleteEntry(entryId: entryId);
      setState(() {
        deletingEntryId = null;
        if (editingEntryId == entryId) {
          editingEntryId = null;
        }
      });
      await _loadEntries(profileId);
    } catch (e) {
      setState(() {
        deletingEntryId = null;
        entryActionError = e.toString();
      });
    }
  }

  Future<void> _previewExcel() async {
    final profileId = selectedProfileId;
    if (profileId == null) {
      setState(() {
        previewError = context.tr('Select a conversion profile first.', '请先选择转换方案。');
      });
      return;
    }

    setState(() {
      previewLoading = true;
      previewError = null;
      preview = null;
      commitResult = null;
      commitError = null;
    });

    try {
      final bytes = await readSelectedExcelFile('script-conversion-excel');
      if (bytes == null) {
        throw StateError(context.tr('Select an Excel file first.', '请先选择 Excel 文件。'));
      }

      final encoded = base64Encode(bytes);
      final result = await client.scriptConversion.previewExcelBase64(
        profileId: profileId,
        excelBase64: encoded,
      );

      setState(() {
        excelBase64 = encoded;
        preview = result;
        previewLoading = false;
      });
    } catch (e) {
      setState(() {
        previewLoading = false;
        previewError = e.toString();
      });
    }
  }

  Future<void> _commitExcel() async {
    final profileId = selectedProfileId;
    final encoded = excelBase64;
    if (profileId == null || encoded == null) {
      setState(() {
        commitError = context.tr('Preview an Excel file before importing.', '导入前请先预览 Excel 文件。');
      });
      return;
    }

    setState(() {
      commitLoading = true;
      commitError = null;
      commitResult = null;
    });

    try {
      final result = await client.scriptConversion.commitExcelBase64(
        profileId: profileId,
        excelBase64: encoded,
      );
      setState(() {
        commitResult = result;
        commitLoading = false;
      });
      await _loadEntries(profileId);
    } catch (e) {
      setState(() {
        commitError = e.toString();
        commitLoading = false;
      });
    }
  }

  Future<void> _testConvert() async {
    final profileId = selectedProfileId;
    if (profileId == null) {
      setState(() {
        testError = context.tr('Select a profile first.', '请先选择方案。');
      });
      return;
    }

    setState(() {
      testLoading = true;
      testError = null;
    });

    try {
      final result = await client.scriptConversion.testConvert(
        profileId: profileId,
        text: testInput,
        reverse: testReverse,
      );
      setState(() {
        testOutput = result;
        testLoading = false;
      });
    } catch (e) {
      setState(() {
        testError = e.toString();
        testLoading = false;
      });
    }
  }

  Component _field(
    String fieldTitle,
    String value,
    void Function(String value) onInput, {
    String? placeholder,
  }) {
    return div(classes: 'script-conversion-field', [
      span([.text(fieldTitle)]),
      input<String>(
        value: value,
        attributes: {if (placeholder != null) 'placeholder': placeholder},
        events: events<String>(onInput: onInput),
      ),
    ]);
  }

  Component _stat(String statLabel, int value) {
    return div(classes: 'script-stat-card', [
      span([.text(statLabel)]),
      strong([.text('$value')]),
    ]);
  }

  @override
  Component build(BuildContext context) {
    final profile = selectedProfile;

    return div(classes: 'script-conversion-page', [
      div(classes: 'script-conversion-heading', [
        div([
          h2([.text(context.tr('Script Conversion', '文字转换'))]),
          p([
            .text(
              context.tr('Platform-level conversion data. Separate from client dictionary entries.', '平台级转换数据，与客户端词典条目相互独立。'),
            ),
          ]),
        ]),
        button(
          classes: 'admin-secondary-button',
          onClick: () {
            _loadProfiles();
          },
          [.text(context.tr('Reload profiles', '重新加载方案'))],
        ),
      ]),

      div(classes: 'script-conversion-layout', [
        section(classes: 'script-conversion-panel', [
          h3([.text(context.tr('Conversion Profiles', '转换方案'))]),
          p(classes: 'admin-muted', [
            .text(context.tr('One language can have multiple script conversion profiles.', '一种语言可以有多个文字转换方案。')),
          ]),
          if (loadingProfiles)
            p([.text(context.tr('Loading...', '加载中...'))])
          else if (loadError != null)
            div(classes: 'admin-error', [.text(loadError!)])
          else if (profiles.isEmpty)
            p(classes: 'admin-muted', [.text(context.tr('No profiles yet.', '暂无方案。'))])
          else
            div(classes: 'script-profile-list', [
              for (final item in profiles)
                button(
                  classes:
                      'script-profile-card${item.id == selectedProfileId ? ' is-active' : ''}',
                  onClick: () {
                    _selectProfile(item);
                  },
                  [
                    strong([.text(item.name)]),
                    span([
                      .text(
                        '${item.languageCode} / ${item.sourceScriptCode} -> ${item.targetScriptCode}',
                      ),
                    ]),
                    span([
                      .text('${item.sourceColumn} -> ${item.targetColumn}'),
                    ]),
                    span([
                      .text(context.tr('Mode: ${item.conversionMode ?? 'dictionary'}', '模式：${item.conversionMode ?? 'dictionary'}')),
                    ]),
                  ],
                ),
            ]),
        ]),

        section(classes: 'script-conversion-panel', [
          h3([.text(context.tr('New Profile', '新建方案'))]),
          div(classes: 'script-conversion-form-grid', [
            _field(
              context.tr('Name', '名称'),
              name,
              (value) => name = value,
              placeholder: 'Vietnamese Latin -> Nom',
            ),
            _field(
              context.tr('Language', '语言'),
              languageCode,
              (value) => languageCode = value,
              placeholder: 'vi / tr / kk',
            ),
            _field(
              context.tr('Source script', '源文字'),
              sourceScriptCode,
              (value) => sourceScriptCode = value,
              placeholder: 'Latn',
            ),
            _field(
              context.tr('Target script', '目标文字'),
              targetScriptCode,
              (value) => targetScriptCode = value,
              placeholder: 'Nom / Arab / Cyrl',
            ),
            _field(
              context.tr('Conversion mode', '转换模式'),
              conversionMode,
              (value) => conversionMode = value,
              placeholder: 'dictionary / rules / hybrid',
            ),
            _field(
              context.tr('Type column', '类型列'),
              typeColumn,
              (value) => typeColumn = value,
              placeholder: context.tr('optional; e.g. type', '可选，例如 type'),
            ),
            _field(
              context.tr('Sheet name', '工作表名称'),
              sheetName,
              (value) => sheetName = value,
              placeholder: context.tr('blank = first sheet', '留空 = 第一个工作表'),
            ),
            _field(
              context.tr('Source column', '源列'),
              sourceColumn,
              (value) => sourceColumn = value,
            ),
            _field(
              context.tr('Target column', '目标列'),
              targetColumn,
              (value) => targetColumn = value,
            ),
            _field(
              context.tr('Priority column', '优先级列'),
              priorityColumn,
              (value) => priorityColumn = value,
              placeholder: context.tr('optional', '可选'),
            ),
            _field(
              context.tr('Note column', '备注列'),
              noteColumn,
              (value) => noteColumn = value,
              placeholder: context.tr('optional', '可选'),
            ),
          ]),
          p(classes: 'admin-muted', [
            .text(
              context.tr('dictionary = words/phrases; rules = characters/sequences; hybrid = dictionary + rules + exceptions.', 'dictionary = 词/短语；rules = 字符/序列；hybrid = 词典 + 规则 + 例外。'),
            ),
          ]),
          if (createError != null)
            div(classes: 'admin-error', [.text(createError!)]),
          button(
            classes: 'admin-primary-button',
            attributes: creating ? {'disabled': 'disabled'} : null,
            onClick: creating ? null : _createProfile,
            [.text(creating ? context.tr('Creating...', '创建中...') : context.tr('Create profile', '创建方案'))],
          ),
        ]),
      ]),

      if (profile != null) ...[
        section(classes: 'script-conversion-panel', [
          div(classes: 'script-conversion-section-header', [
            div([
              h3([.text(context.tr('Edit Profile', '编辑方案'))]),
              p(classes: 'admin-muted', [
                .text(
                  '${profile.languageCode} / ${profile.sourceScriptCode} -> ${profile.targetScriptCode}',
                ),
              ]),
            ]),
            span(classes: 'glyphora-admin-scope-badge', [
              .text(context.tr('PROFILE #${profile.id}', '方案 #${profile.id}')),
            ]),
          ]),
          div(classes: 'script-conversion-form-grid', [
            _field(context.tr('Name', '名称'), editName, (value) => editName = value),
            _field(
              context.tr('Language', '语言'),
              editLanguageCode,
              (value) => editLanguageCode = value,
            ),
            _field(
              context.tr('Source script', '源文字'),
              editSourceScriptCode,
              (value) => editSourceScriptCode = value,
            ),
            _field(
              context.tr('Target script', '目标文字'),
              editTargetScriptCode,
              (value) => editTargetScriptCode = value,
            ),
            _field(
              context.tr('Conversion mode', '转换模式'),
              editConversionMode,
              (value) => editConversionMode = value,
            ),
            _field(
              context.tr('Type column', '类型列'),
              editTypeColumn,
              (value) => editTypeColumn = value,
            ),
            _field(
              context.tr('Sheet name', '工作表名称'),
              editSheetName,
              (value) => editSheetName = value,
            ),
            _field(
              context.tr('Source column', '源列'),
              editSourceColumn,
              (value) => editSourceColumn = value,
            ),
            _field(
              context.tr('Target column', '目标列'),
              editTargetColumn,
              (value) => editTargetColumn = value,
            ),
            _field(
              context.tr('Priority column', '优先级列'),
              editPriorityColumn,
              (value) => editPriorityColumn = value,
            ),
            _field(
              context.tr('Note column', '备注列'),
              editNoteColumn,
              (value) => editNoteColumn = value,
            ),
          ]),
          div(classes: 'script-profile-actions', [
            button(
              classes: 'admin-primary-button',
              attributes: savingProfile ? {'disabled': 'disabled'} : null,
              onClick: savingProfile ? null : _saveProfile,
              [.text(savingProfile ? context.tr('Saving...', '保存中...') : context.tr('Save profile', '保存方案'))],
            ),
            button(
              classes: 'script-danger-button',
              attributes: deletingProfile ? {'disabled': 'disabled'} : null,
              onClick: deletingProfile ? null : _deleteProfile,
              [.text(deletingProfile ? context.tr('Deleting...', '删除中...') : context.tr('Delete profile', '删除方案'))],
            ),
            if (profileActionMessage != null)
              span(classes: 'script-import-result', [
                .text(profileActionMessage!),
              ]),
          ]),
          if (profileActionError != null)
            div(classes: 'admin-error', [.text(profileActionError!)]),
        ]),

        section(classes: 'script-conversion-panel script-conversion-workspace', [
          div(classes: 'script-conversion-section-header', [
            div([
              h3([.text(profile.name)]),
              p(classes: 'admin-muted', [
                .text(
                  '${profile.languageCode} / ${profile.sourceScriptCode} -> ${profile.targetScriptCode} / ${profile.conversionMode ?? 'dictionary'}',
                ),
              ]),
            ]),
            span(classes: 'glyphora-admin-scope-badge', [.text('PLATFORM DATA')]),
          ]),

          div(classes: 'script-import-grid', [
            div(classes: 'script-upload-box', [
              strong([.text(context.tr('Import Excel', '导入 Excel'))]),
              p(classes: 'admin-muted', [
                .text(
                  context.tr(
                    'Required columns: ${profile.sourceColumn}, ${profile.targetColumn}. '
                    'Rules mode auto-detects 1-scalar source as character and longer source as sequence. '
                    'Use ${profile.typeColumn ?? 'an optional type column'} for exception/dictionary/sequence/character.',
                    '必填列：${profile.sourceColumn}、${profile.targetColumn}。'
                    'rules 模式会将单字符源识别为 character，更长的源识别为 sequence。'
                    '使用 ${profile.typeColumn ?? '可选的类型列'} 指定 exception/dictionary/sequence/character。',
                  ),
                ),
              ]),
              input<String>(
                id: 'script-conversion-excel',
                type: InputType.file,
                attributes: {'accept': '.xlsx,.xls'},
                events: {
                  'change': (_) {
                    _previewExcel();
                  },
                },
              ),
              if (previewLoading)
                p(classes: 'admin-muted', [.text('Reading Excel...')]),
              if (previewError != null)
                div(classes: 'admin-error', [.text(previewError!)]),
            ]),

            div(classes: 'script-test-box', [
              strong([.text(context.tr('Test Converter', '测试转换器'))]),
              textarea(
                [.text(testInput)],
                attributes: {'placeholder': context.tr('Enter text to convert', '输入要转换的文字')},
                onInput: (value) {
                  testInput = value;
                },
              ),
              button(
                classes: 'admin-secondary-button script-direction-toggle',
                onClick: () {
                  setState(() {
                    testReverse = !testReverse;
                    testOutput = '';
                  });
                },
                [
                  .text(
                    testReverse
                        ? context.tr('Direction: ${profile.targetScriptCode} -> ${profile.sourceScriptCode}', '方向：${profile.targetScriptCode} -> ${profile.sourceScriptCode}')
                        : context.tr('Direction: ${profile.sourceScriptCode} -> ${profile.targetScriptCode}', '方向：${profile.sourceScriptCode} -> ${profile.targetScriptCode}'),
                  ),
                ],
              ),
              button(
                classes: 'admin-secondary-button',
                attributes: testLoading ? {'disabled': 'disabled'} : null,
                onClick: testLoading ? null : _testConvert,
                [.text(testLoading ? context.tr('Converting...', '转换中...') : context.tr('Convert', '转换'))],
              ),
              if (testError != null)
                div(classes: 'admin-error', [.text(testError!)]),
              if (testOutput.isNotEmpty)
                pre(classes: 'script-test-output', [.text(testOutput)]),
            ]),
          ]),

          if (preview != null) ...[
            div(classes: 'script-preview-stats', [
              _stat(context.tr('Total', '总计'), preview!.totalRows),
              _stat(context.tr('Valid', '有效'), preview!.validRows),
              _stat(context.tr('Warnings', '警告'), preview!.warningRows),
              _stat(context.tr('Errors', '错误'), preview!.errorRows),
            ]),
            div(classes: 'script-preview-table-wrap', [
              table(classes: 'script-preview-table', [
                thead([
                  tr([
                    th([.text(context.tr('Row', '行'))]),
                    th([.text(context.tr('Source', '源'))]),
                    th([.text(context.tr('Target', '目标'))]),
                    th([.text(context.tr('Type', '类型'))]),
                    th([.text(context.tr('Priority', '优先级'))]),
                    th([.text(context.tr('Status', '状态'))]),
                  ]),
                ]),
                tbody([
                  for (final row in preview!.rows.take(50))
                    tr([
                      td([.text('${row.rowNumber}')]),
                      td([.text(row.sourceText ?? '')]),
                      td([.text(row.targetText ?? '')]),
                      td([.text(row.entryType)]),
                      td([.text('${row.priority}')]),
                      td([
                        .text(
                          row.message == null
                              ? row.status
                              : '${row.status}: ${row.message}',
                        ),
                      ]),
                    ]),
                ]),
              ]),
            ]),
            div(classes: 'script-import-actions', [
              button(
                classes: 'admin-primary-button',
                attributes: commitLoading ? {'disabled': 'disabled'} : null,
                onClick: commitLoading ? null : _commitExcel,
                [.text(commitLoading ? context.tr('Importing...', '导入中...') : context.tr('Confirm import', '确认导入'))],
              ),
              if (commitError != null)
                div(classes: 'admin-error', [.text(commitError!)]),
              if (commitResult != null)
                span(classes: 'script-import-result', [
                  .text(
                    context.tr('Inserted ${commitResult!.insertedRows}, updated ${commitResult!.updatedRows}, skipped ${commitResult!.skippedRows}.', '新增 ${commitResult!.insertedRows}，更新 ${commitResult!.updatedRows}，跳过 ${commitResult!.skippedRows}。'),
                  ),
                ]),
            ]),
          ],
        ]),

        section(classes: 'script-conversion-panel', [
          div(classes: 'script-conversion-section-header', [
            div([
              h3([.text(context.tr('Conversion Entries', '转换条目'))]),
              p(classes: 'admin-muted', [
                .text(
                  context.tr('Types: dictionary, exception, sequence, character. Exceptions run before dictionary, then rules.', '类型：dictionary、exception、sequence、character。先执行例外，再执行词典，最后执行规则。'),
                ),
              ]),
            ]),
            button(
              classes: 'admin-secondary-button',
              onClick: profile.id == null
                  ? null
                  : () {
                      _loadEntries(profile.id!);
                    },
              [.text(context.tr('Reload entries', '重新加载条目'))],
            ),
          ]),
          if (entriesLoading)
            p(classes: 'admin-muted', [.text(context.tr('Loading entries...', '正在加载条目...'))])
          else if (entriesError != null)
            div(classes: 'admin-error', [.text(entriesError!)])
          else if (entries.isEmpty)
            p(classes: 'admin-muted', [.text(context.tr('No conversion entries yet.', '暂无转换条目。'))])
          else
            div(classes: 'script-entry-list', [
              for (final entry in entries)
                div(classes: 'script-entry-card', [
                  if (editingEntryId == entry.id) ...[
                    div(classes: 'script-entry-edit-grid', [
                      _field(
                        context.tr('Source', '源'),
                        entrySource,
                        (value) => entrySource = value,
                      ),
                      _field(
                        context.tr('Target', '目标'),
                        entryTarget,
                        (value) => entryTarget = value,
                      ),
                      _field(
                        context.tr('Priority', '优先级'),
                        entryPriority,
                        (value) => entryPriority = value,
                      ),
                      _field(context.tr('Type', '类型'), entryType, (value) => entryType = value),
                      _field(context.tr('Note', '备注'), entryNote, (value) => entryNote = value),
                    ]),
                    div(classes: 'script-entry-actions', [
                      button(
                        classes: 'admin-primary-button',
                        attributes: entrySaving
                            ? {'disabled': 'disabled'}
                            : null,
                        onClick: entrySaving ? null : _saveEntry,
                        [.text(entrySaving ? context.tr('Saving...', '保存中...') : context.tr('Save entry', '保存条目'))],
                      ),
                      button(
                        classes: 'admin-secondary-button',
                        onClick: entrySaving
                            ? null
                            : () {
                                setState(() {
                                  editingEntryId = null;
                                  entryActionError = null;
                                });
                              },
                        [.text(context.tr('Cancel', '取消'))],
                      ),
                    ]),
                  ] else ...[
                    div(classes: 'script-entry-main', [
                      div(classes: 'script-entry-pair', [
                        strong([.text(entry.sourceText)]),
                        span([.text('->')]),
                        strong([.text(entry.targetText)]),
                      ]),
                      div(classes: 'script-entry-meta', [
                        span([.text(entry.entryType ?? 'dictionary')]),
                        span([.text(context.tr('Priority ${entry.priority}', '优先级 ${entry.priority}'))]),
                        if (entry.note != null && entry.note!.isNotEmpty)
                          span([.text(entry.note!)]),
                        span([.text('#${entry.id}')]),
                      ]),
                    ]),
                    div(classes: 'script-entry-actions', [
                      button(
                        classes: 'admin-secondary-button',
                        onClick: () {
                          _startEditEntry(entry);
                        },
                        [.text(context.tr('Edit', '编辑'))],
                      ),
                      button(
                        classes: 'script-danger-button',
                        attributes: deletingEntryId == entry.id
                            ? {'disabled': 'disabled'}
                            : null,
                        onClick: deletingEntryId == entry.id
                            ? null
                            : () {
                                if (entry.id != null) {
                                  _deleteEntry(entry.id!);
                                }
                              },
                        [
                          .text(
                            deletingEntryId == entry.id
                                ? context.tr('Deleting...', '删除中...')
                                : context.tr('Delete', '删除'),
                          ),
                        ],
                      ),
                    ]),
                  ],
                ]),
            ]),
          if (entryActionError != null)
            div(classes: 'admin-error', [.text(entryActionError!)]),
        ]),
      ],
    ]);
  }
}
