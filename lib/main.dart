import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/middlewares.dart';
import 'package:milkwayshipapp/modules/login/global_controller.dart';
// import 'package:milkwayshipapp/core/utils.dart';
import 'package:milkwayshipapp/modules/root/home_page.dart';
import 'package:milkwayshipapp/modules/login/login_page.dart';
import 'package:milkwayshipapp/modules/root/app_bindings.dart';
import 'package:milkwayshipapp/modules/register/register_page.dart';

import 'core/apps.dart';
import 'core/utils.dart';
import 'modules/user/user_page.dart';

void main() {
  // Get.put(GlobalController());

  // AppBindings().dependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBindings(),
      initialRoute: appRoute.rootPage,
      getPages: [
        GetPage(
          name: appRoute.rootPage,
          page: () => HomePage(),
          middlewares: [AuthMiddleware(priority: 0)],
          binding: BindingsBuilder(() {
            Get.lazyPut(() => EncrypterController());
            Get.lazyPut(() => GlobalController());
          }),
        ),
        GetPage(
          name: appRoute.loginPage,
          binding: BindingsBuilder(() {
            Get.lazyPut(() => EncrypterController());
            Get.lazyPut(() => GlobalController());
          }),
          page: () => LoginPage(),
        ),
        GetPage(
          name: appRoute.registerPage,
          page: () => RegisterPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => EncrypterController());
            Get.lazyPut(() => GlobalController());
          }),
        ),
        GetPage(
          name: appRoute.userPage,
          page: () => UserPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => EncrypterController());
            Get.lazyPut(() => GlobalController());
          }),
        ),
      ],
      // home: HomePage(),
    );
  }
}
