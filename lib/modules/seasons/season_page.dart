// 游戏角色管理页
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/apps.dart';
import '../../core/custome_table_field.dart';
import '../../core/models/season_model.dart';
import '../../modules/seasons/season_controller.dart';

class SeasonListPage extends GetView<SeasonListController> {
  bool result = false;
  SeasonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeasonListController>(builder: (ctl) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('赛季信息列表'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: const [
                Text(
                  "赛季信息列表",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.0, // 设置字体大小为20
                    fontWeight: FontWeight.bold, // 设置字体粗细
                  ),
                ),
              ],
            ),
            Container(
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 1),
                ),
              ),
              child: getTableHead(
                ["序号", "赛季名", "赛季编号", "创建人", "状态"],
                [2, 5, 3, 3, 3],
              ),
            ),
            Expanded(
              child: ctl.hasData
                  ? ListView.builder(
                      itemBuilder: (ctx, index) {
                        SeasonInfoModel? tmp = ctl.seasonInfos?[index];
                        // String? username = tempUser["用户名"];
                        return Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                          ),
                          // padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () async {
                                    bool result = await Get.toNamed(
                                      AppRoute.seasonOptionPage,
                                      parameters: {
                                        'season_id': tmp?.id ?? "",
                                      },
                                    );
                                    if (result == true) {
                                      ctl.reload();
                                    }
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
                                child: Text(
                                  tmp?.name ?? "",
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "${tmp?.index}",
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(tmp?.creator?.wechatName ?? ""),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(tmp?.statusName ?? ""),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: ctl.length,
                    )
                  : const Text("暂无数据"),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    result = await Get.toNamed(AppRoute.seasonNewPage);
                    if (result == true) {
                      ctl.reload();
                    }
                  },
                  child: const Text('创建'),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
