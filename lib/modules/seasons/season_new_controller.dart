// 游戏角色管理的游戏角色列表 controller
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/custom_option_widget.dart';
import '../../core/urls.dart';

// import '../../core/server.dart';

class SeasonNewController extends GetxController {
  // List<SeasonInfoModel>? seasonInfos;
  // bool hasData = false;
  // int length = 0;

  // @override
  // void onInit() {
  //   super.onInit();
  //   _loadData();
  // }

  // Future<void> _loadData() async {
  //   final as = ApiService();

  //   final response = await as.getRequest(apiUrl.seasonListCreatePath, null);

  //   if (response.statusCode != 200) {
  //     // TODO: 弹窗
  //   } else {
  //     final responseData = ResponseData.fromJson(response.data);
  //     if (responseData.data != null) {
  //       seasonInfos = SeasonInfoModel.fromJsonToList(responseData.data);
  //       final length = seasonInfos?.length ?? 0;
  //       if (length > 0) {
  //         hasData = true;
  //       }
  //     }
  //   }
  //   update();
  // }

  Future<bool> onCreate(
    String? seasonName,
    String? seasonIndex,
  ) async {
    final res = await customePostOption(
      "创建新赛季",
      apiUrl.seasonListCreatePath,
      {
        'season_name': seasonName,
        'season_index': seasonIndex,
      },
    );
    return res;
  }
}
