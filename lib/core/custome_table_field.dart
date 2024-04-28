import 'package:flutter/material.dart';

Row getTableHead(
  List<String> headerNames,
  List<int>? flexList,
) {
  List<Expanded> ls = [];

  for (int i = 0; i < headerNames.length; i++) {
    ls.add(Expanded(
      flex: flexList?[i] ?? 1,
      child: Text(headerNames[i]),
    ));
  }

  return Row(
    children: ls,
  );
}
