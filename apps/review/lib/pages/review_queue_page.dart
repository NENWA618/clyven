import 'package:glyphora_web_l10n/web_l10n.dart';
import 'package:glyphora_backend_client/backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../services/review_client.dart';

enum _ReviewTab { unclaimed, mine, secondReview, completed }

class ReviewQueuePage extends StatefulComponent {
  const ReviewQueuePage({super.key});

  @override
  State<ReviewQueuePage> createState() => _ReviewQueuePageState();
}

class _ReviewQueuePageState extends State<ReviewQueuePage> {
  SubtitleReviewDashboard? dashboard;
  bool loading = true;
  String? error;
  int? claimingTaskId;
  _ReviewTab tab = _ReviewTab.unclaimed;

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
      final result = await reviewClient.review.getDashboard();
      if (!mounted) return;
      setState(() {
        dashboard = result;
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

  List<SubtitleReviewQueueItem> get _items {
    final data = dashboard;
    if (data == null) return const [];

    return switch (tab) {
      _ReviewTab.unclaimed => data.unclaimed,
      _ReviewTab.mine => data.mine,
      _ReviewTab.secondReview => data.secondReview,
      _ReviewTab.completed => data.completed,
    };
  }

  Future<void> _claimAndOpen(
    BuildContext context,
    SubtitleReviewQueueItem item,
  ) async {
    final taskId = item.task.id;
    if (taskId == null || claimingTaskId != null) return;

    setState(() {
      claimingTaskId = taskId;
      error = null;
    });

    try {
      await reviewClient.review.claimTask(taskId: taskId);
      if (!mounted) return;
      Router.of(context).push('/tasks/$taskId');
    } catch (e) {
      if (!mounted) return;
      setState(() {
        claimingTaskId = null;
        error = e.toString();
      });
    }
  }

  @override
  Component build(BuildContext context) {
    final data = dashboard;

    return div(classes: 'review-queue-page', [
      div(classes: 'review-hero', [
        div([
          p(classes: 'review-eyebrow', [.text('GLYPHORA REVIEW')]),
          h1([.text(context.tr('Subtitle Work Queue', '字幕工作队列'))]),
          p([.text(context.tr('Only subtitle tasks that need attention are shown here. Finished tasks leave the workspace automatically and staff contribution records are kept permanently.', '这里只显示需要处理的字幕任务。完成后自动退出工作区，并永久保留员工贡献记录。'))]),
        ]),
        if (data != null)
          div(classes: 'review-current-staff', [
            span([.text(context.tr('Current staff', '当前员工'))]),
            strong([.text(data.currentDisplayName)]),
          ]),
      ]),
      if (data != null)
        div(classes: 'review-stats', [
          _stat(context.tr('Unclaimed', '待领取'), data.unclaimedCount),
          _stat(context.tr('My tasks', '我的任务'), data.myCount),
          _stat(context.tr('Second review', '待复核'), data.secondReviewCount),
          _stat(context.tr('Completed', '已完成'), data.completedCount),
        ]),
      div(classes: 'review-tabs', [
        _tabButton(context.tr('Unclaimed', '待领取'), _ReviewTab.unclaimed, data?.unclaimedCount ?? 0),
        _tabButton(context.tr('My tasks', '我的任务'), _ReviewTab.mine, data?.myCount ?? 0),
        _tabButton(
          context.tr('Second review', '待复核'),
          _ReviewTab.secondReview,
          data?.secondReviewCount ?? 0,
        ),
        _tabButton(context.tr('Completed', '已完成'), _ReviewTab.completed, data?.completedCount ?? 0),
        button(
          type: ButtonType.button,
          classes: 'review-refresh',
          onClick: loading ? null : _load,
          [.text(loading ? context.tr('Refreshing…', '刷新中…') : context.tr('Refresh', '刷新'))],
        ),
      ]),
      if (error != null) div(classes: 'review-error', [.text(error!)]),
      if (loading)
        div(classes: 'review-empty', [.text(context.tr('Loading the work queue…', '正在读取工作队列…'))])
      else if (_items.isEmpty)
        div(classes: 'review-empty', [
          strong([.text(_emptyTitle(context))]),
          p([.text(_emptyDescription(context))]),
        ])
      else
        div(classes: 'review-task-grid', [
          for (final item in _items) _taskCard(context, item),
        ]),
      if (data != null)
        p(classes: 'review-page-note', [
          .text(context.tr('Each group loads only the first 40 items; the numbers show the full task totals. Language filters, pagination and auto-assignment will follow at larger scale.', '工作区每组只加载前 40 条；数字显示完整任务总数。大规模后继续加语言筛选、分页和自动派单。')),
        ]),
    ]);
  }

  Component _stat(String label, int value) {
    return div(classes: 'review-stat', [
      strong([.text('$value')]),
      span([.text(label)]),
    ]);
  }

  Component _tabButton(String label, _ReviewTab wanted, int count) {
    return button(
      type: ButtonType.button,
      classes: 'review-tab${tab == wanted ? ' is-active' : ''}',
      onClick: () {
        setState(() {
          tab = wanted;
        });
      },
      [
        span([.text(label)]),
        b([.text('$count')]),
      ],
    );
  }

  Component _taskCard(BuildContext context, SubtitleReviewQueueItem item) {
    final task = item.task;
    final taskId = task.id;
    final completed =
        task.status == SubtitleReviewTaskStatus.published ||
        task.status == SubtitleReviewTaskStatus.approved;

    return article(classes: 'review-task-card', [
      div(classes: 'review-task-card-top', [
        div(classes: 'review-badges', [
          span(classes: 'review-language-badge', [
            .text(task.languageCode.toUpperCase()),
          ]),
          if (task.scriptCode != null && task.scriptCode!.isNotEmpty)
            span(classes: 'review-script-badge', [.text(task.scriptCode!)]),
          if (task.languageCode.toLowerCase().startsWith('vi') &&
              (task.scriptCode ?? '').toLowerCase() == 'hnom')
            span(classes: 'review-script-badge', [.text(context.tr('Script conversion', '文字转换'))]),
          span(classes: 'review-status-badge', [
            .text(_statusLabel(context, task.status)),
          ]),
        ]),
        span(classes: 'review-task-id', [.text('#${taskId ?? '—'}')]),
      ]),
      h3([.text(item.videoTitle)]),
      p(classes: 'review-task-meta', [
        .text('${item.videoAuthorName} · ${_duration(item.durationSeconds)}'),
      ]),
      div(classes: 'review-credit-lines', [
        _credit(context.tr('Claimed', '领取'), task.assignedDisplayName),
        _credit(context.tr('Proofread', '校对'), task.editedByDisplayName),
        _credit(context.tr('Reviewed', '复核'), task.reviewedByDisplayName),
        _credit(context.tr('Approved', '通过'), task.approvedByDisplayName),
      ]),
      div(classes: 'review-task-actions', [
        if (tab == _ReviewTab.unclaimed && taskId != null)
          button(
            type: ButtonType.button,
            classes: 'review-primary-button',
            onClick: claimingTaskId == null
                ? () => _claimAndOpen(context, item)
                : null,
            [.text(claimingTaskId == taskId ? context.tr('Claiming…', '领取中…') : context.tr('Claim and open', '领取并打开'))],
          )
        else if (!completed && taskId != null)
          button(
            type: ButtonType.button,
            classes: 'review-primary-button',
            onClick: () => Router.of(context).push('/tasks/$taskId'),
            [.text(tab == _ReviewTab.secondReview ? context.tr('Start review', '开始复核') : context.tr('Continue', '继续工作'))],
          )
        else
          span(classes: 'review-completed-note', [.text(context.tr('Left the workspace · contribution saved', '已离开工作区 · 贡献记录已保存'))]),
      ]),
    ]);
  }

  Component _credit(String label, String? name) {
    final display = name?.trim();
    return div([
      span([.text(label)]),
      strong([.text(display == null || display.isEmpty ? '—' : display)]),
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

  String _duration(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:'
          '${m.toString().padLeft(2, '0')}:'
          '${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';
  }

  String _emptyTitle(BuildContext context) {
    return switch (tab) {
      _ReviewTab.unclaimed => context.tr('No unclaimed tasks right now', '现在没有待领取任务'),
      _ReviewTab.mine => context.tr('You have no tasks in progress', '你目前没有进行中的任务'),
      _ReviewTab.secondReview => context.tr('No tasks awaiting second review', '现在没有待复核任务'),
      _ReviewTab.completed => context.tr('No completed records yet', '还没有完成记录'),
    };
  }

  String _emptyDescription(BuildContext context) {
    return switch (tab) {
      _ReviewTab.unclaimed => context.tr('New AI subtitle, script conversion and other production tasks arrive here automatically.', '新的 AI 字幕、文字转换等生产任务会自动进入这里。'),
      _ReviewTab.mine => context.tr('Tasks you claim will appear here.', '领取任务后会出现在这里。'),
      _ReviewTab.secondReview => context.tr('Tasks submitted by proofreaders arrive here automatically.', '校对员提交后会自动进入这里。'),
      _ReviewTab.completed => context.tr('Published tasks stay in history only and no longer take up the workspace.', '审核发布后的任务只保留在历史记录，不再占用工作区。'),
    };
  }
}
