import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  // 添加 key 参数
  // HomePage() {
  //   _checkLoginStatus();
  // }

  Future<void> _checkLoginStatus() async {
    bool isLogin = _controller.isLoggedIn.value;
    if (!isLogin) {
      // Get.offAllNamed('/login');
      Get.toNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Obx(
        () => _controller.isLoggedIn.value
            ? const Center(child: Text('Home Page'))
            : Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Get.offAllNamed('/login');
                    Get.toNamed('/login');
                  },
                  child: const Text('Go to Login'),
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_people),
            label: '势力',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '攻略',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          // 处理底部导航栏点击事件
        },
      ),
    );
  }
}
