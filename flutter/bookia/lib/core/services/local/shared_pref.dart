import 'dart:convert';

import 'package:bookia/features/auth/data/models/auth_response/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late final SharedPreferences prefs;

  static const String kUserData = 'user';
  static const String kToken = 'token';
  static const String kWishlist = 'wishlist';

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void setWishlist(List<int> wishlistIds) {
    // List<int> => List<String>
    // cache ids as strings
    List<String> ids = [];
    for (var id in wishlistIds) {
      ids.add(id.toString());
    }
    prefs.setStringList(kWishlist, ids);
  }

  static List<int> getWishlist() {
    // List<String> => List<int>
    // fetch ids as integers
    var ids = prefs.getStringList(kWishlist);
    if (ids == null) return [];
    return ids.map((e) => int.tryParse(e) ?? 0).toList();
  }

  static void setToken(String? token) {
    if (token == null) return;
    setString(kToken, token);
  }

  static String? getToken() {
    return getString(kToken);
  }

  static void setUserData(User? user) {
    if (user == null) return;

    // Object(toJson) => Map(encode) => String
    var objToJson = user.toJson();
    var jsonToString = jsonEncode(objToJson);

    setString(kUserData, jsonToString);
  }

  static User? getUserData() {
    var cachedString = getString(kUserData);
    if (cachedString == null) return null;

    // String => Map(decode) => Object(fromJson)
    var stringToJson = jsonDecode(cachedString);

    return User.fromJson(stringToJson);
  }

  static void setInt(String key, int value) {
    prefs.setInt(key, value);
  }

  static int? getInt(String key) {
    return prefs.getInt(key);
  }

  static void setDouble(String key, double value) {
    prefs.setDouble(key, value);
  }

  static double? getDouble(String key) {
    return prefs.getDouble(key);
  }

  static void setBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  static bool? getBool(String key) {
    return prefs.getBool(key);
  }

  static void setString(String key, String value) {
    prefs.setString(key, value);
  }

  static String? getString(String key) {
    return prefs.getString(key);
  }
}
