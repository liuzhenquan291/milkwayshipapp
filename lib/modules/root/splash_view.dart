import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_service.dart';

class SplashView extends GetView<SplashService> {
  const SplashView({Key? key}) : super(key: key);

  String toolbarTitle() {
    return "";
  }

  bool hideToolbar() {
    return true;
  }

  Widget buildBody(BuildContext context, SplashService controller) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => Text(
              controller.welcomeStr[controller.activeStr.value],
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        title: const Text('正在启动, 请稍后'),
        // centerTitle: true,
      ),
      body: buildBody(context, controller),
      // floatingActionButton: floatingActionButton(),
      // bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
