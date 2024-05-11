// import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/ruins_group.dart';
import 'package:milkwayshipapp/core/models/ruins_model.dart';
import 'package:milkwayshipapp/core/urls.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/models/options_model.dart';
import '../../core/server.dart';

class RuinOptionController extends GetxController {
  final RefreshController refreshController = RefreshController();

  String ruinId = '-1';
  RuinsModel? ruinData;
  List<RuinGroupModel> groups = [];
  bool hasData = false;
  bool ruinOwner = false;
  List<OptionModel> options = [];

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  void reloadData() async {
    hasData = false;
    // hasShipUserData = false;
    options = [];
    groups = [];
    _loadData();
  }

  Future<void> _loadData() async {
    ruinId = Get.parameters['ruinId'] ?? "-1";

    final as = ApiService();
    final url = sprintf(apiUrl.ruinsRetrUpdDestPath, [ruinId]);
    final response = await as.getRequest(url, null);
    if (response.statusCode != 200) {
      return;
    }
    final responseData = ResponseData.fromJson(response.data);
    if (responseData.data != null) {
      ruinData = RuinsModel.fromJson(responseData.data);
      hasData = true;
      if (ruinData?.groups != null) {
        groups = ruinData?.groups ?? [];
      }
      options = ruinData?.options ?? [];
    }

    update();
  }

  @override
  void onClose() {
    refreshController.dispose();
    // scrollController.dispose();
    super.onClose();
  }

  Future<bool> onOption(OptionModel option) async {
    return false;
  }
}
