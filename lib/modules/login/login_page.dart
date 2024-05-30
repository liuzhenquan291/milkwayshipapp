import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/auth.dart';
import '../../core/apps.dart';
import '../../core/host.dart';
import '../../core/urls.dart';
import '../../core/utils.dart';
import '../../core/server.dart';
import '../../core/auth_controller.dart';
import '../../modules/login/user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
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
                    Get.offAllNamed(AppRoute.registerPage);
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
      ApiService apiService = ApiService();
      final AuthService au = Get.find<AuthService>();
      final EncrypterController enc = Get.find<EncrypterController>();
      final passwdEnc = enc.encryptMd5(password);
      final data = {
        'username': username,
        'password': passwdEnc,
        'version': version,
      };
      final response = await apiService.postRequest(apiUrl.userLoginPath, data);

      // 检查登录成功与否
      if (response.statusCode == 200) {
        // 模拟登录成功后更新token
        ResponseData respData = ResponseData.fromJson(response.data);
        if (respData.code == 0) {
          UserModel user = UserModel.fromJson(respData.data);

          await StorageHelper.setAll(
            user.userId,
            user.username,
            user.displayName,
            user.userRole,
            user.token ?? "",
            user.regionId,
            user.regionName,
          );

          await au.onLogin();
          Get.offAllNamed(AppRoute.rootPage);
        } else {
          Get.snackbar(
            "登录异常",
            respData.message.toString(),
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
