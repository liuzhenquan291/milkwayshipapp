import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/auth.dart';
import 'package:milkwayshipapp/core/auth_controller.dart';
import 'package:milkwayshipapp/core/custom_text_field.dart';
import 'package:sprintf/sprintf.dart';
import 'package:dio/dio.dart' as dio;

import '../../core/apps.dart';
import '../../core/models/user_model.dart';
import '../../core/server.dart';
import '../../core/urls.dart';
import '../../core/utils.dart';
import './user_edit_controller.dart';

class UserEditPage extends StatefulWidget {
  const UserEditPage({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _UserEditState();
  }
}

class _UserEditState extends State<UserEditPage> {
  bool ifEdited = false;
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
  final EncrypterController enc = Get.find<EncrypterController>();
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
    return GetBuilder<UserEditController>(builder: (ctl) {
      displayNameController.text = ctl.userData?.displayName ?? "";
      wxDisNameController.text = ctl.userData?.wechatName ?? "";
      wxGNameController.text = ctl.userData?.wcqName ?? "";
      return WillPopScope(
        onWillPop: () async {
          Get.back(result: ifEdited);
          return true;
        },
        child: Scaffold(
          // appBar: AppBar(
          //   title: const Text('用户信息'),
          // ),
          appBar: AppBar(
            // automaticallyImplyLeading: true,
            title: const Text('个人信息'),
            // centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
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
                        child: Text(ctl.userData?.username ?? ""),
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
                    // TODO: 后续再添加修改信息、修改密码功能
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          ctl.onEditUserInfo(
                            displayNameController.text,
                            wxDisNameController.text,
                            wxGNameController.text,
                          );
                        },
                        child: const Text(
                          '确认修改',
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     Get.offAllNamed(AppRoute.loginPage);
                      //   },
                      //   child: const Text(
                      //     '修改密码',
                      //   ),
                      // ),
                      // const SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          // // 退出登录
                          await StorageHelper.removeAll();
                          await Get.find<AuthService>().clearToken();
                          Get.offAllNamed(AppRoute.loginPage);
                        },
                        child: const Text(
                          '退出登录',
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          onOptionLogout(ctl.userData as UserModel);
                        },
                        child: const Text(
                          '注销账号',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

// 注销账号
  void onOptionLogout(UserModel userData) async {
    final url = sprintf(apiUrl.userRetriveUpdateDestroyPath, [userData.id]);
    await _defaultDeleteOption(userData, "注销账号", url, null);
    ifEdited = true;
  }

  Future<void> _defaultDeleteOption(UserModel userData, String title,
      String optionUrl, Map<String, dynamic>? payload) async {
    Get.defaultDialog(
      title: title,
      middleText: '确定要执行该操作吗？',
      textConfirm: '确认',
      textCancel: '取消',
      confirmTextColor: Colors.white, // 自定义确认按钮文本颜色
      onCancel: () {
        Get.back();
      },
      onConfirm: () async {
        final apiService = ApiService();
        Map<String, dynamic> myPayload = {};
        if (payload != null) {
          myPayload = payload;
        }

        myPayload["user_id"] = userData.id;
        myPayload["updated_time"] = userData.updatedTime;

        final response = await apiService.deleteRequest(optionUrl, myPayload);
        if (response?.statusCode != 204) {
          Get.defaultDialog(
            title: '操作失败',
            content: Text(response?.statusMessage ?? ""),
            confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('操作失败'),
            ),
          );
        } else {
          Get.defaultDialog(
            title: '操作成功',
            // content: Text(""),
            confirm: TextButton(
              onPressed: () async {
                Get.back();
                await StorageHelper.removeAll();
                await Get.find<AuthService>().clearToken();
              },
              child: const Text('操作成功'),
            ),
          );
        }
      },
    );
  }
}
