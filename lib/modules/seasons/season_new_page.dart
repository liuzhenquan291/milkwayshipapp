// 游戏角色管理页
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/seasons/season_new_controller.dart';

import '../../core/apps.dart';

class SeasonNewPage extends GetView<SeasonNewController> {
  final TextEditingController seasonNameController = TextEditingController();
  final TextEditingController seasonIndexController = TextEditingController();
  bool result = false;
  SeasonNewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeasonNewController>(builder: (ctl) {
      return WillPopScope(
        onWillPop: () async {
          Get.back(result: result);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('新建赛季信息'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: seasonNameController,
                    decoration: const InputDecoration(
                      labelText: '赛季名称',
                      hintText: '请输入赛季名称: 如 第 35 赛季',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: seasonIndexController,
                    decoration: const InputDecoration(
                      labelText: '赛季编号',
                      hintText: '请输入赛季编号: 35',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          result = await _create(
                            seasonNameController.text,
                            seasonIndexController.text,
                          );
                        },
                        child: const Text(
                          '确认创建',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<bool> _create(String? seasonName, String? seasonIndex) async {
    final res = await controller.onCreate(seasonName, seasonIndex);
    return res;
  }
}
