import 'dart:convert';

import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

import '../../services/excel_file_reader.dart';

class _MemoryAuthStorage implements ClientAuthSuccessStorage {
  AuthSuccess? _value;

  @override
  Future<AuthSuccess?> get() async {
    return _value;
  }

  @override
  Future<void> set(AuthSuccess? data) async {
    _value = data;
  }
}

class DictionaryImportPage extends StatefulComponent {
  const DictionaryImportPage({super.key});

  @override
  State<DictionaryImportPage> createState() => _DictionaryImportPageState();
}

class _DictionaryImportPageState extends State<DictionaryImportPage> {
  final client =
      Client(
          'https://glyphora-server-11129163384.asia-southeast1.run.app/',
          connectionTimeout: const Duration(minutes: 2),
        )
        ..authSessionManager = ClientAuthSessionManager(
          storage: _MemoryAuthStorage(),
        );

  // =========================
  // LOGIN
  // =========================

  String loginEmail = '';
  String loginPassword = '';

  bool loginLoading = false;
  bool loggedIn = false;

  String? loginError;

  // =========================
  // SERVER / PROFILE
  // =========================

  bool loading = true;
  String? error;

  List<DictionaryImportProfile> profiles = [];
  int? selectedProfileId;

  // =========================
  // DICTIONARY PREVIEW
  // =========================

  bool previewLoading = false;
  String? previewError;

  DictionaryImportPreview? preview;
  String? previewExcelBase64;

  // =========================
  // DICTIONARY COMMIT
  // =========================

  bool showImportConfirm = false;

  bool commitLoading = false;
  String? commitError;

  DictionaryImportCommitResult? commitResult;

  @override
  void initState() {
    super.initState();
    _loadProfiles();
  }

  // =========================
  // LOGIN
  // =========================

  Future<void> _login() async {
    if (loginEmail.trim().isEmpty) {
      setState(() {
        loginError = '请输入邮箱';
      });
      return;
    }

    if (loginPassword.isEmpty) {
      setState(() {
        loginError = '请输入密码';
      });
      return;
    }

    setState(() {
      loginLoading = true;
      loginError = null;
    });

    try {
      final authSuccess = await client.emailIdp.login(
        email: loginEmail.trim().toLowerCase(),
        password: loginPassword,
      );

      await client.auth.updateSignedInUser(authSuccess);

      setState(() {
        loggedIn = true;
        loginLoading = false;
        loginPassword = '';
      });
    } catch (e) {
      setState(() {
        loggedIn = false;
        loginLoading = false;
        loginError = e.toString();
      });
    }
  }

  // =========================
  // LOAD IMPORT PROFILES
  // =========================

