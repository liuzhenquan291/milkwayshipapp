// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/urls.dart';
import '../../core/server.dart';
import '../../core/custom_option_widget.dart';
import '../../core/models/agenda_models.dart';
import '../../core/models/options_model.dart';

class DepartalEditController extends GetxController {
  final RefreshController refreshController = RefreshController();
  final TextEditingController nameCtl = TextEditingController();
  final TextEditingController skillCtl = TextEditingController();
  final TextEditingController skillEffectCtl = TextEditingController();
  final TextEditingController upgradePropsCtl = TextEditingController();
  final TextEditingController skillMajorCtl = TextEditingController();
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

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
    nameCtl.dispose();
    skillCtl.dispose();
    skillEffectCtl.dispose();
    upgradePropsCtl.dispose();
    skillMajorCtl.dispose();
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
        nameCtl.text = departData?.name ?? '';
        skillCtl.text = departData?.skill ?? '';
        skillEffectCtl.text = departData?.skillEffect ?? '';
        skillMajorCtl.text = departData?.skillMajorName ?? '';
        upgradePropsCtl.text = departData?.upgradePropsName ?? '';
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

  Future<bool> onEditOption() async {
    Map<String, dynamic> payload = {
      'name': nameCtl.text,
      'skill': skillCtl.text,
      'skill_effect': skillEffectCtl.text,
      'upgrade_props_name': upgradePropsCtl.text,
      'skill_major_name': skillMajorCtl.text,
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
