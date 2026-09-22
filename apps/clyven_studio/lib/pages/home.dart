import 'dart:convert';

import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../services/excel_file_reader.dart';
import '../services/studio_client.dart';

class Home extends StatefulComponent {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  // =========================
  // DICTIONARY TABLE
  // =========================

  List<DictionaryEntryDetail> dictionaryEntries = [];

  bool dictionaryEntriesLoading = false;
  String? dictionaryEntriesError;

  int dictionaryVisibleCount = 100;

  // =========================
  // SUBTITLE WORKSPACE
  // =========================

  List<Video> studioVideos = [];
  int? selectedVideoId;

  String subtitleLanguageCode = 'vi';

  bool videosLoading = false;
  bool subtitleLoading = false;

  String? videosError;
  String? subtitleError;

  List<SubtitleCueDetail> subtitleCues = [];

  @override
  void initState() {
    super.initState();

    _restoreLogin();
    _loadProfiles();
    _loadVideos();
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

      await _loadDictionaryEntries();
    } catch (e) {
      setState(() {
        loggedIn = false;
        loginLoading = false;
        loginError = e.toString();
      });
    }
  }

  Future<void> _restoreLogin() async {
    try {
      await client.auth.initialize();

      if (!mounted) {
        return;
      }

      final authenticated = client.auth.isAuthenticated;

      setState(() {
        loggedIn = authenticated;
      });

      if (authenticated) {
        await _loadDictionaryEntries();
      }
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        loggedIn = false;
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

      await _loadDictionaryEntries();
    } catch (e) {
      setState(() {
        commitError = e.toString();
        commitLoading = false;
      });
    }
  }

  Future<void> _loadDictionaryEntries() async {
    if (!loggedIn) {
      return;
    }

    setState(() {
      dictionaryEntriesLoading = true;
      dictionaryEntriesError = null;
    });

    try {
      const pageSize = 100;

      final allEntries = <DictionaryEntryDetail>[];

      var offset = 0;

      while (true) {
        final page = await client.dictionary.listEntries(
          languageCode: 'vi',
          offset: offset,
          limit: pageSize,
        );

        allEntries.addAll(page);

        if (page.length < pageSize) {
          break;
        }

        offset += page.length;
      }

      setState(() {
        dictionaryEntries = allEntries;
        dictionaryEntriesLoading = false;
        dictionaryVisibleCount = 100;
      });
    } catch (e) {
      setState(() {
        dictionaryEntriesLoading = false;
        dictionaryEntriesError = e.toString();
      });
    }
  }

  String _dictionaryForm(
    DictionaryEntryDetail detail,
    String scriptCode,
  ) {
    for (final form in detail.forms) {
      if (form.scriptCode == scriptCode) {
        return form.text;
      }
    }

    return '';
  }

  String _dictionaryDefinition(
    DictionaryEntryDetail detail,
    String languageCode,
  ) {
    for (final definition in detail.definitions) {
      if (definition.explanationLanguageCode == languageCode) {
        return definition.gloss;
      }
    }

    return '';
  }

  String _dictionaryExample(
    DictionaryEntryDetail detail, {
    required String languageCode,
    required String scriptCode,
  }) {
    for (final example in detail.examples) {
      for (final text in example.texts) {
        if (text.languageCode == languageCode && text.scriptCode == scriptCode) {
          return text.text;
        }
      }
    }

    return '';
  }

  Future<void> _loadVideos() async {
    setState(() {
      videosLoading = true;
      videosError = null;
    });

    try {
      final result = await client.video.getMyVideos();

      setState(() {
        studioVideos = result;
        videosLoading = false;

        if (result.isNotEmpty && selectedVideoId == null) {
          selectedVideoId = result.first.id;
        }
      });
    } catch (e) {
      setState(() {
        videosError = e.toString();
        videosLoading = false;
      });
    }
  }

  // =========================
  // LOAD SUBTITLES
  // =========================

  Future<void> _loadSubtitles() async {
    if (selectedVideoId == null) {
      setState(() {
        subtitleError = '请选择视频';
      });

      return;
    }

    if (subtitleLanguageCode.trim().isEmpty) {
      setState(() {
        subtitleError = '请输入语言代码';
      });
      return;
    }

    setState(() {
      subtitleLoading = true;
      subtitleError = null;
      subtitleCues = [];
    });

    try {
      final result = await client.subtitle.getCueDetails(
        videoId: selectedVideoId!,
        languageCode: subtitleLanguageCode.trim().toLowerCase(),
      );

      setState(() {
        subtitleCues = result;
        subtitleLoading = false;
      });
    } catch (e) {
      setState(() {
        subtitleError = e.toString();
        subtitleLoading = false;
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
        // =========================
        // HERO
        // =========================
        div(
          classes: 'studio-hero',
          [
            div([
              p(
                classes: 'eyebrow',
                [.text('Clyven Content Operations')],
              ),
              h1(
                classes: 'studio-title',
                [.text('Clyven Studio')],
              ),
              p(
                classes: 'studio-subtitle',
                [
                  .text(
                    '管理 Clyven 的词典、字幕与语言内容。',
                  ),
                ],
              ),
            ]),
            if (loading)
              span(
                classes: 'status-pill',
                [.text('● Connecting...')],
              )
            else if (error != null)
              span(
                classes: 'status-pill error',
                [.text('● Serverpod Offline')],
              )
            else
              span(
                classes: 'status-pill connected',
                [.text('● Serverpod Connected')],
              ),
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

        div(
          classes: 'panel dictionary-table-panel',
          [
            div(
              classes: 'panel-header',
              [
                div(
                  [
                    h2([.text('Dictionary Entries')]),
                    p([
                      .text(
                        '数据库中的越南语主词表，可在这里统一管理。',
                      ),
                    ]),
                  ],
                ),
                div(
                  classes: 'dictionary-table-count',
                  [
                    .text('${dictionaryEntries.length} entries'),
                  ],
                ),
              ],
            ),
            div(
              classes: 'panel-body',
              [
                if (dictionaryEntriesLoading)
                  div(
                    classes: 'preview-loading',
                    [
                      .text('正在读取词库...'),
                    ],
                  )
                else if (dictionaryEntriesError != null)
                  div(
                    classes: 'preview-error',
                    [
                      .text(dictionaryEntriesError!),
                    ],
                  )
                else if (dictionaryEntries.isEmpty)
                  p(
                    classes: 'empty-state',
                    [
                      .text(
                        loggedIn ? '数据库目前没有词条' : '登录后显示词库',
                      ),
                    ],
                  )
                else ...[
                  div(
                    classes: 'dictionary-table-scroll',
                    [
                      div(
                        classes: 'dictionary-table-row dictionary-table-header',
                        [
                          div([.text('#')]),
                          div([.text('国语字')]),
                          div([.text('喃字')]),
                          div([.text('中文')]),
                          div([.text('词性')]),
                          div([.text('国语字例句')]),
                          div([.text('喃字例句')]),
                          div([.text('中文例句')]),
                        ],
                      ),
                      for (
                        var index = 0;
                        index <
                            (dictionaryVisibleCount < dictionaryEntries.length
                                ? dictionaryVisibleCount
                                : dictionaryEntries.length);
                        index++
                      )
                        () {
                          final detail = dictionaryEntries[index];

                          return div(
                            classes: 'dictionary-table-row',
                            [
                              div([
                                .text('${index + 1}'),
                              ]),
                              div([
                                .text(detail.entry.text),
                              ]),
                              div([
                                .text(
                                  _dictionaryForm(
                                    detail,
                                    'nom',
                                  ),
                                ),
                              ]),
                              div([
                                .text(
                                  _dictionaryDefinition(
                                    detail,
                                    'zh',
                                  ),
                                ),
                              ]),
                              div([
                                .text(
                                  detail.entry.partOfSpeech ?? '',
                                ),
                              ]),
                              div([
                                .text(
                                  _dictionaryExample(
                                    detail,
                                    languageCode: 'vi',
                                    scriptCode: 'latn',
                                  ),
                                ),
                              ]),
                              div([
                                .text(
                                  _dictionaryExample(
                                    detail,
                                    languageCode: 'vi',
                                    scriptCode: 'nom',
                                  ),
                                ),
                              ]),
                              div([
                                .text(
                                  _dictionaryExample(
                                    detail,
                                    languageCode: 'zh',
                                    scriptCode: 'hans',
                                  ),
                                ),
                              ]),
                            ],
                          );
                        }(),
                    ],
                  ),
                  if (dictionaryVisibleCount < dictionaryEntries.length)
                    div(
                      classes: 'dictionary-load-more',
                      [
                        button(
                          classes: 'import-button',
                          onClick: () {
                            setState(() {
                              final next = dictionaryVisibleCount + 100;

                              dictionaryVisibleCount = next > dictionaryEntries.length
                                  ? dictionaryEntries.length
                                  : next;
                            });
                          },
                          [
                            .text(
                              '加载更多 · '
                              '剩余 ${dictionaryEntries.length - dictionaryVisibleCount} 条',
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ],
            ),
          ],
        ),

        // =========================
        // SUBTITLE WORKSPACE
        // =========================
        div(
          classes: 'subtitle-workspace',
          [
            div(
              classes: 'panel',
              [
                div(
                  classes: 'panel-header',
                  [
                    h2([.text('Subtitle Workspace')]),
                    p([
                      .text(
                        '读取现有视频字幕。目前先做只读查看。',
                      ),
                    ]),
                  ],
                ),
                div(
                  classes: 'panel-body',
                  [
                    if (videosLoading)
                      div(
                        classes: 'preview-loading',
                        [.text('正在读取视频...')],
                      )
                    else if (videosError != null)
                      div(
                        classes: 'preview-error',
                        [.text(videosError!)],
                      )
                    else if (studioVideos.isEmpty)
                      p(
                        classes: 'empty-state',
                        [.text('目前没有视频')],
                      )
                    else ...[
                      div(
                        classes: 'video-picker',
                        [
                          for (final video in studioVideos)
                            button(
                              classes: 'video-card ${selectedVideoId == video.id ? 'selected' : ''}',
                              onClick: () {
                                setState(() {
                                  selectedVideoId = video.id;
                                  subtitleCues = [];
                                  subtitleError = null;
                                });
                              },
                              [
                                div(
                                  classes: 'video-card-title',
                                  [.text(video.title)],
                                ),
                                div(
                                  classes: 'video-card-meta',
                                  [
                                    .text(
                                      'Video #${video.id} · ${video.authorName}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                      div(
                        classes: 'subtitle-search',
                        [
                          input<String>(
                            type: InputType.text,
                            attributes: {
                              'placeholder': 'Language Code',
                              'value': subtitleLanguageCode,
                            },
                            events: events<String>(
                              onInput: (value) {
                                subtitleLanguageCode = value;
                              },
                            ),
                          ),
                          button(
                            classes: 'subtitle-load-button',
                            attributes: subtitleLoading
                                ? {
                                    'disabled': 'disabled',
                                  }
                                : null,
                            onClick: subtitleLoading
                                ? null
                                : () {
                                    _loadSubtitles();
                                  },
                            [
                              .text(
                                subtitleLoading ? '读取中...' : 'Load Subtitles',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],

                    if (subtitleError != null)
                      div(
                        classes: 'preview-error',
                        [.text(subtitleError!)],
                      ),

                    if (!subtitleLoading && subtitleError == null && subtitleCues.isEmpty)
                      p(
                        classes: 'empty-state',
                        [
                          .text(
                            selectedVideoId == null ? '请选择视频' : '点击 Load Subtitles 读取字幕',
                          ),
                        ],
                      ),

                    if (subtitleCues.isNotEmpty)
                      div(
                        classes: 'subtitle-list',
                        [
                          for (final detail in subtitleCues)
                            div(
                              classes: 'subtitle-cue',
                              [
                                div(
                                  classes: 'subtitle-time',
                                  [
                                    .text(
                                      '${detail.cue.startMs} ms → ${detail.cue.endMs} ms',
                                    ),
                                  ],
                                ),
                                div(
                                  classes: 'subtitle-text',
                                  [.text(detail.cue.text)],
                                ),
                                div(
                                  classes: 'subtitle-meta',
                                  [
                                    .text(
                                      'Tokens: ${detail.tokens.length} · Phrases: ${detail.phrases.length}',
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
            ),
          ],
        ),
      ],
    );
  }
}
