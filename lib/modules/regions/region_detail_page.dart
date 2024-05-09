import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/custome_table_field.dart';
import '../../core/models/ship_user_model.dart';
import '../../modules/regions/region_detail_congroller.dart';

class RegionDetailPage extends GetView<RegionDetailController> {
  const RegionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegionDetailController>(builder: (ctl) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: ctl.hasRegion
                    ? Column(
                        children: [
                          const SizedBox(height: 12),
                          // Text("您当前所属势力: ${ctl.regionData?.name}"),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              "您当前所属势力: ${ctl.regionData?.name}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Container(
                            color: Colors.black12,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child:
                                          Text("势力名称: ${ctl.regionData?.name}"),
                                    ),
                                    Expanded(
                                      child: Text(
                                          "昵称缩写: ${ctl.regionData?.nameFmt}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "势力人数: ${ctl.regionData?.userCount}"),
                                    ),
                                    Expanded(
                                      child: Text(
                                          "势力司令: ${ctl.regionData?.commander?.mksName ?? ''}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "总角色数: ${ctl.regionData?.shipUsers?.length ?? ''}"),
                                    ),
                                    Expanded(
                                      child: Text(
                                          "藏号数: ${ctl.regionData?.concealCount ?? ''}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "主号数: ${ctl.regionData?.normalCount}"),
                                    ),
                                    Expanded(
                                      child: Text(
                                          "小号数: ${ctl.regionData?.viceCount}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "耗兵数: ${ctl.regionData?.drainCount}"),
                                    ),
                                    Expanded(
                                      child: Text(
                                          "间谍数: ${ctl.regionData?.spyCount}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "当前战区: ${ctl.regionData?.zoneInfo}"),
                                    ),
                                    Expanded(
                                      child: Text(
                                          "当前颜色: ${ctl.regionData?.color ?? ''}"),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "势力简介: ${ctl.regionData?.desc ?? ''}",
                                      // style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // const SizedBox(height: 8),
                          // Container(
                          //   alignment: Alignment.centerLeft,
                          //   padding: const EdgeInsets.all(6),
                          //   child: const Text(
                          //     "势力简介",
                          //     style: TextStyle(fontSize: 16),
                          //   ),
                          // ),
                          // Container(
                          //   color: Colors.black12,
                          //   // height: 100,
                          //   padding: const EdgeInsets.all(10),
                          //   child: Column(
                          //     children: [
                          //       Row(
                          //         children: [
                          //           Expanded(
                          //             child: Text(
                          //                 "     ${ctl.regionData?.desc ?? ''}"),
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          const SizedBox(height: 12),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(6),
                            child: const Text(
                              "势力人员",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Container(
                            // height: 50,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
                            ),
                            child: getTableHead(
                              ["序号", "角色名", "微信昵称", "职务", "类型", "战力"],
                              [2, 4, 3, 3, 3, 3],
                            ),
                          ),
                          Expanded(
                            child: ctl.hasUser
                                ? ListView.builder(
                                    itemBuilder: (ctx, index) {
                                      ShipUserModel? tmp = controller
                                          .regionData?.shipUsers?[index];
                                      return Container(
                                        // height: 20,
                                        // padding: const EdgeInsets.only(
                                        //     left: 6),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black26,
                                                width: 1),
                                          ),
                                        ),
                                        // padding: EdgeInsets.all(20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: InkWell(
                                                // onTap: () {
                                                //   Get.toNamed(
                                                //     AppRoute.regionOptionsPage,
                                                //     parameters: {
                                                //       'regionId': tempUser['id']
                                                //     },
                                                //   );
                                                // },
                                                // child: Text(
                                                //   tmp?.mksName ?? "",
                                                // ),
                                                child: Text(
                                                  "${index + 1}",
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                tmp?.mksName ?? "",
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  tmp?.user?.wechatName ?? ""),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                  tmp?.regionsRoleName ?? ""),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(tmp?.typeName ?? ""),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(tmp?.swordName ?? ""),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: controller
                                        .regionData?.shipUsers?.length,
                                  )
                                : const Text("暂无数据"),
                          ),
                        ],
                      )
                    : Column(
                        children: const [
                          SizedBox(height: 200),
                          Center(
                            child: Text(
                              "您尚未加入任何势力",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                          SizedBox(height: 200),
                        ],
                      ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ctl.listOptions, // 创建势力  加入势力  展示
            ),
          ],
        ),
      );
    });
  }
}
