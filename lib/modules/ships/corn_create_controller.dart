import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';
import 'package:sprintf/sprintf.dart';
import 'package:intl/intl.dart';

import '../../core/common_controller.dart';
import '../../core/server.dart';
import '../../core/urls.dart';

class CornCreateController extends GetxController {
  String? shipUserId;
  ShipUserModel? shipUserData;

  String? regionsId;

  var options = ['是', '否'];

  final TimePickerController tc = Get.find<TimePickerController>();

  // 计划开盆时间
  String? time;
  // 自己是否参盆
  String? join;

  @override
  void onInit() {
    final formater = DateFormat('yyyy-MM-dd HH:mm:ss');
    time = formater.format(DateTime.now());
    join = options[0];
    super.onInit();
    _loadData();
  }

  void setTime(String? time) {
    this.time = time;
    update();
  }

  void setSelfJoin(String? join) {
    this.join = join;
    update();
  }

  Future<void> _loadData() async {
    final apiService = Get.find<ApiService>();
    shipUserId = Get.parameters['shipuser_id'];
    final url = sprintf(apiUrl.shipUserRetriveUpdateDestroyPath, [shipUserId]);
    final response = await apiService.getRequest(url, null);
    if (response.statusCode != 200) {
      // TODO: 弹窗
    } else {
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data != null) {
        shipUserData = ShipUserModel.fromJson(responseData.data);
        regionsId = shipUserData?.regionsId;
      }
    }
    update();
  }

  void onCreate() {
    final apiService = Get.find<ApiService>();
    var toJoin = false;
    if (join == '是') {
      toJoin = true;
    }
    final payload = <String, dynamic>{
      "ship_user_id": shipUserId,
      "schedule_time": time,
      "if_self_join": toJoin,
      "regions_id": regionsId,
    };
    apiService.postRequest(apiUrl.cornListCreatePath, payload);
    update();
  }
}
