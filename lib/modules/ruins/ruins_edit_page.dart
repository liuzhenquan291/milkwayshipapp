import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/server.dart';
import 'ruins_edit_controller.dart';
import '../../core/custom_text_field.dart';
import '../../core/models/ruins_group.dart';
import '../../core/models/register_model.dart';

const userNameExpandedFlex = 5;
const otherExpandedFlex = 3;

class RuinsEditPage extends GetView<RuinsEditController> {
  String? ruinId;

  RuinsEditPage({
    Key? key,
    ruinId,
  }) : super(key: key);

  final ApiService gc = ApiService();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RuinsEditController>(
      builder: (ctl) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: const Text('废墟任务编辑页'),
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
                            Text("编       号: ${ctl.ruinData?.number ?? ''}"),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text("开始时间: ${ctl.ruinData?.getStartTime() ?? ''}"),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text("结束时间: ${ctl.ruinData?.getEndTime() ?? ''}"),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Text("占据废墟: "),
                            const SizedBox(
                              width: 10,
                            ),
                            // Expanded(
                            //   child: CustomTextField(
                            //     controller: ctl.ruinOwnerTextCtl,
                            //     placeholder: "最终是否占据废墟: 是/否",
                            //     onChanged: ctl.ruinOwnerOnchange,
                            //     height: 20,
                            //     borderWidth: 2,
                            //     showBorder: true,
                            //     prefix: const Text('请填"是"或"否"  '),
                            //   ),
                            // ),
                            Expanded(
                              child: DropdownButtonFormField(
                                value: ctl.ruinOwnerStr,
                                items: ["是", "否"]
                                    .map((option) => DropdownMenuItem(
                                          value: option,
                                          child: Text(option),
                                        ))
                                    .toList(),
                                onChanged: (newValue) {
                                  ctl.ruinOwnerOnchange(newValue);
                                },
                                // onSaved: (newValue) {
                                //   ctl.ruinOwnerChangeConfrim(newValue);
                                // },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            const Text("外  环  数: "),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomTextField(
                                controller: ctl.outerCntCtl,
                                placeholder: "外环数量: 1/2/3/4",
                                height: 20,
                                borderWidth: 2,
                                showBorder: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            const Text("中  环  数: "),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomTextField(
                                controller: ctl.middleCntCtl,
                                placeholder: "中环数量: 1/2/3/4",
                                height: 20,
                                borderWidth: 2,
                                showBorder: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            const Text("内  环  数: "),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomTextField(
                                controller: ctl.innerCntCtl,
                                placeholder: "内环数量: 1/2/3/4",
                                height: 20,
                                borderWidth: 2,
                                showBorder: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            const Text("目标人数: "),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomTextField(
                                controller: ctl.targetCntCtl,
                                placeholder: "计划最终完成人数",
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(6),
                    child: const Text(
                      "分组信息: ",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Column(
                    children: ctl.groups
                        .map((item) => buildGroup(item))
                        .toList(), // 使用.map()来生成Text组件的列表
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.onCreateOrUpdate();
                    },
                    child: Text(ctl.isNew ? "确认创建" : "确认更新"),
                  ),
                ],
              ),
            ));
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
            color: Colors.blue[300],
          ),
          Row(children: [
            Text("分组: ${data.groupName}      "),
            Text("目标人数: ${data.targetShipuserCnt}     "),
            Text("链接分组成:   ${data.scoreDesc}     "),
          ]),
          Row(children: const [
            Text(
                "任务安排:     名称     |  目标分   |         开始         |        结束        |")
          ]),
          // Column(
          //   children: gs
          //       .map((item) => buildSchedule(item))
          //       .toList(), // 使用.map()来生成Text组件的列表
          // ),
          Column(
            children: data.schedules!
                .map((item) => Text(
                    "${item.scheduleName} |     ${item.targetScore}     |   ${item.getStartTime()}   |   ${item.getEndTime()}   | "))
                .toList(), // 使用.map()来生成Text组件的列表
          ),
          Row(children: const [
            Text("人员安排: 角色   |  微信  |  激活技能? | 委员会轮次 | 委员会节点 | ")
          ]),
          // Column(
          //   children: rs
          //       .map((item) => buildRegisterShipUser(item))
          //       .toList(), // 使用.map()来生成Text组件的列表
          // ),
          Column(
            children: data.registers!
                .map((item) => Text(
                    "    ${item.shipuserMskName}        |       等等再加         |        ${item.committeeAliveName}        |      ${item.committeeLevel}     |     ${item.committeeNode}               "))
                .toList(), // 使用.map()来生成Text组件的列表
          ),
          ElevatedButton(
            onPressed: () async {
              await controller.onSelectShipUsers(data.groupName);
            },
            child: const Text("为分组选择角色"),
          ),
        ],
      ),
    );
  }

  Widget buildSchedule(RuinGroupSchedule data) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          child: Column(
            children: [
              Row(children: [Text("任务名称: ${data.scheduleName}")]),
              Row(children: [Text("目标分数: ${data.targetScore}")]),
              Row(children: [Text("开始时间:   ${data.getStartTime()}")]),
              Row(children: [Text("结束时间:   ${data.getEndTime()}")]),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRegisterShipUser(RuinRegisterModel data) {
    return Column();
  }
}
