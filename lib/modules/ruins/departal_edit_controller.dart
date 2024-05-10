// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/custom_option_widget.dart';
import 'package:milkwayshipapp/core/models/agenda_models.dart';
import 'package:milkwayshipapp/core/urls.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/models/options_model.dart';
import '../../core/server.dart';

class DepartalEditController extends GetxController {
  final RefreshController refreshController = RefreshController();
  String departId = '-1';
  DepartmentalAgendaModel? departData;
  bool hasData = false;
  // bool hasShipUserData = false;

  List<OptionModel> options = [];

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void reloadData() async {
    hasData = false;
    // hasShipUserData = false;
    options = [];
    _loadData();
  }

  Future<void> _loadData() async {
    departId = Get.parameters['departId'] ?? "-1";
    if (departId == '-1') {
      // 新建
    } else {
      final apiService = ApiService();
      final url = sprintf(apiUrl.departalRetrUpdDestPath, [departId]);
      final response = await apiService.getRequest(url, null);
      if (response.statusCode != 200) {
        return;
      }
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data != null) {
        departData = DepartmentalAgendaModel.fromJson(responseData.data);
        hasData = true;
        // if (departData?.shipUserDatas != null) {
        //   hasShipUserData = true;
        // }
      }
    }

    update();
  }

  @override
  void onClose() {
    refreshController.dispose();
    // scrollController.dispose();
    super.onClose();
  }

  Future<bool> onEditOption(
    String name,
    String skill,
    String skillEffect,
    String upgradePropsName,
    String skillMajorName,
  ) async {
    Map<String, dynamic> payload = {
      'name': name,
      'skill': skill,
      'skill_effect': skillEffect,
      'upgrade_props_name': upgradePropsName,
      'skill_major_name': skillMajorName,
    };
    String title = '';
    String url = '';
    bool result = false;

    if (departId == '-1') {
      title = '确认新建';
      url = apiUrl.departalListCreatePath;
      result = await customePostOption(
        title,
        url,
        payload,
      );
    } else {
      title = '确认编辑';
      url = sprintf(apiUrl.departalRetrUpdDestPath, [departId]);
      payload['depart_id'] = departId;
      payload['updated_time'] = departData?.updatedTime;
      result = await customePutOption(
        title,
        url,
        payload,
      );
    }

    return result;
  }
}
