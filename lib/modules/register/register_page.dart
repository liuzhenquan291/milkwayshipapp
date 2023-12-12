import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:milkwayshipapp/core/server.dart';
import 'package:milkwayshipapp/core/utils.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswdController = TextEditingController();
  final TextEditingController wxDisNameController = TextEditingController();
  final TextEditingController wxGNameController = TextEditingController();
  final TextEditingController captchaController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final EncrypterController encrypterController =
      Get.find<EncrypterController>();

  String _generateCaptcha() {
    final random = Random();

    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(4, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    String captcha = _generateCaptcha();
    return Scaffold(
      appBar: AppBar(
        title: const Text('请注册'),
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
                hintText: '请输入手机号',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: '密码', hintText: '请输入密码: 6~18位字母数字组合'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: rePasswdController,
              obscureText: true,
              decoration:
                  const InputDecoration(labelText: '确认密码', hintText: '请确认密码'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: wxDisNameController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '微信昵称',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: wxGNameController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: '微信群昵称',
              ),
            ),
            const SizedBox(height: 24.0),
            TextFormField(
              controller: captchaController,
              decoration: InputDecoration(
                labelText: '验证码',
                suffixIcon: Text(captcha), // Display the generated captcha
              ),
              validator: (value) {
                if (value != captcha) {
                  return '验证码无效';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Simulate password encryption (for demonstration purposes)
                final password = passwordController.text;
                final passwdEnc = EncrypterController().encryptMd5(password);

                Get.offNamed('/');
              },
              child: const Text(
                '立即注册',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
