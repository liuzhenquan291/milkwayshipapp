// 创建开盆计划
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/models/ship_cornucopia_model.dart';
import 'corn_join_controller.dart';

class JoinCornPage extends GetView<CornJoinController> {
  String? shipUserId;

  JoinCornPage({
    Key? key,
    shipUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CornJoinController>(builder: (ctl) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('参盆?取消?'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(6),
              child: const Text(
                "角色信息",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              color: Colors.orange[100],
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("当前角色: ${ctl.shipUserData?.mksName}"),
                      ),
                      Expanded(
                        child:
                            Text("创建人: ${ctl.shipUserData?.user?.displayName}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text("势力: ${ctl.shipUserData?.region?.name}"),
                      ),
                      Expanded(
                        child:
                            Text("角色职务: ${ctl.shipUserData?.regionsRoleName}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "上次开盆时间: ${ctl.shipUserData?.lastOpenCornTime}"),
                      ),
                      Expanded(
                        child: Text(
                            "上次参盆时间: ${ctl.shipUserData?.lastJoinCornTime}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child:
                            Text("是否可开盆: ${ctl.shipUserData?.canCornucopia}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child:
                            Text("是否需参盆: ${ctl.shipUserData?.needCornucopia}"),
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
                "可参加聚宝盆",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              child: SmartRefresher(
                controller: ctl.refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () async {
                  // ctl._loadData();
                },
                child: Column(
                  // scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      height: 30,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      child: Row(
                        children: const [
                          Expanded(child: Text("聚宝盆")),
                          Expanded(child: Text("开盆角色")),
                          Expanded(child: Text("创建时间")),
                          Expanded(child: Text("计划开盆时间")),
                          Expanded(child: Text("当前状态")),
                          Expanded(child: Text("操作"))
                        ],
                      ),
                    ),
                    Expanded(
                      child: ctl.hasTojoin
                          ? ListView.builder(
                              itemBuilder: (ctx, index) {
                                ShipCornucopiaModel? corn =
                                    ctl.toJoinCors[index];
                                return Container(
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black26, width: 1),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(corn.number),
                                      ),
                                      Expanded(
                                        child: Text(
                                          corn.shipuser?.mksName ?? "",
                                        ),
                                      ),
                                      Expanded(
                                          child: Text(corn.getCreatedTime())),
                                      Expanded(
                                        child: Text(
                                          corn.getScheduleTime(),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          corn.statusName ?? "",
                                        ),
                                      ),
                                      const Expanded(
                                          child: Text("实现操作")), // TODO
                                    ],
                                  ),
                                );
                              },
                              itemCount: ctl.toJoinCors.length,
                            )
                          : const Text("暂无数据"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(6),
              child: const Text(
                "操作参盆记录",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
                child: SmartRefresher(
                    controller: ctl.refreshController2,
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: () async {
                      // ctl._loadData();
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
                                Expanded(child: Text("聚宝盆")),
                                Expanded(child: Text("开盆角色")),
                                Expanded(child: Text("计划开盆时间")),
                                Expanded(child: Text("申请加入时间")),
                                Expanded(child: Text("当前状态")),
                                Expanded(child: Text("已加入?")),
                                Expanded(child: Text("操作"))
                              ],
                            ),
                          ),
                          Expanded(
                              child: ctl.hasCornRecords
                                  ? ListView.builder(
                                      itemBuilder: (ctx, index) {
                                        ShipCornucopiaModel? recd =
                                            ctl.cornRecords[index];
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
                                                  recd.number,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  recd.shipuser?.mksName ?? "",
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                      recd.getScheduleTime())),
                                              Expanded(
                                                child: Text(
                                                  recd.appliTime ?? "",
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  recd.statusName ?? "",
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  recd.ifMissed ? "已错过" : "已加入",
                                                ),
                                              ),
                                              const Expanded(
                                                child: Text(
                                                  "操作",
                                                ), // TODO
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: ctl.cornRecords.length,
                                    )
                                  : const Text("暂无数据")),
                        ]))),
            const SizedBox(height: 24),
          ],
        ),
      );
    });
  }
}
