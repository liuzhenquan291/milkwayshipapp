import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/auth.dart';
import '../../core/apps.dart';
import '../../core/server.dart';
import '../../core/models/user_model.dart';
import '../../core/custome_table_field.dart';
import '../../modules/user/user_list_controller.dart';

const userNameExpandedFlex = 5;
const otherExpandedFlex = 3;

class UserListPage extends GetView<UserListController> {
  final ApiService gc = ApiService();

  UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserListController>(
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('用户列表'),
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
              //       child: Text(
              //           "您的身份是: ${ctl.userRole}, 您可对用户执行${ctl.totalOptions}等操作。"),
              //     ),
              //   )
              // ]),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Text(
                    "用户列表",
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
                            ["序号", "手机号", "微信昵称", "用户状态", "用户身份", "角色数"],
                            [2, 5, 3, 3, 3, 3, 2],
                          ),
                        ),
                        Expanded(
                          child: ctl.hasUser
                              ? ListView.builder(
                                  itemBuilder: (ctx, index) {
                                    UserModel user = ctl.userList[index];
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
                                            flex: 2,
                                            child: InkWell(
                                              onTap: () async {
                                                String userId = user.id;
                                                _tapOnUser(userId);
                                              },
                                              child: Text(
                                                "  ${index + 1}",
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: otherExpandedFlex,
                                          //   child: Text(user.displayName),
                                          // ),
                                          Expanded(
                                            flex: userNameExpandedFlex,
                                            child: Text(user.username),
                                          ),
                                          Expanded(
                                            flex: otherExpandedFlex,
                                            child: Text(user.wechatName),
                                          ),
                                          Expanded(
                                            flex: otherExpandedFlex,
                                            child: Text(
                                              user.statusName,
                                            ),
                                          ),
                                          Expanded(
                                            flex: otherExpandedFlex,
                                            child: Text(user.roleName),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child:
                                                Text("${user.shipUserCount}"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: ctl.userList.length,
                                )
                              : const Text("暂无数据"),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 点击用户名时 跳转
  // 如果点的是自己进入编辑页
  // 如果点的是别人进入用户操作页
  void _tapOnUser(String userId) async {
    final gc = Get.find<AuthService>();
    bool? result = false;
    // if (gc.isManager() || userId != gc.userId) {
    //   result = await Get.toNamed(
    //     AppRoute.userOptionPage,
    //     parameters: {'userId': userId},
    //   );
    // } else {
    //   // 非管理员如果点自己账号只能进编辑页
    //   result = await Get.toNamed(
    //     AppRoute.userEditPage,
    //   );
    // }
    if (userId == gc.userId) {
      result = await Get.toNamed(
        AppRoute.userEditPage,
      );
    } else {
      result = await Get.toNamed(
        AppRoute.userOptionPage,
        parameters: {'userId': userId},
      );
    }
    if (result == true) {
      controller.reloadData();
    }
  }
}
