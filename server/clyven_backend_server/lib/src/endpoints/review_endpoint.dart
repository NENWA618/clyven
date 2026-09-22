import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import '../services/subtitle_review_task_service.dart';
import '../services/vietnamese_nom_conversion_service.dart';
import 'subtitle_endpoint.dart';

class ReviewEndpoint extends Endpoint {
  static const _pageSize = 40;
  final _taskService = SubtitleReviewTaskService();
  final _nomConversionService = VietnameseNomConversionService();

  @override
  Set<Scope> get requiredScopes => {Scope.admin};

  Future<({String userId, String displayName})> _actor(
    Session session,
  ) async {
    final auth = session.authenticated;
    if (auth == null) {
      throw Exception('需要登录 Clyven Review');
    }

    final profile = await auth.userProfile(session);
    final displayName = (profile?.fullName?.trim().isNotEmpty ?? false)
        ? profile!.fullName!.trim()
        : (profile?.userName?.trim().isNotEmpty ?? false)
        ? profile!.userName!.trim()
        : (profile?.email?.trim().isNotEmpty ?? false)
        ? profile!.email!.trim()
        : auth.userIdentifier.toString();

    return (
      userId: auth.userIdentifier.toString(),
      displayName: displayName,
    );
  }

  Future<SubtitleReviewQueueItem> _toItem(
    Session session,
    SubtitleReviewTask task, {
    required String currentUserId,
  }) async {
    final video = await Video.db.findById(session, task.videoId);

    return SubtitleReviewQueueItem(
      task: task,
      videoTitle: video?.title ?? 'Video #${task.videoId}',
      videoAuthorName: video?.authorName ?? '—',
      durationSeconds: video?.durationSeconds ?? 0,
      isMine: task.assignedUserId == currentUserId,
    );
  }

  Future<List<SubtitleReviewQueueItem>> _items(
    Session session,
    List<SubtitleReviewTask> tasks, {
    required String currentUserId,
  }) async {
    if (tasks.isEmpty) return [];

    final videoIds = tasks.map((task) => task.videoId).toSet();
    final videos = await Video.db.find(
      session,
      where: (video) => video.id.inSet(videoIds),
    );

    final videosById = <int, Video>{
      for (final video in videos)
        if (video.id != null) video.id!: video,
    };

    return [
      for (final task in tasks)
        SubtitleReviewQueueItem(
          task: task,
          videoTitle:
              videosById[task.videoId]?.title ?? 'Video #${task.videoId}',
          videoAuthorName: videosById[task.videoId]?.authorName ?? '—',
          durationSeconds: videosById[task.videoId]?.durationSeconds ?? 0,
          isMine: task.assignedUserId == currentUserId,
        ),
    ];
  }

