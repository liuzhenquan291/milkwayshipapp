// 游戏角色管理页

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/ship_cornucopia_model.dart';
import 'package:milkwayshipapp/modules/ships/cornucopia_list_controller.dart';

import '../../core/apps.dart';
import '../../core/models/ship_user_model.dart';

class CornucopiaListPage extends GetView<CornucopiaListController> {
  const CornucopiaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CornucopiaListController>(builder: (ctl) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('聚宝盆综合信息'),
          centerTitle: true,
        ),
        body: ctl.hasData
            ? Column(
                children: [
                  const SizedBox(height: 24),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(6),
                    child: const Text(
                      "势力信息",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    height: 100 + 80 * ctl.userDataLength,
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.orange[100],
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "当前势力: ${ctl.cornucopiaInfos?.regionData?.name ?? ''}",
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "势力司令: ${ctl.cornucopiaInfos?.regionData?.commander?.mksName ?? ''}",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 30,
                          alignment: Alignment.centerLeft,
                          child: const Text("您在本势力的角色:"),
                        ),
                        Expanded(
                            child: ListView.builder(
                          itemBuilder: (ctx, index) {
                            ShipUserModel? shipUser =
                                ctl.cornucopiaInfos?.shipUserData?[index];
                            return Container(
                              height: 50,
                              decoration: const BoxDecoration(
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
                                            "职务: ${shipUser?.regionsRoleName ?? ''}"),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Text(
                                        "上次开盆时间: ${shipUser?.lastOpenCornTime ?? ''}"),
                                  ),
                                  Expanded(
                                    child: Text(
                                        "上次参盆时间: ${shipUser?.lastJoinCornTime ?? ''}"),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            "是否需参盆: ${shipUser?.needCornucopia}"),
                                      ),
                                      Expanded(
                                        child: Text(
                                            "是否可开盆: ${shipUser?.canCornucopia}"),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            );
                          },
                          itemCount:
                              ctl.cornucopiaInfos?.shipUserData?.length ?? 0,
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 20,
                    alignment: Alignment.centerLeft,
                    child: const Text("本势力需参盆角色:"),
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
                          child: ctl.needCorcuCnt > 0
                              ? ListView.builder(
                                  itemBuilder: (ctx, index) {
                                    ShipUserModel? tmp = ctl.cornucopiaInfos
                                        ?.needCorcuShipUserList?[index];
                                    // String? username = tmp["用户名"];
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
                                            child: Text(tmp?.mksName as String),
                                          ),
                                          Expanded(
                                            child: Text(tmp?.user?.displayName
                                                as String),
                                          ),
                                          Expanded(
                                            child: Text(
                                                tmp?.regionsRoleName as String),
                                          ),
                                          Expanded(
                                            child:
                                                Text(tmp?.statusName as String),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: ctl.needCorcuCnt,
                                )
                              : const SizedBox(
                                  height: 20,
                                  child: Text("暂无数据"),
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 20,
                    alignment: Alignment.centerLeft,
                    child: const Text("本势力可开盆角色:"),
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
                          child: ctl.canCorcuCnt > 0
                              ? ListView.builder(
                                  itemBuilder: (ctx, index) {
                                    ShipUserModel? tmp = ctl.cornucopiaInfos
                                        ?.canOpenCorcuShipUserList?[index];
                                    // String? username = tmp["用户名"];
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
                                            child: Text(tmp?.mksName as String),
                                          ),
                                          Expanded(
                                            child: Text(tmp?.user?.displayName
                                                as String),
                                          ),
                                          Expanded(
                                            child: Text(
                                                tmp?.regionsRoleName as String),
                                          ),
                                          Expanded(
                                            child: Text(tmp?.status as String),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: ctl.canCorcuCnt,
                                )
                              : const SizedBox(
                                  height: 20,
                                  child: Text("暂无数据"),
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 20,
                    alignment: Alignment.centerLeft,
                    child: const Text("本势力开盆计划:"),
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
                          child: ctl.toCorcuCnt > 0
                              ? ListView.builder(
                                  itemBuilder: (ctx, index) {
                                    ShipCornucopiaModel? tempObj = controller
                                        .cornucopiaInfos
                                        ?.toOpenCorcuDataList?[index];
                                    // String? username = tmp["用户名"];
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
                                            child: InkWell(
                                              onTap: () {
                                                String cornucopiaId =
                                                    tempObj?.id as String;
                                                _tapOnCornucopia(cornucopiaId);
                                              },
                                              child: Text(
                                                tempObj?.number as String,
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(tempObj
                                                ?.shipuser?.mksName as String),
                                          ),
                                          Expanded(
                                            child: Text(
                                                tempObj?.getScheduleTime() ??
                                                    ""),
                                          ),
                                          Expanded(
                                            child: Text(
                                                tempObj?.getCreatedTime() ??
                                                    ""),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: ctl.toCorcuCnt,
                                )
                              : const SizedBox(
                                  height: 20,
                                  child: Text("暂无数据"),
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 20,
                    alignment: Alignment.centerLeft,
                    child: const Text("本势力进行中的盆:"),
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
                          child: ctl.processingCorcuCnt > 0
                              ? ListView.builder(
                                  itemBuilder: (ctx, index) {
                                    ShipCornucopiaModel? tempObj = controller
                                        .cornucopiaInfos
                                        ?.processingCorcuDataList?[index];
                                    // String? username = tmp["用户名"];
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
                                            child:
                                                Text(tempObj?.number as String),
                                          ),
                                          Expanded(
                                            child: Text(tempObj
                                                ?.shipuser?.mksName as String),
                                          ),
                                          Expanded(
                                            child: Text(
                                                tempObj?.getScheduleTime() ??
                                                    ""),
                                          ),
                                          Expanded(
                                            child: Text(
                                                tempObj?.getCreatedTime() ??
                                                    ""),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: ctl.processingCorcuCnt,
                                )
                              : const SizedBox(
                                  height: 20,
                                  child: Text("暂无数据"),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: const [
                  SizedBox(
                    height: 16,
                  ),
                  Text("暂无数据"),
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

  // 点击用户名时 跳转
  // 如果点的是自己进入编辑页
  // 如果点的是别人进入用户操作页
  void _tapOnCornucopia(String cornucopiaId) {
    Get.toNamed(
      AppRoute.cornucopiaOptionPage,
      parameters: {'cornucopiaId': cornucopiaId},
    );
  }
}
