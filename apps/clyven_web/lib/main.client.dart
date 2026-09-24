library;

import 'package:jaspr/client.dart';

import 'app.dart';
import 'main.client.options.dart';

void main() {
  Jaspr.initializeApp(options: defaultClientOptions);

  runApp(const App(), attachTo: 'body');
}
