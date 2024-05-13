import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/apps.dart';
import '../../core/server.dart';
import '../../core/models/ruins_model.dart';
import '../../core/custome_table_field.dart';
import '../../modules/ruins/ruins_controller.dart';

const userNameExpandedFlex = 5;
const otherExpandedFlex = 3;

class RuinListPage extends GetView<RuinsListController> {
  final ApiService gc = ApiService();

  RuinListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RuinsListController>(
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('废墟任务列表'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: const [
                  Text(
                    "废墟任务列表",
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
                            ["序号", "编号", "外环", "中环", "占据废墟", "目标", "成果"],
                            [2, 4, 2, 2, 3, 2, 2],
                          ),
                        ),
                        Expanded(
                          child: ctl.hasData
                              ? ListView.builder(
                                  itemBuilder: (ctx, index) {
                                    RuinsModel tmp = ctl.ruinsList[index];
                                    return Container(
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black26, width: 1),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: InkWell(
                                              onTap: () async {
                                                _tapOnRuin(tmp.id ?? '');
                                              },
                                              child: Text(
                                                " ${index + 1}",
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(tmp.number ?? ''),
                                          ),
                                          // Expanded(
                                          //   flex: 3,
                                          //   child: Text(
                                          //     tmp.creator?.wechatName ?? "",
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 2,
                                            child: Text("${tmp.outerCnt}"),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text("${tmp.middleCnt}"),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              tmp.ruinOwnerName ?? '',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "${tmp.targetShipUserCnt}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "${tmp.actualShipUserCnt}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: ctl.ruinsList.length,
                                )
                              : const Text("暂无数据"),
                        ),
                      ]),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ctl.canCreateNew
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await ctl.onOptionNewAdd();
                          },
                          child: const Text("新建任务"),
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 1,
                    ),
            ],
          ),
        );
      },
    );
  }

  // 点击用户名时 跳转
  // 如果点的是自己进入编辑页
  // 如果点的是别人进入用户操作页
  void _tapOnRuin(String ruinId) async {
    bool? result = false;
    result = await Get.toNamed(
      AppRoute.ruinOptionPage,
      parameters: {'ruinId': ruinId},
    );

    if (result == true) {
      controller.reloadData();
    }
  }
}
