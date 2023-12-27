import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/regions/region_options_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RegionOptionsPage extends GetView<RegionOptionsController> {
  String? regionId;
  RegionOptionsPage({
    Key? key,
    regionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegionOptionsController>(builder: (controller) {
      controller.regionId = regionId;
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('返回势力列表'),
        ),
        body: Container(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(6),
                child: Text(
                  "势力: ${controller.regionData?.name}",
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
                          child: Text("势力名称: ${controller.regionData?.name}"),
                        ),
                        Expanded(
                          child:
                              Text("昵称缩写: ${controller.regionData?.nameFmt}"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                              "势力人数: ${controller.regionData?.shipUsers?.length}"),
                        ),
                        Expanded(
                          child: Text(
                              "司令: ${controller.regionData?.commander ?? ''}"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child:
                              Text("当前战区: ${controller.regionData?.zoneInfo}"),
                        ),
                        Expanded(
                          child: Text(
                              "当前颜色: ${controller.regionData?.color ?? ''}"),
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
                          child:
                              Text("     ${controller.regionData?.desc ?? ''}"),
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
                            children: const [
                              Expanded(
                                child: Text("游戏角色名"),
                              ),
                              Expanded(
                                child: Text("用户名"),
                              ),
                              Expanded(
                                child: Text("微信昵称"),
                              ),
                              Expanded(
                                child: Text("微信群昵称"),
                              ),
                              Expanded(
                                child: Text("职务"),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: controller.hasUser
                              ? ListView.builder(
                                  itemBuilder: (ctx, index) {
                                    Map<String, dynamic> tempUser = controller
                                        .regionData?.shipUsers?[index];
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
                                              // onTap: () {
                                              //   Get.toNamed(
                                              //     appRoute.regionOptionsPage,
                                              //     parameters: {
                                              //       'regionId': tempUser['id']
                                              //     },
                                              //   );
                                              // },
                                              child: Text(
                                                tempUser["游戏角色名"],
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(tempUser["用户名"]),
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
                                            child: Text(tempUser["微信群昵称"]),
                                            // child: Container(
                                            //   child: Text(tempUser["用户状态"]),
                                            // ),
                                          ),
                                          Expanded(
                                            child: Text(tempUser["职务"]),
                                            // child: Container(
                                            //   child: Text(tempUser["用户状态"]),
                                            // ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount:
                                      controller.regionData?.shipUsers?.length,
                                )
                              : Container(
                                  child: Text("暂无数据"),
                                ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 24),
              // () {
              //   return Row();
              // }(),
              // Container(
              //   height: 50,
              //   child: ListView(
              //     // mainAxisAlignment: MainAxisAlignment.center,
              //     // children: controller.hasOptions
              //     scrollDirection: Axis.horizontal,

              //     children: controller.hasOptions
              //         ? controller.regionData?.options?.map((option) {
              //             return ElevatedButton(
              //               onPressed: () {
              //                 // 处理按钮点击事件
              //                 print('${option['name']} button pressed');
              //               },
              //               child: Text(option['name'] as String),
              //             );
              //           }).toList() as List<Widget>
              //         : [],
              //   ),
              // ),
              Container(
                  height: 200,
                  child: GridView.builder(
                      itemCount: controller.regionData?.options?.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2, // 交叉轴方向上的间距
                        childAspectRatio: 4,
                        mainAxisSpacing: 2, // 主轴方向上的间距
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final option = controller.regionData?.options![index];
                        return ElevatedButton(
                          onPressed: () {
                            // 处理按钮点击事件
                            print('${option['name']} button pressed');
                          },
                          child: Text(option['name'] as String),
                        );
                      })),
            ],
          ),
        ),
      );
    });
  }
}
