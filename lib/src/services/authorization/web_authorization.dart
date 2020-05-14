// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:vockify/src/services/authorization/authorization.dart';

Authorization getAuthorization() => WebAuthorization();

class WebAuthorization extends Authorization {
  @override
  Future<void> authenticate() async {
    window.location.href = Authorization.url;
  }
}
