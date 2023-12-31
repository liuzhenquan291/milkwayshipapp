import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/user/user_models.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';
// import 'package:dio/dio.dart' as dio;

import '../../core/server.dart';
import '../../core/urls.dart';
import '../login/global_controller.dart';

class UserOptionController extends GetxController {
  String? userId;
  UserListUserModel? userData;
  String? userDisplayName;
  bool hasUser = false;
  bool hasOptions = false;
  final RefreshController refreshController = RefreshController();
  // bool hasRegion = false;
  // bool ifSelfRegion = false; // 通过 token 查询 势力

  @override
  void onInit() {
    super.onInit();
    // 在控制器初始化时，获取页面参数
    // regionId = Get.arguments;

    _loadData();
  }

  // dio.Response? response;
  Future<void> _loadData() async {
    final apiService = Get.find<ApiService>();
    String? userId = Get.parameters['userId'];
    final url = sprintf(apiUrl.userRetriveUpdateDestroyPath, [userId]);
    final response = await apiService.getRequest(url, null);

    if (response.statusCode != 200) {
      // TODO: 弹窗
    } else {
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data != null) {
        userData = UserListUserModel.fromJson(responseData.data);
        if (userData != null) {
          final users = userData?.shipUsers ?? [];
          if (users.isNotEmpty) {
            hasUser = true;
          }
          final options = userData?.options ?? [];
          if (options.isNotEmpty) {
            hasOptions = true;
          }
        }
      }
    }
    final GlobalController gc = Get.find<GlobalController>();
    userDisplayName = gc.userDisplayName as String;
    update();
  }
}
