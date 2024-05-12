// 游戏角色管理的游戏角色列表 controller
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/custom_option_widget.dart';
import '../../core/models/options_model.dart';
import '../../core/models/season_model.dart';
import '../../core/option_conf.dart';
import '../../core/urls.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/server.dart';

class SeasonOptionController extends GetxController {
  String? seasonId;
  SeasonInfoModel? seasonInfo;
  List<OptionModel> validOptions = [];
  bool hasData = false;
  bool hasOption = false;
  // int length = 0;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void reload() async {
    hasData = false;
    hasOption = false;
    // length = 0;
    _loadData();
  }

  Future<void> _loadData() async {
    final as = ApiService();

    seasonId = Get.parameters['season_id'];
    final url = sprintf(apiUrl.seasonRetrieveUpdateDestoryPath, [seasonId]);
    final response = await as.getRequest(url, null);

    if (response.statusCode != 200) {
      // TODO: 弹窗
    } else {
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data != null) {
        seasonInfo = SeasonInfoModel.fromJson(responseData.data);
        hasData = true;
        final options = seasonInfo?.options ?? [];
        if (options.isNotEmpty) {
          hasOption = true;
          validOptions = options;
        }
      }
    }
    update();
  }

  Future<bool> onOption(OptionModel option) async {
    bool result = false;
    switch (option.code) {
      case SeasonOptConf.APPROVE:
        result = await _onApprove(option);
        break;
      case SeasonOptConf.END:
        result = await _onEnd(option);
        break;
    }
    return result;
  }

  Future<bool> _onApprove(OptionModel option) async {
    late Map<String, dynamic> myPayload = {};

    myPayload["season_id"] = seasonInfo?.id;
    myPayload["updated_time"] = seasonInfo?.updatedTime;
    final res = await customePostOption(
      option.title ?? "",
      apiUrl.seasonApprovePath,
      myPayload,
    );
    return res;
  }

  Future<bool> _onEnd(OptionModel option) async {
    late Map<String, dynamic> myPayload = {};

    myPayload["season_id"] = seasonInfo?.id;
    myPayload["updated_time"] = seasonInfo?.updatedTime;
    final res = await customePostOption(
      option.title ?? "",
      apiUrl.seasonEndPath,
      myPayload,
    );
    return res;
  }
}
