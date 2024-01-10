// 游戏角色管理页
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/ship_cornucopia_model.dart';
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
          // title: const Text(
          //   '返回首页',
          //   style: TextStyle(fontSize: 14),
          // ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Container(
              height: 70 + 80 * controller.userDataLength,
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
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: Text("您在本势力的角色:"),
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      ShipUserModel? shipUser =
                          controller.cornucopiaInfos?.shipUserData?[index];
                      return Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.black38, // 顶部边框颜色
                              width: 1.0, // 顶部边框宽度
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text("角色: ${shipUser?.mksName}"),
                                ),
                                Expanded(
                                  child: Text(
                                      "职务: ${shipUser?.regionsRole ?? ''}"),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                  "上次开盆时间: ${shipUser?.lastOpenRegionTime ?? ''}"),
                            ),
                            Expanded(
                              child: Text(
                                  "上次参盆时间: ${shipUser?.lastJoinRegionTime ?? ''}"),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                      "是否需参盆: ${shipUser?.needCornucopia}"),
                                ),
                                Expanded(
                                  child:
                                      Text("是否可开盆: ${shipUser?.canCornucopia}"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
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
            SizedBox(
              height: 8,
            ),
            Container(
              height: 20,
              alignment: Alignment.centerLeft,
              child: Text("本势力需参盆角色:"),
            ),
            Expanded(
              child: Column(
                // scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    height: 50,
                    color: Colors.blue[200],
                    // decoration: const BoxDecoration(
                    //   border: Border(
                    //     bottom: BorderSide(color: Colors.black, width: 1),
                    //   ),
                    // ),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text("角色名"),
                        ),
                        Expanded(
                          child: Text("用户名"),
                        ),
                        Expanded(
                          child: Text("角色身份"),
                        ),
                        Expanded(
                          child: Text("角色状态"),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: controller.needCorcuCnt > 0
                        ? ListView.builder(
                            itemBuilder: (ctx, index) {
                              ShipUserModel? tempUser = controller
                                  .cornucopiaInfos
                                  ?.needCorcuShipUserList?[index];
                              // String? username = tempUser["用户名"];
                              return Container(
                                height: 20,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 1),
                                  ),
                                ),
                                // padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(tempUser?.mksName as String),
                                    ),
                                    Expanded(
                                      child: Text(tempUser?.user?.displayName
                                          as String),
                                    ),
                                    Expanded(
                                      child:
                                          Text(tempUser?.regionsRole as String),
                                    ),
                                    Expanded(
                                      child: Text(tempUser?.status as String),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: controller.needCorcuCnt,
                          )
                        : Container(
                            height: 20,
                            child: Text("暂无数据"),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 20,
              alignment: Alignment.centerLeft,
              child: Text("本势力可开盆角色:"),
            ),
            Expanded(
              child: Column(
                // scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    height: 50,
                    color: Colors.blue[200],
                    // decoration: const BoxDecoration(
                    //   border: Border(
                    //     bottom: BorderSide(color: Colors.black, width: 1),
                    //   ),
                    // ),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text("角色名"),
                        ),
                        Expanded(
                          child: Text("用户名"),
                        ),
                        Expanded(
                          child: Text("角色身份"),
                        ),
                        Expanded(
                          child: Text("角色状态"),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: controller.canCorcuCnt > 0
                        ? ListView.builder(
                            itemBuilder: (ctx, index) {
                              ShipUserModel? tempUser = controller
                                  .cornucopiaInfos
                                  ?.canOpenCorcuShipUserList?[index];
                              // String? username = tempUser["用户名"];
                              return Container(
                                height: 20,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 1),
                                  ),
                                ),
                                // padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(tempUser?.mksName as String),
                                    ),
                                    Expanded(
                                      child: Text(tempUser?.user?.displayName
                                          as String),
                                    ),
                                    Expanded(
                                      child:
                                          Text(tempUser?.regionsRole as String),
                                    ),
                                    Expanded(
                                      child: Text(tempUser?.status as String),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: controller.canCorcuCnt,
                          )
                        : Container(
                            height: 20,
                            child: Text("暂无数据"),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 20,
              alignment: Alignment.centerLeft,
              child: Text("本势力开盆计划:"),
            ),
            Expanded(
              child: Column(
                // scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    height: 50,
                    color: Colors.blue[200],
                    // decoration: const BoxDecoration(
                    //   border: Border(
                    //     bottom: BorderSide(color: Colors.black, width: 1),
                    //   ),
                    // ),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text("盆编号"),
                        ),
                        Expanded(
                          child: Text("游戏角色"),
                        ),
                        Expanded(
                          child: Text("计划开盆时间"),
                        ),
                        Expanded(
                          child: Text("计划创建时间"),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: controller.toCorcuCnt > 0
                        ? ListView.builder(
                            itemBuilder: (ctx, index) {
                              ShipCornucopiaModel? tempObj = controller
                                  .cornucopiaInfos?.toOpenCorcuDataList?[index];
                              // String? username = tempUser["用户名"];
                              return Container(
                                height: 20,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 1),
                                  ),
                                ),
                                // padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(tempObj?.number as String),
                                    ),
                                    Expanded(
                                      child: Text(
                                          tempObj?.shipuser?.mksName as String),
                                    ),
                                    Expanded(
                                      child: Text(tempObj?.scheduleTime
                                          .toString() as String),
                                    ),
                                    Expanded(
                                      child: Text(tempObj?.createdTime
                                          .toString() as String),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: controller.toCorcuCnt,
                          )
                        : Container(
                            height: 20,
                            child: Text("暂无数据"),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 20,
              alignment: Alignment.centerLeft,
              child: Text("本势力进行中的盆:"),
            ),
            Expanded(
              child: Column(
                // scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    height: 50,
                    color: Colors.blue[200],
                    // decoration: const BoxDecoration(
                    //   border: Border(
                    //     bottom: BorderSide(color: Colors.black, width: 1),
                    //   ),
                    // ),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text("盆编号"),
                        ),
                        Expanded(
                          child: Text("游戏角色"),
                        ),
                        Expanded(
                          child: Text("计划开盆时间"),
                        ),
                        Expanded(
                          child: Text("计划创建时间"),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: controller.processingCorcuCnt > 0
                        ? ListView.builder(
                            itemBuilder: (ctx, index) {
                              ShipCornucopiaModel? tempObj = controller
                                  .cornucopiaInfos
                                  ?.processingCorcuDataList?[index];
                              // String? username = tempUser["用户名"];
                              return Container(
                                height: 20,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 1),
                                  ),
                                ),
                                // padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(tempObj?.number as String),
                                    ),
                                    Expanded(
                                      child: Text(
                                          tempObj?.shipuser?.mksName as String),
                                    ),
                                    Expanded(
                                      child: Text(tempObj?.scheduleTime
                                          .toString() as String),
                                    ),
                                    Expanded(
                                      child: Text(tempObj?.createdTime
                                          .toString() as String),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: controller.processingCorcuCnt,
                          )
                        : Container(
                            height: 20,
                            child: Text("暂无数据"),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
