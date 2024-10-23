import 'package:get_storage/get_storage.dart';

class LocalStorage {
  // Private constructor
  LocalStorage._();
  // Single instance
  static final LocalStorage instance = LocalStorage._();
  // Factory constructor returns the single instance
  factory LocalStorage() => instance;

  // Initialize GetStorage
  static late GetStorage box;

  static Future<void> init() async {
    await GetStorage.init();
    box = GetStorage();
  }

  dynamic read(String key) {
    return box.read(key);
  }

  // T? read<T>(String key) {
  //   return box.read<T>(key);
  // }

  // Example method to write data to storage
  Future<void> write(String key, dynamic value) async {
    await box.write(key, value);
  }

  // Example method to remove data from storage
  Future<void> remove(String key) async {
    await box.remove(key);
  }

  // Example method to clear all data from storage
  Future<void> clear() async {
    await box.erase();
  }
}
