import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:clyven_subtitle_editor/clyven_subtitle_editor.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../services/review_client.dart';

class ReviewTaskPage extends StatefulComponent {
  const ReviewTaskPage({required this.taskId, super.key});

  final int taskId;

  @override
  State<ReviewTaskPage> createState() => _ReviewTaskPageState();
}

class _ReviewTaskPageState extends State<ReviewTaskPage> {
  SubtitleReviewTaskDetail? detail;
  bool loading = true;
  bool actionLoading = false;
  String? error;
  String returnNote = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final result = await reviewClient.review.getTaskDetail(
        taskId: component.taskId,
      );
      if (!mounted) return;
      setState(() {
        detail = result;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  Future<void> _run(Future<SubtitleReviewTask> Function() action) async {
    if (actionLoading) return;

    setState(() {
      actionLoading = true;
      error = null;
    });

    try {
      await action();
      if (!mounted) return;
      await _load();
      if (!mounted) return;
      setState(() {
        actionLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        actionLoading = false;
        error = e.toString();
      });
    }
  }

  Future<void> _generateNomTask(BuildContext context, int trackId) async {
    if (actionLoading) return;

    setState(() {
      actionLoading = true;
      error = null;
    });

    try {
      final task = await reviewClient.review.generateVietnameseNomDraft(
        trackId: trackId,
      );

      if (!mounted) return;

      final taskId = task.id;
      if (taskId == null) {
        throw Exception('喃字任务创建失败');
      }

      Router.of(context).push('/tasks/$taskId');
    } catch (e) {
      if (!mounted) return;
      setState(() {
        actionLoading = false;
        error = e.toString();
      });
    }
  }

  bool _canGenerateNom(SubtitleReviewTask task) {
    final language = task.languageCode
        .trim()
        .toLowerCase()
        .split(RegExp(r'[-_]'))
        .first;

    return language == 'vi' &&
        (task.scriptCode ?? '').trim().toLowerCase() == 'latn' &&
        task.status == SubtitleReviewTaskStatus.published;
  }

  @override
  Component build(BuildContext context) {
    if (loading) {
      return div(classes: 'review-empty', [.text('正在打开审核任务…')]);
    }

    final current = detail;
    if (current == null) {
      return div(classes: 'review-error', [.text(error ?? '找不到任务')]);
    }

    final task = current.item.task;
    final published = task.status == SubtitleReviewTaskStatus.published;
    final approved = task.status == SubtitleReviewTaskStatus.approved;

    return div(classes: 'review-task-page', [
      div(classes: 'review-task-toolbar', [
        Link(
          to: '/',
          child: span(classes: 'review-back', [.text('← 工作队列')]),
        ),
        div(classes: 'review-task-toolbar-copy', [
          span([.text('TASK #${task.id}')]),
          strong([.text(_statusLabel(task.status))]),
        ]),
      ]),
      div(classes: 'review-workflow-card', [
        div(classes: 'review-workflow-title', [
          div([
            h1([.text(current.item.videoTitle)]),
            p([
              .text(
                '${task.languageCode.toUpperCase()}'
                '${task.scriptCode == null ? '' : ' · ${task.scriptCode}'}'
                ' · ${current.item.videoAuthorName}',
              ),
            ]),
          ]),
          div(classes: 'review-workflow-credits', [
            _credit('领取员工', task.assignedDisplayName),
            _credit('字幕校对', task.editedByDisplayName),
            _credit('字幕复核', task.reviewedByDisplayName),
            _credit('审核通过', task.approvedByDisplayName),
          ]),
        ]),
        if (error != null) div(classes: 'review-error', [.text(error!)]),
        div(classes: 'review-workflow-actions', [
          if (task.status == SubtitleReviewTaskStatus.readyForReview)
            button(
              type: ButtonType.button,
              classes: 'review-primary-button',
              onClick: actionLoading
                  ? null
                  : () => _run(
                      () => reviewClient.review.claimTask(
                        taskId: component.taskId,
                      ),
                    ),
              [.text(actionLoading ? '处理中…' : '领取任务')],
            ),
          if ((task.status == SubtitleReviewTaskStatus.assigned ||
                  task.status == SubtitleReviewTaskStatus.returned) &&
              current.item.isMine)
            button(
              type: ButtonType.button,
              classes: 'review-primary-button',
              onClick: actionLoading
                  ? null
                  : () => _run(
                      () => reviewClient.review.startTask(
                        taskId: component.taskId,
                      ),
                    ),
              [.text(actionLoading ? '处理中…' : '开始校对')],
            ),
          if (task.status == SubtitleReviewTaskStatus.inReview &&
              current.item.isMine)
            button(
              type: ButtonType.button,
              classes: 'review-primary-button',
              onClick: actionLoading
                  ? null
                  : () => _run(
                      () => reviewClient.review.submitTask(
                        taskId: component.taskId,
                      ),
                    ),
              [.text(actionLoading ? '提交中…' : '完成校对 · 提交复核')],
            ),
          if (task.status == SubtitleReviewTaskStatus.readyForSecondReview) ...[
            button(
              type: ButtonType.button,
              classes: 'review-primary-button',
              onClick: actionLoading
                  ? null
                  : () => _run(
                      () => reviewClient.review.approveAndPublish(
                        taskId: component.taskId,
                      ),
                    ),
              [.text(actionLoading ? '发布中…' : '通过并发布 Clyven Official')],
            ),
            input<String>(
              type: InputType.text,
              classes: 'review-return-note',
              attributes: {'placeholder': '退回原因（可选）'},
              events: events<String>(
                onInput: (value) {
                  returnNote = value;
                },
              ),
            ),
            button(
              type: ButtonType.button,
              classes: 'review-secondary-button',
              onClick: actionLoading
                  ? null
                  : () => _run(
                      () => reviewClient.review.returnTask(
                        taskId: component.taskId,
                        note: returnNote,
                      ),
                    ),
              [.text('退回修改')],
            ),
          ],
          if (_canGenerateNom(task))
            button(
              type: ButtonType.button,
              classes: 'review-primary-button',
              onClick: actionLoading
                  ? null
                  : () => _generateNomTask(context, task.trackId),
              [.text(actionLoading ? '生成中…' : '生成喃字草稿 · 建立转换任务')],
            ),
          if (published || approved)
            span(classes: 'review-published-message', [
              .text('任务已完成，已退出员工工作区。贡献者姓名和历史记录永久保留。'),
            ]),
        ]),
      ]),
      if (!published && !approved)
        SubtitleEditorPage(
          client: reviewClient,
          videoId: task.videoId,
          languageCode: task.languageCode,
          scriptCode: task.scriptCode,
          backRoute: '/',
          backLabel: '← 工作队列',
          showPublishControls: false,
        ),
      section(classes: 'review-history', [
        h2([.text('任务记录')]),
        if (current.events.isEmpty)
          p([.text('还没有操作记录')])
        else
          div(classes: 'review-history-list', [
            for (final event in current.events)
              div(classes: 'review-history-row', [
                span(classes: 'review-history-time', [
                  .text(_time(event.createdAt)),
                ]),
                strong([
                  .text(
                    event.actorDisplayName?.trim().isNotEmpty ?? false
                        ? event.actorDisplayName!
                        : 'System',
                  ),
                ]),
                span([.text(_actionLabel(event.action))]),
                if (event.note != null && event.note!.trim().isNotEmpty)
                  em([.text(event.note!)]),
              ]),
          ]),
      ]),
    ]);
  }

  Component _credit(String label, String? name) {
    return div([
      span([.text(label)]),
      strong([.text(name?.trim().isNotEmpty ?? false ? name! : '—')]),
    ]);
  }

  String _statusLabel(SubtitleReviewTaskStatus status) {
    return switch (status) {
      SubtitleReviewTaskStatus.readyForReview => '待领取',
      SubtitleReviewTaskStatus.assigned => '已领取',
      SubtitleReviewTaskStatus.inReview => '校对中',
      SubtitleReviewTaskStatus.readyForSecondReview => '待复核',
      SubtitleReviewTaskStatus.returned => '退回修改',
      SubtitleReviewTaskStatus.approved => '已通过',
      SubtitleReviewTaskStatus.published => '已发布',
      SubtitleReviewTaskStatus.failed => '异常',
    };
  }

  String _actionLabel(String action) {
    return switch (action) {
      'claimed' => '领取任务',
      'started' => '开始校对',
      'submitted' => '完成校对并提交复核',
      'returned' => '退回修改',
      'approved' => '审核通过',
      'published' => '发布为 Clyven Official',
      'nomDraftGenerated' => 'Clyven 喃字转换器生成草稿',
      'nomDraftRequested' => '创建喃字转换任务',
      _ => action,
    };
  }

  String _time(DateTime value) {
    final local = value.toLocal();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${local.year}-${two(local.month)}-${two(local.day)} '
        '${two(local.hour)}:${two(local.minute)}';
  }
}
