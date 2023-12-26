import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/regions/region_detail_model.dart';
// import 'package:dio/dio.dart' as dio;

import '../../core/server.dart';
import '../../core/urls.dart';
import '../login/global_controller.dart';

class RegionDetailController extends GetxController {
  RegionDetailModel? regionData;
  bool hasRegion = false;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  // dio.Response? response;
  Future<void> _loadData() async {
    final apiService = Get.find<ApiService>();
    final response = await apiService.getRequest(apiUrl.regionByUser, null);
    if (response.statusCode != 200) {
      // TODO: 弹窗
    } else {
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data == null) {
        return;
      } else {
        hasRegion = true;
        regionData = RegionDetailModel.fromJson(responseData.data);
      }
    }
    update();
  }
}
