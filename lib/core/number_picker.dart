import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

class MyNumberPicker extends StatefulWidget {
  @override
  _MyNumberPickerState createState() => _MyNumberPickerState();
}

class _MyNumberPickerState extends State<MyNumberPicker> {
  int _selectedNumber = 0;

  final List<int> _numbers =
      List.generate(10, (index) => index); // 生成 0 到 9 的数字列表

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController:
          FixedExtentScrollController(initialItem: _selectedNumber), // 初始化选中的项
      itemExtent: 32.0, // 每项的高度
      onSelectedItemChanged: (int index) {
        setState(() {
          _selectedNumber = index;
        });
      },
      children: _numbers.map((number) {
        return Center(
          child: Text('${number}'), // 显示每个选项的文本
        );
      }).toList(),
    );
  }

  int getSelectedNum() {
    return _selectedNumber;
  }
}
