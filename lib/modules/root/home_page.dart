import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/login/global_controller.dart';

import '../../components/marquee.dart';
import '../../core/apps.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  final TextEditingController usernameController = TextEditingController();

  // 添加 key 参数
  // HomePage() {
  //   _checkLoginStatus();
  // }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final GlobalController gc = Get.find<GlobalController>();
    String userDisplayName = gc.userDisplayName as String;

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
    // List<String> scrollMessages = [
    //   "喜报: 醉花荫正式更名龍魂: 因规模扩大, 醉花荫...",
    //   "震惊: 大帝在龙虎山钓出前年王八...",
    //   "恶搞: 机器人大战黑熊怪最后自己怀孕了...",
    //   "喜报: 恐虐、凯文两位大佬双双晋级8强",
    // ];

    // Get.find<MarqueeController>().updateMessages(scrollMessages);

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
              color: Colors.indigo[300],
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
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
            // Container(
            //   child: GetBuilder<MarqueeController>(
            //     init: MarqueeController(),
            //     builder: (controller) {
            //       return SingleChildScrollView(
            //         scrollDirection: Axis.vertical,
            //         // controller: controller.scrollController,
            //         child: Column(
            //           children: controller.messages
            //               .map((message) => Padding(
            //                   padding: EdgeInsets.symmetric(horizontal: 16.0),
            //                   child: Row(
            //                     children: [
            //                       Text(
            //                         textAlign: TextAlign.left,
            //                         "${message.substring(0, message.length > 17 ? 17 : message.length)}...",
            //                         style: TextStyle(fontSize: 20.0),
            //                       ),
            //                     ],
            //                   )))
            //               .toList(),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
