import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'global_controller.dart';
import 'package:milkwayshipapp/core/server.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                final username = usernameController.text;
                final password = passwordController.text;

                if (username.isNotEmpty && password.isNotEmpty) {
                  try {
                    final data = {'username': username, 'password': password};
                    final response = await apiService.postRequest(
                        'http://localhost:8002/login/', data);

                    // 检查登录成功与否
                    if (response.statusCode == 200) {
                      // 模拟登录成功后更新token
                      Get.find<GlobalController>().token.value =
                          'your_token_here';
                      Get.offAllNamed('/');
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
                } else {
                  Get.snackbar(
                    '输入错误',
                    '账号和密码不能为空',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
