import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/custom_option_widget.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/apps.dart';
import '../../core/models/options_model.dart';
import '../../core/models/ship_user_model.dart';
import '../../core/option_conf.dart';
import '../../core/server.dart';
import '../../core/urls.dart';

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
    shipUserId = Get.parameters['shipuser_id'];
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
      // 创建开盆计划
      case ShipuserOptionConf.OPEN_CORNUCOPIA:
        onOptionOpenCornucopia(option);
        break;
      // 加入开盆计划
      case ShipuserOptionConf.JOIN_CORNUCOPIA:
        onOptionJoinCornucopia(option);
        break;
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

  void onOptionDesignate(OptionModel? option) {
    late Map<String, dynamic> myPayload = {};
    final TextEditingController tc = TextEditingController();

    myPayload["ship_user_id"] = shipUserId;
    myPayload["updated_time"] = shipUserData?.updatedTime;

    editablePostOption(
      option?.title ?? "",
      apiUrl.shipUserDesignatePath,
      "请设置职位: 司令/副司令/军神/军长/成员",
      "ship_user_role",
      tc,
      myPayload,
    );
  }

  // 编辑信息
  void onOptionUpdate(OptionModel? option) {
    Get.toNamed(AppRoute.userEditPage,
        parameters: {"shipuser_id": shipUserId ?? ""});
  }

  void onOptionRemark(OptionModel? option) {
    late Map<String, dynamic> myPayload = {};
    final TextEditingController tc = TextEditingController();

    myPayload["ship_user_id"] = shipUserId;
    myPayload["updated_time"] = shipUserData?.updatedTime;

    editablePostOption(
      option?.title ?? "",
      apiUrl.shipUserRemarkPath,
      "请为角色打标签: 10字以内",
      "label",
      tc,
      myPayload,
    );
    // tc.dispose();
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

  void onOptionOpenCornucopia(OptionModel? option) {
    Get.toNamed(AppRoute.cornucopiaNewPage,
        parameters: {"shipuser_id": shipUserId ?? ""});
  }

  void onOptionJoinCornucopia(OptionModel? option) {
    Get.toNamed(AppRoute.cornJoinPage,
        parameters: {"shipuser_id": shipUserId ?? ""});
  }

  void _defaultPostOption(
      String title, String optionUrl, Map<String, dynamic>? payload) {
    late Map<String, dynamic> myPayload;
    if (payload != null) {
      myPayload = payload;
    }

    myPayload["ship_user_id"] = shipUserId;
    myPayload["updated_time"] = shipUserData?.updatedTime;
    customePostOption(title, optionUrl, myPayload);
  }

  void _defaultDeleteOption(
      String title, String optionUrl, Map<String, dynamic>? payload) {
    late Map<String, dynamic> myPayload;
    if (payload != null) {
      myPayload = payload;
    }

    myPayload["ship_user_id"] = shipUserId;
    myPayload["updated_time"] = shipUserData?.updatedTime;
    customeDeleteOption(title, optionUrl, myPayload);
  }
}
