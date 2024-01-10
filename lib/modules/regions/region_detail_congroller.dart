import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/region_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:dio/dio.dart' as dio;

import '../../core/server.dart';
import '../../core/urls.dart';

class RegionDetailController extends GetxController {
  RegionModel? regionData;
  bool hasRegion = false;
  bool hasUser = false;
  final RefreshController refreshController = RefreshController();

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
        regionData = RegionModel.fromJson(responseData.data);
        final userCnt = regionData?.shipUsers?.length ?? 0;
        if (userCnt > 0) {
          hasUser = true;
        }
      }
    }
    update();
  }
}
