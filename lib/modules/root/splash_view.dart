import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_service.dart';

class SplashView extends GetView<SplashService> {
  SplashView({Key? key}) : super(key: key);

  // @override
  // String toolbarTitle() {
  //   return "";
  // }

  // @override
  // bool hideToolbar() {
  //   return true;
  // }

  @override
  Widget buildBody(BuildContext context, SplashService _controller) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Text(
                _controller.welcomeStr[_controller.activeStr.value],
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        title: const Text('闪屏'),
        // centerTitle: true,
      ),
      body: buildBody(context, controller),
      // floatingActionButton: floatingActionButton(),
      // bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
