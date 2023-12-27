// 聚宝盆管理页的聚宝盆列表 controller
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/ship_cornucopia_model.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';
import 'package:milkwayshipapp/core/server.dart';
import 'package:milkwayshipapp/core/urls.dart';

import '../../core/models/region_model.dart';
import '../login/global_controller.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

class CornucopiaListController extends GetxController {
  // final RefreshController refreshController = RefreshController();
  CornucopiaInfosModel? cornucopiaInfos;
  String? userDisplayName;
  bool hasData = false;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    final apiService = Get.find<ApiService>();
    final response =
        await apiService.getRequest(apiUrl.cornucopiaInfosPath, null);
    if (response.statusCode != 200) {
      return;
    }
    final responseData = ResponseData.fromJson(response.data);

    if (responseData.code != 0) {
      // TOOD: 弹窗
    } else if (response.data == null) {
      return;
    }

    hasData = true;
    cornucopiaInfos = CornucopiaInfosModel.fromJson(responseData.data);

    final GlobalController gc = Get.find<GlobalController>();
    userDisplayName = gc.userDisplayName as String;

    update();
  }

  @override
  void onClose() {
    // scrollController.dispose();
    super.onClose();
  }
}

class CornucopiaInfosModel {
  RegionModel? regionData;
  List<ShipUserModel>? shipUserData;
  List<ShipCornucopiaModel>? toOpenCorcuDataList;
  List<ShipCornucopiaModel>? processingCorcuDataList;
  List<ShipUserModel>? needCorcuShipUserList;
  List<ShipUserModel>? canOpenCorcuShipUserList;

  CornucopiaInfosModel.fromJson(Map<String, dynamic> json) {
    json['region_data'] != null
        ? RegionModel.fromJson(json['region_data'] ?? {})
        : null;
    ShipUserModel.fromJsonToList(json['shipuser_data']);
    RegionModel.fromJsonToList(json['to_open_corcu_data_list']);
    RegionModel.fromJsonToList(json['processing_corcu_data_list']);
    RegionModel.fromJsonToList(json['need_corcu_shipuser_data_list']);
    RegionModel.fromJsonToList(json['can_open_corcu_shipuser_data_list']);
  }
}