  Future<SubtitleReviewDashboard> getDashboard(Session session) async {
    await _taskService.initialBackfillIfNeeded(session);

    final actor = await _actor(session);

    final unclaimedCount = await SubtitleReviewTask.db.count(
      session,
      where: (task) =>
          task.status.equals(SubtitleReviewTaskStatus.readyForReview),
    );

    final myStatuses = <SubtitleReviewTaskStatus>{
      SubtitleReviewTaskStatus.assigned,
      SubtitleReviewTaskStatus.inReview,
      SubtitleReviewTaskStatus.returned,
    };

    final myCount = await SubtitleReviewTask.db.count(
      session,
      where: (task) =>
          task.assignedUserId.equals(actor.userId) &
          task.status.inSet(myStatuses),
    );

    final secondReviewCount = await SubtitleReviewTask.db.count(
      session,
      where: (task) =>
          task.status.equals(SubtitleReviewTaskStatus.readyForSecondReview),
    );

    final completedStatuses = <SubtitleReviewTaskStatus>{
      SubtitleReviewTaskStatus.approved,
      SubtitleReviewTaskStatus.published,
    };

    final completedCount = await SubtitleReviewTask.db.count(
      session,
      where: (task) => task.status.inSet(completedStatuses),
    );

    final unclaimedTasks = await SubtitleReviewTask.db.find(
      session,
      where: (task) =>
          task.status.equals(SubtitleReviewTaskStatus.readyForReview),
      orderBy: (task) => task.priority,
      orderDescending: true,
      limit: _pageSize,
    );

    final myTasks = await SubtitleReviewTask.db.find(
      session,
      where: (task) =>
          task.assignedUserId.equals(actor.userId) &
          task.status.inSet(myStatuses),
      orderBy: (task) => task.updatedAt,
      orderDescending: true,
      limit: _pageSize,
    );

    final secondReviewTasks = await SubtitleReviewTask.db.find(
      session,
      where: (task) =>
          task.status.equals(SubtitleReviewTaskStatus.readyForSecondReview),
      orderBy: (task) => task.submittedAt,
      orderDescending: false,
      limit: _pageSize,
    );

    final completedTasks = await SubtitleReviewTask.db.find(
      session,
      where: (task) => task.status.inSet(completedStatuses),
      orderBy: (task) => task.completedAt,
      orderDescending: true,
      limit: _pageSize,
    );

    return SubtitleReviewDashboard(
      currentUserId: actor.userId,
      currentDisplayName: actor.displayName,
      unclaimedCount: unclaimedCount,
      myCount: myCount,
      secondReviewCount: secondReviewCount,
      completedCount: completedCount,
      unclaimed: await _items(
        session,
        unclaimedTasks,
        currentUserId: actor.userId,
      ),
      mine: await _items(
        session,
        myTasks,
        currentUserId: actor.userId,
      ),
      secondReview: await _items(
        session,
        secondReviewTasks,
        currentUserId: actor.userId,
      ),
      completed: await _items(
        session,
        completedTasks,
        currentUserId: actor.userId,
      ),
    );
  }

  Future<SubtitleReviewTaskDetail> getTaskDetail(
    Session session, {
    required int taskId,
  }) async {
    final actor = await _actor(session);
    final task = await SubtitleReviewTask.db.findById(session, taskId);

    if (task == null) {
      throw Exception('找不到字幕审核任务');
    }

    final events = await SubtitleReviewEvent.db.find(
      session,
      where: (event) => event.taskId.equals(taskId),
      orderBy: (event) => event.createdAt,
      orderDescending: true,
      limit: 100,
    );

    return SubtitleReviewTaskDetail(
      item: await _toItem(
        session,
        task,
        currentUserId: actor.userId,
      ),
      events: events,
    );
  }

  Future<void> _event(
    Session session, {
    required int taskId,
    required ({String userId, String displayName}) actor,
    required String action,
    String? note,
  }) async {
    await SubtitleReviewEvent.db.insertRow(
      session,
      SubtitleReviewEvent(
        taskId: taskId,
        actorUserId: actor.userId,
        actorDisplayName: actor.displayName,
        action: action,
        note: note,
      ),
    );
  }

  Future<SubtitleReviewTask> generateVietnameseNomDraft(
    Session session, {
    required int trackId,
  }) async {
    final actor = await _actor(session);

    final task = await _nomConversionService.generateLatinToNomDraft(
      session,
      trackId: trackId,
    );

    if (task.id != null) {
      await _event(
        session,
        taskId: task.id!,
        actor: actor,
        action: 'nomDraftRequested',
      );
    }

    return task;
  }

  Future<SubtitleReviewTask> claimTask(
    Session session, {
    required int taskId,
  }) async {
    final actor = await _actor(session);
    var task = await SubtitleReviewTask.db.findById(session, taskId);

    if (task == null) throw Exception('找不到任务');

    if (task.status != SubtitleReviewTaskStatus.readyForReview &&
        task.status != SubtitleReviewTaskStatus.returned) {
      throw Exception('这个任务当前不能领取');
    }

    if (task.assignedUserId != null && task.assignedUserId != actor.userId) {
      throw Exception('这个任务已经由其他员工领取');
    }

    final now = DateTime.now();
    task.assignedUserId = actor.userId;
    task.assignedDisplayName = actor.displayName;
    task.claimedAt ??= now;
    task.status = SubtitleReviewTaskStatus.assigned;
    task.updatedAt = now;

    task = await SubtitleReviewTask.db.updateRow(session, task);

    await _event(
      session,
      taskId: taskId,
      actor: actor,
      action: 'claimed',
    );

    return task;
  }

