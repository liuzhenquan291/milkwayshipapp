import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/apps.dart';
import '../../core/models/options_model.dart';
import '../../core/models/ship_user_model.dart';
import '../../core/option_conf.dart';
import '../../core/server.dart';
import '../../core/urls.dart';
// import '../login/global_controller.dart';

class ShipUserOptionController extends GetxController {
  String? shipUserId;
  ShipUserModel? shipUserData;
  bool hasOptions = false;
  List<OptionModel> validOptions = [];
  final RefreshController refreshController = RefreshController();

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
    String? shipUserId = Get.parameters['userId'];
    final url = sprintf(apiUrl.shipUserRetriveUpdateDestroyPath, [shipUserId]);
    final response = await apiService.getRequest(url, null);

    if (response.statusCode != 200) {
      // TODO: 弹窗
    } else {
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data != null) {
        shipUserData = ShipUserModel.fromJson(responseData.data);
      }
      final options = shipUserData?.options ?? [];
      if (options.isNotEmpty) {
        for (OptionModel option in options) {
          String code = option.code ?? "";

          if (shipuserOptionConf.optionInOptionPage(code)) {
            validOptions.add(option);
            hasOptions = true;
          }
        }
      }
    }
    update();
  }

  void onOption(OptionModel? option) {
    switch (option?.code) {
      // 通过新用户申请
      case ShipuserOptionConf.APPROVE:
        onOptionApprove(option);
        update();
        break;

      // 设为不活跃角色
      case ShipuserOptionConf.DEMOTE:
        onOptionDemote(option);
        update();
        break;

      // 禁用角色
      case ShipuserOptionConf.FORBIDDEN:
        onOptionForbidden(option);
        update();
        break;

      // 注销角色
      case ShipuserOptionConf.LOGOUT:
        onOptionLogout(option);
        break;

      // 设置角色职位
      case ShipuserOptionConf.DESIGNATE:
        onOptionDesignate(option);
        update();
        break;

      // 编辑角色信息
      case ShipuserOptionConf.UPDATE:
        onOptionUpdate(option);
        break;

      // 给角色打标签
      case ShipuserOptionConf.REMARK:
        onOptionRemark(option);
        break;
      // 退出登录
      // case UserOptionConf.LOGOFF:
      //   onOptionLogoff(option);
      //   break;
    }
  }

  void onOptionApprove(OptionModel? option) {
    _defaultPostOption(option?.title ?? "", apiUrl.shipUserApprovePath, null);
  }

  void onOptionDemote(OptionModel? option) {
    _defaultPostOption(option?.title ?? "", apiUrl.shipUserDemotePath, null);
  }

  void onOptionForbidden(OptionModel? option) {
    _defaultPostOption(option?.title ?? "", apiUrl.shipUserForbiddenPath, null);
  }

  // 注销账号
  void onOptionLogout(OptionModel? option) {
    final url = sprintf(apiUrl.shipUserRetriveUpdateDestroyPath, [shipUserId]);
    _defaultDeleteOption(option?.title ?? "", url, null);
  }

  // TODO: 职位
  void onOptionDesignate(OptionModel? option) {
    _defaultPostOption(option?.title ?? "", apiUrl.shipUserDesignatePath, null);
  }

  // 编辑信息
  void onOptionUpdate(OptionModel? option) {
    Get.toNamed(appRoute.userEditPage,
        parameters: {"user_id": shipUserId ?? ""});
  }

  // TODO: 标签
  void onOptionRemark(OptionModel? option) {
    _defaultPostOption(option?.title ?? "", apiUrl.shipUserRemarkPath, null);
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

        myPayload["user_id"] = shipUserId;
        myPayload["user_updated_time"] = shipUserData?.updatedTime;

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

        myPayload["user_id"] = shipUserId;
        myPayload["user_updated_time"] = shipUserData?.updatedTime;

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
