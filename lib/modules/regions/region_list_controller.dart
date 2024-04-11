// 势力管理页的势力列表 controller
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/server.dart';
import 'package:milkwayshipapp/core/urls.dart';
import 'package:milkwayshipapp/modules/login/global_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RegionListController extends GetxController {
  final RefreshController refreshController = RefreshController();
  List<Map<String, String>> regionList = [];
  int page = 1;
  String? isSelf;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    final gc = Get.find<GlobalController>();
    String isSelf = Get.parameters['isSelf'] ?? "";
    String userId = isSelf != "" ? gc.userId as String : "";
    final apiService = Get.find<ApiService>();
    final response = await apiService.getRequest(
        apiUrl.regionsCreateListPath, {'page': page, 'user_id': userId});
    if (response.statusCode != 200) {
      return;
    }
    final responseData = ResponseData.fromJson(response.data);
    final regionInfos = responseData.data as List<dynamic>;

    List<Map<String, String>> newData =
        List.generate(regionInfos.length, (index) {
      var item = regionInfos[index] as Map<String, dynamic>;
      return {
        'id': item['id'],
        '势力名称': item['name'],
        '成员格式': item['name_fmt'],
        '战区信息': item['zone_info'],
        '势力状态': item['status_name'],
      };
    });
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
