import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String? userId;
  String? username;
  String? token;
  String? userDisplayName;
  String? userRole;
  bool? isLogin;

  UserModel({
    this.userId,
    this.username,
    this.token,
    this.userDisplayName,
    this.userRole,
    this.isLogin,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'] ?? "";
    username = json['username'] ?? "";
    token = json['token'] ?? "";
    userDisplayName = json['user_displayname'] ?? "";
    userRole = json['user_role'] ?? "";
    isLogin = true;
  }

  void setToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId ?? "");
    await prefs.setString('token', token ?? "");
    await prefs.setString('username', username ?? "");
    await prefs.setString('userDisplayName', userDisplayName ?? "");
    await prefs.setString('userRole', userRole ?? "");
    await prefs.setBool('isLogin', isLogin ?? false);
  }
}
