import 'package:glyphora_web_l10n/web_l10n.dart';
import 'package:glyphora_backend_client/backend_client.dart';
import 'package:glyphora_subtitle_editor/subtitle_editor.dart';
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
        throw Exception(trNow('Failed to create the Nôm task', '喃字任务创建失败'));
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
      return div(classes: 'review-empty', [.text(context.tr('Opening the review task…', '正在打开审核任务…'))]);
    }

    final current = detail;
    if (current == null) {
      return div(classes: 'review-error', [.text(error ?? context.tr('Task not found', '找不到任务'))]);
    }

    final task = current.item.task;
    final published = task.status == SubtitleReviewTaskStatus.published;
    final approved = task.status == SubtitleReviewTaskStatus.approved;

    return div(classes: 'review-task-page', [
      div(classes: 'review-task-toolbar', [
        Link(
          to: '/',
          child: span(classes: 'review-back', [.text(context.tr('← Work Queue', '← 工作队列'))]),
        ),
        div(classes: 'review-task-toolbar-copy', [
          span([.text(context.tr('TASK #${task.id}', '任务 #${task.id}'))]),
          strong([.text(_statusLabel(context, task.status))]),
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
            _credit(context.tr('Claimed by', '领取员工'), task.assignedDisplayName),
            _credit(context.tr('Proofread by', '字幕校对'), task.editedByDisplayName),
            _credit(context.tr('Reviewed by', '字幕复核'), task.reviewedByDisplayName),
            _credit(context.tr('Approved by', '审核通过'), task.approvedByDisplayName),
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
              [.text(actionLoading ? context.tr('Working…', '处理中…') : context.tr('Claim task', '领取任务'))],
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
              [.text(actionLoading ? context.tr('Working…', '处理中…') : context.tr('Start proofreading', '开始校对'))],
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
              [.text(actionLoading ? context.tr('Submitting…', '提交中…') : context.tr('Finish proofreading · Submit for review', '完成校对 · 提交复核'))],
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
              [.text(actionLoading ? context.tr('Publishing…', '发布中…') : context.tr('Approve and publish as Glyphora Official', '通过并发布 Glyphora Official'))],
            ),
            input<String>(
              type: InputType.text,
              classes: 'review-return-note',
              attributes: {'placeholder': context.tr('Reason for returning (optional)', '退回原因（可选）')},
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
              [.text(context.tr('Return for changes', '退回修改'))],
            ),
          ],
          if (_canGenerateNom(task))
            button(
              type: ButtonType.button,
              classes: 'review-primary-button',
              onClick: actionLoading
                  ? null
                  : () => _generateNomTask(context, task.trackId),
              [.text(actionLoading ? context.tr('Generating…', '生成中…') : context.tr('Generate Nôm draft · Create conversion task', '生成喃字草稿 · 建立转换任务'))],
            ),
          if (published || approved)
            span(classes: 'review-published-message', [
              .text(context.tr('Task complete and removed from the staff workspace. Contributor names and history are kept permanently.', '任务已完成，已退出员工工作区。贡献者姓名和历史记录永久保留。')),
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
          backLabel: context.tr('← Work Queue', '← 工作队列'),
          showPublishControls: false,
        ),
      section(classes: 'review-history', [
        h2([.text(context.tr('Task history', '任务记录'))]),
        if (current.events.isEmpty)
          p([.text(context.tr('No activity yet', '还没有操作记录'))])
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
                span([.text(_actionLabel(context, event.action))]),
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

  String _statusLabel(BuildContext context, SubtitleReviewTaskStatus status) {
    return switch (status) {
      SubtitleReviewTaskStatus.readyForReview => context.tr('Unclaimed', '待领取'),
      SubtitleReviewTaskStatus.assigned => context.tr('Claimed', '已领取'),
      SubtitleReviewTaskStatus.inReview => context.tr('In review', '校对中'),
      SubtitleReviewTaskStatus.readyForSecondReview => context.tr('Second review', '待复核'),
      SubtitleReviewTaskStatus.returned => context.tr('Returned', '退回修改'),
      SubtitleReviewTaskStatus.approved => context.tr('Approved', '已通过'),
      SubtitleReviewTaskStatus.published => context.tr('Published', '已发布'),
      SubtitleReviewTaskStatus.failed => context.tr('Failed', '异常'),
    };
  }

  String _actionLabel(BuildContext context, String action) {
    return switch (action) {
      'claimed' => context.tr('Claimed the task', '领取任务'),
      'started' => context.tr('Started proofreading', '开始校对'),
      'submitted' => context.tr('Finished proofreading and submitted for review', '完成校对并提交复核'),
      'returned' => context.tr('Returned for changes', '退回修改'),
      'approved' => context.tr('Approved', '审核通过'),
      'published' => context.tr('Published as Glyphora Official', '发布为 Glyphora Official'),
      'nomDraftGenerated' => context.tr('Draft generated by the Glyphora Nôm converter', 'Glyphora 喃字转换器生成草稿'),
      'nomDraftRequested' => context.tr('Created a Nôm conversion task', '创建喃字转换任务'),
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
