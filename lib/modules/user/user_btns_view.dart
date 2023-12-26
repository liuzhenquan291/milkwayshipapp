import 'package:flutter/material.dart';

class UserBtnsView extends StatefulWidget {
  @override
  _UserBtnsPageState createState() => _UserBtnsPageState();

  late List<dynamic> options;
  late String userId;

  UserBtnsView({
    Key? key,
    options,
    userId,
  }) : super(key: key);
}

class _UserBtnsPageState extends State<UserBtnsView> {
  @override
  Widget build(BuildContext context) {
    return widget.options.isEmpty
        ? Column()
        : Column(
            children: [],
          );
  }
}
