import 'package:shared_preferences/shared_preferences.dart';

class StorageKeys {
  static String tokenKey = 'token';
  static String userIdKey = 'userId';
  static String usernameKey = 'username';
  static String displayNameKey = 'displayName';
  static String userRoleKey = 'userRole';
  static String regionIdKey = 'regionId';
  static String regionNameKey = 'regionName';
}

class StorageHelper {
  static SharedPreferences? _prefs;

  static Future<dynamic> _getInstance() async =>
      _prefs = await SharedPreferences.getInstance();

  static void set(String key, dynamic value) async {
    await _getInstance();
    _prefs?.setString(key, value);
  }

  static Future<String?> get(String key) async {
    await _getInstance();
    return _prefs?.getString(key);
  }

  static void remove(String key) async {
    await _getInstance();
    _prefs?.remove(key);
  }

  static Future<void> setAll(
    String? userId,
    String? username,
    String? displayName,
    String? userRole,
    String token,
    String? regionId,
    String? regionName,
  ) async {
    set(StorageKeys.userIdKey, userId);
    set(StorageKeys.usernameKey, username);
    set(StorageKeys.displayNameKey, displayName);
    set(StorageKeys.userRoleKey, userRole);
    set(StorageKeys.tokenKey, token);
    set(StorageKeys.regionIdKey, token);
    set(StorageKeys.regionNameKey, token);
  }

  static Future<void> removeAll() async {
    remove(StorageKeys.userIdKey);
    remove(StorageKeys.usernameKey);
    remove(StorageKeys.displayNameKey);
    remove(StorageKeys.userRoleKey);
    remove(StorageKeys.tokenKey);
    remove(StorageKeys.regionIdKey);
    remove(StorageKeys.regionNameKey);
  }
}
