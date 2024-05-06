import 'package:get/get.dart';

import '../modules/seasons/season_new_controller.dart';
import '../modules/seasons/season_new_page.dart';
import '../modules/seasons/season_option_controller.dart';
import '../modules/regions/region_detail_congroller.dart';
import '../modules/regions/region_join_controller.dart';
import '../modules/regions/region_join_page.dart';
import '../modules/regions/region_list_controller.dart';
import '../modules/regions/region_options_page.dart';
import '../modules/root/home_page.dart';
import '../modules/login/login_page.dart';
import '../modules/register/register_page.dart';
import '../modules/root/settings_page.dart';
import '../modules/seasons/season_controller.dart';
import '../modules/seasons/season_option_page.dart';
import '../modules/seasons/season_page.dart';
import '../modules/ships/corn_join_controller.dart';
import '../modules/ships/corn_join_page.dart';
import '../modules/ships/cornucopia_list_controller.dart';
import '../modules/ships/cornucopia_list_page.dart';
import '../modules/ships/cornucopia_option_page.dart';
import '../modules/ships/corn_create_controller.dart';
import '../modules/ships/corn_create_page.dart';
import '../modules/ships/shipuser_list_controller.dart';
import '../modules/ships/shipuser_list_page.dart';
import '../modules/ships/shipuser_option_controller.dart';
import '../modules/user/user_edit_controller.dart';
import '../modules/user/user_edit_page.dart';
import '../modules/user/user_list_controller.dart';
import '../modules/user/user_option_controller.dart';
import '../modules/user/user_option_page.dart';
import '../modules/regions/region_detail_page.dart';
import '../modules/regions/region_options_controller.dart';
import '../modules/regions/region_page.dart';
import '../modules/regions/regions_new_page.dart';
import '../modules/root/index_page.dart';
import '../modules/ships/cornucopia_option_controller.dart';
import '../modules/ships/cornucopia_self_controller.dart';
import '../modules/ships/cornucopia_self_page.dart';
import '../modules/ships/shipuser_option_page.dart';
import '../modules/user/user_page.dart';
import 'common_controller.dart';
import 'middlewares.dart';
import 'utils.dart';

// AppRoute AppRoute = AppRoute();

abstract class AppRoute {
  // 导航页
  static String rootPage = '/';
  // 首页
  static String homePage = '/home';
  // 登录页
  static String loginPage = '/login';
  // 注册页
  static String registerPage = '/register';
  // 用户管理页
  static String userPage = '/user';
  // 势力管理页
  static String regionPage = '/region';
  // 势力详情页
  static String regionDetailPage = '/regionDetail';
  // 势力编辑页
  static String regionEditPage = '/regionEdit';
  // 新建势力页
  static String regionNewPage = '/regionNew';
  // 势力操作页
  static String regionOptionsPage = '/regionOptions';
  // 加入势力页
  static String regionJoin = '/regionJoin';
  // 角色管理页
  static String shipUserPage = '/ship/user';
  // 角色编辑页
  static String shipUserEditPage = '/ship/userEdit';
  // 角色操作页
  static String shipUserOptionsPage = '/shipUserOptions';
  // 新建角色页
  static String shipUserNewPage = '/ship/userNew';
  // 聚宝盆管理页
  static String cornucopiaPage = '/ship/cornucopia';

  // 赛季管理页
  static String seasonPage = '/season';
  // 赛季新建
  static String seasonNewPage = '/season/new';
  // 赛季操作
  static String seasonOptionPage = '/season/option';

  // 新建开盆计划页
  static String cornucopiaNewPage = '/ship/cornucopiaNew';
  // 加入开盆计划页
  static String cornJoinPage = '/ship/cornJoin';
  // 编辑开盆计划页
  static String cornucopiaEditPage = '/ship/cornucopiaEdit';
  // 编辑开盆计划页
  static String cornucopiaOptionPage = '/ship/cornucopiaOption';
  // 自己的所有角色的开盆情况
  static String cornucopiaSelfPage = '/ship/cornucopiaSelf';
  // 攻略页
  static String instructionPage = '/instruction';
  // 个人信息页
  static String accountInfoPage = '/account';
  // 对用户进行操作页
  static String userOptionPage = '/userOptions';
  // 用户信息编辑页
  static String userEditPage = '/userEdit';
  // 设置
  static String settingsPage = '/settings';

