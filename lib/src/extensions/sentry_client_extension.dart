import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

extension SentryClientExtension on SentryClient {
  /// Reports [error] along with its [stackTrace] to Sentry.io.
  Future<Null> reportError(dynamic error, dynamic stackTrace) async {
    print('Caught error: $error');

    if (!kReleaseMode) {
      print(stackTrace);
      return;
    }

    await captureException(
      error,
      stackTrace: stackTrace,
    );
  }

  Future<void> exceptionHandler(FlutterErrorDetails details) async {
    if (!kReleaseMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Sentry.
      final stack = details.stack;
      if (stack != null) {
        Zone.current.handleUncaughtError(details.exception, stack);
      }
    }
  }
}
