// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/options_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/auth.dart';
import '../../core/server.dart';
import '../../core/urls.dart';
import '../../core/models/ruins_model.dart';

class RuinsListController extends GetxController {
  final RefreshController refreshController = RefreshController();
  List<RuinsModel> ruinsList = [];
  List<OptionModel> options = [];
  bool hasData = false;
  int page = 1;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void reloadData() async {
    ruinsList = [];
    hasData = false;
    options = [];
    page = 1;
    _loadData();
  }

  Future<void> _loadData() async {
    final apiService = ApiService();

    final response = await apiService.getRequest(
      apiUrl.ruinsListCreatePath,
      {'page': page},
    );
    if (response.statusCode != 200) {
      return;
    }
    final responseData = ResponseData.fromJson(response.data);
    ruinsList = RuinsModel.fromJsonToList(responseData.data);
    if (ruinsList.isNotEmpty) {
      hasData = true;
    }

    final gc = Get.find<AuthService>();
    if (gc.isManager()) {
      options = [
        OptionModel(
          code: "new_add",
          name: "新建任务",
          title: "新建废墟任务",
        )
      ];
    }

    page++;
    update();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  Future<void> onOption(OptionModel option) async {}
}
