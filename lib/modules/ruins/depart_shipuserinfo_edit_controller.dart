import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/agenda_models.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/apps.dart';
import '../../core/models/options_model.dart';
import '../../core/server.dart';
import '../../core/urls.dart';

class DepartShipuserInfoEditController extends GetxController {
  String? departId;
  String? shipUserId;
  DepartmentalAgendaModel? departData;
  ShipuserDepartmentalInfoModel? departShipUserData;
  ShipUserModel? shipUserData;

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  Future<void> reloadData() async {
    loadData();
  }

  Future<void> loadData() async {
    final apiService = ApiService();
    departId = Get.parameters['departId'];
    shipUserId = Get.parameters['shipUserId'];
    final url = sprintf(apiUrl.departalRetrUpdDestPath, [departId]);
    final response =
        await apiService.getRequest(url, {'ship_user_id': shipUserId});

    if (response.statusCode != 200) {
      // TODO: 弹窗
    } else {
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data != null) {
        departData = DepartmentalAgendaModel.fromJson(responseData.data);
        if (departData != null) {
          final users = departData?.shipUserDatas ?? [];
          if (users.isNotEmpty) {
            departShipUserData = users[0];
            shipUserData = departShipUserData?.shipUser;
          }
        }
      }
    }
    update();
  }

  Future<void> onOption(OptionModel option) async {
    final result = await Get.toNamed(
      AppRoute.departEditPage,
      parameters: {'departId': "${departData?.id ?? '-1'}"},
    );
    if (result == true) {
      await reloadData();
    }
  }

  Future<bool> onOptionSave(
    String? skillAliveText,
    String agendaLevelText,
    String agendaNoteText,
    String propsLackText,
  ) async {
    return false;
  }
}
