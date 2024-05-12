// 游戏角色管理页
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/seasons/season_option_controller.dart';

class SeasonOptionPage extends GetView<SeasonOptionController> {
  String? seasonId;
  SeasonOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeasonOptionController>(
      builder: (ctl) {
        bool result = false;
        return WillPopScope(
          onWillPop: () async {
            Get.back(result: result);
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            // appBar: AppBar(
            //   automaticallyImplyLeading: false,
            //   title: Text('${ctl.displayName}, 您好!'),
            // ),
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: const Text('赛季详情'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(6),
                    child: const Text(
                      "赛季信息",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.black12,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text("赛季名称:   ${ctl.seasonInfo?.name}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text("赛季编号:   ${ctl.seasonInfo?.index}"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: ctl.validOptions.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5, // 交叉轴方向上的间距
                        childAspectRatio: 4,
                        mainAxisSpacing: 5, // 主轴方向上的间距
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final option = ctl.validOptions[index];
                        return ElevatedButton(
                          onPressed: () async {
                            result = await ctl.onOption(option);
                          },
                          child: Text(option.name ?? ""),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
