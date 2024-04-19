import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/apps.dart';
import '../../core/server.dart';
import '../../core/urls.dart';

class RegionNewPage extends StatefulWidget {
  const RegionNewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegionNewPageState();
  }
}

class _RegionNewPageState extends State<RegionNewPage> {
  @override
  void initState() {
    super.initState();
  }
// }

// class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nameFmtController = TextEditingController();
  final TextEditingController zoneNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // String captcha = _generateCaptcha();
    return Scaffold(
      appBar: AppBar(
        title: const Text('创建新势力'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: '势力名称',
                  hintText: '请输入势力名称',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: nameFmtController,
                // obscureText: true,
                decoration: const InputDecoration(
                    labelText: '名字格式', hintText: '势力成员名字格式: 如 "龍魂ৡ+名字"'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: zoneNameController,
                // obscureText: true,
                decoration: const InputDecoration(
                    labelText: '当前战区', hintText: '请输入战区信息, 如 "第7战区"'),
              ),
              const SizedBox(height: 16.0),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "势力简介:",
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: descriptionController,
                maxLines: 8,
                maxLength: 200,
                decoration: const InputDecoration(
                    // hintText: '200字以内',
                    ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await _create(
                    nameController.text,
                    nameFmtController.text,
                    zoneNameController.text,
                    descriptionController.text,
                  );
                },
                child: const Text(
                  '确认创建',
                ),
              ),
              // Row(
              //   // crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     ElevatedButton(
              //       onPressed: () async {
              //         await _create(
              //           nameController.text,
              //           nameFmtController.text,
              //           zoneNameController.text,
              //           descriptionController.text,
              //         );
              //       },
              //       child: const Text(
              //         '确认创建',
              //       ),
              //     ),
              //     const SizedBox(width: 16.0),
              //     ElevatedButton(
              //       onPressed: () async {
              //         Get.back();
              //       },
              //       child: const Text(
              //         '返回上一页',
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  _create(
      String name, String nameFmt, String zoneName, String description) async {
    if (name.isEmpty) {
      Get.snackbar(
        "创建势力异常",
        "名字不能为空",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (nameFmt.isEmpty) {
      Get.snackbar(
        "创建势力异常",
        "名字不能为空",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (zoneName.isEmpty) {
      Get.snackbar(
        "创建势力异常",
        "战区信息",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (description.isEmpty) {
      Get.snackbar(
        "创建势力异常",
        "势力简介",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      // 去注册
      final apiService = ApiService();

      final data = {
        "name": name,
        "name_fmt": nameFmt,
        "zone_info": zoneName,
        "desc": description,
      };
      try {
        final response =
            await apiService.postRequest(apiUrl.regionsCreateListPath, data);

        // 检查登录成功与否
        if (response.statusCode == 200) {
          // 模拟登录成功后更新token
          ResponseData responseData = ResponseData.fromJson(response.data);
          if (responseData.code == 0) {
            // UserModel user = UserModel.fromJson(responseData.data);
            // TODO: 注册角色成功后的操作

            Get.offAllNamed(AppRoute.rootPage);
          } else {
            Get.snackbar(
              "注册异常",
              responseData.message.toString(),
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
