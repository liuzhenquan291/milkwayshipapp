import 'package:get/get.dart';
import 'package:milkwayshipapp/core/auth_controller.dart';
import 'package:milkwayshipapp/core/custom_option_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/models/user_model.dart';
import '../../core/server.dart';
import '../../core/urls.dart';

class UserEditController extends GetxController {
  String? userId;
  // String? isSelf;
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
    final apiService = ApiService();
    // 只有自己才能到这个页面
    // String userId = Get.parameters['userId'] ?? "";
    // String isSelf = Get.parameters['isSelf'] ?? "";

    // if (isSelf == 'true') {
    //   final gc = Get.find<GlobalController>();
    //   userId = gc.userId ?? "";
    // }
    userId = await StorageHelper.get(StorageKeys.userIdKey);

    final url = sprintf(apiUrl.userRetriveUpdateDestroyPath, [userId]);
    final response = await apiService.getRequest(url, null);
    final responseData = ResponseData.fromJson(response.data);
    if (responseData.data != null) {
      userData = UserModel.fromJson(responseData.data);
    }

    update();
  }

  // 修改用户信息
  Future<void> onEditUserInfo(
    String displayName,
    String wxName,
    String wxGname,
  ) async {
    userData?.displayName = displayName;
    userData?.wechatName = wxName;
    userData?.wcqName = wxGname;

    final payload = {
      "id": userData?.id,
      "username": userData?.username,
      "display_name": userData?.displayName,
      "wechat_name": userData?.wechatName,
      "wcq_name": userData?.wcqName,
      "updated_time": userData?.updatedTime,
      "number": userData?.number,
    };

    final url = sprintf(apiUrl.userRetriveUpdateDestroyPath, [userId]);
    final result = await customePutOption("修改信息", url, payload);
    if (result == true) {
      _loadData();
    }
  }

  // 修改用户密码
  void onEditUserPassWd() {}
}
