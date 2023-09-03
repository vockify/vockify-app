import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter/foundation.dart';

late AmplitudeService amplitude;

void setupAmplitude() {
  amplitude = AmplitudeService();
}

class AmplitudeService {
  static const String _apiKey = '<api-key>';
  static const String _project = '<project>';

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

  Future<void> logEvent(String eventType, {Map<String, dynamic>? eventProperties, bool? outOfSession}) async {
    if (!kReleaseMode) {
      print('$eventType: ${eventProperties.toString()}');
      return;
    }

    _amplitude.logEvent(eventType, eventProperties: eventProperties, outOfSession: outOfSession);
  }
}