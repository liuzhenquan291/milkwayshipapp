// import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String? userId;
  String? username;
  String? token;
  String? displayName;
  String? userRole;
  bool? isLogin;
  String? regionId;
  String? regionName;

  UserModel({
    this.userId,
    this.username,
    this.token,
    this.displayName,
    this.userRole,
    this.isLogin,
    this.regionId,
    this.regionName,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'] ?? "";
    username = json['username'] ?? "";
    token = json['token'] ?? "";
    displayName = json['displayname'] ?? "";
    userRole = json['user_role'] ?? "";
    regionId = json['region_id'] ?? '';
    regionName = json['region_name'] ?? '';
    isLogin = true;
  }

  // void setToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('userId', userId ?? "");
  //   await prefs.setString('token', token ?? "");
  //   await prefs.setString('username', username ?? "");
  //   await prefs.setString('displayName', displayName ?? "");
  //   await prefs.setString('userRole', userRole ?? "");
  //   await prefs.setBool('isLogin', isLogin ?? false);
  // }
}
