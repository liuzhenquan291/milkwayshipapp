import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import 'region_join_controller.dart';

class RegoinJoinPage extends GetView<RegionJoinController> {
  RegoinJoinPage({super.key});

  final TextEditingController mskNameCtl = TextEditingController();
  final TextEditingController regionRoleCtl = TextEditingController();
  final TextEditingController typeCtl = TextEditingController();
  final TextEditingController swrodCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegionJoinController>(builder: (ctl) {
      bool result = false;
      return WillPopScope(
        onWillPop: () async {
          Get.back(result: result);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('创建新角色加入势力'),
          ),
          body: ctl.hasRegion
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Row(
                        //   mainAxisSize: MainAxisSize.max,
                        //   children: [
                        //     const Text("请选择要加入的势力: "),
                        //     const SizedBox(width: 20),
                        //     Expanded(
                        //       child: DropdownButtonFormField(
                        //         value: ctl.toJoinRegionId,
                        //         items: ctl.regionDataList
                        //             .map((option) => DropdownMenuItem(
                        //                   value: option.id,
                        //                   child: Text(option.name),
                        //                 ))
                        //             .toList(),
                        //         onChanged: (newValue) {
                        //           ctl.setToJoinRegionId(newValue);
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Text("您要加入的势力是：${ctl.toJoinRegionName}"),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: mskNameCtl,
                          // obscureText: true,
                          decoration: const InputDecoration(
                            labelText: '游戏内角色名：',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: regionRoleCtl,
                          // obscureText: true,
                          decoration: const InputDecoration(
                              labelText: '角色职务', hintText: '司令/副司令/军神/军长/成员'),
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: typeCtl,
                          // obscureText: true,
                          decoration: const InputDecoration(
                              labelText: '角色类型', hintText: '主号/耗兵/副号/谍号/沉号'),
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: swrodCtl,
                          // obscureText: true,
                          decoration: const InputDecoration(
                              labelText: '战力', hintText: '战力'),
                        ),
                        const SizedBox(height: 16.0),
                        // Row(
                        //   children: [
                        //     const Text("上次开盆时间："),
                        //     const SizedBox(width: 10),
                        //     ElevatedButton(
                        //       onPressed: () {
                        //         DatePicker.showDateTimePicker(
                        //           context,
                        //           showTitleActions: true,
                        //           locale: LocaleType.zh,
                        //           onChanged: (time) {
                        //             ctl.setLastOpenTime(formatDateTime_1(time));
                        //           },
                        //           onConfirm: (time) {
                        //             // Update state when time is confirmed
                        //             ctl.timeCtl.selectTime(time);
                        //           },
                        //           currentTime: DateTime.now(),
                        //         );
                        //       },
                        //       child: Text("${ctl.lastOpenTime}"),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 16.0),
                        // Row(
                        //   children: [
                        //     const Text("上次参盆时间："),
                        //     const SizedBox(width: 10),
                        //     ElevatedButton(
                        //       onPressed: () {
                        //         DatePicker.showDateTimePicker(
                        //           context,
                        //           showTitleActions: true,
                        //           locale: LocaleType.zh,
                        //           onChanged: (time) {
                        //             ctl.setLastJoinTime(formatDateTime_1(time));
                        //           },
                        //           onConfirm: (time) {
                        //             // Update state when time is confirmed
                        //             ctl.timeCtl.selectTime(time);
                        //           },
                        //           currentTime: DateTime.now(),
                        //         );
                        //       },
                        //       child: Text("${ctl.lastJoinTime}"),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 32.0),
                        ElevatedButton(
                          onPressed: () async {
                            await ctl.onCreateShipUser(
                              mskNameCtl.text,
                              regionRoleCtl.text,
                              typeCtl.text,
                              swrodCtl.text,
                            );
                            result = true;
                          },
                          child: const Text(
                            '确认创建角色',
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: Text("没有可加入的势力！请联系管理员"),
                ),
        ),
      );
    });
  }
}
