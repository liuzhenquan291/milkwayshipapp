// 游戏角色管理页
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';
import 'package:milkwayshipapp/modules/ships/shipuser_list_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/apps.dart';

class ShipuserListPage extends GetView<ShipuserListController> {
  const ShipuserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShipuserListController>(builder: (ctl) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('角色列表'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Row(children: [
              Expanded(
                child: Container(
                  height: 100,
                  // width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.black12,
                  child: const Text("您的身份是: 管理员, 您可对角色审核、禁用、设置管理员"),
                ),
              )
            ]),
            const SizedBox(height: 16),
            Row(
              children: const [
                Text(
                  "游戏角色列表",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.0, // 设置字体大小为20
                    fontWeight: FontWeight.bold, // 设置字体粗细
                  ),
                ),
              ],
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
                        height: 50,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text("用户"),
                              // child: Container(

                              // ),
                            ),
                            Expanded(
                              child: Text("微信昵称"),
                              // child: Container(
                              //   child: Text("用户昵称"),
                              // ),
                            ),
                            Expanded(
                              child: Text("角色"),
                              // child: Container(
                              //   child: Text("微信昵称"),
                              // ),
                            ),
                            Expanded(child: Text("所属势力")),
                            Expanded(child: Text("势力职务")),
                            Expanded(
                              child: Text("角色状态"),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ctl.hasUsers
                            ? ListView.builder(
                                itemBuilder: (ctx, index) {
                                  ShipUserModel? tempUser =
                                      ctl.shipUsers?[index];
                                  // String? username = tempUser["用户名"];
                                  return Container(
                                    height: 50,
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
                                            onTap: () async {
                                              bool result = await Get.toNamed(
                                                AppRoute.shipUserOptionsPage,
                                                parameters: {
                                                  'shipuser_id':
                                                      tempUser?.id ?? "",
                                                },
                                              );
                                              if (result == true) {
                                                controller.loadData();
                                              }
                                            },
                                            child: Text(
                                              tempUser?.user?.displayName ?? "",
                                              style: const TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            tempUser?.user?.wechatName ?? "",
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            tempUser?.mksName ?? "",
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                              tempUser?.region?.name ?? ""),
                                        ),
                                        Expanded(
                                          child: Text(
                                              tempUser?.regionsRoleName ?? ""),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: ctl.shipUsers?.length ?? 0,
                              )
                            : const Text("暂无数据"),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      );
    });
  }
}
