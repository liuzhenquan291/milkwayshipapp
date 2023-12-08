import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/root/home_page.dart';
import 'package:milkwayshipapp/modules/login/login_page.dart';
import 'package:milkwayshipapp/modules/root/app_bindings.dart';

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
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
        ),
      ],
      home: HomePage(),
      // initialBinding: BindingsBuilder(() {
      //   Get.put(GlobalController());
      // }),
    );
  }
}
