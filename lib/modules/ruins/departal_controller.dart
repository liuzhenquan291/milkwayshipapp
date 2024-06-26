// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/urls.dart';
import '../../core/apps.dart';
import '../../core/auth.dart';
import '../../core/server.dart';
import '../../core/models/options_model.dart';
import '../../core/models/agenda_models.dart';

class DepartalListController extends GetxController {
  final RefreshController refreshController = RefreshController();
  List<DepartmentalAgendaModel> deparList = [];
  bool hasData = false;
  bool isManager = false;

  List<OptionModel> options = [];
  int page = 1;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void reloadData() async {
    isManager = false;
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
      isManager = true;
      // options = [
      //   OptionModel(
      //     code: "new_add",
      //     name: "新建议程",
      //     title: "新建部门议程",
      //   )
      // ];
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

  Future<void> onOptionNewAdd() async {
    final result = await Get.toNamed(
      AppRoute.departEditPage,
      parameters: {'departId': '-1'},
    );
    if (result == true) {
      reloadData();
    }
  }

  // Future<void> onOption(OptionModel option) async {
  //   final result = await Get.toNamed(
  //     AppRoute.departEditPage,
  //     parameters: {'departId': '-1'},
  //   );
  //   if (result == true) {
  //     reloadData();
  //   }
  // }
}
