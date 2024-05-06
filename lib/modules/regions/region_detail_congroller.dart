import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/options_model.dart';
import 'package:milkwayshipapp/core/models/region_model.dart';
import 'package:milkwayshipapp/core/option_conf.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:dio/dio.dart' as dio;

import '../../core/apps.dart';
import '../../core/server.dart';
import '../../core/urls.dart';

class RegionDetailController extends GetxController {
  List<Widget> listOptions = [];
  RegionModel? regionData;
  TotalOptionModel? totalOptionData;
  bool hasRegion = false;
  bool hasUser = false;
  int shipUserCnt = 0;
  bool hasTotalOption = false;
  bool hasAddRegionOption = false;
  bool hasJoinRegionOption = false;
  // final RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void _reloadData() async {
    listOptions = [];
    hasRegion = false;
    hasUser = false;
    hasTotalOption = false;
    hasAddRegionOption = false;
    hasJoinRegionOption = false;
    _loadData();
  }

  // dio.Response? response;
  Future<void> _loadData() async {
    final apiService = ApiService();
    final response = await apiService.getRequest(apiUrl.regionByUser, null);
    if (response.statusCode != 200) {
      // TODO: 弹窗
    } else {
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data != null) {
        hasRegion = true;
        regionData = RegionModel.fromJson(responseData.data);
        final userCnt = regionData?.shipUsers?.length ?? 0;
        if (userCnt > 0) {
          shipUserCnt = userCnt;
          hasUser = true;
        }
      }
    }
    final res2 = await apiService.getRequest(apiUrl.regionTotalOptions, null);
    final res2Data = ResponseData.fromJson(res2.data);
    if (res2Data.data != null) {
      hasTotalOption = true;
      totalOptionData = TotalOptionModel.fromJson(res2Data.data);

      totalOptionData?.options?.forEach((element) => {
            if (element.code == RegionsOptionConf.JOIN)
              {hasJoinRegionOption = true}
            else if (element.code == RegionsOptionConf.Add)
              {hasAddRegionOption = true}
          });
      addOption();
    }

    update();
  }

  void addOption() {
    if (hasAddRegionOption) {
      listOptions.add(
        ElevatedButton(
          onPressed: () async {
            bool result = await Get.toNamed(AppRoute.regionNewPage);
            if (result == true) {
              _reloadData();
            }
          },
          child: const Text('创建势力'),
        ),
      );
    }
    if (hasJoinRegionOption) {
      if (listOptions.isNotEmpty) {
        listOptions.add(const SizedBox(width: 32));
      }
      listOptions.add(
        ElevatedButton(
          onPressed: () async {
            bool result = await Get.toNamed(AppRoute.regionJoin);
            if (result == true) {
              _reloadData();
            }
          },
          child: const Text('加入势力'),
        ),
      );
    }
  }
}
