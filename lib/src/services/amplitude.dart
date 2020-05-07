import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter/foundation.dart';

AmplitudeService amplitude;

void setupAmplitude() {
  amplitude = AmplitudeService();
}

class AmplitudeService {
  static const String _apiKey = '1e8f8556d3eb5de3c208ab9725d6a4e9';
  static const String _project = 'vockify-mobile';

  final Amplitude _amplitude  = Amplitude.getInstance(instanceName: _project);

  AmplitudeService() {
    _amplitude.init(_apiKey);
    _amplitude.enableCoppaControl();
    _amplitude.trackingSessionEvents(true);
  }

  Future<void> setUserId(String userId) async {
    await _amplitude.setUserId(userId);
  }

  Future<void> setUserProperties(Map<String, dynamic> userProperties) async {
    await _amplitude.setUserProperties(userProperties);
  }

  Future<void> logEvent(String eventType, {Map<String, dynamic> eventProperties, bool outOfSession}) async {
    if (!kReleaseMode) {
      print('$eventType: ${eventProperties.toString()}');
      return;
    }

    _amplitude.logEvent(eventType, eventProperties: eventProperties, outOfSession: outOfSession);
  }
}