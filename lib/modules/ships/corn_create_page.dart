// 创建开盆计划
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

import 'corn_create_controller.dart';

class CreateCornucopiaPage extends GetView<CornCreateController> {
  String? shipuserId;
  CreateCornucopiaPage({
    Key? key,
    shipUserId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CornCreateController>(builder: (ctl) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('创建开盆计划'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text("要开盆角色:   ${ctl.shipUserData?.mksName}"),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Text(
                //           "游戏uuid:   ${ctl.shipUserData?.mksUuid ?? '暂未支持'}"),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Expanded(
                      child: Text("角色状态:   ${ctl.shipUserData?.statusName}"),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Text("所属势力:   ${ctl.shipUserData?.region?.name}"),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const Text("计划开盆时间:"),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        DatePicker.showDateTimePicker(
                          context,
                          showTitleActions: true,
                          locale: LocaleType.zh,
                          onChanged: (time) {
                            ctl.setTime(time.toString());
                          },
                          onConfirm: (time) {
                            // Update state when time is confirmed
                            ctl.tc.selectTime(time);
                          },
                          currentTime: DateTime.now(),
                        );
                      },
                      child: Text("${ctl.time}"),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text("自己是否加入?:"),
                    const SizedBox(width: 20),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: ctl.join,
                        items: ctl.options
                            .map((option) => DropdownMenuItem(
                                  value: option,
                                  child: Text(option),
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          ctl.setSelfJoin(newValue);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    ctl.onCreate();
                  },
                  child: const Text(
                    '确认创建开盆计划',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
