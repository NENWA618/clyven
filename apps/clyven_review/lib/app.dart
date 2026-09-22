import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'components/review_auth_gate.dart';
import 'components/review_shell.dart';
import 'pages/review_queue_page.dart';
import 'pages/review_task_page.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return div(classes: 'admin-app', [
      Router(
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              return ReviewAuthGate(child: ReviewShell(child: child));
            },
            routes: [
              Route(
                path: '/',
                title: 'Work Queue · Clyven Review',
                builder: (context, state) => const ReviewQueuePage(),
              ),
              Route(
                path: '/tasks/:taskId',
                title: 'Subtitle Task · Clyven Review',
                builder: (context, state) {
                  final taskId = int.tryParse(state.params['taskId'] ?? '');
                  if (taskId == null) {
                    return div(classes: 'review-error', [.text('无效的审核任务 ID')]);
                  }
                  return ReviewTaskPage(taskId: taskId);
                },
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
