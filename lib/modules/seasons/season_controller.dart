// 游戏角色管理的游戏角色列表 controller
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/season_model.dart';
import 'package:milkwayshipapp/core/urls.dart';

import '../../core/server.dart';

class SeasonListController extends GetxController {
  List<SeasonInfoModel>? seasonInfos;
  bool hasData = false;
  int length = 0;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void reload() async {
    hasData = false;
    length = 0;
    _loadData();
  }

  Future<void> _loadData() async {
    final as = ApiService();

    final response = await as.getRequest(apiUrl.seasonListCreatePath, null);

    if (response.statusCode != 200) {
      // TODO: 弹窗
    } else {
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data != null) {
        seasonInfos = SeasonInfoModel.fromJsonToList(responseData.data);
        length = seasonInfos?.length ?? 0;
        if (length > 0) {
          hasData = true;
        }
      }
    }
    update();
  }
}
