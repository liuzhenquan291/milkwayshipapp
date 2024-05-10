import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/custom_text_field.dart';
import '../../core/server.dart';
import 'departal_edit_controller.dart';

const userNameExpandedFlex = 5;
const otherExpandedFlex = 3;

class DepartalEditPage extends GetView<DepartalEditController> {
  String? departId;
  final TextEditingController nameCtl = TextEditingController();
  final TextEditingController skillCtl = TextEditingController();
  final TextEditingController skillEffectCtl = TextEditingController();
  final TextEditingController upgradePropsCtl = TextEditingController();
  final TextEditingController skillMajorCtl = TextEditingController();

  DepartalEditPage({
    Key? key,
    departId,
  }) : super(key: key);

  final ApiService gc = ApiService();

  // @override
  // void dispose() {
  //   super.dispose();
  //   nameCtl.dispose();
  //   skillCtl.dispose();
  //   skillEffectCtl.dispose();
  //   // captchaController.dispose();
  //   skillMajorCtl.dispose();
  //   upgradePropsCtl.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepartalEditController>(
      builder: (ctl) {
        if (ctl.hasData) {
          nameCtl.text = ctl.departData?.name ?? '';
          skillCtl.text = ctl.departData?.skill ?? '';
          skillEffectCtl.text = ctl.departData?.skillEffect ?? '';
          skillMajorCtl.text = ctl.departData?.skillMajorName ?? '';
          upgradePropsCtl.text = ctl.departData?.upgradePropsName ?? '';
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('部门议程编辑页'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text("议程名字: "),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: nameCtl,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Text("激活技能: "),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: skillCtl,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Text("技能效果: "),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: skillEffectCtl,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Text("主要增益类型: "),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: skillMajorCtl,
                          placeholder: "全部/航母/战列舰/驱逐舰/护卫舰/巡洋舰",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Text("升级道具: "),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: upgradePropsCtl,
                          placeholder: "部门徽章/部门凭证",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final result = await ctl.onEditOption(
                            nameCtl.text,
                            skillCtl.text,
                            skillEffectCtl.text,
                            upgradePropsCtl.text,
                            skillMajorCtl.text,
                          );
                          if (result == true) {
                            Get.back(result: result);
                          }
                        },
                        child: Text(
                          ctl.hasData ? '确认修改' : '确认新建',
                        ),
                      ),
                      const SizedBox(width: 16.0),
                    ],
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
