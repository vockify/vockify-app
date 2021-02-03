import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:vockify/src/redux/selectors/selectors.dart';
import 'package:vockify/src/redux/state/app_state.dart';

AmplitudeService amplitude;

void setupAmplitude(Store<AppState> store) {
  amplitude = AmplitudeService(store);
}

class AmplitudeService {
  static const String _apiKey = '1e8f8556d3eb5de3c208ab9725d6a4e9';
  static const String _project = 'vockify-mobile';

  final Store<AppState> _store;
  final Amplitude _amplitude  = Amplitude.getInstance(instanceName: _project);

  AmplitudeService(this._store) {
    _amplitude.init(_apiKey);
    _amplitude.enableCoppaControl();
    _amplitude.trackingSessionEvents(true);
  }

  Future<void> logEvent(String eventType, {Map<String, dynamic> eventProperties, bool outOfSession}) async {
    if (!kReleaseMode) {
      // Do nothing in development mode.
      return;
    }

    _amplitude.setUserId(getUserId(_store.state).toString());
    _amplitude.logEvent(eventType, eventProperties: eventProperties, outOfSession: outOfSession);
  }
}