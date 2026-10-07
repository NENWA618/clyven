import 'package:glyphora_web_l10n/web_l10n.dart';
import 'dart:convert';

import 'package:glyphora_backend_client/backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

import '../../services/excel_file_reader.dart';
import '../../services/studio_client.dart';

class DictionaryImportPage extends StatefulComponent {
  const DictionaryImportPage({super.key});

  @override
  State<DictionaryImportPage> createState() => _DictionaryImportPageState();
}

class _DictionaryImportPageState extends State<DictionaryImportPage> {
  final client = studioClient;

  // =========================
  // LOGIN
  // =========================

  String loginEmail = '';
  String loginPassword = '';

  bool loginLoading = false;
  bool loggedIn = studioClient.auth.isAuthenticated;

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
        loginError = trNow('Enter your email', '请输入邮箱');
      });
      return;
    }

    if (loginPassword.isEmpty) {
      setState(() {
        loginError = trNow('Enter your password', '请输入密码');
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
        previewError = trNow('Select an Import Profile', '请选择 Import Profile');
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
        throw Exception(trNow('Select an Excel file', '请选择 Excel 文件'));
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
        commitError = trNow('Sign in to Studio first', '请先登录 Studio');
      });
      return;
    }

    if (selectedProfileId == null) {
      setState(() {
        commitError = trNow('Select an Import Profile', '请选择 Import Profile');
      });
      return;
    }

    if (previewExcelBase64 == null) {
      setState(() {
        commitError = trNow('There is no Excel file to import', '没有可导入的 Excel 文件');
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
            h1([.text(context.tr('Dictionary Import', '词典导入'))]),
            p([
              .text(context.tr('Preview and import dictionary Excel data through an Import Profile.', '通过 Import Profile 预览并导入词典 Excel 数据。')),
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
                  h3([.text(context.tr('Studio Login', 'Studio 登录'))]),
                  p([
                    .text(
                      context.tr('Sign in before making real changes to dictionary, subtitles and videos.', '正式修改词典、字幕和视频内容前需要登录。'),
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
                        loginLoading ? context.tr('Signing in...', '登录中...') : context.tr('Sign in', '登录'),
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
            [.text(context.tr('✓ Signed in to Studio', '✓ Studio 已登录'))],
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
                    p([.text(context.tr('Choose the dictionary import rules.', '选择词典导入规则。'))]),
                  ],
                ),
                div(
                  classes: 'panel-body',
                  [
                    if (loading)
                      p([.text(context.tr('Loading profiles...', '正在读取 Profile...'))])
                    else if (error != null)
                      p([.text(context.tr('Could not load profiles: $error', '无法读取 Profile：$error'))])
                    else if (profiles.isEmpty)
                      p([.text(context.tr('No profiles yet', '暂无 Profile'))])
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
                                  context.tr('Language: ${profile.languageCode} · ID: ${profile.id}', '语言：${profile.languageCode} · ID：${profile.id}'),
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
                        context.tr('Upload an Excel file to preview first; nothing is written to the database yet.', '上传 Excel 后先进行 Preview，不会直接写入数据库。'),
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
                          [.text(context.tr('Choose an Excel file', '选择 Excel 文件'))],
                        ),
                        p(
                          classes: 'upload-description',
                          [.text(context.tr('Supports .xlsx / .xls', '支持 .xlsx / .xls'))],
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
                        [.text(context.tr('Analyzing Excel...', '正在分析 Excel...'))],
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
                            context.tr('Total', '总计'),
                            preview!.totalRows,
                          ),
                          _statCard(
                            context.tr('Valid', '有效'),
                            preview!.validRows,
                            tone: 'valid',
                          ),
                          _statCard(
                            context.tr('Warnings', '警告'),
                            preview!.warningRows,
                            tone: 'warning',
                          ),
                          _statCard(
                            context.tr('Errors', '错误'),
                            preview!.errorRows,
                            tone: 'error',
                          ),
                        ],
                      ),

                      if (preview!.warningRows > 0)
                        div(
                          classes: 'warning-section',
                          [
                            h3([.text(context.tr('Warning Rows', '警告行'))]),
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
                                            context.tr('Row ${row.rowNumber}', '第 ${row.rowNumber} 行'),
                                          ),
                                        ]),
                                        .text(
                                          ' · ${row.headword ?? context.tr('(no headword)', '(无主词)')} · ${row.message ?? context.tr('Warning', '警告')}',
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
                                preview!.errorRows > 0 ? context.tr('Errors found; cannot import', '存在错误，无法导入') : context.tr('Confirm Import', '确认导入'),
                              ),
                            ],
                          ),
                        ],
                      ),

                      if (showImportConfirm)
                        div(
                          classes: 'confirm-box',
                          [
                            h3([.text(context.tr('Confirm import', '确认导入'))]),
                            p([
                              .text(
                                context.tr('Profile: ${preview!.profile.name}', 'Profile：${preview!.profile.name}'),
                              ),
                            ]),
                            p([
                              .text(
                                context.tr('Total: ${preview!.totalRows}', '总计：${preview!.totalRows}'),
                              ),
                            ]),
                            p([
                              .text(
                                context.tr('Will import: ${preview!.validRows}', '将导入：${preview!.validRows}'),
                              ),
                            ]),
                            p([
                              .text(
                                context.tr('Will skip: ${preview!.warningRows}', '将跳过：${preview!.warningRows}'),
                              ),
                            ]),
                            p([
                              .text(
                                context.tr('Errors: ${preview!.errorRows}', '错误：${preview!.errorRows}'),
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
                                  [.text(context.tr('Cancel', '取消'))],
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
                                      commitLoading ? context.tr('Importing...', '正在导入...') : context.tr('Import', '正式导入'),
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
                            selectedProfileId == null ? context.tr('Select an Import Profile first', '请先选择 Import Profile') : context.tr('Preview results will appear here', 'Preview 结果会显示在这里'),
                          ),
                        ],
                      ),

                    if (commitResult != null)
                      div(
                        classes: 'commit-result',
                        [
                          h3([.text(context.tr('Import Complete', '导入完成'))]),
                          p(
                            classes: 'commit-result-description',
                            [.text(context.tr('The Excel file has been imported.', 'Excel 已完成正式导入。'))],
                          ),
                          div(
                            classes: 'stats-grid',
                            [
                              _statCard(
                                context.tr('Total', '总计'),
                                commitResult!.totalRows,
                              ),
                              _statCard(
                                context.tr('Inserted', '新增'),
                                commitResult!.insertedEntries,
                                tone: 'valid',
                              ),
                              _statCard(
                                context.tr('Merged', '合并'),
                                commitResult!.mergedEntries,
                              ),
                              _statCard(
                                context.tr('Skipped', '跳过'),
                                commitResult!.skippedRows,
                                tone: 'warning',
                              ),
                              _statCard(
                                context.tr('Failed', '失败'),
                                commitResult!.failedRows,
                                tone: 'error',
                              ),
                            ],
                          ),
                          if (commitResult!.messages.isNotEmpty)
                            div(
                              classes: 'commit-messages',
                              [
                                h4([.text(context.tr('Messages', '消息'))]),
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
