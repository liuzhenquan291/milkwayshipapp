import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    onConfirm: () async {
      Get.back();

      final as = Get.find<ApiService>();
      final response = await as.postRequest(optionUrl, payload);
      final responseData = ResponseData.fromJson(response.data);

      if (responseData.code != 0) {
        Get.defaultDialog(
          title: '操作失败',
          content: Text(responseData.message as String),
          confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('关闭'),
          ),
        );
      } else {
        Get.defaultDialog(
          title: "",
          content: const Text("操作成功"),
          confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('关闭'),
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
  TextEditingController ctl,
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
          controller: ctl,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(hintText: "请输入"),
        ),
      ],
    ),
    onCancel: () {
      // Get.back();
    },
    onConfirm: () async {
      Get.back();

      payload?[infoName] = ctl.text;

      final as = Get.find<ApiService>();
      final response = await as.postRequest(optionUrl, payload);
      final responseData = ResponseData.fromJson(response.data);

      if (responseData.code != 0) {
        Get.defaultDialog(
          title: '操作失败',
          content: Text(responseData.message as String),
          confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('关闭'),
          ),
        );
      } else {
        Get.defaultDialog(
          title: '操作成功',
          confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('关闭'),
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
    onConfirm: () async {
      Get.back();

      final as = Get.find<ApiService>();
      final response = await as.deleteRequest(optionUrl, payload);
      final responseData = ResponseData.fromJson(response?.data);

      if (responseData.code != 0) {
        Get.defaultDialog(
          title: '操作失败',
          content: Text(responseData.message ?? ""),
          confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('关闭'),
          ),
        );
      } else {
        Get.defaultDialog(
          title: '',
          content: const Text('操作成功'),
          confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('关闭'),
          ),
        );
      }
    },
  );
}

ResponseData? customePostOptionWithResp(
  String title,
  String optionUrl,
  Map<String, dynamic>? payload,
) {
  ResponseData? resp;
  Get.defaultDialog(
    title: title,
    middleText: '确定要执行该操作吗？',
    textConfirm: '确认',
    textCancel: '取消',
    confirmTextColor: Colors.white, // 自定义确认按钮文本颜色
    onCancel: () {
      // Get.back();
    },
    onConfirm: () async {
      Get.back();

      final as = Get.find<ApiService>();
      final response = await as.postRequest(optionUrl, payload);
      final responseData = ResponseData.fromJson(response.data);

      if (responseData.code != 0) {
        Get.defaultDialog(
          title: '操作失败',
          content: Text(responseData.message as String),
          confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('关闭'),
          ),
        );
      } else {
        Get.defaultDialog(
          title: "",
          content: const Text("操作成功"),
          confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('关闭'),
          ),
        );
        resp = responseData;
      }
    },
  );
  return resp;
}
