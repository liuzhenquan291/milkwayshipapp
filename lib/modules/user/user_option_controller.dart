import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/auth.dart';
import '../../core/apps.dart';
import '../../core/urls.dart';
import '../../core/server.dart';
import '../../core/option_conf.dart';
import '../../core/models/user_model.dart';
import '../../core/custom_option_widget.dart';
import '../../core/models/options_model.dart';

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

  void reloadData() async {
    hasUser = false;
    hasOptions = false;
    validOptions = [];
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
            } else if (UserOptionConf.LOGOUT == option.code) {
              final as = Get.find<AuthService>();
              if (as.userRole == 'manager' || as.userRole == 'root') {
                validOptions.add(option);
                hasOptions = true;
              }
            }
          }
        }
      }
    }

    update();
  }

  void onOption(OptionModel? option) async {
    bool result = false;
    switch (option?.code) {
      // 通过新用户申请
      case UserOptionConf.APPROVE:
        result = await onOptionApprove(option);
        break;

      // 拒绝新用户申请
      case UserOptionConf.REFUSE:
        result = await onOptionRefuse(option);
        break;

      // 置为不活跃用户
      case UserOptionConf.DEMOTE:
        result = await onOptionDemote(option);
        break;

      // 禁用用户
      case UserOptionConf.FORBIDDEN:
        result = await onOptionForbidden(option);
        break;

      // 编辑信息
      case UserOptionConf.UPDATE:
        result = await onOptionUpdate(option);
        break;
      // 注销账号
      case UserOptionConf.LOGOUT:
        result = await onOptionLogout(option);
        break;
      // 退出登录
      // case UserOptionConf.LOGOFF:
      //   onOptionLogoff(option);
      //   break;
      case UserOptionConf.SET_ROLES:
        result = await onOptionSetRoles(option);
        break;
    }
    if (result == true) {
      reloadData();
    }
  }

  Future<bool> onOptionApprove(OptionModel? option) async {
    final Map<String, dynamic> myPayload = {
      "refused": false,
      "refused_reason": "",
      "user_id": userId,
      "updated_time": userData?.updatedTime,
    };
    bool result = await customePostOption(
      option?.title ?? "",
      apiUrl.userApprove,
      myPayload,
    );
    return result;
  }

  Future<bool> onOptionRefuse(OptionModel? option) async {
    final Map<String, dynamic> myPayload = {
      "refused": true,
      "user_id": userId,
      "updated_time": userData?.updatedTime,
      // "refused_reason": "拒绝用户申请", 在弹窗中填入
    };
    bool result = await editablePostOption(
      option?.title ?? "",
      apiUrl.userApprove,
      "拒绝用户申请原因",
      "refused_reason",
      txc,
      myPayload,
    );
    return result;
  }

  Future<bool> onOptionDemote(OptionModel? option) async {
    final Map<String, dynamic> myPayload = {
      "user_id": userId,
      "updated_time": userData?.updatedTime,
    };
    bool result = await customePostOption(
      option?.title ?? "",
      apiUrl.userDemote,
      myPayload,
    );
    return result;
  }

  // TODO: 禁用原因??
  Future<bool> onOptionForbidden(OptionModel? option) async {
    final Map<String, dynamic> myPayload = {
      "user_id": userId,
      "updated_time": userData?.updatedTime,
    };
    bool result = await customePostOption(
      option?.title ?? "",
      apiUrl.userForbidden,
      myPayload,
    );
    return result;
  }

// 编辑信息
  Future<bool> onOptionUpdate(OptionModel? option) async {
    bool result = await Get.toNamed(
      AppRoute.userEditPage,
      parameters: {"user_id": userId ?? ""},
    );
    return result;
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
  Future<bool> onOptionLogout(OptionModel? option) async {
    final url = sprintf(apiUrl.userRetriveUpdateDestroyPath, [userId]);
    final Map<String, dynamic> myPayload = {
      "user_id": userId,
      "updated_time": userData?.updatedTime,
    };
    bool result = await customeDeleteOption(
      option?.title ?? "",
      url,
      myPayload,
    );
    return result;
  }

  // 设置用户角色
  Future<bool> onOptionSetRoles(OptionModel? option) async {
    final Map<String, dynamic> myPayload = {
      "user_id": userId,
      "updated_time": userData?.updatedTime,
    };
    bool result = await editablePostOption(
      option?.title ?? "",
      apiUrl.userSetRole,
      "请输入身份：管理员/普通用户",
      "role_name",
      txc,
      myPayload,
    );
    return result;
  }
}
