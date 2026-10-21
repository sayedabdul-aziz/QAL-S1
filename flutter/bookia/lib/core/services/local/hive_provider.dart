// import 'package:hive_ce_flutter/hive_flutter.dart';
// import 'package:taskati/core/hive/hive_registrar.g.dart';
// import 'package:taskati/core/models/task_model.dart';

// class HiveProvider {
//   static late Box _userBox;
//   static late Box<TaskModel> _taskBox;

//   static const String kUserBox = 'userBox';
//   static const String kTaskBox = 'taskBox';

//   static const String kName = 'name';
//   static const String kImage = 'image';
//   static const String kIsDark = 'isDark';

//   static Future<void> init() async {
//     await Hive.initFlutter();
//     Hive.registerAdapters();
//     _userBox = await Hive.openBox(kUserBox);
//     _taskBox = await Hive.openBox<TaskModel>(kTaskBox);
//   }

//   static Box<TaskModel> get taskBox => _taskBox;

//   static Box get userBox => _userBox;

//   static Future<void> cacheData(String key, dynamic value) async {
//     await _userBox.put(key, value); // if new key (add) , if old key (update)
//   }

//   static dynamic getData(String key) {
//     return _userBox.get(key);
//   }

//   static Future<void> deleteData(String key) async {
//     await _userBox.delete(key);
//   }

//   static Future<void> cacheTask(String key, TaskModel value) async {
//     await _taskBox.put(key, value);
//   }

//   static TaskModel? getTask(String key) {
//     return _taskBox.get(key);
//   }

//   static Future<void> deleteTask(String key) async {
//     await _taskBox.delete(key);
//   }

//   static Future<void> cacheUserData({
//     required String name,
//     required String imagePath,
//   }) async {
//     await cacheData(HiveProvider.kName, name);
//     await cacheData(HiveProvider.kImage, imagePath);
//   }
// }
