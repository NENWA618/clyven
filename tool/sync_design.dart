// Copies the shared design stylesheets from design/ into each app's web/
// directory (each app serves its own static files).
//
//   dart run tool/sync_design.dart
import 'dart:io';

const _targets = {
  'apps/web/web': ['glyphora-tokens.css', 'glyphora-web.css'],
  'apps/studio/web': [
    'glyphora-tokens.css',
    'glyphora-console.css',
    'glyphora-studio.css',
  ],
  'apps/admin/web': ['glyphora-tokens.css', 'glyphora-console.css'],
  'apps/review/web': [
    'glyphora-tokens.css',
    'glyphora-console.css',
    'glyphora-review.css',
  ],
};

void main() {
  var copied = 0;
  _targets.forEach((dir, files) {
    for (final name in files) {
      final src = File('design/$name');
      if (!src.existsSync()) {
        stderr.writeln('skip $name (not in design/)');
        continue;
      }
      src.copySync('$dir/$name');
      copied++;
    }
  });
  stdout.writeln('synced $copied files');
}
