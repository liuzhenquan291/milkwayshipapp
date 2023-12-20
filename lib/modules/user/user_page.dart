import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/user/user_list_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../login/global_controller.dart';

// class UserPage extends StatefulWidget {
//   UserPage({
//     Key? key,
//   }) : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return _UserState();
//   }
// }

class UserPage extends GetView<UserListController> {
  final GlobalController gc = Get.find<GlobalController>();
  // final UserListController ulct = Get.find<UserListController>();

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {});
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   // Get.delete(tag: "user");
  // }

  @override
  Widget build(BuildContext context) {
    String userDisplayName = gc.userDisplayName.value;
    return GetBuilder<UserListController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text('$userDisplayName, 您好!'),
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
                  child: const Text("您的身份是: 管理员, 您可对用户审核、禁用、设置管理员"),
                ),
              )
            ]),
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
                              child: Text("用户名"),
                              // child: Container(

                              // ),
                            ),
                            const Expanded(
                              child: Text("用户昵称"),
                              // child: Container(
                              //   child: Text("用户昵称"),
                              // ),
                            ),
                            Expanded(
                              child: Text("微信昵称"),
                              // child: Container(
                              //   child: Text("微信昵称"),
                              // ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text("用户状态"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: controller.userList.isNotEmpty != false
                            ? ListView.builder(
                                itemBuilder: (ctx, index) {
                                  Map<String, dynamic> tempUser =
                                      controller.userList[index];
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
                                          child: Text(tempUser["用户名"]),
                                          // child: Container(
                                          //   child: Text(tempUser["用户名"]),
                                          // ),
                                        ),
                                        Expanded(
                                          child: Text(tempUser["用户昵称"]),
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
                                          child: Text(tempUser["用户状态"]),
                                          // child: Container(
                                          //   child: Text(tempUser["用户状态"]),
                                          // ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: controller.userList.length,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.offAllNamed('/'); // 返回上一页
          },
          child: Icon(Icons.arrow_back),
        ),
      );
    });
  }
}