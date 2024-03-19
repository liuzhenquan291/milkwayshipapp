import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/custom_text_field.dart';
import 'package:sprintf/sprintf.dart';
import 'package:dio/dio.dart' as dio;

import '../../core/apps.dart';
import '../../core/models/user_model.dart';
import '../../core/server.dart';
import '../../core/urls.dart';
import '../../core/utils.dart';
import '../login/global_controller.dart';
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
                  // TODO: 后续再添加修改信息、修改密码功能
                  children: [
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   child: const Text(
                    //     '确认修改',
                    //   ),
                    // ),
                    // const SizedBox(width: 16.0),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     Get.offAllNamed(appRoute.loginPage);
                    //   },
                    //   child: const Text(
                    //     '修改密码',
                    //   ),
                    // ),
                    ElevatedButton(
                      onPressed: () async {
                        // // 退出登录
                        // void onOptionLogoff(OptionModel? option) {
                        final gc = Get.find<GlobalController>;
                        Get.find<GlobalController>().userId = "";
                        Get.find<GlobalController>().token = "";
                        Get.find<GlobalController>().username = "";
                        Get.find<GlobalController>().userDisplayName = "";
                        Get.find<GlobalController>().userRole = "";
                        Get.find<GlobalController>().isLogin = false;

                        //   Get.offAllNamed(appRoute.rootPage);
                        // }
                        Get.offAllNamed(appRoute.loginPage);
                      },
                      child: const Text(
                        '退出登录',
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        onOptionLogout(controller.userData as UserModel);
                        Get.offAllNamed(appRoute.loginPage);
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
      );
    });
  }

// 注销账号
  void onOptionLogout(UserModel userData) {
    final url = sprintf(apiUrl.userRetriveUpdateDestroyPath, [userData.id]);
    _defaultDeleteOption(userData, "注销账号", url, null);
  }

  void _defaultDeleteOption(UserModel userData, String title, String optionUrl,
      Map<String, dynamic>? payload) {
    Get.defaultDialog(
      title: title,
      middleText: '确定要执行该操作吗？',
      textConfirm: '确认',
      textCancel: '取消',
      confirmTextColor: Colors.white, // 自定义确认按钮文本颜色
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        final apiService = Get.find<ApiService>();
        late Map<String, dynamic> myPayload;
        if (payload != null) {
          myPayload = payload;
        }

        myPayload["user_id"] = userData.id;
        myPayload["user_updated_time"] = userData.updatedTime;

        // Map<String, dynamic> =
        // final Map<String, dynamic> payload = {
        //   "user_id": userId,
        //   "user_updated_time": userData?.updatedTime,
        // };
        final response =
            apiService.deleteRequest(optionUrl, myPayload) as dio.Response;
        final responseData = ResponseData.fromJson(response.data);
        if (responseData.code != 0) {
          Get.defaultDialog(
            title: '操作失败',
            content: Text(responseData.message as String),
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
              onPressed: () {
                Get.back();
              },
              child: const Text('操作成功'),
            ),
          );
        }
      },
    );
  }
}
