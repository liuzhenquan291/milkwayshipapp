// 势力管理页的势力列表 controller
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/auth.dart';
import '../../core/urls.dart';
import '../../core/server.dart';
import '../../core/models/region_model.dart';

class RegionListController extends GetxController {
  final RefreshController refreshController = RefreshController();
  List<RegionModel> regionList = [];
  int page = 1;
  String? isSelf;
  bool canCreate = false;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void onLoadMore() async {
    page += 1;
    _loadData();
    refreshController.loadComplete();
  }

  void reloadData() async {
    regionList = [];
    page = 1;
    canCreate = false;
    _loadData();
  }

  Future<void> _loadData() async {
    final apiService = ApiService();
    final AuthService authCtl = Get.find<AuthService>();
    String isSelf = Get.parameters['isSelf'] ?? "";
    String userId = isSelf != "" ? authCtl.userId as String : "";
    canCreate = authCtl.isSuper();

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
