// 游戏角色管理页
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';
import 'package:milkwayshipapp/modules/ships/shipuser_list_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/apps.dart';
import '../../core/custome_table_field.dart';

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
            // Row(children: [
            //   Expanded(
            //     child: Container(
            //       height: 100,
            //       // width: double.infinity,
            //       padding: const EdgeInsets.all(16.0),
            //       color: Colors.black12,
            //       child: const Text("您的身份是: 管理员, 您可对角色审核、禁用、设置管理员"),
            //     ),
            //   )
            // ]),
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
                        child: getTableHead(
                          ["角色", "用户", "微信昵称", "所属势力", "势力职务", "角色状态"],
                          [5, 3, 3, 3, 3, 3],
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
                                          flex: 5,
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
                                                controller.reload();
                                              }
                                            },
                                            child: Text(
                                              tempUser?.mksName ?? "",
                                              style: const TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            tempUser?.user?.displayName ?? "",
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            tempUser?.user?.wechatName ?? "",
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                              tempUser?.region?.name ?? ""),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                              tempUser?.regionsRoleName ?? ""),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child:
                                              Text(tempUser?.statusName ?? ""),
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
