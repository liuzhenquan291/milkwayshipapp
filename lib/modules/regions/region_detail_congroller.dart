import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/regions/region_detail_model.dart';
import 'package:sprintf/sprintf.dart';
import 'package:dio/dio.dart' as dio;

import '../../core/server.dart';
import '../../core/urls.dart';

class RegionDetailController extends GetxController {
  String? regionId;
  RegionDetailModel? regionData;
  bool hasRegion = false;
  bool ifSelfRegion = false; // 通过 token 查询 势力

  // 在路由跳转时传递参数
  // Get.toNamed('/your_page', arguments: 'your_parameter_value');

  @override
  void onInit() {
    super.onInit();
    // 在控制器初始化时，获取页面参数
    regionId = Get.arguments;
    _loadData();
  }

  dio.Response? response;
  Future<void> _loadData() async {
    final apiService = Get.find<ApiService>();
    if (regionId != null || regionId != "") {
      ifSelfRegion = false;
      final url = sprintf(apiUrl.regionsRetrieveUpdateDestroyPath, regionId);
      final response = apiService.getRequest(url, null);
    } else {
      final response = apiService.getRequest(apiUrl.regionByUser, null);
    }
    if (response == null) {
    } else if (response?.statusCode != 200) {
      // TODO: 弹窗
    } else {
      hasRegion = true;
      regionData = RegionDetailModel.fromJson(response?.data);
    }
  }
}
