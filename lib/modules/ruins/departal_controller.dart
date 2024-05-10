// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/agenda_models.dart';
import 'package:milkwayshipapp/core/urls.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/auth.dart';
import '../../core/models/options_model.dart';
import '../../core/server.dart';

class DepartalListController extends GetxController {
  final RefreshController refreshController = RefreshController();
  List<DepartmentalAgendaModel> deparList = [];
  bool hasData = false;

  List<OptionModel> options = [];
  int page = 1;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void reloadData() async {
    deparList = [];
    hasData = false;
    options = [];
    page = 1;
    _loadData();
  }

  Future<void> _loadData() async {
    final apiService = ApiService();

    final response = await apiService.getRequest(
      apiUrl.departalListCreatePath,
      {'page': page},
    );
    if (response.statusCode != 200) {
      return;
    }
    final responseData = ResponseData.fromJson(response.data);
    deparList = DepartmentalAgendaModel.fromJsonToList(responseData.data);
    if (deparList.isNotEmpty) {
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
    // scrollController.dispose();
    super.onClose();
  }

  Future<void> onOption(OptionModel option) async {}
}
