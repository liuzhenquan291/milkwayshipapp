import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  bool? isAuthenticated = false;
  String? token;

  Future<void> login(String username, String password) async {
    // 这里模拟登录成功，实际情况下需要调用认证接口获取 token
    await Future.delayed(Duration(seconds: 2));
    token = 'your_generated_token';
    isAuthenticated = true;

    // 将 token 缓存到本地
    await _saveTokenToLocal(token);
  }

  Future<void> logout() async {
    isAuthenticated = false;
    token = null;

    // 清除本地缓存的 token
    await _clearTokenFromLocal();
  }

  Future<void> _saveTokenToLocal(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token ?? "");
  }

  Future<void> _clearTokenFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final cachedToken = prefs.getString('token');

    if (cachedToken != null) {
      token = cachedToken;
      isAuthenticated = true;
    } else {
      isAuthenticated = false;
    }
    update();
  }
}
