import 'dart:convert';

import 'package:clyven_backend_client/clyven_backend_client.dart';
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
            'Name, language, scripts and source/target columns are required.';
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
      );

      setState(() {
        savingProfile = false;
        profileActionMessage = 'Profile saved.';
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
        previewError = 'Select a conversion profile first.';
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
        throw StateError('Select an Excel file first.');
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
        commitError = 'Preview an Excel file before importing.';
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
        testError = 'Select a profile first.';
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
          h2([.text('Script Conversion')]),
          p([
            .text(
              'Platform-level conversion data. Separate from client dictionary entries.',
            ),
          ]),
        ]),
        button(
          classes: 'admin-secondary-button',
          onClick: () {
            _loadProfiles();
          },
          [.text('Reload profiles')],
        ),
      ]),

      div(classes: 'script-conversion-layout', [
        section(classes: 'script-conversion-panel', [
          h3([.text('Conversion Profiles')]),
          p(classes: 'admin-muted', [
            .text('One language can have multiple script conversion profiles.'),
          ]),
          if (loadingProfiles)
            p([.text('Loading...')])
          else if (loadError != null)
            div(classes: 'admin-error', [.text(loadError!)])
          else if (profiles.isEmpty)
            p(classes: 'admin-muted', [.text('No profiles yet.')])
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
                  ],
                ),
            ]),
        ]),

        section(classes: 'script-conversion-panel', [
          h3([.text('New Profile')]),
          div(classes: 'script-conversion-form-grid', [
            _field(
              'Name',
              name,
              (value) => name = value,
              placeholder: 'Vietnamese Latin -> Nom',
            ),
            _field(
              'Language',
              languageCode,
              (value) => languageCode = value,
              placeholder: 'vi / tr / kk',
            ),
            _field(
              'Source script',
              sourceScriptCode,
              (value) => sourceScriptCode = value,
              placeholder: 'Latn',
            ),
            _field(
              'Target script',
              targetScriptCode,
              (value) => targetScriptCode = value,
              placeholder: 'Nom / Arab / Cyrl',
            ),
            _field(
              'Sheet name',
              sheetName,
              (value) => sheetName = value,
              placeholder: 'blank = first sheet',
            ),
            _field(
              'Source column',
              sourceColumn,
              (value) => sourceColumn = value,
            ),
            _field(
              'Target column',
              targetColumn,
              (value) => targetColumn = value,
            ),
            _field(
              'Priority column',
              priorityColumn,
              (value) => priorityColumn = value,
              placeholder: 'optional',
            ),
            _field(
              'Note column',
              noteColumn,
              (value) => noteColumn = value,
              placeholder: 'optional',
            ),
          ]),
          if (createError != null)
            div(classes: 'admin-error', [.text(createError!)]),
          button(
            classes: 'admin-primary-button',
            attributes: creating ? {'disabled': 'disabled'} : null,
            onClick: creating ? null : _createProfile,
            [.text(creating ? 'Creating...' : 'Create profile')],
          ),
        ]),
      ]),

      if (profile != null) ...[
        section(classes: 'script-conversion-panel', [
          div(classes: 'script-conversion-section-header', [
            div([
              h3([.text('Edit Profile')]),
              p(classes: 'admin-muted', [
                .text(
                  '${profile.languageCode} / ${profile.sourceScriptCode} -> ${profile.targetScriptCode}',
                ),
              ]),
            ]),
            span(classes: 'clyven-admin-scope-badge', [
              .text('PROFILE #${profile.id}'),
            ]),
          ]),
          div(classes: 'script-conversion-form-grid', [
            _field('Name', editName, (value) => editName = value),
            _field(
              'Language',
              editLanguageCode,
              (value) => editLanguageCode = value,
            ),
            _field(
              'Source script',
              editSourceScriptCode,
              (value) => editSourceScriptCode = value,
            ),
            _field(
              'Target script',
              editTargetScriptCode,
              (value) => editTargetScriptCode = value,
            ),
            _field(
              'Sheet name',
              editSheetName,
              (value) => editSheetName = value,
            ),
            _field(
              'Source column',
              editSourceColumn,
              (value) => editSourceColumn = value,
            ),
            _field(
              'Target column',
              editTargetColumn,
              (value) => editTargetColumn = value,
            ),
            _field(
              'Priority column',
              editPriorityColumn,
              (value) => editPriorityColumn = value,
            ),
            _field(
              'Note column',
              editNoteColumn,
              (value) => editNoteColumn = value,
            ),
          ]),
          div(classes: 'script-profile-actions', [
            button(
              classes: 'admin-primary-button',
              attributes: savingProfile ? {'disabled': 'disabled'} : null,
              onClick: savingProfile ? null : _saveProfile,
              [.text(savingProfile ? 'Saving...' : 'Save profile')],
            ),
            button(
              classes: 'script-danger-button',
              attributes: deletingProfile ? {'disabled': 'disabled'} : null,
              onClick: deletingProfile ? null : _deleteProfile,
              [.text(deletingProfile ? 'Deleting...' : 'Delete profile')],
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
                  '${profile.languageCode} / ${profile.sourceScriptCode} -> ${profile.targetScriptCode}',
                ),
              ]),
            ]),
            span(classes: 'clyven-admin-scope-badge', [.text('PLATFORM DATA')]),
          ]),

          div(classes: 'script-import-grid', [
            div(classes: 'script-upload-box', [
              strong([.text('Import Excel')]),
              p(classes: 'admin-muted', [
                .text(
                  'Required columns: ${profile.sourceColumn}, ${profile.targetColumn}',
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
              strong([.text('Test Converter')]),
              textarea(
                [.text(testInput)],
                attributes: {'placeholder': 'Enter text to convert'},
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
                        ? 'Direction: ${profile.targetScriptCode} -> ${profile.sourceScriptCode}'
                        : 'Direction: ${profile.sourceScriptCode} -> ${profile.targetScriptCode}',
                  ),
                ],
              ),
              button(
                classes: 'admin-secondary-button',
                attributes: testLoading ? {'disabled': 'disabled'} : null,
                onClick: testLoading ? null : _testConvert,
                [.text(testLoading ? 'Converting...' : 'Convert')],
              ),
              if (testError != null)
                div(classes: 'admin-error', [.text(testError!)]),
              if (testOutput.isNotEmpty)
                pre(classes: 'script-test-output', [.text(testOutput)]),
            ]),
          ]),

          if (preview != null) ...[
            div(classes: 'script-preview-stats', [
              _stat('Total', preview!.totalRows),
              _stat('Valid', preview!.validRows),
              _stat('Warnings', preview!.warningRows),
              _stat('Errors', preview!.errorRows),
            ]),
            div(classes: 'script-preview-table-wrap', [
              table(classes: 'script-preview-table', [
                thead([
                  tr([
                    th([.text('Row')]),
                    th([.text('Source')]),
                    th([.text('Target')]),
                    th([.text('Priority')]),
                    th([.text('Status')]),
                  ]),
                ]),
                tbody([
                  for (final row in preview!.rows.take(50))
                    tr([
                      td([.text('${row.rowNumber}')]),
                      td([.text(row.sourceText ?? '')]),
                      td([.text(row.targetText ?? '')]),
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
                [.text(commitLoading ? 'Importing...' : 'Confirm import')],
              ),
              if (commitError != null)
                div(classes: 'admin-error', [.text(commitError!)]),
              if (commitResult != null)
                span(classes: 'script-import-result', [
                  .text(
                    'Inserted ${commitResult!.insertedRows}, updated ${commitResult!.updatedRows}, skipped ${commitResult!.skippedRows}.',
                  ),
                ]),
            ]),
          ],
        ]),

        section(classes: 'script-conversion-panel', [
          div(classes: 'script-conversion-section-header', [
            div([
              h3([.text('Conversion Entries')]),
              p(classes: 'admin-muted', [
                .text('Showing up to 200 imported entries for this profile.'),
              ]),
            ]),
            button(
              classes: 'admin-secondary-button',
              onClick: profile.id == null
                  ? null
                  : () {
                      _loadEntries(profile.id!);
                    },
              [.text('Reload entries')],
            ),
          ]),
          if (entriesLoading)
            p(classes: 'admin-muted', [.text('Loading entries...')])
          else if (entriesError != null)
            div(classes: 'admin-error', [.text(entriesError!)])
          else if (entries.isEmpty)
            p(classes: 'admin-muted', [.text('No conversion entries yet.')])
          else
            div(classes: 'script-entry-list', [
              for (final entry in entries)
                div(classes: 'script-entry-card', [
                  if (editingEntryId == entry.id) ...[
                    div(classes: 'script-entry-edit-grid', [
                      _field(
                        'Source',
                        entrySource,
                        (value) => entrySource = value,
                      ),
                      _field(
                        'Target',
                        entryTarget,
                        (value) => entryTarget = value,
                      ),
                      _field(
                        'Priority',
                        entryPriority,
                        (value) => entryPriority = value,
                      ),
                      _field('Note', entryNote, (value) => entryNote = value),
                    ]),
                    div(classes: 'script-entry-actions', [
                      button(
                        classes: 'admin-primary-button',
                        attributes: entrySaving
                            ? {'disabled': 'disabled'}
                            : null,
                        onClick: entrySaving ? null : _saveEntry,
                        [.text(entrySaving ? 'Saving...' : 'Save entry')],
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
                        [.text('Cancel')],
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
                        span([.text('Priority ${entry.priority}')]),
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
                        [.text('Edit')],
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
                                ? 'Deleting...'
                                : 'Delete',
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
