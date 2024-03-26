import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/common_controller.dart';
import '../../core/server.dart';
import '../../core/urls.dart';

class CreateCornucopiaController extends GetxController {
  String? shipUserId;
  ShipUserModel? shipUserData;
  final TimePickerController tc = Get.find<TimePickerController>();
  String? time;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void setTime(String? time) {
    this.time = time;
    update();
  }

  Future<void> _loadData() async {
    final apiService = Get.find<ApiService>();
    String? shipUserId = Get.parameters['shipuser_id'];
    final url = sprintf(apiUrl.shipUserRetriveUpdateDestroyPath, [shipUserId]);
    final response = await apiService.getRequest(url, null);
    if (response.statusCode != 200) {
      // TODO: 弹窗
    } else {
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data != null) {
        shipUserData = ShipUserModel.fromJson(responseData.data);
      }
    }
    update();
  }

  void onCreate() {}
}
