import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/apps.dart';
import '../../core/auth.dart';
import '../../core/urls.dart';
import '../../core/utils.dart';
import '../../core/server.dart';
import '../../core/option_conf.dart';
import '../../core/custom_option_widget.dart';
import '../../core/models/options_model.dart';
import '../../core/models/ship_user_model.dart';

class ShipUserOptionController extends GetxController {
  final TextEditingController mskNameCtl = TextEditingController();
  final TextEditingController shipUserTypeCtl = TextEditingController();
  final TextEditingController swordCtl = TextEditingController();

  String? shipUserId;
  ShipUserModel? shipUserData;
  bool hasOptions = false;
  List<OptionModel> validOptions = [];
  final RefreshController refreshController = RefreshController();
  final auu = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    // 在控制器初始化时，获取页面参数
    // regionId = Get.arguments;

    _loadData();
  }

  void _reloadData() async {
    hasOptions = false;
    validOptions = [];
    _loadData();
  }

  Future<void> reloadData() async {
    hasOptions = false;
    validOptions = [];
    _loadData();
    update();
  }

  // dio.Response? response;
  Future<void> _loadData() async {
    final apiService = ApiService();
    shipUserId = Get.parameters['shipuser_id'];
    final url = sprintf(apiUrl.shipUserRetriveUpdateDestroyPath, [shipUserId]);
    final response = await apiService.getRequest(url, null);

    if (response.statusCode != 200) {
      // TODO: 弹窗
    } else {
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data != null) {
        shipUserData = ShipUserModel.fromJson(responseData.data);
        mskNameCtl.text = shipUserData?.mksName ?? "";
        shipUserTypeCtl.text = shipUserData?.typeName ?? "";
        swordCtl.text = "${shipUserData?.sword ?? 0}";
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

  Future<bool> onOption(OptionModel? option) async {
    bool result = false;
    switch (option?.code) {
      // 通过新用户申请
      case ShipuserOptionConf.APPROVE:
        result = await onOptionApprove(option);
        break;

      // // 设为不活跃角色
      // case ShipuserOptionConf.DEMOTE:
      //   result = await onOptionDemote(option);
      //   break;

      // // 禁用角色
      // case ShipuserOptionConf.FORBIDDEN:
      //   result = await onOptionForbidden(option);
      //   break;

      // 注销角色
      case ShipuserOptionConf.LOGOUT:
        result = await onOptionLogout(option);
        break;

      // 设置角色职位
      case ShipuserOptionConf.DESIGNATE:
        result = await onOptionDesignate(option);
        break;

      // 编辑角色信息
      case ShipuserOptionConf.UPDATE:
        result = await onOptionUpdate(option);
        break;

      // 给角色打标签
      case ShipuserOptionConf.REMARK:
        result = await onOptionRemark(option);
        break;
    }
    return result;
  }

  Future<bool> onOptionApprove(OptionModel? option) async {
    final result = await _defaultPostOption(
      option?.title ?? "",
      apiUrl.shipUserApprovePath,
      null,
    );
    return result;
  }

  // Future<bool> onOptionDemote(OptionModel? option) async {
  //   final result = await _defaultPostOption(
  //     option?.title ?? "",
  //     apiUrl.shipUserDemotePath,
  //     null,
  //   );
  //   return result;
  // }

  // Future<bool> onOptionForbidden(OptionModel? option) async {
  //   final result = await _defaultPostOption(
  //     option?.title ?? "",
  //     apiUrl.shipUserForbiddenPath,
  //     null,
  //   );
  //   return result;
  // }

  // 注销角色
  Future<bool> onOptionLogout(OptionModel? option) async {
    final url = sprintf(apiUrl.shipUserRetriveUpdateDestroyPath, [shipUserId]);
    final result = await _defaultDeleteOption(
      option?.title ?? "",
      url,
      null,
    );
    return result;
  }

  Future<bool> onOptionDesignate(OptionModel? option) async {
    late Map<String, dynamic> myPayload = {};
    final TextEditingController tc = TextEditingController();

    myPayload["ship_user_id"] = shipUserId;
    myPayload["updated_time"] = shipUserData?.updatedTime;

    final result = await editablePostOption(
      option?.title ?? "",
      apiUrl.shipUserDesignatePath,
      "请设置职位: 司令/副司令/军神/军长/成员",
      "ship_user_role",
      tc,
      myPayload,
      null,
    );
    return result;
  }

  // 编辑信息
  Future<bool> onOptionUpdate(OptionModel? option) async {
    final result = await Get.toNamed(
      AppRoute.shipUserEditPage,
      parameters: {"shipUserId": shipUserId ?? ""},
    );
    return result;
  }

  Future<bool> onOptionRemark(OptionModel? option) async {
    late Map<String, dynamic> myPayload = {};
    final TextEditingController tc = TextEditingController();

    myPayload["ship_user_id"] = shipUserId;
    myPayload["updated_time"] = shipUserData?.updatedTime;

    final result = await editablePostOption(
      option?.title ?? "",
      apiUrl.shipUserRemarkPath,
      "请为角色打标签: 10字以内",
      "label",
      tc,
      myPayload,
      null,
    );
    return result;
  }

  Future<bool> _defaultPostOption(
      String title, String optionUrl, Map<String, dynamic>? payload) async {
    Map<String, dynamic> myPayload = {};
    if (payload != null) {
      myPayload = payload;
    }

    myPayload["ship_user_id"] = shipUserId;
    myPayload["updated_time"] = shipUserData?.updatedTime;
    bool result = await customePostOption(title, optionUrl, myPayload);
    if (result == true) {
      _reloadData();
    }
    return result;
  }

  Future<bool> _defaultDeleteOption(
      String title, String optionUrl, Map<String, dynamic>? payload) async {
    Map<String, dynamic> myPayload = {};
    if (payload != null) {
      myPayload = payload;
    }

    myPayload["ship_user_id"] = shipUserId;
    myPayload["updated_time"] = shipUserData?.updatedTime;
    bool result = await customeDeleteOption(title, optionUrl, myPayload);
    if (result == true) {
      _reloadData();
    }
    return result;
  }

  Future<bool> onUpdateBasic(
      // String mskName,
      // String shipUserTypeName,
      // String swordString,
      ) async {
    Map<String, dynamic> myPayload = {};
    myPayload["ship_user_id"] = shipUserId;
    myPayload["updated_time"] = shipUserData?.updatedTime;
    myPayload['mks_name'] = mskNameCtl.text;
    myPayload['type_name'] = shipUserTypeCtl.text;
    myPayload['sword'] = swordCtl.text;
    final res = await customePostOption(
      "更新角色基本信息",
      apiUrl.setShipUserBasic,
      myPayload,
    );
    return res;
  }
}
