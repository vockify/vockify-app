import 'dart:async';

import 'package:vockify/src/api/app_api.dart';
import 'package:vockify/src/services/authorization/mobile_authorization.dart';

abstract class Authorization {
  static Authorization _instance;

  static const String url = 'http://${AppApi.apiUri}/auth/google';

  Future<void> authenticate();

  static Authorization getInstance() {
    if (_instance == null) {
      _instance = getAuthorization();
    }

    return _instance;
  }
}
