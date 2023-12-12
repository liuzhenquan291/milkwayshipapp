import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/root/home_page.dart';
import 'package:milkwayshipapp/modules/login/login_page.dart';
import 'package:milkwayshipapp/modules/root/app_bindings.dart';
import 'package:milkwayshipapp/modules/register/register_page.dart';

void main() {
  // Get.put(GlobalController());

  AppBindings().dependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      // // 定义 unknownRoute 处理函数
      // unknownRoute: GetPage(
      //   name: '/404', // 404 页面的路由名称
      //   page: () => NotFoundPage(),
      // ),
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
        ),
        GetPage(
          name: "/register",
          page: () => RegisterPage(),
        ),
      ],
      home: HomePage(),
    );
  }
}
