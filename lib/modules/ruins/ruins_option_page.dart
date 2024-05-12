import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/server.dart';
import 'ruins_option_controller.dart';
import '../../core/models/ruins_group.dart';

const userNameExpandedFlex = 5;
const otherExpandedFlex = 3;

class RuinOptionPage extends GetView<RuinOptionController> {
  String? ruinId;
  bool result = false;

  RuinOptionPage({
    Key? key,
    ruinId,
    result,
  }) : super(key: key);

  final ApiService gc = ApiService();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RuinOptionController>(
      builder: (ctl) {
        bool result = false;
        return WillPopScope(
          onWillPop: () async {
            Get.back(result: result);
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: const Text('废墟任务详情页'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(6),
                    child: const Text(
                      "废墟信息: ",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    // height: 300,
                    padding: const EdgeInsets.all(6),
                    color: Colors.black12,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "编         号:  ${ctl.ruinData?.number ?? ''}"),
                            ),
                            Expanded(
                              child:
                                  Text("占领废墟:  ${ctl.ruinData?.ruinOwnerName}"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "开始时间:  ${ctl.ruinData?.getStartTime() ?? ''}"),
                            ),
                            Expanded(
                              child: Text(
                                  "结束时间:  ${ctl.ruinData?.getEndTime() ?? ''}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child:
                                  Text("外  环  数:  ${ctl.ruinData?.outerCnt}"),
                            ),
                            Expanded(
                              child:
                                  Text("中  环  数:  ${ctl.ruinData?.middleCnt}"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child:
                                  Text("内  环  数:  ${ctl.ruinData?.innerCnt}"),
                            ),
                            Expanded(
                              child: Text(
                                  "完成人数:  ${ctl.ruinData?.targetShipUserCnt}"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // 分组信息
                  Column(
                    children:
                        ctl.groups.map((item) => buildGroup(item)).toList(),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: ctl.options.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5, // 交叉轴方向上的间距
                        childAspectRatio: 4,
                        mainAxisSpacing: 5, // 主轴方向上的间距
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final option = ctl.options[index];
                        return ElevatedButton(
                          onPressed: () async {
                            final result = await ctl.onOption(option);
                            if (result == true) {
                              Get.back(result: result);
                            }
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

  Widget buildGroup(RuinGroupModel data) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: Column(
        children: [
          Divider(
            thickness: 5,
            height: 5,
            color: Colors.blue[300],
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(6),
            child: Text(
              "${data.groupName}信息: ",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Row(children: [
            // Text("分组: ${data.groupName}      "),
            Text("目标人数: ${data.targetShipuserCnt}     "),
            Text("链接分组成:   ${data.scoreDesc}     "),
          ]),
          const SizedBox(height: 6),
          Row(children: const [Text("任务安排")]),
          Table(
            border: TableBorder.all(color: Colors.black, width: 1.0),
            children: [
              const TableRow(
                children: [
                  TableCell(child: Text("任务名称", textAlign: TextAlign.center)),
                  TableCell(child: Text("目标分", textAlign: TextAlign.center)),
                  TableCell(child: Text("开始", textAlign: TextAlign.center)),
                  TableCell(child: Text("结束", textAlign: TextAlign.center)),
                ],
              ),
              ...data.schedules!
                  .map(
                    (row) => TableRow(
                      children: [
                        TableCell(
                          child: Text(
                            "${row.scheduleName}",
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            "${row.targetScore}",
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                            child: Text(
                          row.getStartTime(),
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        )),
                        TableCell(
                          child: Text(
                            row.getEndTime(),
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ],
          ),
          const SizedBox(height: 6),
          Row(children: const [Text("人员安排")]),
          Table(
            border: TableBorder.all(color: Colors.black, width: 1.0),
            children: [
              const TableRow(
                children: [
                  TableCell(child: Text("角色", textAlign: TextAlign.center)),
                  // TableCell(child: Text("微信")),
                  TableCell(child: Text("激活技能?", textAlign: TextAlign.center)),
                  TableCell(child: Text("委员会轮次", textAlign: TextAlign.center)),
                  TableCell(child: Text("委员会节点", textAlign: TextAlign.center)),
                ],
              ),
              ...data.registers!
                  .map(
                    (row) => TableRow(
                      children: [
                        TableCell(
                          child: Text(
                            row.shipuserMskName,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // TableCell(
                        //   child: Text(
                        //     "以后再说",
                        //     style: const TextStyle(fontSize: 12),
                        //   ),
                        // ),
                        TableCell(
                            child: Text(
                          row.committeeAliveName,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        )),
                        TableCell(
                          child: Text(
                            "${row.committeeLevel}",
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TableCell(
                          child: Text(
                            "${row.committeeNode}",
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ],
          ),
          // ElevatedButton(
          //   onPressed: () async {
          //     await controller.onSelectShipUsers(data.groupName);
          //   },
          //   child: const Text("为分组选择角色"),
          // ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
