import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
                          const SizedBox(height: 24),
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
                                          "势力人数: ${ctl.regionData?.shipUsers?.length}"),
                                    ),
                                    Expanded(
                                      child: Text(
                                          "司令: ${ctl.regionData?.commander ?? ''}"),
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
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(6),
                            child: const Text(
                              "势力简介",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Container(
                            color: Colors.black12,
                            height: 100,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "     ${ctl.regionData?.desc ?? ''}"),
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
                              "势力人员",
                              style: TextStyle(fontSize: 16),
                            ),
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
                                      // height: 50,
                                      padding: const EdgeInsets.only(left: 6),
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black, width: 1),
                                        ),
                                      ),
                                      child: Row(
                                        children: const [
                                          Expanded(
                                            child: Text("角色名"),
                                          ),
                                          Expanded(
                                            child: Text("用户名"),
                                          ),
                                          Expanded(
                                            child: Text("微信昵称"),
                                          ),
                                          Expanded(
                                            child: Text("群昵称"),
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
                                                ShipUserModel? tmp = controller
                                                    .regionData
                                                    ?.shipUsers?[index];
                                                return Container(
                                                  height: 50,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6),
                                                  decoration:
                                                      const BoxDecoration(
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
                                                        child: InkWell(
                                                          // onTap: () {
                                                          //   Get.toNamed(
                                                          //     AppRoute.regionOptionsPage,
                                                          //     parameters: {
                                                          //       'regionId': tempUser['id']
                                                          //     },
                                                          //   );
                                                          // },
                                                          child: Text(
                                                            tmp?.mksName ?? "",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(tmp?.user
                                                                ?.displayName ??
                                                            ""),
                                                      ),
                                                      Expanded(
                                                        child: Text(tmp?.user
                                                                ?.wechatName ??
                                                            ""),
                                                      ),
                                                      Expanded(
                                                        child: Text(tmp?.user
                                                                ?.wcqName ??
                                                            ""),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            tmp?.regionsRoleName ??
                                                                ""),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              itemCount: controller.regionData
                                                  ?.shipUsers?.length,
                                            )
                                          : const Text("暂无数据"),
                                    ),
                                    const SizedBox(height: 200),
                                  ]),
                            ),
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
