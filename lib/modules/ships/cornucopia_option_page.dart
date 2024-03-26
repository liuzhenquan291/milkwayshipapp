import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'cornucopia_option_controller.dart';

class CornucopiaOptionPage extends GetView<CornucopiaOptionController> {
  String? cornucopiaId;

  CornucopiaOptionPage({
    Key? key,
    cornucopiaId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CornucopiaOptionController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('聚宝盆详情'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(6),
              child: const Text(
                "聚宝盆信息",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              color: Colors.green[200],
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("开盆计划: ${controller.cornData?.number}"),
                      ),
                      Expanded(
                        child: Text("创建人: ${controller.userData?.displayName}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text("势力: ${controller.regionData?.name}"),
                      ),
                      Expanded(
                        child: Text(
                            "司令: ${controller.regionData?.commander?.mksName ?? ''}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "创建人角色: ${controller.cornData?.shipuser?.mksName ?? ""}"),
                      ),
                      Expanded(
                        child: Text(
                            "角色职务: ${controller.cornData?.shipuser?.regionsRoleName ?? ''}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child:
                            Text("创建时间: ${controller.cornData?.createdTime}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "计划开盆时间: ${controller.cornData?.scheduleTime}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "实际开盆时间: ${controller.cornData?.startTime ?? ''}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "聚宝盆状态: ${controller.cornData?.statusName ?? ''}"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(6),
              child: const Text(
                "已参盆角色",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
                child: SmartRefresher(
                    controller: controller.refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: () async {
                      // controller._loadData();
                    },
                    child: Column(
                        // scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            height: 30,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Expanded(child: Text("用户")),
                                Expanded(child: Text("微信昵称")),
                                Expanded(child: Text("角色")),
                                Expanded(child: Text("职务")),
                              ],
                            ),
                          ),
                          Expanded(
                              child: controller.hasJoined
                                  ? ListView.builder(
                                      itemBuilder: (ctx, index) {
                                        ShipUserModel? tempUser =
                                            controller.joinedShipusers?[index];
                                        return Container(
                                          height: 50,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black26,
                                                  width: 1),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  tempUser?.user?.displayName ??
                                                      "",
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  tempUser?.user?.wechatName ??
                                                      "",
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                      tempUser?.mksName ?? "")),
                                              Expanded(
                                                child: Text(
                                                  tempUser?.regionsRoleName ??
                                                      "",
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount:
                                          controller.joinedShipusers?.length ??
                                              0,
                                    )
                                  : const Text("暂无数据")),
                        ]))),
            const SizedBox(height: 24),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(6),
              child: const Text(
                "自己可参盆角色",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
                child: SmartRefresher(
                    controller: controller.refreshController2,
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: () async {
                      // controller._loadData();
                    },
                    child: Column(
                        // scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            height: 30,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
                            ),
                            child: Row(
                              children: const [
                                Expanded(child: Text("用户")),
                                Expanded(child: Text("微信昵称")),
                                Expanded(child: Text("角色")),
                                Expanded(child: Text("职务")),
                              ],
                            ),
                          ),
                          Expanded(
                              child: controller.hasTojoin
                                  ? ListView.builder(
                                      itemBuilder: (ctx, index) {
                                        ShipUserModel? tempUser =
                                            controller.toJoinShipusers?[index];
                                        return Container(
                                          height: 50,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black26,
                                                  width: 1),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  tempUser?.user?.displayName ??
                                                      "",
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  tempUser?.user?.wechatName ??
                                                      "",
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                      tempUser?.mksName ?? "")),
                                              Expanded(
                                                child: Text(
                                                  tempUser?.regionsRoleName ??
                                                      "",
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount:
                                          controller.toJoinShipusers?.length ??
                                              0,
                                    )
                                  : const Text("暂无数据")),
                        ]))),
            const SizedBox(height: 24),
            const SizedBox(height: 24),
            Container(
              height: 200,
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: controller.validOptions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5, // 交叉轴方向上的间距
                  childAspectRatio: 4,
                  mainAxisSpacing: 5, // 主轴方向上的间距
                ),
                itemBuilder: (BuildContext context, int index) {
                  final option = controller.validOptions[index];
                  return ElevatedButton(
                    onPressed: () {
                      controller.onOption(option);
                    },
                    child: Text(option.name ?? ""),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
