// 势力管理页
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/regions/region_list_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/apps.dart';
import '../../core/custome_table_field.dart';
import '../../core/models/region_model.dart';

// class UserPage extends StatefulWidget {
//   UserPage({
//     Key? key,
//   }) : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return _UserState();
//   }
// }

class RegionPage extends GetView<RegionListController> {
  const RegionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegionListController>(builder: (ctl) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('势力列表'),
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
            //       child: const Text("您的身份是: 管理员, 您可对势力审核、禁用、设置管理员"),
            //     ),
            //   )
            // ]),
            const SizedBox(height: 16),
            Row(
              children: const [
                Text(
                  "势力列表",
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
                          ["势力名称", "成员格式", "战区信息", "势力状态"],
                          null,
                        ),
                      ),
                      Expanded(
                        child: ctl.regionList.isNotEmpty != false
                            ? ListView.builder(
                                itemBuilder: (ctx, index) {
                                  RegionModel tmp = ctl.regionList[index];
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
                                          child: InkWell(
                                            onTap: () async {
                                              String regionId = tmp.id;
                                              _tapOnRegion(regionId);
                                            },
                                            child: Text(
                                              tmp.name,
                                              style: const TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(tmp.nameFmt),
                                          // child: Container(
                                          //   child: Text(tempUser["用户昵称"]),
                                          // ),
                                        ),
                                        Expanded(
                                          child: Text(tmp.zoneInfo),
                                          // child: Container(
                                          //   child: Text(tempUser["微信昵称"]),
                                          // ),
                                        ),
                                        Expanded(
                                          child: Text(tmp.statusName),
                                          // child: Container(
                                          //   child: Text(tempUser["用户状态"]),
                                          // ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: ctl.regionList.length,
                              )
                            : const Text("暂无数据"),
                      ),
                    ]),
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   child: Icon(Icons.arrow_back),
        // ),
      );
    });
  }

  // 点击势力是
  void _tapOnRegion(String regionId) async {
    bool? result = false;
    result = await Get.toNamed(
      AppRoute.regionOptionsPage,
      parameters: {'regionId': regionId},
    );
    if (result == true) {
      controller.reloadData();
    }
  }
}
