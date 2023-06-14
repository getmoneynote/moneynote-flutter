import 'package:flutter/cupertino.dart';
import 'app.dart';

void main() {
  runApp(const App());
}


// Future<void> main() async {
//   await SentryFlutter.init((options) {
//       options.dsn = 'https://bf640906692f40539248fc512072f370@o506813.ingest.sentry.io/4505159625867264';
//       // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
//       // We recommend adjusting this value in production.
//       options.tracesSampleRate = 1.0;
//     },
//     appRunner: () => runApp(const App()),
//   );
//
//   // or define SENTRY_DSN via Dart environment variable (--dart-define)
// }