import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/middlewares.dart';
import 'package:milkwayshipapp/modules/regions/region_detail_congroller.dart';
import 'package:milkwayshipapp/modules/regions/region_list_controller.dart';
import 'package:milkwayshipapp/modules/regions/region_options_page.dart';
import 'package:milkwayshipapp/modules/root/home_page.dart';
import 'package:milkwayshipapp/modules/login/login_page.dart';
import 'package:milkwayshipapp/modules/root/app_bindings.dart';
import 'package:milkwayshipapp/modules/register/register_page.dart';
import 'package:milkwayshipapp/modules/root/settings_page.dart';
import 'package:milkwayshipapp/modules/ships/corn_join_controller.dart';
import 'package:milkwayshipapp/modules/ships/corn_join_page.dart';
import 'package:milkwayshipapp/modules/ships/cornucopia_list_controller.dart';
import 'package:milkwayshipapp/modules/ships/cornucopia_list_page.dart';
import 'package:milkwayshipapp/modules/ships/cornucopia_option_page.dart';
import 'package:milkwayshipapp/modules/ships/corn_create_controller.dart';
import 'package:milkwayshipapp/modules/ships/corn_create_page.dart';
import 'package:milkwayshipapp/modules/ships/shipuser_list_controller.dart';
import 'package:milkwayshipapp/modules/ships/shipuser_list_page.dart';
import 'package:milkwayshipapp/modules/ships/shipuser_option_controller.dart';
import 'package:milkwayshipapp/modules/user/user_edit_controller.dart';
import 'package:milkwayshipapp/modules/user/user_edit_page.dart';
import 'package:milkwayshipapp/modules/user/user_list_controller.dart';
import 'package:milkwayshipapp/modules/user/user_option_controller.dart';
import 'package:milkwayshipapp/modules/user/user_option_page.dart';

import 'core/apps.dart';
import 'core/common_controller.dart';
import 'core/utils.dart';
import 'modules/regions/region_detail_page.dart';
import 'modules/regions/region_options_controller.dart';
import 'modules/regions/region_page.dart';
import 'modules/regions/regions_new_page.dart';
import 'modules/root/index_page.dart';
import 'modules/ships/cornucopia_option_controller.dart';
import 'modules/ships/cornucopia_self_controller.dart';
import 'modules/ships/cornucopia_self_page.dart';
import 'modules/ships/shipuser_option_page.dart';
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
          page: () => const IndexPage(),
          middlewares: [AuthMiddleware(priority: 0)],
          binding: BindingsBuilder(() {
            Get.lazyPut(() => RegionDetailController());
          }),
          children: [
            GetPage(
              name: appRoute.homePage,
              page: () => const HomePage(),
            ),
            // 势力详情页
            GetPage(
              name: appRoute.regionDetailPage,
              page: () => const RegionDetailPage(),
            ),
          ],
        ),
        GetPage(
          name: appRoute.settingsPage,
          page: () => const SettingsPage(),
        ),
        // 登录页
        GetPage(
          name: appRoute.loginPage,
          binding: BindingsBuilder(() {
            Get.lazyPut(() => EncrypterController());
          }),
          page: () => const LoginPage(),
        ),
        // 注册页
        GetPage(
          name: appRoute.registerPage,
          page: () => const RegisterPage(),
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
        // 用户操作页
        GetPage(
          name: appRoute.userOptionPage,
          page: () => UserOptionPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => UserOptionController());
          }),
        ),
        // 用户信息编辑页-- 编辑自己;
        GetPage(
            name: appRoute.userEditPage,
            page: () => const UserEditPage(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => UserEditController());
              Get.lazyPut(() => EncrypterController());
            })),
        // 势力管理页
        GetPage(
          name: appRoute.regionPage,
          page: () => RegionPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => RegionListController());
          }),
        ),
        // 新建势力页
        GetPage(
          name: appRoute.regionNewPage,
          page: () => const RegionNewPage(),
        ),
        // 势力操作页
        GetPage(
          name: appRoute.regionOptionsPage,
          page: () => RegionOptionsPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => RegionOptionsController());
          }),
        ),
        // 游戏角色管理页
        GetPage(
          name: appRoute.shipUserPage,
          page: () => ShipuserListPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => ShipuserListController());
          }),
        ),
        // 游戏角色操作页
        GetPage(
            name: appRoute.shipUserOptionsPage,
            page: () => ShipUserOptionPage(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => ShipUserOptionController());
            })),
        // 聚宝盆管理页
        GetPage(
          name: appRoute.cornucopiaPage,
          page: () => const CornucopiaListPage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => CornucopiaListController());
            },
          ),
        ),
        GetPage(
          name: appRoute.cornucopiaSelfPage,
          page: () => const CornucopiaSelfPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => CornucopiaSelfController());
          }),
        ),
        GetPage(
          name: appRoute.cornucopiaOptionPage,
          page: () => CornucopiaOptionPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => CornucopiaOptionController());
          }),
        ),
        GetPage(
          name: appRoute.cornucopiaNewPage,
          page: () => CreateCornucopiaPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => CornCreateController());
            Get.lazyPut(() => TimePickerController());
          }),
        ),
        GetPage(
          name: appRoute.cornJoinPage,
          page: () => JoinCornPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => CornJoinController());
          }),
        ),
      ],
    );
  }
}
