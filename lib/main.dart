import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/middlewares.dart';
import 'package:milkwayshipapp/modules/account/account_page.dart';
import 'package:milkwayshipapp/modules/instruction/instruction_page.dart';
import 'package:milkwayshipapp/modules/regions/region_detail_congroller.dart';
import 'package:milkwayshipapp/modules/regions/region_list_controller.dart';
// import 'package:milkwayshipapp/modules/login/global_controller.dart';
// import 'package:milkwayshipapp/core/utils.dart';
import 'package:milkwayshipapp/modules/root/home_page.dart';
import 'package:milkwayshipapp/modules/login/login_page.dart';
import 'package:milkwayshipapp/modules/root/app_bindings.dart';
import 'package:milkwayshipapp/modules/register/register_page.dart';
import 'package:milkwayshipapp/modules/ships/cornucopia_list_controller.dart';
import 'package:milkwayshipapp/modules/ships/cornucopia_page.dart';
import 'package:milkwayshipapp/modules/ships/shipuser_list_controller.dart';
import 'package:milkwayshipapp/modules/ships/shipuser_page.dart';
import 'package:milkwayshipapp/modules/user/user_list_controller.dart';

import 'components/marquee.dart';
import 'core/apps.dart';
import 'core/utils.dart';
import 'modules/regions/region_detail_page.dart';
import 'modules/regions/region_page.dart';
import 'modules/regions/regions_new_page.dart';
import 'modules/root/index_page.dart';
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
        // 首页
        GetPage(
          name: appRoute.rootPage,
          // page: () => HomePage(),
          page: () => IndexPage(),
          middlewares: [AuthMiddleware(priority: 0)],
          binding: BindingsBuilder(() {
            Get.lazyPut(() => RegionDetailController());
            // Get.lazyPut(() => MarqueeController());
            // Get.lazyPut(() => ScrollController());
          }),
          children: [
            GetPage(
              name: appRoute.homePage,
              page: () => HomePage(),
            ),
            // 势力详情页
            GetPage(
              name: appRoute.regionDetailPage,
              page: () => RegionDetailPage(),
            ),
          ],
        ),
        // 登录页
        GetPage(
          name: appRoute.loginPage,
          binding: BindingsBuilder(() {
            Get.lazyPut(() => EncrypterController());
          }),
          page: () => LoginPage(),
        ),
        // 注册页
        GetPage(
          name: appRoute.registerPage,
          page: () => RegisterPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => EncrypterController());
          }),
        ),
        // 用户管理页
        GetPage(
          name: appRoute.userPage,
          page: () => UserListPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => UserListController());
          }),
        ),
        // 势力管理页
        GetPage(
          name: appRoute.regionPage,
          page: () => RegionPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => RegionListController());
          }),
        ),
        // 加入势力页
        GetPage(
          name: appRoute.regionNewPage,
          page: () => RegionNewPage(),
        ),
        // 游戏角色管理页
        GetPage(
          name: appRoute.shipUserPage,
          page: () => ShipuserListPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => ShipuserListController());
          }),
        ),
        // 聚宝盆管理页
        GetPage(
          name: appRoute.cornucopiaPage,
          page: () => CornucopiaListPage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => CornucopiaListController());
            },
          ),
        ),
        // // 个人中心页
        // GetPage(
        //   name: appRoute.accountInfoPage,
        //   page: () => AccountPage(),
        //   binding: BindingsBuilder(() {}),
        // ),
        // // 攻略页
        // GetPage(
        //   name: appRoute.instructionPage,
        //   page: () => InstructionPage(),
        //   binding: BindingsBuilder(() {}),
        // ),
      ],
      // home: HomePage(),
    );
  }
}
