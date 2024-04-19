// 聚宝盆管理页的聚宝盆列表 controller
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/auth.dart';
import 'package:milkwayshipapp/core/models/ship_cornucopia_model.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';
import 'package:milkwayshipapp/core/urls.dart';

import '../../core/models/region_model.dart';
import '../../core/server.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

class CornucopiaListController extends GetxController {
  // final RefreshController refreshController = RefreshController();
  CornucopiaInfosModel? cornucopiaInfos;
  String? displayName;
  bool hasData = false;
  double userDataLength = 0.0;
  int needCorcuCnt = 0; // 需开盆角色数量
  int canCorcuCnt = 0; // 可开盆角色数量
  int toCorcuCnt = 0; // 开盆计划
  int processingCorcuCnt = 0; // 进行中的盆

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    final apiService = ApiService();
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
    userDataLength = cornucopiaInfos?.shipUserData?.length.toDouble() as double;
    needCorcuCnt = cornucopiaInfos?.needCorcuShipUserList?.length as int;
    canCorcuCnt = cornucopiaInfos?.canOpenCorcuShipUserList?.length as int;
    toCorcuCnt = cornucopiaInfos?.toOpenCorcuDataList?.length as int;
    processingCorcuCnt =
        cornucopiaInfos?.processingCorcuDataList?.length as int;

    displayName = Get.find<AuthService>().displayName as String;

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
    regionData = json['region_data'] != null
        ? RegionModel.fromJson(json['region_data'] ?? {})
        : null;
    shipUserData = ShipUserModel.fromJsonToList(json['shipuser_data']);
    toOpenCorcuDataList =
        ShipCornucopiaModel.fromJsonToList(json['to_open_corcu_data_list']);
    processingCorcuDataList =
        ShipCornucopiaModel.fromJsonToList(json['processing_corcu_data_list']);
    needCorcuShipUserList =
        ShipUserModel.fromJsonToList(json['need_corcu_shipuser_data_list']);
    canOpenCorcuShipUserList =
        ShipUserModel.fromJsonToList(json['can_open_corcu_shipuser_data_list']);
  }
}
