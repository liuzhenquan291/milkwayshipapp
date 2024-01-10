// 游戏角色管理的游戏角色列表 controller
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';
import 'package:milkwayshipapp/core/server.dart';
import 'package:milkwayshipapp/core/urls.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShipuserListController extends GetxController {
  final RefreshController refreshController = RefreshController();
  // final ScrollController scrollController = ScrollController();
  List<ShipUserModel>? shipUsers;
  bool hasUsers = false;
  int page = 1;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    final apiService = Get.find<ApiService>();
    final response = await apiService
        .getRequest(apiUrl.shipUserListCreatePath, {'page': page});

    if (response.statusCode != 200) {
      // TODO: 弹窗
    } else {
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data != null) {
        shipUsers = ShipUserModel.fromJsonToList(responseData.data);
        final length = shipUsers?.length ?? 0;
        if (length > 0) {
          hasUsers = true;
        }
      }
    }
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
