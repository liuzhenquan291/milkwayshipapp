import 'package:get/get.dart';
import 'package:flutter/material.dart';

// import 'package:milkwayshipapp/core/custom_option_widget.dart';
// import 'package:sprintf/sprintf.dart';
// import '../../core/apps.dart';
// import '../../core/auth.dart';
// import '../../core/urls.dart';
import '../../core/utils.dart';
// import '../../core/server.dart';
import './user_edit_controller.dart';
// import '../../core/auth_controller.dart';
import '../../core/custom_text_field.dart';
// import '../../core/models/user_model.dart';

class UserEditPage extends StatefulWidget {
  String? userId;
  String? isSelf;
  UserEditPage({
    Key? key,
    userId,
    isSelf,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _UserEditState();
  }
}

class _UserEditState extends State<UserEditPage> {
  bool ifEdited = false;

  final EncrypterController enc = Get.find<EncrypterController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserEditController>(builder: (ctl) {
      return WillPopScope(
        onWillPop: () async {
          Get.back(result: ifEdited);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('用户信息'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
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
                          controller: ctl.displayNameCtl,
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
                          controller: ctl.wxNameCtl,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Text("群  昵  称："),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(controller: ctl.wxGnameCtl),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          ctl.onEditUserInfo();
                        },
                        child: const Text('确认修改'),
                      ),
                      const SizedBox(width: 16.0),
                      ctl.isSelfBool
                          ? ElevatedButton(
                              onPressed: () async {
                                // // 退出登录
                                ifEdited = await ctl.onLogoff();
                              },
                              child: const Text('退出登录'),
                            )
                          : const SizedBox(width: 0),
                      const SizedBox(width: 16.0),
                      ctl.isSelfBool
                          ? ElevatedButton(
                              onPressed: () async {
                                ifEdited = await ctl.onEditUserPassWd();
                              },
                              child: const Text('修改密码'),
                            )
                          : const SizedBox(width: 0),
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
}
