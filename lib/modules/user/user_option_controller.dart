import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/apps.dart';
import '../../core/models/options_model.dart';
import '../../core/models/user_model.dart';
import '../../core/server.dart';
import '../../core/urls.dart';
import '../../core/option_conf.dart';

class UserOptionController extends GetxController {
  String? userId;

  UserModel? userData;
  String? userDisplayName;
  bool hasUser = false;
  bool hasOptions = false;
  List<OptionModel> validOptions = [];
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
    String userId = Get.parameters['userId'] ?? "";

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
      "refused_reason": null,
    };
    _defaultPostOption(option?.title ?? "", apiUrl.userDemote, myPayload);
  }

  void onOptionRefuse(OptionModel? option) {
    final Map<String, dynamic> myPayload = {
      "refused": true,
      "refused_reason": null, // TODO: 拒绝原因
    };
    _defaultPostOption(option?.title ?? "", apiUrl.userDemote, myPayload);
  }

  void onOptionDemote(OptionModel? option) {
    _defaultPostOption(option?.title ?? "", apiUrl.userDemote, null);
  }

  void onOptionForbidden(OptionModel? option) {
    _defaultPostOption(option?.title ?? "", apiUrl.userForbidden, null);
  }

// 编辑信息
  void onOptionUpdate(OptionModel? option) {
    Get.toNamed(appRoute.userEditPage, parameters: {"user_id": userId ?? ""});
  }

  // // 退出登录
  // void onOptionLogoff(OptionModel? option) {
  //   final gc = Get.find<GlobalController>;
  //   Get.find<GlobalController>().userId = "";
  //   Get.find<GlobalController>().token = "";
  //   Get.find<GlobalController>().username = "";
  //   Get.find<GlobalController>().userDisplayName = "";
  //   Get.find<GlobalController>().userRole = "";
  //   Get.find<GlobalController>().isLogin = false;

  //   Get.offAllNamed(appRoute.rootPage);
  // }

  // 注销账号
  void onOptionLogout(OptionModel? option) {
    final url = sprintf(apiUrl.userRetriveUpdateDestroyPath, [userId]);
    _defaultDeleteOption(option?.title ?? "", url, null);
  }

  void _defaultPostOption(
      String title, String optionUrl, Map<String, dynamic>? payload) {
    Get.defaultDialog(
      title: title,
      middleText: '确定要执行该操作吗？',
      textConfirm: '确认',
      textCancel: '取消',
      confirmTextColor: Colors.white, // 自定义确认按钮文本颜色
      onCancel: () {
        // Get.back();
      },
      onConfirm: () {
        final apiService = Get.find<ApiService>();
        late Map<String, dynamic> myPayload;
        if (payload != null) {
          myPayload = payload;
        }

        myPayload["user_id"] = userId;
        myPayload["user_updated_time"] = userData?.updatedTime;

        // Map<String, dynamic> =
        // final Map<String, dynamic> payload = {
        //   "user_id": userId,
        //   "user_updated_time": userData?.updatedTime,
        // };
        final response =
            apiService.postRequest(optionUrl, myPayload) as dio.Response;
        final responseData = ResponseData.fromJson(response.data);
        if (responseData.code != 0) {
          Get.defaultDialog(
            title: '操作失败',
            content: Text(responseData.message as String),
            confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('操作失败'),
            ),
          );
        } else {
          Get.defaultDialog(
            title: '操作成功',
            // content: Text(""),
            confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('操作成功'),
            ),
          );
        }
      },
    );
  }

  void _defaultDeleteOption(
      String title, String optionUrl, Map<String, dynamic>? payload) {
    Get.defaultDialog(
      title: title,
      middleText: '确定要执行该操作吗？',
      textConfirm: '确认',
      textCancel: '取消',
      confirmTextColor: Colors.white, // 自定义确认按钮文本颜色
      onCancel: () {
        // Get.back();
      },
      onConfirm: () {
        final apiService = Get.find<ApiService>();
        late Map<String, dynamic> myPayload;
        if (payload != null) {
          myPayload = payload;
        }

        myPayload["user_id"] = userId;
        myPayload["user_updated_time"] = userData?.updatedTime;

        // Map<String, dynamic> =
        // final Map<String, dynamic> payload = {
        //   "user_id": userId,
        //   "user_updated_time": userData?.updatedTime,
        // };
        final response =
            apiService.deleteRequest(optionUrl, myPayload) as dio.Response;
        final responseData = ResponseData.fromJson(response.data);
        if (responseData.code != 0) {
          Get.defaultDialog(
            title: '操作失败',
            content: Text(responseData.message as String),
            confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('操作失败'),
            ),
          );
        } else {
          Get.defaultDialog(
            title: '操作成功',
            // content: Text(""),
            confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('操作成功'),
            ),
          );
        }
      },
    );
  }
}
