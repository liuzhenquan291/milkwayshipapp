// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/apps.dart';
import 'package:milkwayshipapp/core/custom_option_widget.dart';
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
      final url = sprintf(apiUrl.ruinsRetrUpdDestPath, [ruinId]);
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
    String ruinOwnerStrNew = ownerText ?? "否";
    String ruinOwnerStrOld = ruinOwnerStr;
    if (ruinOwnerStrNew == ruinOwnerStr) {
      return;
    }
    // Get.defaultDialog(
    //   title: "确认执行?",
    //   middleText: '更改废墟归属将重置数据',
    //   textConfirm: '确认',
    //   textCancel: '取消',
    //   confirmTextColor: Colors.white, // 自定义确认按钮文本颜色
    //   onCancel: () {
    //     Get.back();
    //   },
    //   onConfirm: () async {
    //     Get.back();
    //     ruinOwnerStr = ruinOwnerStrNew;
    //     ruinOwner = (ruinOwnerStr == "是") ? true : false;
    //     reloadData();
    //   },
    // );
    reloadData();
  }

  // void ruinOwnerChangeConfrim(String? ownerText) async {
  //   String ruinOwnerStrNew = ownerText ?? "否";
  //   String ruinOwnerStrOld = ruinOwnerStr;
  //   if (ruinOwnerStrNew == ruinOwnerStr) {
  //     return;
  //   }
  //   Get.defaultDialog(
  //     title: "确认执行?",
  //     middleText: '更改废墟归属将重置数据',
  //     textConfirm: '确认',
  //     textCancel: '取消',
  //     confirmTextColor: Colors.white, // 自定义确认按钮文本颜色
  //     onCancel: () {
  //       Get.back();
  //     },
  //     onConfirm: () async {
  //       Get.back();
  //       ruinOwnerStr = ruinOwnerStrNew;
  //       ruinOwner = (ruinOwnerStr == "是") ? true : false;
  //       reloadData();
  //     },
  //   );
  // }

  Future<bool> onSelectShipUsers(String? groupName) async {
    List<String> selectedShipUserIds = [];
    for (int i = 0; i < groups.length; i++) {
      String inGroupName = groupName ?? '';
      String thisGroupName = groups[i].groupName!;
      if (thisGroupName == inGroupName) {
        toAddshipUserGroupIdx = i;
        if (groups[i].registers != null) {
          for (int j = 0; j < groups[i].registers!.length; j++) {
            selectedShipUserIds.add(groups[i].registers![j].shipuserId);
          }
        }
        break;
      }
    }
    String jsonStr = jsonEncode(selectedShipUserIds);

    await Get.toNamed(
      AppRoute.committeeSelectPage,
      parameters: {'selectedShipUserIds': jsonStr},
    )?.then(
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
    bool result = false;
    String url = '';
    String title = '';
    Map<String, dynamic> payload = ruinData!.toDict();
    if (ruinId == '-1') {
      url = apiUrl.ruinsListCreatePath;
      title = '确认创建';
      result = await customePostOption(title, url, payload);
    } else {
      url = sprintf(apiUrl.ruinsRetrUpdDestPath, [ruinId]);
      title = '确认更新';
      result = await customePutOption(title, url, payload);
    }

    return result;
  }

  RuinRegisterModel trans(ShipuserDepartmentalInfoModel data) {
    return RuinRegisterModel(
      shipuserId: data.shipUserId,
      shipuserMskName: data.shipUserMksName,
      committeeAlive: data.skillAlive ?? false,
      committeeAliveName: data.skillAliveName ?? '',
      committeeLevel: data.agendaLevel,
      committeeNode: data.agendaNode,
      committeePropsLack: data.propsLack,
    );
  }
}
