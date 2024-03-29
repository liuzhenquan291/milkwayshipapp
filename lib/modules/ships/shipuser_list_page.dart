// 游戏角色管理页
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';
import 'package:milkwayshipapp/modules/ships/shipuser_list_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/apps.dart';
import '../login/global_controller.dart';

class ShipuserListPage extends GetView<ShipuserListController> {
  final GlobalController gc = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    String userDisplayName = gc.userDisplayName as String;
    return GetBuilder<ShipuserListController>(builder: (controller) {
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
                        height: 50,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text("用户"),
                              // child: Container(

                              // ),
                            ),
                            const Expanded(
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
                            Expanded(
                              child: Container(
                                child: Text("所属势力"),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text("势力职务"),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text("角色状态"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: controller.hasUsers
                            ? ListView.builder(
                                itemBuilder: (ctx, index) {
                                  ShipUserModel? tempUser =
                                      controller.shipUsers?[index];
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
                                            onTap: () {
                                              Get.toNamed(
                                                appRoute.shipUserOptionsPage,
                                                parameters: {
                                                  'userId': tempUser?.id ?? "",
                                                },
                                              );
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
                                          child:
                                              Text(tempUser?.regionsRole ?? ""),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: controller.shipUsers?.length ?? 0,
                              )
                            : Container(
                                child: Text("暂无数据"),
                              ),
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
