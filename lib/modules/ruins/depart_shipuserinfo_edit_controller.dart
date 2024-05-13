import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';
import 'package:flutter/cupertino.dart';

import '../../core/urls.dart';
import '../../core/server.dart';
import '../../core/custom_option_widget.dart';
import '../../core/models/agenda_models.dart';
import '../../core/models/ship_user_model.dart';

class DepartShipuserInfoEditController extends GetxController {
  String? departId;
  String? shipUserId;
  bool canSave = false;
  DepartmentalAgendaModel? departData;
  ShipuserDepartmentalInfoModel? departShipUserData;
  ShipUserModel? shipUserData;

  final TextEditingController skillAliveCtl = TextEditingController();
  final TextEditingController agendaLevelCtl = TextEditingController();
  final TextEditingController agendaNodeCtl = TextEditingController();
  final TextEditingController propsLackCtl = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    skillAliveCtl.dispose();
    agendaLevelCtl.dispose();
    agendaNodeCtl.dispose();
    propsLackCtl.dispose();
  }

  Future<void> reloadData() async {
    canSave = false;
    loadData();
  }

  Future<void> loadData() async {
    final as = ApiService();
    departId = Get.parameters['departId'];
    shipUserId = Get.parameters['shipUserId'];
    final url = sprintf(apiUrl.departalRetrUpdDestPath, [departId]);
    final response = await as.getRequest(url, {'ship_user_id': shipUserId});

    if (response.statusCode != 200) {
      // TODO: 弹窗
    } else {
      final responseData = ResponseData.fromJson(response.data);
      canSave = responseData.message!.toLowerCase() == 'true';
      if (responseData.data != null) {
        departData = DepartmentalAgendaModel.fromJson(responseData.data);
        if (departData != null) {
          final users = departData?.shipUserDatas ?? [];
          bool skillAlive = false;
          if (departShipUserData?.skillAlive != null) {
            skillAlive = departShipUserData?.skillAlive ?? false;
          }

          if (users.isNotEmpty) {
            departShipUserData = users[0];
            shipUserData = departShipUserData?.shipUser;
            skillAliveCtl.text = skillAlive ? "是" : "否";
            agendaLevelCtl.text = "${departShipUserData?.agendaLevel ?? 1}";
            agendaNodeCtl.text = "${departShipUserData?.agendaNode ?? 0}";
            propsLackCtl.text = "${departShipUserData?.propsLack ?? 0}";
          }
        }
      }
    }
    update();
  }

  Future<bool> onOptionSave() async {
    Map<String, dynamic> payload = {
      // "id": departShipUserData?.id,
      "user_id": shipUserData?.userId,
      "ship_user_id": shipUserData?.id,
      "ship_user_mks_name": shipUserData?.mksName,
      "agenda_id": departData?.id,
      "agenda_name": departData?.name,
      "skill_alive": skillAliveCtl.text == "是",
      "agenda_level": agendaLevelCtl.text,
      "agenda_node": agendaNodeCtl.text,
      "props_lack": propsLackCtl.text,
    };
    final result = await customePostOption(
      "更新角色的部门议程信息",
      apiUrl.departShipUserUpdPath,
      payload,
    );
    await reloadData();
    return result;
  }
}
