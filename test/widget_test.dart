// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:vockify/src/redux/effects/app_effect.dart';
import 'package:vockify/src/redux/effects/set_effect.dart';
import 'package:vockify/src/redux/effects/term_effect.dart';
import 'package:vockify/src/redux/middlewares/navigation_middleware.dart';
import 'package:vockify/src/redux/middlewares/tracking_middleware.dart';
import 'package:vockify/src/redux/reducers/app_reducer.dart';
import 'package:vockify/src/redux/reducers/set_reducer.dart';
import 'package:vockify/src/redux/reducers/term_reducer.dart';
import 'package:vockify/src/redux/state/app_state.dart';
import 'package:vockify/src/vockify_app.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final reducer = AppReducer(SetReducer(), TermReducer());
    final effect = AppEffect(SetEffect(), TermEffect());

    final store = Store<AppState>(
      reducer.getState,
      middleware: [
        EpicMiddleware(effect.getEffects()),
        NavigationMiddleware<AppState>(),
        TrackingMiddleware(),
      ],
      initialState: AppState.initial(),
    );

    await tester.pumpWidget(VockifyApp(store: store,));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
