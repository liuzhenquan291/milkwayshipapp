import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../asserts/imgs.dart';
import '../../core/apps.dart';
import '../login/global_controller.dart';

class InstructionPage extends StatefulWidget {
  InstructionPage({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _InstructionState();
  }
}

class _InstructionState extends State<InstructionPage> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    final GlobalController gc = Get.find<GlobalController>();
    String userDisplayName = gc.userDisplayName.value;

    List<Map<String, String>> grandItems = [
      {
        "title": "用户\n管理",
        "app": appRoute.userPage,
      },
      {
        "title": "势力\n管理",
        "app": appRoute.regionPage,
      },
      {
        "title": "角色\n管理",
        "app": appRoute.shipUserPage,
      },
      {
        "title": "聚宝\n  盆",
        "app": appRoute.cornucopiaPage,
      },
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('$userDisplayName, 您好!'),
      ),
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Row(
              children: [
                const Text(
                  "氪矿刷新时间",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.0, // 设置字体大小为20
                    fontWeight: FontWeight.bold, // 设置字体粗细
                  ),
                ),
              ],
            ),
            Image.asset(
              Imgs.krImg,
              width: 400,
              height: 600,
              // 你可以根据需要设置其他属性，比如fit、alignment等
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.emoji_people),
            icon: Icon(Icons.business),
            label: '势力',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: '攻略',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        // unse: Colors.black,
        onTap: (index) {
          // 处理底部导航栏点击事件
          setState(() {
            // 不更新状态
            if (_currentIndex == index) {
              return;
            }

            _currentIndex = index;

            if (_currentIndex == 0) {
              Get.offAllNamed(appRoute.rootPage);
            } else if (_currentIndex == 1) {
              Get.offAllNamed(appRoute.regionDetailPage);
            } else if (_currentIndex == 2) {
              Get.offAllNamed(appRoute.instructionPage);
            } else if (_currentIndex == 3) {
              Get.offAllNamed(appRoute.accountInfoPage);
            }
          });
        },
      ),
    );
  }
}