  static List<GetPage> getPages2() {
    return [];
  }

  static List<GetPage> getPages() {
    return [
      // 首页
      GetPage(
        name: AppRoute.rootPage,
        // page: () => HomePage(),
        page: () => const IndexPage(),
        middlewares: [AuthMiddleware(priority: 0)],
        binding: BindingsBuilder(() {
          Get.lazyPut(() => RegionDetailController());
        }),
        children: [
          GetPage(
            name: AppRoute.homePage,
            page: () => const HomePage(),
          ),
          // 势力详情页
          GetPage(
            name: AppRoute.regionDetailPage,
            page: () => const RegionDetailPage(),
          ),
        ],
      ),
      GetPage(
        name: AppRoute.settingsPage,
        page: () => const SettingsPage(),
      ),
      // 登录页
      GetPage(
        name: AppRoute.loginPage,
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EncrypterController());
        }),
        page: () => const LoginPage(),
      ),
      // 注册页
      GetPage(
        name: AppRoute.registerPage,
        page: () => const RegisterPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EncrypterController());
        }),
      ),
      // 用户管理页
      GetPage(
        name: AppRoute.userPage,
        page: () => UserListPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => UserListController());
        }),
      ),
      // 用户操作页
      GetPage(
        name: AppRoute.userOptionPage,
        page: () => UserOptionPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => UserOptionController());
        }),
      ),
      // 用户信息编辑页-- 编辑自己;
      GetPage(
          name: AppRoute.userEditPage,
          page: () => const UserEditPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => UserEditController());
            Get.lazyPut(() => EncrypterController());
          })),
      // 势力管理页
      GetPage(
        name: AppRoute.regionPage,
        page: () => const RegionPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => RegionListController());
        }),
      ),
      // 新建势力页
      GetPage(
        name: AppRoute.regionNewPage,
        page: () => const RegionNewPage(),
      ),
      // 势力操作页
      GetPage(
        name: AppRoute.regionOptionsPage,
        page: () => RegionOptionsPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => RegionOptionsController());
        }),
      ),
      // 游戏角色管理页
      GetPage(
        name: AppRoute.shipUserPage,
        page: () => const ShipuserListPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ShipuserListController());
        }),
      ),
      // 游戏角色操作页
      GetPage(
        name: AppRoute.shipUserOptionsPage,
        page: () => ShipUserOptionPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ShipUserOptionController());
          Get.lazyPut(() => TimePickerController());
        }),
      ),
      GetPage(
        name: AppRoute.regionJoin,
        page: () => RegoinJoinPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => RegionJoinController());
          Get.lazyPut(() => TimePickerController());
        }),
      ),
      // 聚宝盆管理页
      GetPage(
        name: AppRoute.cornucopiaPage,
        page: () => const CornucopiaListPage(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => CornucopiaListController());
          },
        ),
      ),
      GetPage(
        name: AppRoute.cornucopiaSelfPage,
        page: () => const CornucopiaSelfPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CornucopiaSelfController());
        }),
      ),
      GetPage(
        name: AppRoute.cornucopiaOptionPage,
        page: () => CornucopiaOptionPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CornucopiaOptionController());
        }),
      ),
      GetPage(
        name: AppRoute.cornucopiaNewPage,
        page: () => CreateCornucopiaPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CornCreateController());
          Get.lazyPut(() => TimePickerController());
        }),
      ),
      GetPage(
        name: AppRoute.cornJoinPage,
        page: () => JoinCornPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CornJoinController());
        }),
      ),
      // 赛季操作
      GetPage(
        name: AppRoute.seasonPage,
        page: () => SeasonListPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SeasonListController());
        }),
      ),
      GetPage(
        name: AppRoute.seasonNewPage,
        page: () => SeasonNewPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SeasonNewController());
        }),
      ),
      GetPage(
        name: AppRoute.seasonOptionPage,
        page: () => SeasonOptionPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SeasonOptionController());
        }),
      ),
    ];
  }
}
