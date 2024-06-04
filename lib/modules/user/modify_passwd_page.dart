// 用户修改密码

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/auth.dart';
import '../../core/apps.dart';
import '../../core/urls.dart';
import '../../core/utils.dart';
import '../../core/server.dart';
import '../login/user_model.dart';
import '../../core/auth_controller.dart';

class UserModyPasswdPage extends StatefulWidget {
  String? userId;
  String? updatedTime;
  UserModyPasswdPage({
    Key? key,
    userId,
    userUpdatedTime,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<UserModyPasswdPage> {
  final TextEditingController oldPasswdCtl = TextEditingController();
  final TextEditingController newPasswdCtl = TextEditingController();
  final TextEditingController rePasswdCtl = TextEditingController();
  final EncrypterController enc = Get.find<EncrypterController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    oldPasswdCtl.dispose();
    newPasswdCtl.dispose();
    rePasswdCtl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String captcha = _generateCaptcha();
    final userId = Get.parameters['userId'] ?? "";
    final updatedTime = Get.parameters['updatedTime'] ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('修改密码'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: oldPasswdCtl,
                decoration: const InputDecoration(
                  labelText: '旧密码',
                  hintText: '请输入旧密码',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: newPasswdCtl,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: '新密码', hintText: '请输入密码: 6~18位字母数字组合'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: rePasswdCtl,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: '确认密码', hintText: '请确认密码'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await _modyPasswd(
                    userId,
                    updatedTime,
                    oldPasswdCtl.text,
                    newPasswdCtl.text,
                    rePasswdCtl.text,
                  );
                },
                child: const Text('修改密码'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _modyPasswd(
    String userId,
    String userUpdatedTime,
    String oldPasswd,
    String newPasswd,
    String rePasswd,
  ) async {
    if (oldPasswd.isEmpty) {
      Get.snackbar(
        "异常",
        "旧密码不能为空",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (newPasswd.isEmpty) {
      Get.snackbar(
        "异常",
        "密码不能为空",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (rePasswd != newPasswd) {
      Get.snackbar(
        "注册异常",
        "两次密码不一致",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      // 修改密码
      final enc = Get.find<EncrypterController>();
      final oldEnc = enc.encryptMd5(oldPasswd);
      final newEnc = enc.encryptMd5(newPasswd);

      final data = {
        "user_id": userId,
        "updated_time": userUpdatedTime,
        "old_passwd": oldEnc,
        "new_passwd": newEnc,
      };
      final as = Get.find<ApiService>();
      final response = await as.postRequest(apiUrl.modyPasswd, data);

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
          await Get.find<AuthService>().onLogin();

          Get.offAllNamed(AppRoute.rootPage);
        } else {
          Get.snackbar(
            "修改密码失败",
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
    }
  }
}
