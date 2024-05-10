// ignore_for_file: avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/apps.dart';
import '../../core/custome_table_field.dart';
import '../../core/models/agenda_models.dart';
import 'departal_option_controller.dart';

class DepartOptionsPage extends GetView<DepartOptionsController> {
  String? departId;
  DepartOptionsPage({
    Key? key,
    departId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepartOptionsController>(builder: (ctl) {
      ctl.departId = departId;
      return WillPopScope(
        onWillPop: () async {
          Get.back(result: true);
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('部门议程信息'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(6),
                child: const Text(
                  "议程信息",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                color: Colors.black12,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text("议程名称: ${ctl.departData?.name}"),
                        ),
                        Expanded(
                          child: Text("议程技能: ${ctl.departData?.skill}"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                              "议程增益: ${ctl.departData?.skillMajorName ?? ''}"),
                        ),
                        Expanded(
                          child:
                              Text("升级道具: ${ctl.departData?.upgradePropsName}"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text("技能作用: ${ctl.departData?.skillEffect}"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
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
                  ["序号", "角色名", "轮次", "已激活?", "本轮节点", "本轮缺少道具"],
                  [2, 4, 2, 2, 3, 4],
                ),
              ),
              Expanded(
                child: ctl.hasUser
                    ? ListView.builder(
                        itemBuilder: (ctx, index) {
                          ShipuserDepartmentalInfoModel? tmp =
                              controller.departData?.shipUserDatas?[index];
                          bool skillAlive = tmp?.skillAlive ?? false;
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
                                  child: ctl.isManager
                                      ? InkWell(
                                          onTap: () async {
                                            final result = await Get.toNamed(
                                              AppRoute
                                                  .departShipUserInfoEditPage,
                                              parameters: {
                                                'shipUserId':
                                                    tmp?.shipUserId ?? "-1",
                                                'departId':
                                                    "${tmp?.agendaId ?? -1}",
                                              },
                                            );
                                            if (result == true) {
                                              await ctl.reloadData();
                                            }
                                          },
                                          child: Text(
                                            "  ${index + 1}",
                                            style: const TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          "  ${index + 1}",
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(tmp?.shipUserMksName ?? ""),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text("${tmp?.agendaLevel}"),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(skillAlive ? "是" : "否"),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text("${tmp?.agendaNode}"),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text("${tmp?.propsLack ?? 0}"),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: ctl.shipUserLength,
                      )
                    : const Text("暂无数据"),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 50,
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: ctl.validOptions.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5, // 交叉轴方向上的间距
                    childAspectRatio: 4,
                    mainAxisSpacing: 5, // 主轴方向上的间距
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final option = ctl.validOptions[index];
                    return ElevatedButton(
                      onPressed: () async {
                        await ctl.onOption(option);
                      },
                      child: Text(option.name ?? ""),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
