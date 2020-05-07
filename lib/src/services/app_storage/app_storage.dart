import 'package:vockify/src/services/app_storage/mobile_storage.dart';

abstract class AppStorage {
  static AppStorage _instance;

  Future<bool> containsKey(String key);

  Future<String> getValue(String key);

  Future<void> remove(String key);

  Future<void> setValue(String key, String value);

  static AppStorage getInstance() {
    if (_instance == null) {
      _instance = getAppStorage();
    }

    return _instance;
  }
}
