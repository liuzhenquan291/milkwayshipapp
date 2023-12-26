import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/user/user_option_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/apps.dart';

class UserOptionPage extends GetView<UserOptionController> {
  String? userId;
  UserOptionPage({
    Key? key,
    regionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserOptionController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('${controller.userDisplayName}, 您好!'),
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
              height: 100,
              padding: EdgeInsets.all(10),
              color: Colors.black12,
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "账        号:   ${controller.userData?.username}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "昵        称:   ${controller.userData?.userDisplayName}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "微信昵称:   ${controller.userData?.wechatName ?? ''}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "群  昵  称:   ${controller.userData?.wcqName ?? ''}"),
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
                controller: controller.refreshController,
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
                          child: Text("游戏角色名"),
                        ),
                        Expanded(
                          child: Text("用户名"),
                        ),
                        Expanded(
                          child: Text("微信昵称"),
                        ),
                        Expanded(
                          child: Text("微信群昵称"),
                        ),
                        Expanded(
                          child: Text("职务"),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: controller.hasUser
                        ? ListView.builder(
                            itemBuilder: (ctx, index) {
                              Map<String, dynamic> tempUser =
                                  controller.userData?.shipUsers?[index];
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
                                      // child: InkWell(
                                      //   onTap: () {
                                      //     Get.toNamed(
                                      //       appRoute.userOptionPage,
                                      //       parameters: {
                                      //         'regionId': tempUser['id']
                                      //       },
                                      //     );
                                      //   },
                                      child: Text(
                                        tempUser["游戏角色名"],
                                        style: const TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      // ),
                                    ),
                                    Expanded(
                                      child: Text(tempUser["用户名"]),
                                      // child: Container(
                                      //   child: Text(tempUser["用户昵称"]),
                                      // ),
                                    ),
                                    Expanded(
                                      child: Text(tempUser["微信昵称"]),
                                      // child: Container(
                                      //   child: Text(tempUser["微信昵称"]),
                                      // ),
                                    ),
                                    Expanded(
                                      child: Text(tempUser["微信群昵称"]),
                                      // child: Container(
                                      //   child: Text(tempUser["用户状态"]),
                                      // ),
                                    ),
                                    Expanded(
                                      child: Text(tempUser["职务"]),
                                      // child: Container(
                                      //   child: Text(tempUser["用户状态"]),
                                      // ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: controller.userData?.shipUsers?.length,
                          )
                        : Container(
                            child: Text("暂无数据"),
                          ),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // children: controller.hasOptions
              children: controller.hasOptions
                  ? controller.userData?.options?.map((option) {
                      return ElevatedButton(
                        onPressed: () {
                          // 处理按钮点击事件
                          print('${option['name']} button pressed');
                        },
                        child: Text(option['name'] as String),
                      );
                    }).toList() as List<Widget>
                  : [],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back),
        ),
      );
    });
  }
}
