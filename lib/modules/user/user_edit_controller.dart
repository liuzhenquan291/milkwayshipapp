import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/models/user_model.dart';
import '../../core/server.dart';
import '../../core/urls.dart';
import '../login/global_controller.dart';

class UserEditController extends GetxController {
  String? userId;
  String? isSelf;
  UserModel? userData;
  final RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    super.onInit();
    // 在控制器初始化时，获取页面参数
    // regionId = Get.arguments;

    _loadData();
  }

  Future<void> _loadData() async {
    final apiService = Get.find<ApiService>();
    String userId = Get.parameters['userId'] ?? "";
    String isSelf = Get.parameters['isSelf'] ?? "";

    if (isSelf == 'true') {
      final gc = Get.find<GlobalController>();
      userId = gc.userId ?? "";
    }
    final url = sprintf(apiUrl.userRetriveUpdateDestroyPath, [userId]);
    final response = await apiService.getRequest(url, null);
    final responseData = ResponseData.fromJson(response.data);
    if (responseData.data != null) {
      userData = UserModel.fromJson(responseData.data);
    }

    update();
  }

  // 修改用户信息
  void onEditUserInfo(UserModel? userData) {}

  // 修改用户密码
  void onEditUserPassWd() {}
}
