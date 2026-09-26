import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveProvider {
  static late Box _userBox;

  static const String userBox = 'userBox';
  static const String kName = 'name';
  static const String kImage = 'image';

  static Future<void> init() async {
    await Hive.initFlutter();
    _userBox = await Hive.openBox(userBox);
  }

  static Future<void> cacheData(String key, dynamic value) async {
    await _userBox.put(key, value);
  }

  static dynamic getData(String key) {
    return _userBox.get(key);
  }

  static Future<void> cacheUserData({
    required String name,
    required String imagePath,
  }) async {
    await cacheData(HiveProvider.kName, name);
    await cacheData(HiveProvider.kImage, imagePath);
  }
}

// var box = Hive.box('userBox');

// one instance of boxes
// hardcoded (boxes name, keys name)
// helpers functions
