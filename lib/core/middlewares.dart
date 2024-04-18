import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:milkwayshipapp/core/auth.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? priority = 1;

  AuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    // Get.putAsync(() => AuthService().init());
    AuthService as = Get.find<AuthService>();
    if (as.isLogin == true) {
      return super.redirect(route);
    } else {
      Future.delayed(
          const Duration(seconds: 1), () => Get.snackbar("提示", "请先登录..."));
      return const RouteSettings(name: '/login');
    }
  }
}
