import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/custom_option_widget.dart';
import 'package:milkwayshipapp/core/models/region_model.dart';
import 'package:milkwayshipapp/core/option_conf.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/models/options_model.dart';
import '../../core/server.dart';
import '../../core/urls.dart';

class RegionOptionsController extends GetxController {
  String? regionId;
  RegionModel? regionData;
  // String? displayName;
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

  Future<void> _loadData() async {
    final apiService = Get.find<ApiService>();
    String? regionId = Get.parameters['regionId'];
    final url = sprintf(apiUrl.regionsRetrieveUpdateDestroyPath, [regionId]);
    final response = await apiService.getRequest(url, null);

    if (response.statusCode != 200) {
      // TODO: 弹窗
    } else {
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data != null) {
        regionData = RegionModel.fromJson(responseData.data);
        if (regionData != null) {
          final users = regionData?.shipUsers ?? [];
          if (users.isNotEmpty) {
            hasUser = true;
          }
          final options = regionData?.options ?? [];
          if (options.isNotEmpty) {
            for (OptionModel option in options) {
              String code = option.code ?? "";

              if (regionsOptionConf.optionInOptionPage(code)) {
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

  void onOption(OptionModel? option) {
    switch (option?.code) {
      // 通过新势力申请
      case RegionsOptionConf.APPROVE:
        onOptionApprove(option);
        update();
        break;

      // 拒绝新势力申请
      case RegionsOptionConf.REFUSE:
        onOptionRefuse(option);
        update();
        break;

      // 设置管理员
      case RegionsOptionConf.SET_MANAGER:
        onOptionSetManager(option);
        update();
        break;

      // 加入势力  移动到创建角色时
      // case RegionsOptionConf.JOIN:
      //   onOptionJoin(option);
      //   update();
      //   break;

      // 编辑信息
      // case RegionsOptionConf.UPDATE:
      //   onOptionUpdate(option);
      //   break;
      // 注销账号
      case RegionsOptionConf.LOGOUT:
        onOptionLogout(option);
        break;
    }
  }

  void onOptionApprove(OptionModel? option) {
    final Map<String, dynamic> myPayload = {
      "refused": false,
      "refused_reason": null,
    };
    _defaultPostOption(
      option?.title ?? "",
      apiUrl.regionsApprovePath,
      myPayload,
    );
  }

  void onOptionRefuse(OptionModel? option) {
    final TextEditingController tc = TextEditingController();
    final Map<String, dynamic> myPayload = {
      "refused": false,
      "refused_reason": null,
      "region_id": regionData?.id,
      "updated_time": regionData?.updatedTime,
    };

    editablePostOption(
      option?.title ?? "",
      apiUrl.regionsApprovePath,
      "请输入拒绝申请原因",
      "refused_reason",
      tc,
      myPayload,
    );
  }

  // TODO: 设置管理员或者移除管理员
  void onOptionSetManager(OptionModel? option) {
    final Map<String, dynamic> myPayload = {
      "refused": true,
      "refused_reason": null, // TODO: 拒绝原因
    };
    _defaultPostOption(
        option?.title ?? "", apiUrl.regionsSetManagerPath, myPayload);
  }

  // void onOptionJoin(OptionModel? option) {
  //   final Map<String, dynamic> myPayload = {
  //     "refused": true,
  //     "refused_reason": null, // TODO: 拒绝原因
  //   };
  //   _defaultPostOption(option?.title ?? "", apiUrl.userDemote, myPayload);
  // }

  // // 编辑信息
  // void onOptionUpdate(OptionModel? option) {
  //   Get.toNamed(AppRoute.userEditPage, parameters: {"user_id": userId ?? ""});
  // }

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

  // 注销势力
  void onOptionLogout(OptionModel? option) {
    final url = sprintf(apiUrl.regionsRetrieveUpdateDestroyPath, [regionId]);
    _defaultDeleteOption(option?.title ?? "", url, null);
  }

  void _defaultPostOption(
    String title,
    String optionUrl,
    Map<String, dynamic>? payload,
  ) {
    late Map<String, dynamic> myPayload;
    if (payload != null) {
      myPayload = payload;
    }

    myPayload["region_id"] = regionData?.id;
    myPayload["updated_time"] = regionData?.updatedTime;
    customePostOption(title, optionUrl, myPayload);
  }

  void _defaultDeleteOption(
    String title,
    String optionUrl,
    Map<String, dynamic>? payload,
  ) {
    late Map<String, dynamic> myPayload;
    if (payload != null) {
      myPayload = payload;
    }

    myPayload["region_id"] = regionData?.id;
    myPayload["updated_time"] = regionData?.updatedTime;
    customeDeleteOption(title, optionUrl, myPayload);
  }
}
