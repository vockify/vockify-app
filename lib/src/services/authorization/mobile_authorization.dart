import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:vockify/src/services/app_storage/app_storage.dart';
import 'package:vockify/src/services/authorization/authorization.dart';
import 'package:vockify/src/services/authorization/authorization_exception.dart';

Authorization getAuthorization() => MobileAuthorization();

class MobileAuthorization extends Authorization {
  @override
  Future<void> authenticate() async {
    final result = await FlutterWebAuth.authenticate(
      url: "${Authorization.url}?type=app",
      callbackUrlScheme: "vockify",
    );

    final token = Uri.parse(result).queryParameters['token'];

    if (token == null || token == '') {
      throw AuthorizationException('Token is empty');
    }

    final storage = AppStorage.getInstance();
    await storage.setValue('token', token);
  }
}