// 聚宝盆管理页的聚宝盆列表 controller
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/auth.dart';
import '../../core/urls.dart';
import '../../core/server.dart';
import '../../core/models/ship_user_model.dart';

class CornucopiaSelfController extends GetxController {
  List<ShipUserModel>? shipUsers;
  bool hasData = false;
  int dataLength = 0;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    final apiService = ApiService();
    String userId = Get.find<AuthService>().userId ?? "";
    final response = await apiService
        .getRequest(apiUrl.shipUserListCreatePath, {'user_id': userId});
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
    shipUsers = ShipUserModel.fromJsonToList(responseData.data);
    dataLength = shipUsers?.length ?? 0;

    // final GlobalController gc = Get.find<GlobalController>();
    // displayName = gc.displayName as String;

    update();
  }

  @override
  void onClose() {
    // scrollController.dispose();
    super.onClose();
  }
}
