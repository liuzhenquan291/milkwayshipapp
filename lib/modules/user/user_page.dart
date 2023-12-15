import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/global_controller.dart';

class UserPage extends StatefulWidget {
  UserPage({
    Key? key,
  }) : super(key: key);
}

class _UserState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext content) {
    final GlobalController gc = Get.find<GlobalController>();
    String userDisplayName = gc.userDisplayName.value;
    return Scaffold(
      appBar: AppBar(
        title: Text('$userDisplayName, 您好!'),
      ),
    );
  }
}
