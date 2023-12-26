import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/regions/region_detail_congroller.dart';

import '../../core/apps.dart';

class RegionDetailPage extends GetView<RegionDetailController> {
  // String? regionId;
  // RegionDetailPage({
  //   Key? key,
  //   regionId,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegionDetailController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: controller.hasRegion
              ? Column(
                  children: [
                    const SizedBox(height: 24),
                    Text("您当前所属势力: ${controller.regionData?.name}"),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("根据 token 查询势力信息"),
                          ],
                        )
                      ],
                    ),
                  ],
                )
              : Container(
                  child: Column(
                    children: [
                      const SizedBox(height: 200),
                      const Center(
                        child: Text(
                          "您尚未加入任何势力",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      const SizedBox(height: 200),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              Get.toNamed(appRoute.regionNewPage);
                            },
                            child: const Text('创建势力'),
                          ),
                          const SizedBox(width: 32),
                          ElevatedButton(
                            onPressed: () {
                              Get.toNamed(appRoute.regionPage);
                            },
                            child: const Text('加入势力'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // ],
                ),
        ),
      );
    });
  }
}
