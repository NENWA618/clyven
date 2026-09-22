import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../services/admin_client.dart';

class UsersPage extends StatefulComponent {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _AdminUserGroup {
  const _AdminUserGroup({
    required this.authorId,
    required this.authorName,
    required this.email,
    required this.videos,
  });

  final String authorId;
  final String authorName;
  final String email;
  final List<Video> videos;
}

class _UsersPageState extends State<UsersPage> {
  final client = adminClient;

  List<_AdminUserGroup> _users = [];
  _AdminUserGroup? _selectedUser;
  Video? _selectedVideo;
  List<SubtitleTrack> _tracks = [];

  bool _loading = true;
  bool _loadingTracks = false;

  String _search = '';
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final videos = await client.admin.getAllVideos();

      final emailsByAuthUserId = await client.admin.getUserEmails();

      final byUser = <String, List<Video>>{};
      for (final video in videos) {
        byUser.putIfAbsent(video.authorId, () => []).add(video);
      }

      final users =
          byUser.entries.map((entry) {
            final list = entry.value
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

            final name = list.isEmpty ? entry.key : list.first.authorName;

            return _AdminUserGroup(
              authorId: entry.key,
              authorName: name,
              email: emailsByAuthUserId[entry.key]?.trim().isNotEmpty == true
                  ? emailsByAuthUserId[entry.key]!.trim()
                  : '未绑定邮箱',
              videos: list,
            );
          }).toList()..sort(
            (a, b) => a.authorName.toLowerCase().compareTo(
              b.authorName.toLowerCase(),
            ),
          );

      if (!mounted) return;

      setState(() {
        _users = users;
        _loading = false;
        if (users.isNotEmpty) {
          _selectedUser ??= users.first;
        }
      });

