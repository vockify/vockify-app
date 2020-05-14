import 'dart:async';

import 'package:vockify/src/services/authorization/web_authorization.dart'
    if (dart.library.io) 'package:vockify/src/services/authorization/mobile_authorization.dart';

abstract class Authorization {
  static Authorization _instance;

  static const String url = 'https://vockify.website/api/auth/google';

  Future<void> authenticate();

  static Authorization getInstance() {
    if (_instance == null) {
      _instance = getAuthorization();
    }

    return _instance;
  }
}
