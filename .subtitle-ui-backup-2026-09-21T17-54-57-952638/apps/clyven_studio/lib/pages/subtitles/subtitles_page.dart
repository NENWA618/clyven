import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

class SubtitlesPage extends StatefulComponent {
  const SubtitlesPage({super.key});

  @override
  State<SubtitlesPage> createState() => _SubtitlesPageState();
}

class _SubtitlesPageState extends State<SubtitlesPage> {
  final client = Client(
    'https://glyphora-server-11129163384.asia-southeast1.run.app/',
    connectionTimeout: const Duration(minutes: 2),
  );

  List<Video> videos = [];

  int? selectedVideoId;
  String languageCode = 'vi';

  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final result = await client.video.getVideos();

      setState(() {
        videos = result;
        loading = false;

        if (result.isNotEmpty) {
          selectedVideoId ??= result.first.id;
        }
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  Video? get selectedVideo {
    if (selectedVideoId == null) {
      return null;
    }

    for (final video in videos) {
      if (video.id == selectedVideoId) {
        return video;
      }
    }

    return null;
  }

  void _openEditor(BuildContext context) {
    if (selectedVideoId == null) {
      return;
    }

    final language = languageCode.trim().toLowerCase();

    if (language.isEmpty) {
      return;
    }

    Router.of(context).push(
      '/subtitles/$selectedVideoId/${Uri.encodeComponent(language)}',
    );
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'subtitles-page',
      [
        div(
          classes: 'page-heading',
          [
            h1([.text('Subtitles')]),
            p([
              .text('选择视频和语言，然后进入独立字幕工作台。'),
            ]),
          ],
        ),

        if (loading)
          div(
            classes: 'preview-loading',
            [.text('正在读取视频...')],
          )
        else if (error != null)
          div(
            classes: 'preview-error',
            [.text(error!)],
          )
        else if (videos.isEmpty)
          div(
            classes: 'empty-state',
            [.text('目前没有视频')],
          )
        else ...[
          div(
            classes: 'panel',
            [
              div(
                classes: 'panel-header',
                [
                  h2([.text('Videos')]),
                  p([.text('选择需要管理字幕的视频。')]),
                ],
              ),
              div(
                classes: 'panel-body',
                [
                  div(
                    classes: 'video-picker',
                    [
                      for (final video in videos)
                        button(
                          classes:
                              'video-card ${selectedVideoId == video.id ? 'selected' : ''}',
                          onClick: () {
                            setState(() {
                              selectedVideoId = video.id;
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
                ],
              ),
            ],
          ),

          div(
            classes: 'subtitle-track-panel panel',
            [
              div(
                classes: 'panel-header',
                [
                  h2([.text('Subtitle Track')]),
                  p([
                    .text('选择字幕语言后进入编辑工作台。'),
                  ]),
                ],
              ),
              div(
                classes: 'panel-body',
                [
                  if (selectedVideo != null)
                    div(
                      classes: 'selected-video-summary',
                      [
                        div(
                          classes: 'selected-video-label',
                          [.text('Selected video')],
                        ),
                        div(
                          classes: 'selected-video-title',
                          [.text(selectedVideo!.title)],
                        ),
                        div(
                          classes: 'selected-video-meta',
                          [
                            .text(
                              'Video #${selectedVideo!.id} · ${selectedVideo!.authorName}',
                            ),
                          ],
                        ),
                      ],
                    ),

                  div(
                    classes: 'subtitle-open-row',
                    [
                      div(
                        classes: 'subtitle-language-field',
                        [
                          label(
                            [.text('Language Code')],
                          ),
                          input<String>(
                            type: InputType.text,
                            attributes: {
                              'value': languageCode,
                              'placeholder': 'vi',
                            },
                            events: events<String>(
                              onInput: (value) {
                                languageCode = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      button(
                        classes: 'subtitle-open-button',
                        onClick: () {
                          _openEditor(context);
                        },
                        [.text('Open Editor')],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ],
    );
  }
}