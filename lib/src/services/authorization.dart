import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:universal_html/html.dart';
import 'package:vockify/src/services/app_storage.dart';

class Authorization {
  static const String _url = 'https://vockify.website/api/auth/google';

  static Future<bool> authorize() async {
    if (kIsWeb) {
      window.location.href = _url;
      return false;
    } else {
      final result = await FlutterWebAuth.authenticate(
        url: "$_url?type=app",
        callbackUrlScheme: "vockify",
      );

      final token = Uri.parse(result).queryParameters['token'];

      if (token != null && token != '') {
        final storage = AppStorage.getInstance();
        await storage.setValue('token', token);

        return true;
      }

      return false;
    }
  }
}
