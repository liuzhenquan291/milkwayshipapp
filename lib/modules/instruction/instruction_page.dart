import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../asserts/imgs.dart';
import '../../core/apps.dart';
import '../login/global_controller.dart';

class InstructionPage extends StatelessWidget {
  InstructionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Row(
              children: const [
                Text(
                  "氪矿刷新时间",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.0, // 设置字体大小为20
                    fontWeight: FontWeight.bold, // 设置字体粗细
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                Imgs.krImg,
                // 你可以根据需要设置其他属性，比如fit、alignment等
              ),
            ),
          ],
        ),
      ),
    );
  }
}
