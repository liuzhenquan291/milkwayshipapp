import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/regions/region_options_controller.dart';

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
          automaticallyImplyLeading: false,
          title: Text('${controller.userDisplayName}, 您好!'),
        ),
        body: Container(
            child: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              child: Text(
                "势力: ${controller.regionData?.name}",
                style: TextStyle(fontSize: 16),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(6),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text("根据 RegionId 查询势力信息"),
                  ],
                )
              ],
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back),
        ),
      );
    });
  }
}
