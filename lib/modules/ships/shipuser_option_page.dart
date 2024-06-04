// ignore_for_file: must_be_immutable

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../modules/ships/shipuser_option_controller.dart';

class ShipUserOptionPage extends GetView<ShipUserOptionController> {
  String? shipUserId;
  ShipUserOptionPage({
    Key? key,
    shipUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShipUserOptionController>(
      builder: (ctl) {
        bool result = false;
        return WillPopScope(
          onWillPop: () async {
            Get.back(result: result);
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            // appBar: AppBar(
            //   automaticallyImplyLeading: false,
            //   title: Text('${ctl.displayName}, 您好!'),
            // ),
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: const Text('角色信息'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(6),
                    child: const Text(
                      "角色信息",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.black12,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "账        号:   ${ctl.shipUserData?.user?.username}"),
                            ),
                            // const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                  "微信昵称:   ${ctl.shipUserData?.user?.wechatName ?? ''}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "角  色  名:   ${ctl.shipUserData?.mksName ?? ''}"),
                            ),
                            Expanded(
                              child: Text(
                                  "所属势力:   ${ctl.shipUserData?.region?.name ?? ''}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "角色类型:   ${ctl.shipUserData?.typeName ?? ''}"),
                            ),
                            Expanded(
                              child: Text(
                                  "战        力:   ${ctl.shipUserData?.swordName ?? ''}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "可  开  盆:   ${ctl.shipUserData?.canCornucopia ?? true ? '是' : '否'}"),
                            ),
                            Expanded(
                              child: Text(
                                  "需  参  盆:   ${ctl.shipUserData?.needCornucopia ?? true ? '是' : '否'}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "可开盆时间:   ${ctl.shipUserData?.canCornucopiaTime ?? ''}"),
                            ),
                            // Expanded(
                            //   child: Text(
                            //       "需参盆时间:   ${ctl.shipUserData?.needCornucopiaTime ?? ''}"),
                            // ),
                          ],
                        ),
                        Row(
                          children: [
                            // Expanded(
                            //   child: Text(
                            //       "可开盆时间:   ${ctl.shipUserData?.canCornucopiaTime ?? ''}"),
                            // ),
                            Expanded(
                              child: Text(
                                  "需参盆时间:   ${ctl.shipUserData?.needCornucopiaTime ?? ''}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "上次开盆时间:   ${ctl.shipUserData?.getLastOpenCornTime()}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "上次参盆时间:   ${ctl.shipUserData?.getLastJoinCornTime()}"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: (ctl.validOptions.length + 1) / 2 * 50 + 10,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: ctl.validOptions.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5, // 交叉轴方向上的间距
                        childAspectRatio: 4,
                        mainAxisSpacing: 5, // 主轴方向上的间距
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final option = ctl.validOptions[index];
                        return ElevatedButton(
                          onPressed: () async {
                            result = await ctl.onOption(option);
                          },
                          child: Text(option.name ?? ""),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
