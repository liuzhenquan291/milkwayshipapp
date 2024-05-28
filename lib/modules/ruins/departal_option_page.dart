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
                  ["序号", "角色名", "轮次", "节点", ctl.isCommittee ? "上次废墟" : "缺少道具"],
                  [2, 4, 2, 2, 3],
                ),
              ),
              Expanded(
                child: ctl.hasUser
                    ? ListView.builder(
                        itemBuilder: (ctx, index) {
                          ShipuserDepartmentalInfoModel? tmp =
                              controller.departData?.shipUserDatas?[index];
                          bool skillAlive = tmp?.skillAlive ?? false;
                          bool canEdit = false;
                          canEdit = canEdit || ctl.isManager;
                          final thisUserId = tmp?.shipUser?.userId ?? "";
                          canEdit = canEdit || thisUserId == ctl.userId;
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
                                  child: canEdit
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
                                              // color: Colors.white,
                                              ),
                                        ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(tmp?.shipUserMksName ?? ""),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text("${tmp?.agendaLevel}"),
                                  ),
                                ),
                                // Expanded(
                                //     flex: 3,
                                //     child: Center(
                                //       child: Text(skillAlive ? "是" : "否"),
                                //     )),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text("${tmp?.agendaNode}"),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Text(
                                        "${ctl.isCommittee ? tmp?.lastRuinTime : tmp?.propsLack ?? 0}"),
                                  ),
                                ),
                                // Expanded(
                                //   flex: ctl.isCommittee ? 3 : 0,
                                //   child: Center(
                                //     child: Text(
                                //         "${ctl.isCommittee ? tmp?.lastRuinTime : ""}"),
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        },
                        itemCount: ctl.shipUserLength,
                      )
                    : const Text("暂无数据"),
              ),
              const SizedBox(height: 12),
              ctl.isManager
                  ? Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await ctl.onOptionUpdate();
                          },
                          child: const Text("编辑议程"),
                        ),
                        const SizedBox(width: 16.0),
                      ],
                    )
                  : const SizedBox(
                      height: 1,
                    ),
            ],
          ),
        ),
      );
    });
  }
}
