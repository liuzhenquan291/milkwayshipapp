import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/auth.dart';
import '../../core/urls.dart';
import '../../core/server.dart';
import '../../core/custom_option_widget.dart';
import '../../core/models/ship_user_model.dart';

class ShipUserEditController extends GetxController {
  final TextEditingController mskNameCtl = TextEditingController();
  final TextEditingController shipUserTypeCtl = TextEditingController();
  final TextEditingController swordCtl = TextEditingController();

  String? shipUserId;
  bool canEdit = false;
  ShipUserModel? shipUserData;
  final RefreshController refreshController = RefreshController();
  final auu = Get.find<AuthService>();

  Timer? _timer;

  bool joinTimerIsEditing = false;
  bool openTimerIsEditing = false;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  // 展示时倒计时使用
  int jd1 = 0;
  int jh1 = 0;
  int jm1 = 0;
  int js1 = 0;
  int od1 = 0;
  int oh1 = 0;
  int om1 = 0;
  int os1 = 0;

  //// 编辑时使用
  // 距收盆还有
  int? jd = 0;
  List<int> jdNums = List.generate(7, (index) => index);
  int? jh = 0;
  List<int> jhNums = List.generate(24, (index) => index);
  int? jm = 0;
  List<int> jmNums = List.generate(60, (index) => index);

  // 距可开盆还有
  int? od = 0;
  List<int> odNums = List.generate(30, (index) => index);
  int? oh = 0;
  List<int> ohNums = List.generate(24, (index) => index);
  int? om = 0;
  List<int> omNums = List.generate(60, (index) => index);

  void setJd(int? _jd) {
    jd = _jd;
    update();
    return;
  }

  void setJh(int? _jh) {
    jh = _jh;
    update();
  }

  void setJm(int? _jm) {
    jm = _jm;
    update();
  }

  void setod(int? _jd) {
    od = _jd;
    update();
    return;
  }

  void setoh(int? _jh) {
    oh = _jh;
    update();
  }

  void setom(int? _jm) {
    om = _jm;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    mskNameCtl.dispose();
    shipUserTypeCtl.dispose();
    swordCtl.dispose();
  }

  // 开始编辑时, 将倒计时的数据设置到编辑框
  void startEditingOpen() {
    if (joinTimerIsEditing) {
      Get.defaultDialog(
        title: "请先完成参盆时间的编辑!",
        textCancel: "返回",
        middleText: "",
      );
    } else {
      openTimerIsEditing = true;
      setod(od1);
      setoh(oh1);
      setom(om1);
      update();
    }
  }

  Future<bool> confirmEditingOpen() async {
    setJd(jd1);
    setJh(jh1);
    setJm(jm1);
    final result = await onOptionUpdateByRemainTime();
    if (result) {
      await reloadData();
    }
    return result;
  }

  void cancelEditingOpen() {
    openTimerIsEditing = false;
    update();
  }

  // 开始编辑时, 将倒计时的数据设置到编辑框
  void startEditingJoin() {
    if (openTimerIsEditing) {
      Get.defaultDialog(
        title: "请先完成开盆时间的编辑!",
        textCancel: "返回",
        middleText: "",
      );
    } else {
      joinTimerIsEditing = true;
      setJd(jd1);
      setJh(jh1);
      setJm(jm1);
      update();
    }
  }

  Future<bool> confirmEditingJoin() async {
    setod(od1);
    setoh(oh1);
    setom(om1);
    final result = await onOptionUpdateByRemainTime();
    if (result) {
      await reloadData();
    }
    return result;
  }

  void cancelEditingJoin() {
    joinTimerIsEditing = false;
    update();
  }

  Future<void> reloadData() async {
    canEdit = false;
    joinTimerIsEditing = false;
    openTimerIsEditing = false;
    jd1 = 0;
    jh1 = 0;
    jm1 = 0;
    js1 = 0;
    od1 = 0;
    oh1 = 0;
    om1 = 0;
    os1 = 0;
    _loadData();
    canEdit = false;
    update();
  }

  Future<void> _loadData() async {
    final apiService = ApiService();
    shipUserId = Get.parameters['shipUserId'];
    final url = sprintf(apiUrl.shipUserRetriveUpdateDestroyPath, [shipUserId]);
    final response = await apiService.getRequest(url, null);

    final responseData = ResponseData.fromJson(response.data);

    if (responseData.data != null) {
      shipUserData = ShipUserModel.fromJson(responseData.data);

      if (shipUserData?.userId == auu.userId) {
        canEdit = true;
      } else if (Get.find<AuthService>().isManager()) {
        canEdit = true;
      }

      mskNameCtl.text = shipUserData?.mksName ?? "";
      shipUserTypeCtl.text = shipUserData?.typeName ?? "";
      swordCtl.text = "${shipUserData?.sword ?? 0}";

      // 初始化计时器
      int toJoin = shipUserData?.toJoinSeconds ?? 0;
      int toOpen = shipUserData?.toOpenSeconds ?? 0;

      jd1 = toJoin ~/ (24 * 60 * 60);
      int remainingSeconds = toJoin % (24 * 60 * 60);
      jh1 = remainingSeconds ~/ (60 * 60);
      remainingSeconds %= (60 * 60);
      jm1 = remainingSeconds ~/ 60;
      js1 = remainingSeconds % 60;

      od1 = toOpen ~/ (24 * 60 * 60);
      remainingSeconds = toOpen % (24 * 60 * 60);
      oh1 = remainingSeconds ~/ (60 * 60);
      remainingSeconds %= (60 * 60);
      om1 = remainingSeconds ~/ 60;
      os1 = remainingSeconds % 60;

      _timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
        if (js1 > 0) {
          js1--;
        } else if (jm1 > 0) {
          js1 = 59;
          jm1--;
        } else if (jh1 > 0) {
          js1 = 59;
          jm1 = 59;
          jh1--;
        } else if (jd1 > 0) {
          jh1 = 23;
          jm1 = 59;
          js1 = 59;
          jd1--;
        } else {}
        if (os1 > 0) {
          os1--;
        } else if (om1 > 0) {
          os1 = 59;
          om1--;
        } else if (oh1 > 0) {
          os1 = 59;
          om1 = 59;
          oh1--;
        } else if (od1 > 0) {
          oh1 = 23;
          om1 = 59;
          os1 = 59;
          od1--;
        } else {}
        update();
      });
    }

    update();
  }

  Future<bool> onOptionUpdateByRemainTime() async {
    final payload = {
      'ship_user_id': shipUserData?.id,
      'updated_time': shipUserData?.updatedTime,
      "join_remain_days": jd,
      "join_remain_hours": jh,
      "join_remain_minutes": jm,
      "open_remain_days": od,
      "open_remain_hours": oh,
      "open_remain_minutes": om,
    };
    final result = await customePostOption(
      "设置聚宝盆时间信息",
      apiUrl.setCornInfoByRemain,
      payload,
    );
    // print(result);
    if (result == true) {
      await reloadData();
    }
    return result;
  }

  Future<bool> onUpdateBasic() async {
    Map<String, dynamic> myPayload = {};
    myPayload["ship_user_id"] = shipUserId;
    myPayload["updated_time"] = shipUserData?.updatedTime;
    myPayload['mks_name'] = mskNameCtl.text;
    myPayload['type_name'] = shipUserTypeCtl.text;
    myPayload['sword'] = swordCtl.text;
    final res = await customePostOption(
      "更新角色基本信息",
      apiUrl.setShipUserBasic,
      myPayload,
    );
    return res;
  }
}
