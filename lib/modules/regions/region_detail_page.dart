import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/apps.dart';
import '../login/global_controller.dart';

class RegionDetailPage extends StatefulWidget {
  final String? regionId;
  RegionDetailPage({
    Key? key,
    this.regionId,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RegionDetailState();
  }
}

class _RegionDetailState extends State<RegionDetailPage> {
  String? regionName;

  @override
  Widget build(BuildContext context) {
    final regionId = widget.regionId;
    bool ifSelfRegion = true;
    if (regionId == null || regionId.isEmpty) {
      ifSelfRegion = false;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(ifSelfRegion ? "您当前所属势力${regionName}" : "势力${regionName}"),
            Column(
              children: [
                Row(
                  children: [
                    Text(""),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
