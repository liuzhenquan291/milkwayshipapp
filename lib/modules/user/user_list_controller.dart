// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/server.dart';
import 'package:milkwayshipapp/core/urls.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/models/user_model.dart';

class UserListController extends GetxController {
  final RefreshController refreshController = RefreshController();
  // final ScrollController scrollController = ScrollController();
  List<UserModel> userList = [];
  bool hasUser = false;
  String userRole = '';
  String totalOptions = '';
  int page = 1;

  @override
  void onInit() {
    super.onInit();
    _loadData();
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent) {
    //     _loadData();
    //   }
    // });
  }

  Future<void> _loadData() async {
    final apiService = Get.find<ApiService>();
    final totalOptionsResponse =
        await apiService.getRequest(apiUrl.userTotalOptions, null);
    if (totalOptionsResponse.statusCode != 200) {
      return;
    }
    final res1Data = ResponseData.fromJson(totalOptionsResponse.data);
    userRole = res1Data.data["user_role"] as String;
    totalOptions = res1Data.data["options_str"] as String;

    final response =
        await apiService.getRequest(apiUrl.useListCreatePath, {'page': page});
    if (response.statusCode != 200) {
      return;
    }
    final responseData = ResponseData.fromJson(response.data);
    userList = UserModel.fromJsonToList(responseData.data);
    if (userList.isNotEmpty) {
      hasUser = true;
    }

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
