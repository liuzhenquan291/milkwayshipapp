import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/ships/shipuser_option_controller.dart';

class ShipUserOptionPage extends GetView<ShipUserOptionController> {
  String? userId;
  ShipUserOptionPage({
    Key? key,
    shipUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShipUserOptionController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: Text('${controller.userDisplayName}, 您好!'),
        // ),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('角色信息'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(6),
              child: const Text(
                "角色信息",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              height: 230,
              padding: EdgeInsets.all(10),
              color: Colors.black12,
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "账        号:   ${controller.shipUserData?.user?.username}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "昵        称:   ${controller.shipUserData?.user?.displayName}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "微信昵称:   ${controller.shipUserData?.user?.wechatName ?? ''}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "群  昵  称:   ${controller.shipUserData?.user?.wcqName ?? ''}"),
                      ),
                    ],
                  ),
                  // 角色信息
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "角  色  名:   ${controller.shipUserData?.mksName ?? ''}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "所属势力:   ${controller.shipUserData?.region?.name ?? ''}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "可  开  盆:   ${controller.shipUserData?.canCornucopia ?? true ? '是' : '否'}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "需  参  盆:   ${controller.shipUserData?.needCornucopia ?? true ? '是' : '否'}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "可开盆时间:   ${controller.shipUserData?.canCornucopiaTime ?? ''}"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "需参盆时间:   ${controller.shipUserData?.needCornucopiaTime ?? ''}"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 200,
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: controller.validOptions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5, // 交叉轴方向上的间距
                  childAspectRatio: 4,
                  mainAxisSpacing: 5, // 主轴方向上的间距
                ),
                itemBuilder: (BuildContext context, int index) {
                  final option = controller.validOptions[index];
                  return ElevatedButton(
                    onPressed: () {
                      controller.onOption(option);
                    },
                    child: Text(option.name ?? ""),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
