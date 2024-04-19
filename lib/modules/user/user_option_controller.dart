import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/auth.dart';
import 'package:milkwayshipapp/core/auth_controller.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/apps.dart';
import '../../core/models/options_model.dart';
import '../../core/models/user_model.dart';
import '../../core/server.dart';
import '../../core/urls.dart';
import '../../core/option_conf.dart';
import '../../core/custom_option_widget.dart';

class UserOptionController extends GetxController {
  String? userId;

  UserModel? userData;
  String? displayName;
  bool hasUser = false;
  bool hasOptions = false;
  List<OptionModel> validOptions = [];
  final RefreshController refreshController = RefreshController();
  final TextEditingController txc = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // 在控制器初始化时，获取页面参数
    // regionId = Get.arguments;

    _loadData();
  }

  @override
  void dispose() {
    txc.dispose();
    super.dispose();
  }

  // dio.Response? response;
  Future<void> _loadData() async {
    final apiService = ApiService();
    userId = Get.parameters['userId'] ?? "";

    final url = sprintf(apiUrl.userRetriveUpdateDestroyPath, [userId]);
    final response = await apiService.getRequest(url, null);

    final responseData = ResponseData.fromJson(response.data);
    if (responseData.data != null) {
      userData = UserModel.fromJson(responseData.data);
      if (userData != null) {
        final users = userData?.shipUsers ?? [];
        if (users.isNotEmpty) {
          hasUser = true;
        }
        final options = userData?.options ?? [];
        if (options.isNotEmpty) {
          for (OptionModel option in options) {
            String code = option.code ?? "";

            if (userOptionConf.optionInOptionPage(code)) {
              validOptions.add(option);
              hasOptions = true;
            }
          }
        }
      }
    }

    update();
  }

  void onOption(OptionModel? option) {
    switch (option?.code) {
      // 通过新用户申请
      case UserOptionConf.APPROVE:
        onOptionApprove(option);
        update();
        break;

      // 拒绝新用户申请
      case UserOptionConf.REFUSE:
        onOptionRefuse(option);
        update();
        break;

      // 置为不活跃用户
      case UserOptionConf.DEMOTE:
        onOptionDemote(option);
        update();
        break;

      // 禁用用户
      case UserOptionConf.FORBIDDEN:
        onOptionForbidden(option);
        update();
        break;

      // 编辑信息
      case UserOptionConf.UPDATE:
        onOptionUpdate(option);
        break;
      // 注销账号
      case UserOptionConf.LOGOUT:
        onOptionLogout(option);
        break;
      // 退出登录
      // case UserOptionConf.LOGOFF:
      //   onOptionLogoff(option);
      //   break;
    }
  }

  void onOptionApprove(OptionModel? option) {
    final Map<String, dynamic> myPayload = {
      "refused": false,
      "refused_reason": "",
      "user_id": userId,
      "updated_time": userData?.updatedTime,
    };
    customePostOption(
      option?.title ?? "",
      apiUrl.userApprove,
      myPayload,
    );
  }

  void onOptionRefuse(OptionModel? option) {
    final Map<String, dynamic> myPayload = {
      "refused": true,
      "user_id": userId,
      "updated_time": userData?.updatedTime,
      // "refused_reason": "拒绝用户申请", 在弹窗中填入
    };
    editablePostOption(
      option?.title ?? "",
      apiUrl.userApprove,
      "拒绝用户申请原因",
      "refused_reason",
      txc,
      myPayload,
    );
  }

  void onOptionDemote(OptionModel? option) {
    final Map<String, dynamic> myPayload = {
      "user_id": userId,
      "updated_time": userData?.updatedTime,
    };
    customePostOption(
      option?.title ?? "",
      apiUrl.userDemote,
      myPayload,
    );
  }

  // TODO: 禁用原因??
  void onOptionForbidden(OptionModel? option) {
    final Map<String, dynamic> myPayload = {
      "user_id": userId,
      "updated_time": userData?.updatedTime,
    };
    customePostOption(
      option?.title ?? "",
      apiUrl.userForbidden,
      myPayload,
    );
  }

// 编辑信息
  void onOptionUpdate(OptionModel? option) {
    Get.toNamed(AppRoute.userEditPage, parameters: {"user_id": userId ?? ""});
  }

  // // 退出登录
  // void onOptionLogoff(OptionModel? option) {
  //   final gc = Get.find<GlobalController>;
  //   Get.find<GlobalController>().userId = "";
  //   Get.find<GlobalController>().token = "";
  //   Get.find<GlobalController>().username = "";
  //   Get.find<GlobalController>().displayName = "";
  //   Get.find<GlobalController>().userRole = "";
  //   Get.find<GlobalController>().isLogin = false;

  //   Get.offAllNamed(AppRoute.rootPage);
  // }

  // 注销账号
  void onOptionLogout(OptionModel? option) async {
    final url = sprintf(apiUrl.userRetriveUpdateDestroyPath, [userId]);
    final Map<String, dynamic> myPayload = {
      "user_id": userId,
      "updated_time": userData?.updatedTime,
    };
    customeDeleteOption(
      option?.title ?? "",
      url,
      myPayload,
    );
    await StorageHelper.removeAll();
    await Get.find<AuthService>().clearToken();
  }
}
