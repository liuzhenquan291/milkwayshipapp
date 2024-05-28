import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'server.dart';

class AuthService extends GetxService {
  String? userId = '';
  String token = '';
  bool _isLogin = false;
  String? username = '';
  String? displayName = '';
  String? userRole = '';
  String? regionId = '';
  String? regionName = '';
  bool get isLogin => _isLogin;

  static String tokenKey = 'token';
  String userIdKey = 'userId';
  String usernameKey = 'username';
  String displayNameKey = 'displayName';
  String userRoleKey = 'userRole';
  String regionIdKey = 'regionId';
  String regionNameKey = 'regionName';

  Future<AuthService> init() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString(userIdKey);
    token = preferences.getString(tokenKey) ?? "";
    username = preferences.getString(usernameKey);
    displayName = preferences.getString(displayNameKey);
    userRole = preferences.getString(userRoleKey);
    regionId = preferences.getString(regionIdKey);
    regionName = preferences.getString(regionNameKey);
    if (token.isNotEmpty) {
      _isLogin = true;
      final ApiService as = ApiService();
      as.token = token;
    }
    return this;
  }

  // 登录
  Future<void> onLogin() async {
    await init();
  }

  // 登出
  Future<void> clearToken() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(userIdKey);
    preferences.remove(usernameKey);
    preferences.remove(displayNameKey);
    preferences.remove(userRoleKey);
    preferences.remove(tokenKey);
    preferences.remove(regionIdKey);
    preferences.remove(regionNameKey);
    await init();
    final as = ApiService();
    as.token = null;
  }

  bool isManager() {
    return userRole == 'root' || userRole == 'manager';
  }

  bool isSuper() {
    return userRole == 'root';
  }
}
