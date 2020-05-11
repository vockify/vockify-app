import 'dart:async';

import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authorization {
  static Future<bool> authorize() async {
    final result = await FlutterWebAuth.authenticate(
      url: "https://vockify.website/api/auth/google",
      callbackUrlScheme: "vockify",
    );

    final token = Uri.parse(result).queryParameters['token'];

    if (token != null && token != '') {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);

      return true;
    }

    return false;
  }
}
