// 游戏角色管理的游戏角色列表 controller
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';
import 'package:milkwayshipapp/core/server.dart';
import 'package:milkwayshipapp/core/urls.dart';
import 'package:milkwayshipapp/modules/login/global_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShipuserListController extends GetxController {
  final RefreshController refreshController = RefreshController();
  List<ShipUserModel>? shipUsers;
  bool hasUsers = false;
  int page = 1;
  String? isSelf; // 从个人中心-角色信息 跳转时, 会带这个参数

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    final gc = Get.find<GlobalController>();
    isSelf = Get.parameters['isSelf'] ?? "";
    String userId = isSelf == "" ? "" : gc.userId as String;
    final apiService = Get.find<ApiService>();
    final response = await apiService.getRequest(
        apiUrl.shipUserListCreatePath, {'page': page, 'user_id': userId});

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
    update();
  }

  @override
  void onClose() {
    refreshController.dispose();
    // scrollController.dispose();
    super.onClose();
  }
}
