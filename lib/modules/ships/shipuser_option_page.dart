// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

// import '../../core/utils.dart';
import '../../modules/ships/shipuser_option_controller.dart';

class ShipUserOptionPage extends GetView<ShipUserOptionController> {
  String? shipUserId;
  ShipUserOptionPage({
    Key? key,
    shipUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShipUserOptionController>(
      builder: (ctl) {
        bool result = false;
        return WillPopScope(
          onWillPop: () async {
            Get.back(result: result);
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            // appBar: AppBar(
            //   automaticallyImplyLeading: false,
            //   title: Text('${ctl.displayName}, 您好!'),
            // ),
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: const Text('角色信息'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(6),
                    child: const Text(
                      "角色信息",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.black12,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "账        号:   ${ctl.shipUserData?.user?.username}"),
                            ),
                            // const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                  "微信昵称:   ${ctl.shipUserData?.user?.wechatName ?? ''}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "角  色  名:   ${ctl.shipUserData?.mksName ?? ''}"),
                            ),
                            Expanded(
                              child: Text(
                                  "所属势力:   ${ctl.shipUserData?.region?.name ?? ''}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "角色类型:   ${ctl.shipUserData?.typeName ?? ''}"),
                            ),
                            Expanded(
                              child: Text(
                                  "战        力:   ${ctl.shipUserData?.swordName ?? ''}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "可  开  盆:   ${ctl.shipUserData?.canCornucopia ?? true ? '是' : '否'}"),
                            ),
                            Expanded(
                              child: Text(
                                  "需  参  盆:   ${ctl.shipUserData?.needCornucopia ?? true ? '是' : '否'}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "可开盆时间:   ${ctl.shipUserData?.canCornucopiaTime ?? ''}"),
                            ),
                            // Expanded(
                            //   child: Text(
                            //       "需参盆时间:   ${ctl.shipUserData?.needCornucopiaTime ?? ''}"),
                            // ),
                          ],
                        ),
                        Row(
                          children: [
                            // Expanded(
                            //   child: Text(
                            //       "可开盆时间:   ${ctl.shipUserData?.canCornucopiaTime ?? ''}"),
                            // ),
                            Expanded(
                              child: Text(
                                  "需参盆时间:   ${ctl.shipUserData?.needCornucopiaTime ?? ''}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "上次开盆时间:   ${ctl.shipUserData?.getLastOpenCornTime()}"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "上次参盆时间:   ${ctl.shipUserData?.getLastJoinCornTime()}"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  ctl.isSelf
                      ? Container(
                          color: Colors.black12,
                          child: Column(
                            children: [
                              Row(children: const [
                                Text(
                                  "更新基本信息: ",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ]),
                              TextField(
                                controller: ctl.mskNameCtl,
                                decoration: InputDecoration(
                                  labelText: '角色名',
                                  hintText:
                                      ctl.shipUserData?.mksName ?? "请输入角色名",
                                ),
                              ),
                              TextField(
                                controller: ctl.shipUserTypeCtl,
                                decoration: InputDecoration(
                                  labelText: '角色类型: 主号/耗兵/副号/谍号/沉号',
                                  hintText:
                                      ctl.shipUserData?.typeName ?? "请输入角色类型",
                                ),
                              ),
                              TextField(
                                controller: ctl.swordCtl,
                                decoration: InputDecoration(
                                  labelText: '角色当前战力',
                                  suffix: const Text("万"),
                                  hintText:
                                      "${ctl.shipUserData?.sword ?? "请输入当前战力"}",
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  result = await ctl.onUpdateBasic();
                                  if (result == true) {
                                    ctl.reloadData();
                                  }
                                },
                                child: const Text("更新角色基本信息"),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(height: 1),
                  const SizedBox(height: 8),
                  ctl.hasUpdOption
                      ? Column(
                          children: [
                            const SizedBox(height: 8.0),
                            Container(
                              // height: 100,
                              color: Colors.black12,
                              child: Column(
                                children: [
                                  Row(children: const [
                                    Text(
                                      "设置聚宝盆剩余时间: ",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ]),
                                  Row(
                                    children: [
                                      const Text("距可收盆还有: "),
                                      DropdownButton<int>(
                                        value: ctl.jd,
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (int? newValue) {
                                          ctl.setJd(newValue);
                                        },
                                        items: ctl.jdNums.map((number) {
                                          return DropdownMenuItem<int>(
                                            value: number,
                                            child: Text('$number'),
                                          );
                                        }).toList(),
                                      ),
                                      const Text("  天"),
                                      DropdownButton<int>(
                                        value: ctl.jh,
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (int? newValue) {
                                          ctl.setJh(newValue);
                                        },
                                        items: ctl.jhNums.map((number) {
                                          return DropdownMenuItem<int>(
                                            value: number,
                                            child: Text('$number'),
                                          );
                                        }).toList(),
                                      ),
                                      const Text("小时"),
                                      DropdownButton<int>(
                                        value: ctl.jm,
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (int? newValue) {
                                          ctl.setJm(newValue);
                                        },
                                        items: ctl.jmNums.map((number) {
                                          return DropdownMenuItem<int>(
                                            value: number,
                                            child: Text('$number'),
                                          );
                                        }).toList(),
                                      ),
                                      const Text("分钟"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("距可开盆还有: "),
                                      DropdownButton<int>(
                                        value: ctl.od,
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (int? newValue) {
                                          ctl.setod(newValue);
                                        },
                                        items: ctl.odNums.map((number) {
                                          return DropdownMenuItem<int>(
                                            value: number,
                                            child: Text('$number'),
                                          );
                                        }).toList(),
                                      ),
                                      const Text("天"),
                                      DropdownButton<int>(
                                        value: ctl.oh,
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        elevation: 16,
                                        style:
                                            TextStyle(color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (int? newValue) {
                                          ctl.setoh(newValue);
                                        },
                                        items: ctl.ohNums.map((number) {
                                          return DropdownMenuItem<int>(
                                            value: number,
                                            child: Text('${number}'),
                                          );
                                        }).toList(),
                                      ),
                                      const Text("小时"),
                                      DropdownButton<int>(
                                        value: ctl.om,
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        elevation: 16,
                                        style:
                                            TextStyle(color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (int? newValue) {
                                          ctl.setom(newValue);
                                        },
                                        items: ctl.omNums.map((number) {
                                          return DropdownMenuItem<int>(
                                            value: number,
                                            child: Text('${number}'),
                                          );
                                        }).toList(),
                                      ),
                                      Text("分钟"),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      result = await ctl
                                          .onOptionUpdateByRemainTime();
                                      if (result == true) {
                                        await ctl.reloadData();
                                      }
                                    },
                                    child: const Text("更新聚宝盆信息"),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : const SizedBox(height: 24),
                  SizedBox(
                    height: (ctl.validOptions.length + 1) / 2 * 50 + 10,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: ctl.validOptions.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5, // 交叉轴方向上的间距
                        childAspectRatio: 4,
                        mainAxisSpacing: 5, // 主轴方向上的间距
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final option = ctl.validOptions[index];
                        return ElevatedButton(
                          onPressed: () async {
                            result = await ctl.onOption(option);
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
}
