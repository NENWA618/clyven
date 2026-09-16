import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class SubtitleLoginPanel extends StatelessComponent {
  const SubtitleLoginPanel({
    required this.loggedIn,
    required this.loading,
    required this.error,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onLogin,
    super.key,
  });

  final bool loggedIn;
  final bool loading;
  final String? error;

  final void Function(String value) onEmailChanged;
  final void Function(String value) onPasswordChanged;
  final void Function() onLogin;

  @override
  Component build(BuildContext context) {
    if (loggedIn) {
      return div(
        classes: 'login-success',
        [
          .text('✓ Studio 已登录，可编辑字幕'),
        ],
      );
    }

    return div(
      classes: 'login-panel',
      [
        div(
          classes: 'login-header',
          [
            h3([
              .text('Studio Login'),
            ]),
            p([
              .text('修改字幕前需要登录。'),
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
                onInput: onEmailChanged,
              ),
            ),
            input<String>(
              type: InputType.password,
              attributes: {
                'placeholder': 'Password',
                'autocomplete': 'current-password',
              },
              events: events<String>(
                onInput: onPasswordChanged,
              ),
            ),
            button(
              classes: 'login-button',
              attributes: loading
                  ? {
                      'disabled': 'disabled',
                    }
                  : null,
              onClick: loading
                  ? null
                  : () {
                      onLogin();
                    },
              [
                .text(
                  loading ? '登录中...' : '登录',
                ),
              ],
            ),
          ],
        ),
        if (error != null)
          div(
            classes: 'login-error',
            [
              .text(error!),
            ],
          ),
      ],
    );
  }
}