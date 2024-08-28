abstract class LocalStorage {
  Future<bool> save<D>(String key, D value);

  Future<bool?> readBool(String key);

  Future<int?> readInt(String key);

  Future<double?> readDouble(String key);

  Future<String?> readString(String key);

  Future<void> delete(String key);

  Future<bool> has(String key);

  Future<void> clean();
}
