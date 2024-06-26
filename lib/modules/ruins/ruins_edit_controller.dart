// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/auth.dart';
import '../../core/urls.dart';
import '../../core/apps.dart';
import '../../core/server.dart';
import '../../core/custom_option_widget.dart';
import '../../core/models/agenda_models.dart';
import '../../core/models/ruins_group.dart';
import '../../core/models/ruins_model.dart';
import '../../core/models/options_model.dart';
import '../../core/models/register_model.dart';

class RuinsEditController extends GetxController {
  final RefreshController refreshController = RefreshController();

  // 废墟信息 controller
  final TextEditingController numberCtl = TextEditingController();
  final TextEditingController ruinOwnerTextCtl = TextEditingController();
  final TextEditingController outerCntCtl = TextEditingController();
  final TextEditingController middleCntCtl = TextEditingController();
  final TextEditingController innerCntCtl = TextEditingController();
  final TextEditingController targetCntCtl = TextEditingController();
  Map<String, TextEditingController> groupTargetCntCtlMap = {};

  bool isNew = true;
  bool isManager = false;
  String ruinId = '-1';
  RuinsModel? ruinData;
  List<RuinGroupModel> groups = [];
  bool hasData = false;
  String ruinOwnerStr = '否';
  bool ruinOwner = false;
  bool? ruinOwnerForUpdate; // 这个是为更新时存储数据本身的 ruinOwner 数据
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
    numberCtl.dispose();
    outerCntCtl.dispose();
    innerCntCtl.dispose();
    middleCntCtl.dispose();
    targetCntCtl.dispose();
    disposeCtlMap();
  }

  void reloadData() async {
    isNew = true;
    hasData = false;
    toAddshipUserGroupIdx = 0;
    // hasShipUserData = false;
    options = [];
    groups = [];
    isManager = false;
    disposeCtlMap();
    _loadData();
  }

  Future<void> _loadData() async {
    final gc = Get.find<AuthService>();

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
        setRuinCtls();

        if (ruinData?.groups != null) {
          groups = ruinData?.groups ?? [];
          setCtlMap();
        }
      }
    } else {
      isNew = false;
      // 编辑时更改了 ruinOwner 重新加载数据
      if (ruinData != null && ruinOwnerForUpdate != ruinOwner) {
        final ruinDataUpdatedTime = ruinData?.updatedTime;
        final as = ApiService();
        final url = apiUrl.ruinsDefaultDataPath;
        final response = await as.getRequest(url, {'ruin_owner': ruinOwner});
        if (response.statusCode != 200) {
          return;
        }
        final responseData = ResponseData.fromJson(response.data);
        if (responseData.data != null) {
          ruinData = RuinsModel.fromJson(responseData.data);
          ruinData?.id = ruinId; // 重新加载数据后, 要把 ruinId 设置回去
          ruinData?.updatedTime = ruinDataUpdatedTime; // 把更新时间设置回去

          // 废墟信息 ctl 初始化
          setRuinCtls();

          if (ruinData?.groups != null) {
            groups = ruinData?.groups ?? [];
            setCtlMap();
          }
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
          ruinData = RuinsModel.fromJson(responseData.data);
          hasData = true;
          setRuinCtls();
          if (ruinData?.groups != null) {
            groups = ruinData?.groups ?? [];
            setCtlMap();
          }
        }
        if (ruinOwnerForUpdate == null) {
          ruinOwnerForUpdate = ruinData?.ruinOwner;
        }
      }
    }

    if (gc.isManager()) {
      isManager = true;
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
    ruinOwnerStr = ruinOwnerStrNew;
    ruinOwner = ruinOwnerStr == "是";
    reloadData();
  }

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
          if (groups[toAddshipUserGroupIdx].registers == null) {
            List<RuinRegisterModel> nulls = [];
            groups[toAddshipUserGroupIdx].registers = nulls;
          }
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
    getCtlMap(); // 将控制器里面的数据设置到对象里
    getRuinCtls(); // 将控制器里面的数据设置到对象里
    ruinData?.groups = groups;
    if (ruinId == '-1') {
      url = apiUrl.ruinsListCreatePath;
      title = '确认创建';
      final payload = ruinData!.toDictForCreate();
      result = await customePostOption(title, url, payload);
    } else {
      final payload = ruinData!.toDictForUpdate();
      url = sprintf(apiUrl.ruinsRetrUpdDestPath, [ruinId]);
      title = '确认更新';
      result = await customePutOption(title, url, payload);
    }
    // if (result) {
    //   Get.back(result: result);
    // }
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

  void disposeCtlMap() {
    for (TextEditingController ctl in groupTargetCntCtlMap.values) {
      ctl.dispose();
    }
    groupTargetCntCtlMap = {};
  }

  void setCtlMap() {
    for (int i = 0; i < groups.length; i++) {
      final ctl = TextEditingController();
      ctl.text = "${groups[i].targetShipuserCnt}";
      groupTargetCntCtlMap[groups[i].groupName!] = ctl;
    }
  }

  void getCtlMap() {
    for (int i = 0; i < groups.length; i++) {
      final ctl = groupTargetCntCtlMap[groups[i].groupName!];
      groups[i].targetShipuserCnt = int.parse(ctl?.text as String);
    }
  }

  void getRuinCtls() {
    /*
      final TextEditingController numberCtl = TextEditingController();
  final TextEditingController ruinOwnerTextCtl = TextEditingController();
  final TextEditingController outerCntCtl = TextEditingController();
  final TextEditingController middleCntCtl = TextEditingController();
  final TextEditingController innerCntCtl = TextEditingController();
  final TextEditingController targetCntCtl = TextEditingController();
    */
    ruinData?.number = numberCtl.text;
    ruinData?.ruinOwner = ruinOwner;
    ruinData?.outerCnt = int.parse(outerCntCtl.text);
    ruinData?.middleCnt = int.parse(middleCntCtl.text);
    ruinData?.innerCnt = int.parse(innerCntCtl.text);
    ruinData?.targetShipUserCnt = int.parse(targetCntCtl.text);
  }

  void setRuinCtls() {
    if (ruinData != null) {
      numberCtl.text = ruinData?.number ?? '';
      ruinOwnerTextCtl.text = ruinData?.ruinOwnerName ?? '';
      outerCntCtl.text = "${ruinData?.outerCnt ?? 0}";
      innerCntCtl.text = "${ruinData?.innerCnt ?? 0}";
      middleCntCtl.text = "${ruinData?.middleCnt ?? 0}";
      targetCntCtl.text = "${ruinData?.targetShipUserCnt ?? 0}";
    }
  }
}