      final firstUser = _selectedUser;
      if (firstUser != null && firstUser.videos.isNotEmpty) {
        await _selectVideo(firstUser.videos.first);
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  List<_AdminUserGroup> get _filteredUsers {
    final query = _search.trim().toLowerCase();
    if (query.isEmpty) return _users;

    return _users
        .where((user) {
          return user.authorName.toLowerCase().contains(query) ||
              user.email.toLowerCase().contains(query);
        })
        .toList(growable: false);
  }

  Future<void> _selectUser(_AdminUserGroup user) async {
    setState(() {
      _selectedUser = user;
      _selectedVideo = null;
      _tracks = [];
      _error = null;
    });

    if (user.videos.isNotEmpty) {
      await _selectVideo(user.videos.first);
    }
  }

  Future<void> _selectVideo(Video video) async {
    setState(() {
      _selectedVideo = video;
      _tracks = [];
      _loadingTracks = true;
      _error = null;
    });

    try {
      final tracks = await client.admin.getSubtitleTracks(videoId: video.id!);

      if (!mounted) return;

      setState(() {
        _tracks = tracks;
        _loadingTracks = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loadingTracks = false;
        _error = e.toString();
      });
    }
  }

  void _openTrack(BuildContext context, SubtitleTrack track) {
    final videoId = _selectedVideo?.id;
    if (videoId == null) return;

    final language = Uri.encodeComponent(track.languageCode);
    final script = track.defaultScriptCode?.trim();

    final path = script == null || script.isEmpty
        ? '/subtitles/$videoId/$language'
        : '/subtitles/$videoId/$language/${Uri.encodeComponent(script)}';

    Router.of(context).push(path);
  }

  @override
  Component build(BuildContext context) {
    final users = _filteredUsers;
    final selectedUser = _selectedUser;

    return div(classes: 'admin-users-page', [
      div(classes: 'admin-users-toolbar', [
        div([
          h2([.text('Users')]),
          p([.text('查看 Clyven 用户，以及该用户账号名下的全部视频。')]),
        ]),
        button(
          type: ButtonType.button,
          classes: 'admin-secondary-button',
          onClick: _load,
          [.text('刷新')],
        ),
      ]),
      if (_error != null)
        div(classes: 'admin-error admin-page-error', [.text(_error!)]),
      if (_loading)
        div(classes: 'admin-users-state', [.text('正在读取所有用户视频…')])
      else
        div(classes: 'admin-users-grid', [
          section(classes: 'admin-users-column', [
            div(classes: 'admin-users-column-header', [
              strong([.text('用户')]),
              span([.text('${_users.length}')]),
            ]),
            input<String>(
              type: InputType.text,
              attributes: {'placeholder': '搜索用户名 / 邮箱', 'value': _search},
              events: events<String>(
                onInput: (value) {
                  setState(() {
                    _search = value;
                  });
                },
              ),
            ),
            div(classes: 'admin-user-list', [
              for (final user in users)
                button(
                  type: ButtonType.button,
                  classes:
                      'admin-user-row${selectedUser?.authorId == user.authorId ? ' is-active' : ''}',
                  onClick: () => _selectUser(user),
                  [
                    div(classes: 'admin-user-avatar', [
                      .text(
                        user.authorName.trim().isEmpty
                            ? '?'
                            : user.authorName
                                  .trim()
                                  .substring(0, 1)
                                  .toUpperCase(),
                      ),
                    ]),
                    div(classes: 'admin-user-copy', [
                      strong([.text(user.authorName)]),
                      span([.text(user.email)]),
                    ]),
                    span(classes: 'admin-user-video-count', [
                      .text('${user.videos.length}'),
                    ]),
                  ],
                ),
            ]),
          ]),
          section(classes: 'admin-videos-column', [
            div(classes: 'admin-users-column-header', [
              strong([
                .text(
                  selectedUser == null
                      ? '视频'
                      : '${selectedUser.authorName} 的视频',
                ),
              ]),
              if (selectedUser != null)
                span([.text('${selectedUser.videos.length}')]),
            ]),
            if (selectedUser == null)
              div(classes: 'admin-users-state', [.text('请选择用户')])
            else if (selectedUser.videos.isEmpty)
              div(classes: 'admin-users-state', [.text('这个用户没有视频')])
            else
              div(classes: 'admin-user-video-list', [
                for (final video in selectedUser.videos)
                  button(
                    type: ButtonType.button,
                    classes:
                        'admin-user-video-card${_selectedVideo?.id == video.id ? ' is-active' : ''}',
                    onClick: () => _selectVideo(video),
                    [
                      div(classes: 'admin-user-video-top', [
                        strong([.text(video.title)]),
                        span([.text('#${video.id}')]),
                      ]),
                      p([
                        .text(
                          video.description.trim().isEmpty
                              ? '无描述'
                              : video.description,
                        ),
                      ]),
                      div(classes: 'admin-user-video-meta', [
                        span([.text(video.category)]),
                        span([.text('${video.durationSeconds}s')]),
                        span([.text('${video.status}')]),
                      ]),
                    ],
                  ),
              ]),
          ]),
          section(classes: 'admin-tracks-column', [
            div(classes: 'admin-users-column-header', [
              strong([.text('字幕轨')]),
              if (_selectedVideo != null)
                span([.text('#${_selectedVideo!.id}')]),
            ]),
            if (_selectedVideo == null)
              div(classes: 'admin-users-state', [.text('请选择视频')])
            else if (_loadingTracks)
              div(classes: 'admin-users-state', [.text('正在读取字幕轨…')])
            else if (_tracks.isEmpty)
              div(classes: 'admin-users-state', [.text('这个视频目前没有字幕轨')])
            else
              div(classes: 'admin-track-admin-list', [
                for (final track in _tracks)
                  div(classes: 'admin-track-admin-card', [
                    div([
                      strong([.text(track.languageCode)]),
                      span([
                        .text(
                          track.defaultScriptCode == null
                              ? 'legacy / default'
                              : track.defaultScriptCode!,
                        ),
                      ]),
                    ]),
                    button(
                      type: ButtonType.button,
                      classes: 'admin-primary-button',
                      onClick: () => _openTrack(context, track),
                      [.text('进入字幕编辑器')],
                    ),
                  ]),
              ]),
          ]),
        ]),
    ]);
  }
}
