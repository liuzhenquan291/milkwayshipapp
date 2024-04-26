// 势力管理页的势力列表 controller
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/auth.dart';
import 'package:milkwayshipapp/core/models/region_model.dart';
import 'package:milkwayshipapp/core/urls.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/server.dart';

class RegionListController extends GetxController {
  final RefreshController refreshController = RefreshController();
  List<RegionModel> regionList = [];
  int page = 1;
  String? isSelf;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    final apiService = ApiService();
    final AuthService authCtl = Get.find<AuthService>();
    String isSelf = Get.parameters['isSelf'] ?? "";
    String userId = isSelf != "" ? authCtl.userId as String : "";

    final response = await apiService.getRequest(
        apiUrl.regionsCreateListPath, {'page': page, 'user_id': userId});
    if (response.statusCode != 200) {
      return;
    }
    final responseData = ResponseData.fromJson(response.data);

    List<RegionModel> newData = RegionModel.fromJsonToList(responseData.data);
    regionList.addAll(newData);
    page++;
    // refreshController.refreshCompleted(); // 结束刷新状态
    update();
  }

  @override
  void onClose() {
    refreshController.dispose();
    // scrollController.dispose();
    super.onClose();
  }
}
