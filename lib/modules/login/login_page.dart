import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/apps.dart';
import 'global_controller.dart';
import 'package:milkwayshipapp/core/server.dart';
import 'package:milkwayshipapp/core/utils.dart';
import 'package:milkwayshipapp/core/urls.dart';
import 'package:milkwayshipapp/modules/login/user_model.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("请登录"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: '手机号',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '密码',
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final username = usernameController.text;
                    final password = passwordController.text;

                    _login(username, password);
                  },
                  child: const Text('登录'),
                ),
                const SizedBox(width: 32),
                ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(appRoute.registerPage);
                  },
                  child: const Text('注册'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        '输入错误',
        '账号和密码不能为空',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      ApiService apiService = Get.find<ApiService>();
      final EncrypterController encrypterController =
          Get.find<EncrypterController>();
      final passwdEnc = encrypterController.encryptMd5(password);
      final data = {'username': username, 'password': passwdEnc};
      final response = await apiService.postRequest(apiUrl.userLoginPath, data);

      // 检查登录成功与否
      if (response?.statusCode == 200) {
        // 模拟登录成功后更新token
        ResponseData responseData = ResponseData.fromJson(response?.data);
        if (responseData.code == 0) {
          UserModel user =
              UserModel.fromJson(responseData.data as Map<String, dynamic>);
          Get.find<GlobalController>().userId = user.userId as String;
          Get.find<GlobalController>().token = user.token as String;
          Get.find<GlobalController>().username = user.username as String;
          Get.find<GlobalController>().userDisplayName =
              user.userDisplayName as String;
          Get.find<GlobalController>().userRole = user.userRole as String;
          Get.find<GlobalController>().isLogin = true;

          Get.offAllNamed(appRoute.rootPage);
        } else {
          Get.snackbar(
            "登录异常",
            responseData.message.toString(),
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        // 处理登录失败
        Get.snackbar(
          '登录失败',
          '服务器异常',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        '前端异常',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
