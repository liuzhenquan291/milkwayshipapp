import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/apps.dart';
import '../../core/server.dart';
import 'departal_controller.dart';
import '../../core/custome_table_field.dart';
import '../../core/models/agenda_models.dart';

const userNameExpandedFlex = 5;
const otherExpandedFlex = 3;

class DepartalListPage extends GetView<DepartalListController> {
  final ApiService gc = ApiService();

  DepartalListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepartalListController>(
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('部门议程'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: const [
                  Text(
                    "部门议程列表",
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
                          ["序号", "议程", "议程技能", "升级道具", "创建时间"],
                          [2, 3, 3, 3, 4],
                        ),
                      ),
                      Expanded(
                        child: ctl.hasData
                            ? ListView.builder(
                                itemBuilder: (ctx, index) {
                                  DepartmentalAgendaModel tmp =
                                      ctl.deparList[index];
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
                                              _tapOnDepar(tmp.id);
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
                                          flex: 3,
                                          child: Text(tmp.name),
                                        ),
                                        // Expanded(
                                        //   flex: 2,
                                        //   child: Text(
                                        //     tmp.creator?.wechatName ?? '',
                                        //   ),
                                        // ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(tmp.skill),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child:
                                              Text("${tmp.upgradePropsName}"),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(tmp.getCreatedDay()),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: ctl.deparList.length,
                              )
                            : const Text("暂无数据"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ctl.isManager
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await ctl.onOptionNewAdd();
                                  },
                                  child: const Text("新建议程"),
                                ),
                              ],
                            )
                          : const SizedBox(
                              height: 1,
                            ),
                      // const SizedBox(width: 60.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _tapOnDepar(int departId) async {
    bool? result = false;
    result = await Get.toNamed(
      AppRoute.departOptionPage,
      parameters: {'departId': "$departId"},
    );
    if (result == true) {
      controller.reloadData();
    }
  }
}
