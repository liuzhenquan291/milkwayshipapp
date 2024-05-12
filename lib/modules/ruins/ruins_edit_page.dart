import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/server.dart';
import 'ruins_edit_controller.dart';
import '../../core/custom_text_field.dart';
import '../../core/models/ruins_group.dart';
// import '../../core/models/register_model.dart';

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
        bool result = false;
        return WillPopScope(
          onWillPop: () async {
            Get.back(result: result);
            return true;
          },
          child: Scaffold(
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
                        // Row(
                        //   children: [
                        //     Text("编       号: ${ctl.ruinData?.number ?? ''}"),
                        //   ],
                        // ),
                        Row(
                          children: [
                            const Text("编       号: "),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomTextField(
                                keyboardType: TextInputType.text,
                                labelText: "废墟任务编号:  RUyyyyMMdd",
                                controller: ctl.numberCtl,
                                // placeholder: "废墟任务编号:  RUyyyyMMdd",
                                height: 20,
                                borderWidth: 2,
                                showBorder: true,
                                onChanged: (String value) {
                                  String filtered = value.replaceAll(
                                      RegExp(r'[^a-zA-Z0-9]'), '');
                                  if (filtered != value) {
                                    ctl.numberCtl.value = TextEditingValue(
                                      text: filtered,
                                      selection: TextSelection.fromPosition(
                                          TextPosition(
                                              offset: filtered.length)),
                                    );
                                  }
                                },
                              ),
                            ),
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
                                keyboardType: TextInputType.number,
                                labelText: "占据外环数量",
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
                                keyboardType: TextInputType.number,
                                labelText: "占据中环数量",
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
                                keyboardType: TextInputType.number,
                                labelText: "占据内环数量",
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
                                keyboardType: TextInputType.number,
                                labelText: "完成角色数",
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
                  Column(
                    children: ctl.groups
                        .map((item) => buildGroup(item))
                        .toList(), // 使用.map()来生成Text组件的列表
                  ),
                  const SizedBox(height: 10),
                  ctl.isManager
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                result = await ctl.onCreateOrUpdate();
                                if (result == true) {
                                  Get.back(result: result);
                                }
                              },
                              child: Text(ctl.isNew ? "确认创建" : "确认更新"),
                            ),
                          ],
                        )
                      : const SizedBox(
                          height: 1,
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
          Row(
            children: [
              const Text("目标人数: "),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: CustomTextField(
                  keyboardType: TextInputType.number,
                  labelText: "本组安排角色数",
                  controller: controller.groupTargetCntCtlMap[data.groupName!],
                  height: 20,
                  borderWidth: 2,
                  showBorder: true,
                ),
              ),
            ],
          ),
          Row(children: [
            // Text("分组: ${data.groupName}      "),
            // Text("目标人数: ${data.targetShipuserCnt}     "),
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
          const SizedBox(height: 20),
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
}
