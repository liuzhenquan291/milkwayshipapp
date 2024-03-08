import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/custom_text_field.dart';

import '../../core/apps.dart';
import '../../core/models/user_model.dart';
import '../../core/utils.dart';
import './user_edit_controller.dart';

class UserEditPage extends StatefulWidget {
  UserEditPage({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _UserEditState();
  }
}

class _UserEditState extends State<UserEditPage> {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController wxDisNameController = TextEditingController();
  final TextEditingController wxGNameController = TextEditingController();
  // final TextEditingController captchaController = TextEditingController();

  // 旧密码
  final TextEditingController olPasswdController = TextEditingController();
  // 新密码
  final TextEditingController passwordController = TextEditingController();
  // 确认密码
  final TextEditingController rePasswdController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final EncrypterController encrypterController =
      Get.find<EncrypterController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    displayNameController.dispose();
    wxDisNameController.dispose();
    wxGNameController.dispose();
    // captchaController.dispose();
    olPasswdController.dispose();
    passwordController.dispose();
    rePasswdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String captcha = _generateCaptcha();
    return GetBuilder<UserEditController>(builder: (controller) {
      displayNameController.text = controller.userData?.displayName ?? "";
      wxDisNameController.text = controller.userData?.wechatName ?? "";
      wxGNameController.text = controller.userData?.wcqName ?? "";
      return Scaffold(
        // appBar: AppBar(
        //   title: const Text('用户信息'),
        // ),
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          title: const Text('个人信息'),
          // centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // 在这里调用 Get.back() 实现返回上一个页面
              Get.back();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Text("账        号："),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(controller.userData?.username ?? ""),
                    )
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const Text("用户昵称："),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: displayNameController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const Text("微信昵称："),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: wxDisNameController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const Text("群  昵  称："),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: wxGNameController,
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
                      onPressed: () {},
                      child: const Text(
                        '确认修改',
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        Get.offAllNamed(appRoute.loginPage);
                      },
                      child: const Text(
                        '修改密码',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
