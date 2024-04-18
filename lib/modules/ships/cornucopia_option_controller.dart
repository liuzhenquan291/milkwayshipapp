// 聚宝盆管理页的聚宝盆列表 controller
// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/region_model.dart';
import 'package:milkwayshipapp/core/models/ship_cornucopia_model.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';
import 'package:milkwayshipapp/core/models/user_model.dart';
import 'package:milkwayshipapp/core/urls.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/models/options_model.dart';
import '../../core/option_conf.dart';
import '../../core/server.dart';

class CornucopiaOptionController extends GetxController {
  final RefreshController refreshController = RefreshController();
  final RefreshController refreshController2 = RefreshController();
  String? cornucopiaId;
  ShipCornucopiaModel? cornData;
  bool hasOptions = false; // 是否有可用操作
  List<OptionModel> validOptions = [];
  bool hasJoined = false; // 是否有已参盆角色
  bool hasTojoin = false; // 是否有可参盆角色
  List<ShipUserModel>? joinedShipusers;
  List<ShipUserModel>? toJoinShipusers;
  UserModel? userData;
  RegionModel? regionData;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    String cornucopiaId = Get.parameters['cornucopiaId'] ?? "";
    final apiService = Get.find<ApiService>();
    final url =
        sprintf(apiUrl.cornucopiasRetrieveUpdateDestroyPath, [cornucopiaId]);
    final response = await apiService.getRequest(url, null);
    if (response.statusCode != 200) {
      return;
    }
    final responseData = ResponseData.fromJson(response.data);

    if (responseData.data != null) {
      cornData = ShipCornucopiaModel.fromJson(responseData.data);
      if (cornData != null) {
        final options = cornData?.options ?? [];
        if (options.isNotEmpty) {
          for (OptionModel option in options) {
            String code = option.code ?? "";

            if (cornucopaOptionConf.optionIsValid(code)) {
              validOptions.add(option);
              hasOptions = true;
            }
          }
        }
        final joined = cornData?.joinedShipUsers ?? [];
        if (joined.isNotEmpty) {
          hasJoined = true;
          joinedShipusers = joined;
        }
        final toJoin = cornData?.toJoinShipUsers ?? [];
        if (toJoin.isNotEmpty) {
          hasTojoin = true;
          toJoinShipusers = toJoin;
        }
        userData = cornData?.shipuser?.user;
        regionData = cornData?.regions;
      }
    }

    update();
  }

  @override
  void onClose() {
    // scrollController.dispose();
    refreshController.dispose();
    refreshController2.dispose();
    super.onClose();
  }

  void onOption(OptionModel? option) {
    switch (option?.code) {
      case CornucopaOptionConf.OPEN:
        onOptionOpen(option);
        update();
        break;
      case CornucopaOptionConf.END:
        onOptionEnd(option);
        update();
        break;
      case CornucopaOptionConf.DISUSE:
        onOptionDisuse(option);
        update();
        break;
      case CornucopaOptionConf.JOIN:
        onOptionJoin(option);
        update();
        break;
    }
  }

  // 开盆
  void onOptionOpen(OptionModel? option) {
    _defaultPostOption(option?.title ?? '', '', null);
  }

  // 收盆
  void onOptionEnd(OptionModel? option) {
    _defaultPostOption(option?.title ?? '', '', null);
  }

  // 错过了盆
  void onOptionDisuse(OptionModel? option) {
    _defaultPostOption(option?.title ?? '', '', null);
  }

  // 参盆
  void onOptionJoin(OptionModel? option) {
    _defaultPostOption(option?.title ?? '', '', null);
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
        // final apiService = Get.find<ApiService>();
        // late Map<String, dynamic> myPayload;
        // if (payload != null) {
        //   myPayload = payload;
        // }

        // myPayload["user_id"] = shipUserId;
        // myPayload["updated_time"] = shipUserData?.updatedTime;

        // // Map<String, dynamic> =
        // // final Map<String, dynamic> payload = {
        // //   "user_id": userId,
        // //   "updated_time": userData?.updatedTime,
        // // };
        // final response =
        //     apiService.postRequest(optionUrl, myPayload) as dio.Response;
        // final responseData = ResponseData.fromJson(response.data);
        // if (responseData.code != 0) {
        //   Get.defaultDialog(
        //     title: '操作失败',
        //     content: Text(responseData.message as String),
        //     confirm: TextButton(
        //       onPressed: () {
        //         Get.back();
        //       },
        //       child: const Text('操作失败'),
        //     ),
        //   );
        // } else {
        //   Get.defaultDialog(
        //     title: '操作成功',
        //     // content: Text(""),
        //     confirm: TextButton(
        //       onPressed: () {
        //         Get.back();
        //       },
        //       child: const Text('操作成功'),
        //     ),
        //   );
        // }
      },
    );
  }
}
