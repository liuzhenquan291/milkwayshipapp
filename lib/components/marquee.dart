// 跑马灯效果
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarqueeController extends GetxController {
  // 文本列表
  var messages = <String>[].obs;

  // 滚动控制器
  final ScrollController scrollController = ScrollController();

  // 滚动速度
  final double scrollSpeed = 50.0;

  @override
  void onInit() {
    super.onInit();
    // 开始滚动
    startScroll();
  }

  // 开始滚动
  void startScroll() {
    Future.delayed(const Duration(seconds: 2), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(
            milliseconds:
                (scrollController.position.maxScrollExtent / scrollSpeed)
                    .round()),
        curve: Curves.linear,
      );

      // 滚动结束后重置到起始位置
      Future.delayed(
          Duration(
              milliseconds:
                  (scrollController.position.maxScrollExtent / scrollSpeed)
                          .round() +
                      500), () {
        scrollController.jumpTo(0);
        // 递归调用，形成循环滚动
        startScroll();
      });
    });
  }

  // 更新消息列表
  void updateMessages(List<String> newMessages) {
    messages.clear();
    messages.addAll(newMessages);
    update(); // 更新状态，触发 UI 重新构建
  }
}
