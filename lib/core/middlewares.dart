import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:milkwayshipapp/modules/login/global_controller.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? priority = 1;

  AuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    GlobalController c = Get.find<GlobalController>();
    if (c.isLogin == true) {
      return super.redirect(route);
    } else {
      Future.delayed(
          const Duration(seconds: 1), () => Get.snackbar("提示", "请先登录..."));
      return const RouteSettings(name: '/login');
    }
  }
}
