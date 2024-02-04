import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/extensions/sentry_client_extension.dart';
import 'package:vockify/src/services/amplitude.dart';
import 'package:vockify/src/services/data_repository/data_repository.dart';
import 'package:vockify/src/vockify_app.dart';

final SentryClient _sentry = new SentryClient(SentryOptions(
  dsn: "<sentry-dsn>",
));

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();

  await setupDataService();
  setupApi();
  setupAmplitude();

  FlutterError.onError = _sentry.exceptionHandler;

  runZonedGuarded<Future<void>>(() async {
    runApp(VockifyApp());
  }, (Object error, StackTrace stackTrace) {
    _sentry.reportError(error, stackTrace);
  });
}
