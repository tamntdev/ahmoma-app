import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppLocalStorage {
  static const _storage = FlutterSecureStorage();

  // Singleton pattern
  static final AppLocalStorage _instance = AppLocalStorage._internal();

  factory AppLocalStorage() {
    return _instance;
  }

  AppLocalStorage._internal();

  // Generic method to save data
  Future<void> save<T>({required String key, required T value}) async {
    try {
      await _storage.write(key: key, value: value.toString());
    } catch (e) {
      throw Exception('Error saving data: $e');
    }
  }

  // Generic method to read data
  Future<T?> read<T>(String key, {T? defaultValue}) async {
    try {
      final value = await _storage.read(key: key);
      if (value == null) return defaultValue;

      // Convert string to appropriate type
      switch (T) {
        case String:
          return value as T;
        case int:
          return int.parse(value) as T;
        case double:
          return double.parse(value) as T;
        case bool:
          return (value.toLowerCase() == 'true') as T;
        default:
          throw Exception('Unsupported type: ${T.toString()}');
      }
    } catch (e) {
      return defaultValue;
    }
  }

  // Delete specific key
  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      throw Exception('Error deleting data: $e');
    }
  }

  // Delete all stored data
  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw Exception('Error deleting all data: $e');
    }
  }

  // Check if key exists
  Future<bool> containsKey(String key) async {
    try {
      final value = await _storage.read(key: key);
      return value != null;
    } catch (e) {
      return false;
    }
  }
}