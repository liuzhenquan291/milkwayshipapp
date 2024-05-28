import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/auth.dart';
import '../../core/urls.dart';
import '../../core/apps.dart';
import '../../core/server.dart';
import '../../core/models/agenda_models.dart';
import '../../core/models/options_model.dart';

class DepartOptionsController extends GetxController {
  String? departId;
  DepartmentalAgendaModel? departData;
  // String? displayName;
  bool hasUser = false;
  int shipUserLength = 0;
  bool hasOptions = false;
  bool isManager = false;
  bool isCommittee = false; // 是否是委员会
  String userId = '';
  List<OptionModel> validOptions = [];

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  Future<void> reloadData() async {
    hasUser = false;
    shipUserLength = 0;
    hasOptions = false;
    isManager = false;
    validOptions = [];
    isCommittee = false;
    loadData();
  }

  Future<void> loadData() async {
    final apiService = ApiService();
    departId = Get.parameters['departId'];
    final url = sprintf(apiUrl.departalRetrUpdDestPath, [departId]);
    final response = await apiService.getRequest(url, null);

    if (response.statusCode != 200) {
      // TODO: 弹窗
    } else {
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data != null) {
        departData = DepartmentalAgendaModel.fromJson(responseData.data);
        if (departData != null) {
          if (departData?.id == 1) {
            isCommittee = true;
          }
          final users = departData?.shipUserDatas ?? [];
          if (users.isNotEmpty) {
            hasUser = true;
            // num cnt = users.length;
            shipUserLength = users.length;
          }
          final AuthService au = Get.find<AuthService>();
          userId = au.userId ?? '';
          if (au.isManager()) {
            isManager = true;
            // hasOptions = true;
            // validOptions = [
            //   OptionModel(
            //     code: "update",
            //     name: "编辑议程",
            //     title: "变异部门议程",
            //   ),
            // ];
          }
        }
      }
    }
    update();
  }

  Future<void> onOptionUpdate() async {
    final result = await Get.toNamed(
      AppRoute.departEditPage,
      parameters: {'departId': "${departData?.id ?? '-1'}"},
    );
    if (result == true) {
      await reloadData();
    }
  }

  // Future<void> onOption(OptionModel option) async {
  //   final result = await Get.toNamed(
  //     AppRoute.departEditPage,
  //     parameters: {'departId': "${departData?.id ?? '-1'}"},
  //   );
  //   if (result == true) {
  //     await reloadData();
  //   }
  // }
}
