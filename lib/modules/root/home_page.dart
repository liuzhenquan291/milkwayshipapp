import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  final HomeController _controller = Get.put(HomeController());

  // 添加 key 参数
  // HomePage() {
  //   _checkLoginStatus();
  // }

  int _currentIndex = 0;

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
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.emoji_people),
            icon: Icon(Icons.business),
            label: '势力',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: '攻略',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        // unse: Colors.black,
        onTap: (index) {
          // 处理底部导航栏点击事件
          setState(() {
            // 不更新状态
            if (_currentIndex == index) {
              return;
            }

            _currentIndex = index;

            if (_currentIndex == 0) {
              Get.offAllNamed('/');
            } else if (_currentIndex == 1) {
              Get.offAllNamed('/login');
            } else if (_currentIndex == 2) {
              Get.offAllNamed('/register');
            } else if (_currentIndex == 3) {
              Get.offAllNamed('/');
            }
          });
        },
      ),
    );
  }
}
