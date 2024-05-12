import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/urls.dart';
import '../../core/apps.dart';
import '../../core/server.dart';
import '../../core/common_controller.dart';
import '../../core/models/region_model.dart';
import '../../core/custom_option_widget.dart';
import '../../core/models/ship_user_model.dart';

class RegionJoinController extends GetxController {
  final RefreshController refreshController = RefreshController();
  List<RegionModel> regionDataList = [];
  bool hasRegion = false;
  bool hasUser = false;
  String? toJoinRegionId;

  // final TimePickerController lastOpenTimeCtl = Get.find<TimePickerController>();
  // final TimePickerController lastJoinTimeCtl = Get.find<TimePickerController>();
  final TimePickerController timeCtl = Get.find<TimePickerController>();

  // 上次开盆时间
  String? lastOpenTime;
  // 上次参盆时间
  String? lastJoinTime;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void setLastOpenTime(String? time) {
    lastOpenTime = time;
    update();
  }

  void setLastJoinTime(String? time) {
    lastJoinTime = time;
    update();
  }

  // dio.Response? response;
  Future<void> _loadData() async {
    final as = ApiService();
    final params = {'can_join': true};
    final response = await as.getRequest(apiUrl.regionsCreateListPath, params);
    final resData = ResponseData.fromJson(response.data);
    if (resData.data == null) {
      return;
    } else {
      hasRegion = true;
      regionDataList = RegionModel.fromJsonToList(resData.data);
      // final userCnt = resData?.shipUsers?.length ?? 0;
      // if (userCnt > 0) {
      //   hasUser = true;
      // }
    }

    update();
  }

  void setToJoinRegionId(String? regionId) {
    toJoinRegionId = regionId;
  }

  Future<void> onCreateShipUser(
    String? mskName,
    String? regionRole,
    String? typeName,
    String? swordName,
  ) async {
    final payload = {
      "regions_id": toJoinRegionId,
      "mks_name": mskName,
      "region_role": regionRole,
      "type_name": typeName,
      "sword": swordName,
      "last_open_corn_time": lastOpenTime,
      "last_join_corn_time": lastJoinTime,
    };
    //                 "mks_uuid": "银河战舰UUID", # 非必填,
    // "mks_name": "银河战舰昵称", # 必填
    // "regions_id": 势力ID, # 非必填
    // "regions_role": 势力中职务, # 非必填
    // "last_join_corn_time": 上次参盆时间,  # 非必填
    // "last_open_corn_time": 上次开盆时间,  # 非必填
    final response = customePostOptionWithResp(
      "加入势力",
      apiUrl.shipUserListCreatePath,
      payload,
    );
    final newShipUser = ShipUserModel.fromJson(response?.data);
    Get.toNamed(
      AppRoute.shipUserOptionsPage,
      parameters: {'shipuser_id': newShipUser.id},
    );
  }

  @override
  void onClose() {
    refreshController.dispose();
    // scrollController.dispose();
    super.onClose();
  }
}
