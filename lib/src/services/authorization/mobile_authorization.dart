import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/services/app_storage/app_storage_key.dart';
import 'package:vockify/src/services/authorization/authorization.dart';
import 'package:vockify/src/services/authorization/authorization_exception.dart';

Authorization getAuthorization() => MobileAuthorization();

class MobileAuthorization extends Authorization {
  @override
  Future<String> authenticate() async {
    final storage = AppStorage.getInstance();
    final currentToken = await storage.getValue(AppStorageKey.token) ?? '';

    final result = await FlutterWebAuth.authenticate(
      url: "${Authorization.url}?type=app&token=${currentToken}",
      callbackUrlScheme: "vockify",
    );

    final token = Uri.parse(result).queryParameters['token'];

    if (token == null || token == '') {
      throw AuthorizationException('Token is empty');
    }

    return token;
  }
}