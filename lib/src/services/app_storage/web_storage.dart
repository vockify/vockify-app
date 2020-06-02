// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:vockify/src/services/app_storage/app_storage.dart';

AppStorage getAppStorage() => WebStorage();

class WebStorage extends AppStorage {
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
    html.document.cookie = '$key=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
  }

  @override
  Future<void> setValue(String key, String value) async {
    html.window.document.cookie = '$key=$value; max-age=31536000; path=/';
  }
}
