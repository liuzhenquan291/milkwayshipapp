// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/apps.dart';
import '../../core/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  // final TextEditingController usernameController = TextEditingController();

  // 添加 key 参数
  // HomePage() {
  //   _checkLoginStatus();
  // }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> grandItems = [
      {
        "title": "用户\n管理",
        "app": AppRoute.userPage,
      },
      {
        "title": "势力\n管理",
        "app": AppRoute.regionPage,
      },
      {
        "title": "角色\n管理",
        "app": AppRoute.shipUserPage,
      },
      {
        "title": "聚宝\n  盆",
        "app": AppRoute.cornucopiaPage,
      },
      {
        "title": "废墟\n管理",
        "app": AppRoute.ruinPage,
      },
      {
        "title": "部门\n议程",
        "app": AppRoute.departalPage,
      }
    ];
    // List<String> scrollMessages = [
    //   "喜报: 醉花荫正式更名龍魂: 因规模扩大, 醉花荫...",
    //   "震惊: 大帝在龙虎山钓出前年王八...",
    //   "恶搞: 机器人大战黑熊怪最后自己怀孕了...",
    //   "喜报: 恐虐、凯文两位大佬双双晋级8强",
    // ];

    // Get.find<MarqueeController>().updateMessages(scrollMessages);

    final au = Get.find<AuthService>();
    final userRole = au.userRole;
    if (userRole == 'root') {
      grandItems.add({
        "title": "赛季\n管理",
        "app": AppRoute.seasonPage,
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        // padding: EdgeInsets.all(2.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Row(
              children: const [
                Text(
                  "全部应用",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.0, // 设置字体大小为20
                    fontWeight: FontWeight.bold, // 设置字体粗细
                  ),
                ),
              ],
            ),
            Container(
              height: 400,
              padding: const EdgeInsets.all(6.0),
              color: Colors.indigo[300],
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: grandItems.length,
                itemBuilder: (context, index) {
                  Map<String, String> item = grandItems[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(item['app'] as String);
                    },
                    child: Container(
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          grandItems[index]['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
