import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/auth.dart';
import '../../core/apps.dart';
import '../../core/urls.dart';
import '../../core/utils.dart';
import '../../core/server.dart';
import '../login/user_model.dart';
import '../../core/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
  }
// }

// class RegisterPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswdController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController wxDisNameController = TextEditingController();
  final TextEditingController wxGNameController = TextEditingController();
  final TextEditingController captchaController = TextEditingController();
  final TextEditingController regionNumCtl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final EncrypterController encrypterController =
      Get.find<EncrypterController>();

  // String _generateCaptcha() {
  //   final random = Random();

  //   const chars =
  //       'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  //   return List.generate(4, (index) => chars[random.nextInt(chars.length)])
  //       .join();
  // }

  @override
  Widget build(BuildContext context) {
    // String captcha = _generateCaptcha();
    return Scaffold(
      appBar: AppBar(
        title: const Text('请注册'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                controller: displayNameController,
                // obscureText: true,
                decoration: const InputDecoration(
                  labelText: '用户昵称',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: wxDisNameController,
                // obscureText: true,
                decoration: const InputDecoration(
                  labelText: '微信昵称',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: wxGNameController,
                // obscureText: true,
                decoration: const InputDecoration(
                  labelText: '微信群昵称',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: regionNumCtl,
                // obscureText: true,
                decoration: const InputDecoration(
                  labelText: '势力编号',
                ),
              ),
              // const SizedBox(height: 24.0),
              // TextFormField(
              //   controller: captchaController,
              //   decoration: InputDecoration(
              //     labelText: '验证码',
              //     suffixIcon: Text(captcha), // Display the generated captcha
              //   ),
              //   validator: (value) {
              //     if (value != captcha) {
              //       return '验证码无效';
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(height: 16.0),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _register(
                        usernameController.text,
                        passwordController.text,
                        rePasswdController.text,
                        displayNameController.text,
                        wxDisNameController.text,
                        wxGNameController.text,
                        regionNumCtl.text,
                      );
                    },
                    child: const Text(
                      '立即注册',
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      Get.offAllNamed(AppRoute.loginPage);
                    },
                    child: const Text(
                      '返回登录',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _register(
    String username,
    String password,
    String repassword,
    String displayname,
    String wxDisplayName,
    String wxGname,
    String regionNum,
  ) async {
    if (username.isEmpty) {
      Get.snackbar(
        "注册异常",
        "用户名不能为空",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (password.isEmpty) {
      Get.snackbar(
        "注册异常",
        "密码不能为空",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (password != repassword) {
      Get.snackbar(
        "注册异常",
        "两次密码不一致",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (displayname.isEmpty) {
      Get.snackbar(
        "注册异常",
        "用户昵称为空",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (wxDisplayName.isEmpty) {
      Get.snackbar(
        "注册异常",
        "微信昵称不能为空",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (wxGname.isEmpty) {
      Get.snackbar(
        "注册异常",
        "微信群昵称不能为空",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (regionNum.isEmpty) {
      Get.snackbar(
        "注册异常",
        "势力编号不能为空",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      // 去注册
      final passwdEnc = Get.find<EncrypterController>().encryptMd5(password);
      final as = ApiService();
      final au = Get.find<AuthService>();

      final data = {
        "username": username,
        "password": passwdEnc,
        "display_name": displayname,
        "wechat_name": wxDisplayName,
        "wcq_name": wxGname,
        "region_number": regionNum,
      };
      try {
        final response = await as.postRequest(apiUrl.userRegisterPath, data);

        // 检查登录成功与否
        if (response.statusCode == 200) {
          // 模拟登录成功后更新token
          ResponseData resData = ResponseData.fromJson(response.data);
          if (resData.code == 0) {
            UserModel user = UserModel.fromJson(resData.data);

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
              "注册异常",
              resData.message.toString(),
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } else {
          // 处理登录失败
          Get.snackbar(
            '注册失败',
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
}
