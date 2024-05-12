import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/auth.dart';
import '../../asserts/imgs.dart';
import '../../core/apps.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService as = Get.find<AuthService>();

    final menuList = [
      {
        "title": "账号信息",
        "app": AppRoute.userEditPage,
      },
      {
        "title": "势力信息",
        "app": AppRoute.regionPage,
      },
      {
        "title": "角色信息",
        "app": AppRoute.shipUserPage,
      },
      {
        "title": "聚宝盆信息",
        "app": AppRoute.cornucopiaSelfPage,
      },
      {
        "title": "设置",
        "app": AppRoute.settingsPage,
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
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset(
                  Imgs.avatar,
                ),
              ),
              Container(
                width: 200,
                height: 50,
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10),
                // child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${as.displayName}, 您好!",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "登录账号: ${as.username}",
                      style: const TextStyle(fontSize: 16),
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
              Map<String, dynamic> tempUser = menuList[index];
              return Column(
                children: [
                  Container(
                    height: 70,
                    padding: const EdgeInsets.only(left: 10),
                    color: Colors.black12,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                tempUser['app'],
                                parameters: {'isSelf': 'true'},
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
            itemCount: menuList.length,
          )),
        ],
      ),
    );
  }
}
