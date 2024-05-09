// ignore_for_file: avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/models/ship_user_model.dart';
import 'package:milkwayshipapp/modules/regions/region_options_controller.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/apps.dart';
import '../../core/custome_table_field.dart';

class RegionOptionsPage extends GetView<RegionOptionsController> {
  String? regionId;
  String? isSelf;
  RegionOptionsPage({
    Key? key,
    regionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegionOptionsController>(builder: (ctl) {
      ctl.regionId = regionId;
      return WillPopScope(
        onWillPop: () async {
          Get.back(result: true);
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('势力信息'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(6),
                child: Text(
                  "势力: ${ctl.regionData?.name}",
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
                          child: Text("势力名称: ${ctl.regionData?.name}"),
                        ),
                        Expanded(
                          child: Text("昵称缩写: ${ctl.regionData?.nameFmt}"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child:
                              Text("势力人数: ${ctl.regionData?.userCount ?? ''}"),
                        ),
                        Expanded(
                          child: Text(
                              "司令: ${ctl.regionData?.commander?.mksName ?? ''}"),
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
                          child: Text("主号数: ${ctl.regionData?.normalCount}"),
                        ),
                        Expanded(
                          child: Text("小号数: ${ctl.regionData?.viceCount}"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text("耗兵数: ${ctl.regionData?.drainCount}"),
                        ),
                        Expanded(
                          child: Text("间谍数: ${ctl.regionData?.spyCount}"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text("当前战区: ${ctl.regionData?.zoneInfo}"),
                        ),
                        Expanded(
                          child: Text("当前颜色: ${ctl.regionData?.color ?? ''}"),
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
              // const SizedBox(height: 24),
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
              //   height: 100,
              //   padding: const EdgeInsets.all(10),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Text("     ${ctl.regionData?.desc ?? ''}"),
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
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: getTableHead(
                  ["序号", "角色名", "微信昵称", "角色状态", "类型", "战力"],
                  [2, 5, 3, 3, 3, 3],
                ),
              ),
              Expanded(
                child: ctl.hasUser
                    ? ListView.builder(
                        itemBuilder: (ctx, index) {
                          ShipUserModel? tempUser =
                              controller.regionData?.shipUsers?[index];
                          return Container(
                            height: 20,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.black26, width: 1),
                              ),
                            ),
                            // padding: EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoute.shipUserOptionsPage,
                                        parameters: {
                                          'shipuser_id': tempUser?.id ?? "",
                                        },
                                      );
                                    },
                                    child: Text(
                                      "  ${index + 1}",
                                      style: const TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Text(tempUser?.mksName ?? ""),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(tempUser?.user?.wechatName ?? ""),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(tempUser?.statusName ?? ""),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(tempUser?.typeName ?? ""),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text("${tempUser?.swordName ?? 0}"),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: ctl.shipUserLength,
                      )
                    : const Text("暂无数据"),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: ctl.hasOptions ? 200 : 0,
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: ctl.validOptions.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5, // 交叉轴方向上的间距
                    childAspectRatio: 4,
                    mainAxisSpacing: 5, // 主轴方向上的间距
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final option = ctl.validOptions[index];
                    return ElevatedButton(
                      onPressed: () {
                        ctl.onOption(option);
                      },
                      child: Text(option.name ?? ""),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