  Future<SubtitleReviewTask> startTask(
    Session session, {
    required int taskId,
  }) async {
    final actor = await _actor(session);
    var task = await SubtitleReviewTask.db.findById(session, taskId);

    if (task == null) throw Exception('找不到任务');
    if (task.assignedUserId != actor.userId) {
      throw Exception('只能开始自己领取的任务');
    }

    if (task.status != SubtitleReviewTaskStatus.assigned &&
        task.status != SubtitleReviewTaskStatus.returned) {
      throw Exception('任务当前不能开始校对');
    }

    final now = DateTime.now();
    task.status = SubtitleReviewTaskStatus.inReview;
    task.startedAt ??= now;
    task.updatedAt = now;
    task = await SubtitleReviewTask.db.updateRow(session, task);

    await _event(
      session,
      taskId: taskId,
      actor: actor,
      action: 'started',
    );

    return task;
  }

  Future<SubtitleReviewTask> submitTask(
    Session session, {
    required int taskId,
  }) async {
    final actor = await _actor(session);
    var task = await SubtitleReviewTask.db.findById(session, taskId);

    if (task == null) throw Exception('找不到任务');
    if (task.assignedUserId != actor.userId) {
      throw Exception('只能提交自己领取的任务');
    }
    if (task.status != SubtitleReviewTaskStatus.inReview) {
      throw Exception('请先开始校对');
    }

    final now = DateTime.now();
    task.editedByUserId = actor.userId;
    task.editedByDisplayName = actor.displayName;
    task.submittedAt = now;
    task.status = SubtitleReviewTaskStatus.readyForSecondReview;
    task.updatedAt = now;
    task = await SubtitleReviewTask.db.updateRow(session, task);

    await _event(
      session,
      taskId: taskId,
      actor: actor,
      action: 'submitted',
    );

    return task;
  }

  Future<SubtitleReviewTask> returnTask(
    Session session, {
    required int taskId,
    String? note,
  }) async {
    final actor = await _actor(session);
    var task = await SubtitleReviewTask.db.findById(session, taskId);

    if (task == null) throw Exception('找不到任务');
    if (task.status != SubtitleReviewTaskStatus.readyForSecondReview) {
      throw Exception('当前任务不在复核阶段');
    }

    final now = DateTime.now();
    task.reviewedByUserId = actor.userId;
    task.reviewedByDisplayName = actor.displayName;
    task.reviewedAt = now;
    task.status = SubtitleReviewTaskStatus.returned;
    task.updatedAt = now;
    task = await SubtitleReviewTask.db.updateRow(session, task);

    await _event(
      session,
      taskId: taskId,
      actor: actor,
      action: 'returned',
      note: note?.trim().isEmpty ?? true ? null : note!.trim(),
    );

    return task;
  }

  Future<SubtitleReviewTask> approveAndPublish(
    Session session, {
    required int taskId,
  }) async {
    final actor = await _actor(session);
    var task = await SubtitleReviewTask.db.findById(session, taskId);

    if (task == null) throw Exception('找不到任务');
    if (task.status != SubtitleReviewTaskStatus.readyForSecondReview) {
      throw Exception('当前任务不在待复核状态');
    }

    final now = DateTime.now();
    task.reviewedByUserId = actor.userId;
    task.reviewedByDisplayName = actor.displayName;
    task.approvedByUserId = actor.userId;
    task.approvedByDisplayName = actor.displayName;
    task.reviewedAt = now;
    task.completedAt = now;
    task.status = SubtitleReviewTaskStatus.approved;
    task.updatedAt = now;

    task = await SubtitleReviewTask.db.updateRow(session, task);

    await _event(
      session,
      taskId: taskId,
      actor: actor,
      action: 'approved',
    );

    await SubtitleEndpoint().publishSubtitleTrack(
      session,
      videoId: task.videoId,
      languageCode: task.languageCode,
    );

    final publishedAt = DateTime.now();
    task.status = SubtitleReviewTaskStatus.published;
    task.publishedAt = publishedAt;
    task.completedAt ??= publishedAt;
    task.updatedAt = publishedAt;
    task = await SubtitleReviewTask.db.updateRow(session, task);

    await _event(
      session,
      taskId: taskId,
      actor: actor,
      action: 'published',
    );

    return task;
  }
}
