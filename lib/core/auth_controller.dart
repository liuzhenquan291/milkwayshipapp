import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  String? userId = '';
  String token = '';
  bool _isLogin = false;
  String? username = '';
  String? displayName = '';
  String? userRole = '';
  bool get isLogin => _isLogin;

  static String tokenKey = 'token';
  String userIdKey = 'userId';
  String usernameKey = 'username';
  String displayNameKey = 'displayName';
  String userRoleKey = 'userRole';

  Future<AuthController> init() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString(userIdKey);
    token = preferences.getString(tokenKey) ?? "";
    username = preferences.getString(usernameKey);
    displayName = preferences.getString(displayNameKey);
    userRole = preferences.getString(userRoleKey);
    if (token.isNotEmpty) {
      _isLogin = true;
    }
    return this;
  }

  // 登录
  Future<void> onLogin(
    String? userId,
    String? username,
    String? displayName,
    String? userRole,
    String token,
  ) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(userIdKey, this.userId ?? "");
    preferences.setString(usernameKey, this.username ?? "");
    preferences.setString(displayNameKey, this.displayName ?? "");
    preferences.setString(userRoleKey, this.userRole ?? "");
    preferences.setString(tokenKey, this.token);
    await init();

    update();
  }

  // 登出
  Future<void> clearToken() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(userIdKey);
    preferences.remove(usernameKey);
    preferences.remove(displayNameKey);
    preferences.remove(userRoleKey);
    preferences.remove(tokenKey);

    await init();
    update();
  }
}
