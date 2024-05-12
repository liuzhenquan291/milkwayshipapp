// import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/apps.dart';
import '../../core/urls.dart';
import '../../core/server.dart';
import '../../core/option_conf.dart';
import '../../core/custom_option_widget.dart';
import '../../core/models/ruins_group.dart';
import '../../core/models/ruins_model.dart';
import '../../core/models/options_model.dart';

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
    bool result = true;
    switch (option.code) {
      case RuinsOptConf.CLOSE:
        result = await _onClose(option);
        break;
      case RuinsOptConf.PROCESS:
        result = await _onProcess(option);
        break;
      case RuinsOptConf.UPDATE:
        _onUpdate(option);
        break;
      case RuinsOptConf.END:
        result = await _onEnd(option);
        break;
      case RuinsOptConf.DELETE:
        result = await _onDelete(option);
        break;
    }
    return result;
  }

  Future<bool> _onClose(OptionModel option) async {
    final Map<String, dynamic> myPayload = {
      "ruin_id": ruinId,
      "updated_time": ruinData?.updatedTime,
    };
    bool result = await customePostOption(
      option.title ?? "",
      apiUrl.closeRuinsPaht,
      myPayload,
    );
    return result;
  }

  Future<bool> _onDelete(OptionModel option) async {
    final url = sprintf(apiUrl.ruinsRetrUpdDestPath, [ruinId]);
    bool result = await customeDeleteOption(
      option.title ?? "",
      url,
      null,
    );
    return result;
  }

  Future<bool> _onProcess(OptionModel option) async {
    final Map<String, dynamic> myPayload = {
      "ruin_id": ruinId,
      "updated_time": ruinData?.updatedTime,
    };
    bool result = await customePostOption(
      option.title ?? "",
      apiUrl.processRuinsPath,
      myPayload,
    );
    return result;
  }

  Future<void> _onUpdate(OptionModel option) async {
    await Get.toNamed(
      AppRoute.ruinEditPage,
      parameters: {'ruinId': ruinId},
    )?.then(
      (value) {
        if (value != null) {
          final bool upded = value;
          if (upded) {
            reloadData();
          }
        }
      },
    );
  }

  Future<bool> _onEnd(OptionModel option) async {
    final Map<String, dynamic> myPayload = {
      "ruin_id": ruinId,
      "updated_time": ruinData?.updatedTime,
    };
    bool result = await customePostOption(
      option.title ?? "",
      apiUrl.endRuinsPath,
      myPayload,
    );
    return result;
  }
}
