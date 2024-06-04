import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:milkwayshipapp/core/auth.dart';
import 'package:sprintf/sprintf.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/apps.dart';
import '../../core/auth.dart';
import '../../core/urls.dart';
import '../../core/server.dart';
import '../../core/auth_controller.dart';
import '../../core/models/user_model.dart';
import '../../core/custom_option_widget.dart';

class UserEditController extends GetxController {
  String? userId;
  String? isSelf;
  bool isSelfBool = false;
  UserModel? userData;

  final RefreshController refreshController = RefreshController();
  final TextEditingController displayNameCtl = TextEditingController();
  final TextEditingController wxNameCtl = TextEditingController();
  final TextEditingController wxGnameCtl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // 在控制器初始化时，获取页面参数
    // regionId = Get.arguments;

    _loadData();
  }

  @override
  void onClose() {
    super.onClose();

    displayNameCtl.dispose();
    wxGnameCtl.dispose();
    wxNameCtl.dispose();
  }

  Future<void> _loadData() async {
    final apiService = ApiService();
    isSelf = Get.parameters['isSelf'] ?? "";
    final userIdInStore = await StorageHelper.get(StorageKeys.userIdKey);
    if (isSelf == 'true') {
      isSelfBool = true;
      userId = userIdInStore;
    } else {
      userId = Get.parameters['userId'] ?? "";
      if (userId == userIdInStore) {
        isSelf = 'true';
        isSelfBool = true;
      }
    }

    final url = sprintf(apiUrl.userRetriveUpdateDestroyPath, [userId]);
    final response = await apiService.getRequest(url, null);
    final responseData = ResponseData.fromJson(response.data);
    if (responseData.data != null) {
      userData = UserModel.fromJson(responseData.data);
      displayNameCtl.text = userData?.displayName ?? '';
      wxNameCtl.text = userData?.wechatName ?? '';
      wxGnameCtl.text = userData?.wcqName ?? '';
    }

    update();
  }

  // 修改用户信息
  Future<bool> onEditUserInfo() async {
    userData?.displayName = displayNameCtl.text;
    userData?.wechatName = wxNameCtl.text;
    userData?.wcqName = wxGnameCtl.text;

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
      await _loadData();
    }
    return result;
  }

  // 修改用户信息
  Future<bool> onLogoff() async {
    await StorageHelper.removeAll();
    await Get.find<AuthService>().clearToken();
    Get.offAllNamed(AppRoute.loginPage);
    return true;
  }

  // 修改用户密码
  Future<bool> onEditUserPassWd() async {
    final result = await Get.toNamed(AppRoute.userModyPassPage, parameters: {
      'userId': userData?.id ?? '',
      'updatedTime': userData?.updatedTime ?? '',
    });
    return result;
  }
}
