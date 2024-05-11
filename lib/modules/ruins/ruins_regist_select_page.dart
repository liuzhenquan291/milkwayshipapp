import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/custome_table_field.dart';
import '../../core/models/agenda_models.dart';
import 'ruins_regist_select_controller.dart';

class RuinsRegistSelectPage extends GetView<RuinsRegistSelectController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RuinsRegistSelectController>(
      builder: (ctl) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('委员会进度列表'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(6),
                child: const Text(
                  "部门议程角色信息",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                // height: 50,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                child: getTableHead(
                  ["", "序号", "角色名", "轮次", "已激活?", "本轮节点", "本轮缺少道具"],
                  [2, 2, 4, 2, 2, 3, 4],
                ),
              ),
              Expanded(
                child: ctl.hasData
                    ? ListView.builder(
                        itemBuilder: (ctx, index) {
                          ShipuserDepartmentalInfoModel? tmp =
                              ctl.committees[index];
                          return Container(
                            height: 20,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.black26, width: 1),
                              ),
                            ),
                            // padding: EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Checkbox(
                                    value: ctl.selector[index],
                                    onChanged: (bool? value) {
                                      ctl.toggleSelection(value, index);
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text("  ${index + 1}"),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(tmp.shipUserMksName),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text("${tmp.agendaLevel}"),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(tmp.skillAliveName ?? ''),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text("${tmp.agendaNode}"),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text("${tmp.propsLack}"),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: ctl.committees.length,
                      )
                    : const Text("暂无数据"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final datas = await controller.onSelect();
                  Get.back(result: datas);
                },
                child: const Text("确认选择"),
              ),
            ],
          ),
        );
      },
    );
  }
}
