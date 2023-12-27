import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../asserts/imgs.dart';
import '../../core/apps.dart';
import '../login/global_controller.dart';

class AccountPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final gc = Get.find<GlobalController>();

    final MenuList = [
      {
        "title": "账号信息",
        "app": appRoute.userOptionPage,
      },
      {
        "title": "势力信息",
        "app": appRoute.regionOptionsPage,
      },
      {
        "title": "角色信息",
        "app": appRoute.shipUserPage,
      },
      {
        "title": "聚宝盆信息",
        "app": appRoute.cornucopiaPage,
      },
      {
        "title": "设置",
        "app": appRoute.settingsPage,
      }
    ];

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              Container(
                width: 60,
                height: 50,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10),
                child: Image.asset(
                  Imgs.avatar,
                  // 你可以根据需要设置其他属性，比如fit、alignment等
                ),
              ),
              Container(
                width: 200,
                height: 50,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10),
                // child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${gc.userDisplayName}, 您好!",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "登录账号: ${gc.username}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              // ),
            ],
          ),
          const SizedBox(height: 40),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, index) {
              Map<String, dynamic> tempUser = MenuList[index];
              // String? username = tempUser["用户名"];
              return Column(
                children: [
                  Container(
                    height: 70,
                    padding: EdgeInsets.only(left: 10),
                    color: Colors.black12,
                    // decoration: const BoxDecoration(
                    //   border: Border(
                    //     top: BorderSide(color: Colors.black26, width: 1),
                    //     bottom: BorderSide(color: Colors.black26, width: 1),
                    //   ),
                    // ),
                    // padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                tempUser['app'],
                              );
                            },
                            child: Text(
                              tempUser["title"] ?? "",
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),

                        // const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
            itemCount: MenuList.length,
          )),
        ],
      ),
    );
  }
}
