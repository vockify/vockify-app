abstract class AppStorageInterface {
  Future<bool> containsKey(String key);

  Future<String> getValue(String key);

  Future<void> remove(String key);

  Future<void> setValue(String key, String value);
}
