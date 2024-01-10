import 'package:get/get.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/models/ship_user_model.dart';
import '../../core/server.dart';
import '../../core/urls.dart';
// import '../login/global_controller.dart';

class ShipUserOptionController extends GetxController {
  String? shipUserId;
  ShipUserModel? shipUserData;
  final RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    super.onInit();
    // 在控制器初始化时，获取页面参数
    // regionId = Get.arguments;

    _loadData();
  }

  // dio.Response? response;
  Future<void> _loadData() async {
    final apiService = Get.find<ApiService>();
    String? shipUserId = Get.parameters['userId'];
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
    // final GlobalController gc = Get.find<GlobalController>();
    // userDisplayName = gc.userDisplayName as String;
    update();
  }
}
