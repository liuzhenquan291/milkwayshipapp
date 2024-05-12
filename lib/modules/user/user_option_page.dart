// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/models/ship_user_model.dart';
import '../../modules/user/user_option_controller.dart';

class UserOptionPage extends GetView<UserOptionController> {
  String? userId;

  UserOptionPage({
    Key? key,
    userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserOptionController>(builder: (ctl) {
      return WillPopScope(
        onWillPop: () async {
          Get.back(result: true);
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('用户详情'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(height: 24),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(6),
                child: const Text(
                  "用户信息",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                height: 125,
                padding: const EdgeInsets.all(10),
                color: Colors.black12,
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child:
                              Text("账        号:   ${ctl.userData?.username}"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                              "昵        称:   ${ctl.userData?.displayName}"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child:
                              Text("微信昵称:   ${ctl.userData?.wechatName ?? ''}"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child:
                              Text("群  昵  称:   ${ctl.userData?.wcqName ?? ''}"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child:
                              Text("用户状态:   ${ctl.userData?.statusName ?? ''}"),
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
                  "游戏角色",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                child: SmartRefresher(
                  controller: ctl.refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: () async {},
                  child: Column(children: [
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
                            child: Text("角色名"),
                          ),
                          Expanded(
                            child: Text("势力名"),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text("势力编号"),
                          ),
                          Expanded(
                            child: Text("司令"),
                          ),
                          Expanded(
                            child: Text("职务"),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ctl.hasUser
                          ? ListView.builder(
                              itemBuilder: (ctx, index) {
                                ShipUserModel? tempUser =
                                    ctl.userData?.shipUsers?[index];
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
                                        child: Text(
                                          tempUser?.mksName ?? "",
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        // ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          tempUser?.region?.name ?? "",
                                        ),
                                        // child: Container(
                                        //   child: Text(tempUser["用户昵称"]),
                                        // ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          tempUser?.region?.number ?? "",
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          tempUser?.region?.commander
                                                  ?.mksName ??
                                              "",
                                        ),
                                        // child: Container(
                                        //   child: Text(tempUser["用户状态"]),
                                        // ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          tempUser?.regionsRoleName ?? "",
                                        ),
                                        // child: Container(
                                        //   child: Text(tempUser["用户状态"]),
                                        // ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: ctl.userData?.shipUsers?.length,
                            )
                          : const Text("暂无数据"),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 200,
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: ctl.validOptions.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5, // 交叉轴方向上的间距
                    childAspectRatio: 4,
                    mainAxisSpacing: 5, // 主轴方向上的间距
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final option = ctl.validOptions[index];
                    return ElevatedButton(
                      onPressed: () async {
                        ctl.onOption(option);
                      },
                      child: Text(option.name ?? ""),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
