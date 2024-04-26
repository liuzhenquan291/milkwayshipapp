import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/auth.dart';
import 'package:milkwayshipapp/modules/account/account_page.dart';
import 'package:milkwayshipapp/modules/instruction/instruction_page.dart';
import 'package:milkwayshipapp/modules/regions/region_detail_page.dart';
import 'package:milkwayshipapp/modules/root/home_page.dart';

import '../../core/edum_wrapper.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IndexState();
  }
}

class _IndexState extends State<IndexPage> {
  final List<Widget> tabs = [
    const HomePage(),
    const EdenKeepAliveWrapper(child: RegionDetailPage()),
    const InstructionPage(),
    const AccountPage(),
  ];
  // 添加 key 参数
  // HomePage() {
  //   _checkLoginStatus();
  // }

  // tab 栏切换
  int _selectedIndex = 0;
  final _pageController = PageController();
  // 将PageController更改为ScrollController
  // late final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    String displayName = Get.find<AuthService>().displayName as String;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('$displayName, 您好!'),
        ),
        body: PageView(
          controller: _pageController, // 可以添加参数配置
          onPageChanged: (index) {
            _selectedIndex = index;
            setState(() {});
          },
          physics: const NeverScrollableScrollPhysics(),
          children: tabs,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          // currentIndex: _currentIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          unselectedLabelStyle: const TextStyle(color: Colors.black),
          selectedFontSize: 14,
          unselectedFontSize: 14,

          onTap: (index) {
            if (_selectedIndex == index) return;
            _selectedIndex = index;
            if (_selectedIndex == 1) {
              tabs[_selectedIndex] =
                  const EdenKeepAliveWrapper(child: RegionDetailPage());
            }
            _pageController.jumpToPage(index);
            setState(() {});
          },

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: '势力',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: '攻略',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '我的',
            ),
          ],
        ));
  }
}