  Future<void> _loadProfiles() async {
    try {
      final result = await client.dictionaryImport.getProfiles();

      setState(() {
        profiles = result;

        if (result.isNotEmpty) {
          selectedProfileId = result.first.id;
        }

        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  // =========================
  // PREVIEW EXCEL
  // =========================

  Future<void> _previewExcel() async {
    if (selectedProfileId == null) {
      setState(() {
        previewError = '请选择 Import Profile';
      });
      return;
    }

    setState(() {
      previewLoading = true;
      previewError = null;
      preview = null;
      previewExcelBase64 = null;
      showImportConfirm = false;
      commitResult = null;
      commitError = null;
    });

    try {
      final bytes = await readSelectedExcelFile('excel-file');

      if (bytes == null) {
        throw Exception('请选择 Excel 文件');
      }

      final excelBase64 = base64Encode(bytes);

      final result = await client.dictionaryImport.previewExcelBase64(
        profileId: selectedProfileId!,
        excelBase64: excelBase64,
      );

      setState(() {
        preview = result;
        previewExcelBase64 = excelBase64;
        previewLoading = false;
      });
    } catch (e) {
      setState(() {
        previewError = e.toString();
        previewLoading = false;
      });
    }
  }

  // =========================
  // COMMIT EXCEL
  // =========================

  Future<void> _commitExcel() async {
    if (!loggedIn) {
      setState(() {
        commitError = '请先登录 Studio';
      });
      return;
    }

    if (selectedProfileId == null) {
      setState(() {
        commitError = '请选择 Import Profile';
      });
      return;
    }

    if (previewExcelBase64 == null) {
      setState(() {
        commitError = '没有可导入的 Excel 文件';
      });
      return;
    }

    setState(() {
      commitLoading = true;
      commitError = null;
      commitResult = null;
    });

    try {
      final result = await client.dictionaryImport.commitExcelBase64(
        profileId: selectedProfileId!,
        excelBase64: previewExcelBase64!,
      );

      setState(() {
        commitResult = result;
        commitLoading = false;
        showImportConfirm = false;
      });
    } catch (e) {
      setState(() {
        commitError = e.toString();
        commitLoading = false;
      });
    }
  }

  // =========================
  // COMMON UI
  // =========================

  Component _statCard(
    String label,
    int value, {
    String tone = '',
  }) {
    return div(
      classes: 'stat-card $tone',
      [
        div(
          classes: 'stat-label',
          [.text(label)],
        ),
        div(
          classes: 'stat-value',
          [.text('$value')],
        ),
      ],
    );
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'studio-page',
      [
        div(
          classes: 'page-heading',
          [
            h1([.text('Dictionary Import')]),
            p([
              .text('通过 Import Profile 预览并导入词典 Excel 数据。'),
            ]),
          ],
        ),

        // =========================
        // LOGIN
        // =========================
        if (!loggedIn)
          div(
            classes: 'login-panel',
            [
              div(
                classes: 'login-header',
                [
                  h3([.text('Studio Login')]),
                  p([
                    .text(
                      '正式修改词典、字幕和视频内容前需要登录。',
                    ),
                  ]),
                ],
              ),
              div(
                classes: 'login-fields',
                [
                  input<String>(
                    type: InputType.email,
                    attributes: {
                      'placeholder': 'Email',
                      'autocomplete': 'email',
                    },
                    events: events<String>(
                      onInput: (value) {
                        loginEmail = value;
                      },
                    ),
                  ),
                  input<String>(
                    type: InputType.password,
                    attributes: {
                      'placeholder': 'Password',
                      'autocomplete': 'current-password',
                    },
                    events: events<String>(
                      onInput: (value) {
                        loginPassword = value;
                      },
                    ),
                  ),
                  button(
                    classes: 'login-button',
                    attributes: loginLoading
                        ? {
                            'disabled': 'disabled',
                          }
                        : null,
                    onClick: loginLoading
                        ? null
                        : () {
                            _login();
                          },
                    [
                      .text(
                        loginLoading ? '登录中...' : '登录',
                      ),
                    ],
                  ),
                ],
              ),
              if (loginError != null)
                div(
                  classes: 'login-error',
                  [.text(loginError!)],
                ),
            ],
          )
        else
          div(
            classes: 'login-success',
            [.text('✓ Studio 已登录')],
          ),

        // =========================
        // DICTIONARY IMPORT
        // =========================
        div(
          classes: 'layout-grid',
          [
            // LEFT: PROFILE
            div(
              classes: 'panel',
              [
                div(
                  classes: 'panel-header',
                  [
                    h2([.text('Import Profile')]),
                    p([.text('选择词典导入规则。')]),
                  ],
                ),
                div(
                  classes: 'panel-body',
                  [
                    if (loading)
                      p([.text('正在读取 Profile...')])
                    else if (error != null)
                      p([.text('无法读取 Profile：$error')])
                    else if (profiles.isEmpty)
                      p([.text('暂无 Profile')])
                    else
                      for (final profile in profiles)
                        button(
                          classes: 'profile-card ${selectedProfileId == profile.id ? 'selected' : ''}',
                          onClick: () {
                            setState(() {
                              selectedProfileId = profile.id;
                              preview = null;
                              previewError = null;
                              previewExcelBase64 = null;
                              showImportConfirm = false;
                              commitResult = null;
                              commitError = null;
                            });
                          },
                          [
                            div(
                              classes: 'profile-name',
                              [.text(profile.name)],
                            ),
                            div(
                              classes: 'profile-meta',
                              [
                                .text(
                                  'Language: ${profile.languageCode} · ID: ${profile.id}',
                                ),
                              ],
                            ),
                          ],
                        ),
                  ],
                ),
              ],
            ),

            // RIGHT: DICTIONARY IMPORT
            div(
              classes: 'panel',
              [
                div(
                  classes: 'panel-header',
                  [
                    h2([.text('Dictionary Import')]),
                    p([
                      .text(
                        '上传 Excel 后先进行 Preview，不会直接写入数据库。',
                      ),
                    ]),
                  ],
                ),
                div(
                  classes: 'panel-body',
                  [
                    div(
                      classes: 'upload-zone',
                      [
                        div(
                          classes: 'upload-icon',
                          [.text('↑')],
                        ),
                        p(
                          classes: 'upload-title',
                          [.text('选择 Excel 文件')],
                        ),
                        p(
                          classes: 'upload-description',
                          [.text('支持 .xlsx / .xls')],
                        ),
                        input<String>(
                          id: 'excel-file',
                          type: InputType.file,
                          attributes: {
                            'accept': '.xlsx,.xls',
                          },
                          events: {
                            'change': (_) {
                              _previewExcel();
                            },
                          },
                        ),
                      ],
                    ),

                    if (previewLoading)
                      div(
                        classes: 'preview-loading',
                        [.text('正在分析 Excel...')],
                      ),

                    if (previewError != null)
                      div(
                        classes: 'preview-error',
                        [.text(previewError!)],
                      ),

                    if (preview != null) ...[
                      div(
                        classes: 'stats-grid',
                        [
                          _statCard(
                            'Total',
                            preview!.totalRows,
                          ),
                          _statCard(
                            'Valid',
                            preview!.validRows,
                            tone: 'valid',
                          ),
                          _statCard(
                            'Warnings',
                            preview!.warningRows,
                            tone: 'warning',
                          ),
                          _statCard(
                            'Errors',
                            preview!.errorRows,
                            tone: 'error',
                          ),
                        ],
                      ),

                      if (preview!.warningRows > 0)
                        div(
                          classes: 'warning-section',
                          [
                            h3([.text('Warning Rows')]),
                            ul(
                              classes: 'warning-list',
                              [
                                for (final row in preview!.rows)
                                  if (row.status == 'warning')
                                    li(
                                      classes: 'warning-item',
                                      [
                                        strong([
                                          .text(
                                            'Row ${row.rowNumber}',
                                          ),
                                        ]),
                                        .text(
                                          ' · ${row.headword ?? '(无主词)'} · ${row.message ?? 'Warning'}',
                                        ),
                                      ],
                                    ),
                              ],
                            ),
                          ],
                        ),

                      div(
                        classes: 'import-actions',
                        [
                          button(
                            classes: 'import-button',
                            attributes: preview!.errorRows > 0
                                ? {
                                    'disabled': 'disabled',
                                  }
                                : null,
                            onClick: preview!.errorRows > 0
                                ? null
                                : () {
                                    setState(() {
                                      showImportConfirm = true;
                                    });
                                  },
                            [
                              .text(
                                preview!.errorRows > 0 ? '存在错误，无法导入' : 'Confirm Import',
                              ),
                            ],
                          ),
                        ],
                      ),

                      if (showImportConfirm)
                        div(
                          classes: 'confirm-box',
                          [
                            h3([.text('确认导入')]),
                            p([
                              .text(
                                'Profile: ${preview!.profile.name}',
                              ),
                            ]),
                            p([
                              .text(
                                'Total: ${preview!.totalRows}',
                              ),
                            ]),
                            p([
                              .text(
                                'Will import: ${preview!.validRows}',
                              ),
                            ]),
                            p([
                              .text(
                                'Will skip: ${preview!.warningRows}',
                              ),
                            ]),
                            p([
                              .text(
                                'Errors: ${preview!.errorRows}',
                              ),
                            ]),
                            div(
                              classes: 'confirm-actions',
                              [
                                button(
                                  classes: 'cancel-button',
                                  onClick: commitLoading
                                      ? null
                                      : () {
                                          setState(() {
                                            showImportConfirm = false;
                                          });
                                        },
                                  [.text('取消')],
                                ),
                                button(
                                  classes: 'commit-button',
                                  attributes: commitLoading
                                      ? {
                                          'disabled': 'disabled',
                                        }
                                      : null,
                                  onClick: commitLoading
                                      ? null
                                      : () {
                                          _commitExcel();
                                        },
                                  [
                                    .text(
                                      commitLoading ? '正在导入...' : '正式导入',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (commitError != null)
                              div(
                                classes: 'preview-error',
                                [.text(commitError!)],
                              ),
                          ],
                        ),
                    ] else if (!previewLoading)
                      p(
                        classes: 'empty-state',
                        [
                          .text(
                            selectedProfileId == null ? '请先选择 Import Profile' : 'Preview 结果会显示在这里',
                          ),
                        ],
                      ),

                    if (commitResult != null)
                      div(
                        classes: 'commit-result',
                        [
                          h3([.text('Import Complete')]),
                          p(
                            classes: 'commit-result-description',
                            [.text('Excel 已完成正式导入。')],
                          ),
                          div(
                            classes: 'stats-grid',
                            [
                              _statCard(
                                'Total',
                                commitResult!.totalRows,
                              ),
                              _statCard(
                                'Inserted',
                                commitResult!.insertedEntries,
                                tone: 'valid',
                              ),
                              _statCard(
                                'Merged',
                                commitResult!.mergedEntries,
                              ),
                              _statCard(
                                'Skipped',
                                commitResult!.skippedRows,
                                tone: 'warning',
                              ),
                              _statCard(
                                'Failed',
                                commitResult!.failedRows,
                                tone: 'error',
                              ),
                            ],
                          ),
                          if (commitResult!.messages.isNotEmpty)
                            div(
                              classes: 'commit-messages',
                              [
                                h4([.text('Messages')]),
                                ul([
                                  for (final message in commitResult!.messages) li([.text(message)]),
                                ]),
                              ],
                            ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
