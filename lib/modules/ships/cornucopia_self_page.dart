import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';
import 'cornucopia_self_controller.dart';

class CornucopiaSelfPage extends GetView<CornucopiaSelfController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CornucopiaSelfController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Column(children: [
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: controller.dataLength > 0
                ? ListView.builder(
                    itemBuilder: (ctx, index) {
                      ShipUserModel tempUser = controller.shipUsers![index];
                      // String? username = tempUser["用户名"];
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 8),
                            alignment: Alignment.centerLeft,
                            height: 20,
                            color: Colors.blue[50],
                            child: Text("角色${index + 1}: "),
                          ),
                          Container(
                            height: 230,
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "账        号:   ${tempUser.user?.username}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "昵        称:   ${tempUser.user?.displayName}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "微信昵称:   ${tempUser.user?.wechatName ?? ''}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "群  昵  称:   ${tempUser.user?.wcqName ?? ''}"),
                                    ),
                                  ],
                                ),
                                // 角色信息
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "角  色  名:   ${tempUser.mksName}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "所属势力:   ${tempUser.region?.name ?? ''}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "可  开  盆:   ${tempUser.canCornucopia ? '是' : '否'}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "需  参  盆:   ${tempUser.needCornucopia ? '是' : '否'}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "可开盆时间:   ${tempUser.canCornucopiaTime}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "需参盆时间:   ${tempUser.needCornucopiaTime}"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: controller.dataLength,
                  )
                : const SizedBox(
                    height: 16,
                    child: Text('暂无数据'),
                  ),
          ),
        ]),
      );
    });
  }
}
