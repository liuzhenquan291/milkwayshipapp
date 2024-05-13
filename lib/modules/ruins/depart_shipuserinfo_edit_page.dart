// ignore_for_file: avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/custom_text_field.dart';
import 'depart_shipuserinfo_edit_controller.dart';

class ShipUserDepartInfoEditPage
    extends GetView<DepartShipuserInfoEditController> {
  String? departId;
  String? shipUserId;
  ShipUserDepartInfoEditPage({
    Key? key,
    departId,
    shipUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepartShipuserInfoEditController>(builder: (ctl) {
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
            title: const Text('编辑角色部门议程'),
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
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text("技能作用: ${ctl.departData?.skillEffect}"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(6),
                child: const Text(
                  "角色信息",
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
                          child: Text("游戏昵称: ${ctl.shipUserData?.mksName}"),
                        ),
                        Expanded(
                          child:
                              Text("战       力: ${ctl.shipUserData?.swordName}"),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                              "职       务: ${ctl.shipUserData?.regionsRoleName}"),
                        ),
                        Expanded(
                          child: Text("角色状态: ${ctl.shipUserData?.statusName}"),
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
                  "当前部门议程进度",
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
                        const Text("技能是否激活: "),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: ctl.skillAliveCtl,
                            placeholder: "是/否",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("轮               次: "),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: ctl.agendaLevelCtl,
                            placeholder: "1/2/3...",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("本  轮   进  度: "),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: ctl.agendaNodeCtl,
                            placeholder: "1/2/3...",
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("本轮还差道具: "),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomTextField(
                            controller: ctl.propsLackCtl,
                            placeholder: "1/2/3...",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 编辑信息
              const SizedBox(height: 24),
              ctl.canSave
                  ? SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          await ctl.onOptionSave();
                        },
                        child: const Text("保存"),
                      ),
                    )
                  : const SizedBox(height: 1),
            ],
          ),
        ),
      );
    });
  }
}
