import 'package:flutter/material.dart';

import '../../asserts/imgs.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
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
            Row(
              children: const [
                Text(
                  "雷达拆解",
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
                Imgs.ldImg,
                // 你可以根据需要设置其他属性，比如fit、alignment等
              ),
            ),
            Row(
              children: const [
                Text(
                  "废墟攻略",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.0, // 设置字体大小为20
                    fontWeight: FontWeight.bold, // 设置字体粗细
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 400,
              // alignment: Alignment.topLeft,
              child: Image.asset(
                Imgs.ruinTarImg,
                height: 300,
                // 你可以根据需要设置其他属性，比如fit、alignment等
              ),
            ),
            SizedBox(
              // alignment: Alignment.topLeft,
              child: Image.asset(
                Imgs.ruinG1Img,
                // 你可以根据需要设置其他属性，比如fit、alignment等
              ),
            ),
            SizedBox(
              // alignment: Alignment.topLeft,
              child: Image.asset(
                Imgs.ruinG2Img,
                // 你可以根据需要设置其他属性，比如fit、alignment等
              ),
            ),
          ],
        ),
      ),
    );
  }
}
