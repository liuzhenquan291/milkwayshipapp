import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/models/ship_cornucopia_model.dart';
import '../../core/server.dart';
import '../../core/urls.dart';

class CornJoinController extends GetxController {
  String? shipUserId;
  ShipUserModel? shipUserData;
  bool hasTojoin = false;
  List<ShipCornucopiaModel> toJoinCors = [];
  bool hasCornRecords = false;
  List<ShipCornucopiaModel> cornRecords = [];
  final RefreshController refreshController = RefreshController();
  final RefreshController refreshController2 = RefreshController();

  String? regionsId;

  @override
  void onInit() {
    super.onInit();
    _loadData();
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
        if (shipUserData?.toJoinCornucopias != null) {
          toJoinCors = shipUserData?.toJoinCornucopias ?? [];
          hasTojoin = toJoinCors.isNotEmpty;
        }
        if (shipUserData?.cornucopias != null) {
          cornRecords = shipUserData?.cornucopias ?? [];
          hasTojoin = toJoinCors.isNotEmpty;
        }
      }
    }
    update();
  }

  void onJoin() {}
}
