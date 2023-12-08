import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  bool? isAuthenticated = false;
  String? token;

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
