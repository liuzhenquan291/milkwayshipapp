// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/apps.dart';
import 'package:milkwayshipapp/core/models/agenda_models.dart';
import 'package:milkwayshipapp/core/models/ruins_group.dart';
import 'package:milkwayshipapp/core/models/ruins_model.dart';
import 'package:milkwayshipapp/core/urls.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sprintf/sprintf.dart';

import '../../core/models/options_model.dart';
import '../../core/models/register_model.dart';
import '../../core/server.dart';

class RuinsEditController extends GetxController {
  final RefreshController refreshController = RefreshController();

  // 废墟信息 controller
  final TextEditingController ruinOwnerTextCtl = TextEditingController();
  final TextEditingController outerCntCtl = TextEditingController();
  final TextEditingController middleCntCtl = TextEditingController();
  final TextEditingController innerCntCtl = TextEditingController();
  final TextEditingController targetCntCtl = TextEditingController();

  bool isNew = true;
  String ruinId = '-1';
  RuinsModel? ruinData;
  List<RuinGroupModel> groups = [];
  bool hasData = false;
  String ruinOwnerStr = '否';
  bool ruinOwner = false;
  List<OptionModel> options = [];
  int toAddshipUserGroupIdx = 0;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
    ruinOwnerTextCtl.dispose();
    outerCntCtl.dispose();
    innerCntCtl.dispose();
    middleCntCtl.dispose();
    targetCntCtl.dispose();
  }

  void reloadData() async {
    isNew = true;
    hasData = false;
    toAddshipUserGroupIdx = 0;
    // hasShipUserData = false;
    options = [];
    groups = [];
    _loadData();
  }

  Future<void> _loadData() async {
    ruinId = Get.parameters['ruinId'] ?? "-1";
    if (ruinId == '-1') {
      // 初始化新数据
      final as = ApiService();
      final url = apiUrl.ruinsDefaultDataPath;
      final response = await as.getRequest(url, {'ruin_owner': ruinOwner});
      if (response.statusCode != 200) {
        return;
      }
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data != null) {
        ruinData = RuinsModel.fromJson(responseData.data);

        // 废墟信息 ctl 初始化
        ruinOwnerTextCtl.text = ruinData?.ruinOwnerName ?? '';
        outerCntCtl.text = "${ruinData?.outerCnt ?? 0}";
        innerCntCtl.text = "${ruinData?.innerCnt ?? 0}";
        middleCntCtl.text = "${ruinData?.middleCnt ?? 0}";
        targetCntCtl.text = "${ruinData?.targetShipUserCnt ?? 0}";

        if (ruinData?.groups != null) {
          groups = ruinData?.groups ?? [];
        }

        options = [
          OptionModel(
            code: "new_add",
            name: "确认新建",
            title: "新建废墟任务",
          )
        ];
      }
    } else {
      final as = ApiService();
      final url = sprintf(apiUrl.departalRetrUpdDestPath, [ruinId]);
      final response = await as.getRequest(url, null);
      if (response.statusCode != 200) {
        return;
      }
      final responseData = ResponseData.fromJson(response.data);
      if (responseData.data != null) {
        isNew = false;
        ruinData = RuinsModel.fromJson(responseData.data);
        hasData = true;
        ruinOwnerTextCtl.text = ruinData?.ruinOwnerName ?? '';
        outerCntCtl.text = "${ruinData?.outerCnt ?? 0}";
        innerCntCtl.text = "${ruinData?.innerCnt ?? 0}";
        middleCntCtl.text = "${ruinData?.middleCnt ?? 0}";
        targetCntCtl.text = "${ruinData?.targetShipUserCnt ?? 0}";
        if (ruinData?.groups != null) {
          groups = ruinData?.groups ?? [];
        }
      }
    }

    update();
  }

  @override
  void onClose() {
    refreshController.dispose();
    // scrollController.dispose();
    super.onClose();
  }

  void ruinOwnerOnchange(String? ownerText) async {
    ruinOwnerStr = ownerText ?? "否";
    ruinOwner = (ruinOwnerStr == "是") ? true : false;
    reloadData();
  }

  Future<bool> onSelectShipUsers(String? groupName) async {
    for (int i = 1; i < groups.length; i++) {
      String inGroupName = groupName ?? '';
      if (groups[i].groupName == inGroupName) {
        toAddshipUserGroupIdx = i;
        break;
      }
    }

    await Get.toNamed(AppRoute.committeeSelectPage)?.then(
      (value) {
        if (value != null) {
          List<ShipuserDepartmentalInfoModel> toAddUser = [];
          toAddUser = value;
          groups[toAddshipUserGroupIdx].registers = []; // 不管怎样都重置
          // if (groups[toAddshipUserGroupIdx].registers == null) {
          //   List<RuinRegisterModel> nulls = [];
          //   groups[toAddshipUserGroupIdx].registers = nulls;
          // }
          for (int i = 0; i < toAddUser.length; i++) {
            groups[toAddshipUserGroupIdx].registers?.add(trans(toAddUser[i]));
          }
          update();
        }
      },
    );

    return false;
  }

  Future<bool> onCreateOrUpdate() async {
    return false;
  }

  RuinRegisterModel trans(ShipuserDepartmentalInfoModel data) {
    return RuinRegisterModel(
      shipuserId: data.shipUserId,
      shipuserMskName: data.shipUserMksName,
      committeeAlive: data.skillAlive ?? false,
      committeeAliveName: data.skillAliveName ?? '',
      committeeLevel: data.agendaLevel,
      committeeNode: data.agendaNode,
    );
  }
}
