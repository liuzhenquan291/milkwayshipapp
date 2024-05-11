import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/models/agenda_models.dart';
import '../../core/server.dart';
import '../../core/urls.dart';

class RuinsRegistSelectController extends GetxController {
  final RefreshController refreshController = RefreshController();
  List<ShipuserDepartmentalInfoModel> committees = [];
  List<bool> selector = [];

  bool hasData = false;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  Future<void> _loadData() async {
    final as = ApiService();
    final resp = await as.getRequest(apiUrl.departCommProcPath, null);
    if (resp.statusCode != 200) {
      return;
    } else {
      final responseData = ResponseData.fromJson(resp.data);
      if (responseData.data != null) {
        committees =
            ShipuserDepartmentalInfoModel.fromJsonToList(responseData.data);
        hasData = committees.isNotEmpty;

        for (int i = 0; i < committees.length; i++) {
          selector.add(false);
        }
      }
    }
    update();
  }

  void toggleSelection(bool? sel, int idx) {
    selector[idx] = sel ?? false;
    update();
  }

  Future<List<ShipuserDepartmentalInfoModel>> onSelect() async {
    List<ShipuserDepartmentalInfoModel> toAddUser = [];
    for (int i = 0; i < selector.length; i++) {
      if (selector[i]) {
        toAddUser.add(committees[i]);
      }
    }
    return toAddUser;
  }
}
