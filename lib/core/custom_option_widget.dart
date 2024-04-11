import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'package:milkwayshipapp/core/server.dart';

void customePostOption(
  String title,
  String optionUrl,
  Map<String, dynamic>? payload,
) {
  Get.defaultDialog(
    title: title,
    middleText: '确定要执行该操作吗？',
    textConfirm: '确认',
    textCancel: '取消',
    confirmTextColor: Colors.white, // 自定义确认按钮文本颜色
    onCancel: () {
      // Get.back();
    },
    onConfirm: () {
      Get.back();

      final as = Get.find<ApiService>();
      final response = as.postRequest(optionUrl, payload) as dio.Response;
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

// 可输入额外信息的 option
void editablePostOption(
  String title,
  String optionUrl,
  String infoCue, // 提示词
  String infoName, // 传参名称
  TextEditingController controller,
  Map<String, dynamic>? payload,
) {
  Get.defaultDialog(
    title: title,
    middleText: '确定要执行该操作吗？',
    textConfirm: '确认',
    textCancel: '取消',
    confirmTextColor: Colors.white, // 自定义确认按钮文本颜色
    content: Column(
      children: [
        Text("$infoCue: "),
        TextField(
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(hintText: "请输入"),
        ),
      ],
    ),
    onCancel: () {
      // Get.back();
    },
    onConfirm: () {
      Get.back();

      payload?[infoName] = controller.text;

      final as = Get.find<ApiService>();
      final response = as.postRequest(optionUrl, payload) as dio.Response;
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

void customeDeleteOption(
  String title,
  String optionUrl,
  Map<String, dynamic>? payload,
) {
  Get.defaultDialog(
    title: title,
    middleText: '确定要执行该操作吗？',
    textConfirm: '确认',
    textCancel: '取消',
    confirmTextColor: Colors.white, // 自定义确认按钮文本颜色
    onCancel: () {
      // Get.back();
    },
    onConfirm: () {
      Get.back();

      final as = Get.find<ApiService>();
      final response = as.deleteRequest(optionUrl, payload) as dio.Response;
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