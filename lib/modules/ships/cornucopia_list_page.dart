// 游戏角色管理页
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/ships/cornucopia_list_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/models/ship_user_model.dart';

class CornucopiaListPage extends GetView<CornucopiaListController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CornucopiaListController>(builder: (controller) {
      return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: Text('${controller.userDisplayName}, 您好!'),
        // ),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          // title: const Text('返回首页'),
        ),
        body: Column(children: [
          SizedBox(
            height: 16,
          ),
          Container(
            height: 100,
            padding: EdgeInsets.all(16.0),
            color: Colors.yellow[100],
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "当前势力: ${controller.cornucopiaInfos?.regionData?.name ?? ''}",
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "势力司令: ${controller.cornucopiaInfos?.regionData?.commander?.mksName ?? ''}",
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    ShipUserModel? shipUser =
                        controller.cornucopiaInfos?.shipUserData?[index];
                    // String? username = tempUser["用户名"];
                    return Container(
                      height: 50,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text("角色: ${shipUser?.mksName ?? ''}"),
                              ),
                              Expanded(
                                child:
                                    Text("职务: ${shipUser?.regionsRole ?? ''}"),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Text(
                                "上次开盆时间: ${shipUser?.lastOpenRegionTime ?? ''}"),
                            // child: Container(
                            //   child: Text(tempUser["微信昵称"]),
                            // ),
                          ),
                          Expanded(
                            child: Text(
                                "上次参盆时间: ${shipUser?.lastJoinRegionTime ?? ''}"),
                            // child: Container(
                            //   child: Text(tempUser["微信昵称"]),
                            // ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child:
                                    Text("是否需参盆: ${shipUser?.needCornucopia}"),
                              ),
                              Expanded(
                                child:
                                    Text("是否可开盆: ${shipUser?.canCornucopia}"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount:
                      controller.cornucopiaInfos?.shipUserData?.length ?? 0,
                )),
              ],
            ),
          ),
          Text("本势力需参盆角色"),
          Container(
            child: Column(),
          ),
          Text("本势力可开盆角色"),
          Container(
            child: Column(),
          ),
          Text("本势力开盆计划"),
          Container(
            child: Column(),
          ),
          Text("本势力进行中的盆"),
          Container(
            child: Column(),
          ),
        ]),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   child: Icon(Icons.arrow_back),
        // ),
      );
    });
  }
}
