import 'package:universal_html/html.dart' as html;
import 'package:vockify/src/services/app_storage/app_storage_interface.dart';

class AppCookieStorage extends AppStorageInterface {
  @override
  Future<bool> containsKey(String key) async {
    final cookie = html.window.document.cookie;
    final Iterable<String> keys = cookie.split(';').map((c) => c.split('=').first);

    return keys.contains(key);
  }

  @override
  Future<String> getValue(String key) async {
    final cookie = html.window.document.cookie;
    final Iterable<MapEntry<String, String>> entries = cookie.split(';').map((c) {
      final keyValue = c.split('=');
      final key = keyValue[0];
      final value = keyValue[1];

      return MapEntry(key, value);
    });

    final map = Map.fromEntries(entries);

    return map[key];
  }

  @override
  Future<void> remove(String key) async {
    // todo remove
  }

  @override
  Future<void> setValue(String key, String value) async {
    html.window.document.cookie = '$key=$value';
  }
}
