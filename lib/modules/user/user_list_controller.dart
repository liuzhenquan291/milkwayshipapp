// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/server.dart';
import 'package:milkwayshipapp/core/urls.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserListController extends GetxController {
  final RefreshController refreshController = RefreshController();
  // final ScrollController scrollController = ScrollController();
  List<Map<String, String>> userList = [];
  int page = 1;

  @override
  void onInit() {
    super.onInit();
    _loadData();
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent) {
    //     _loadData();
    //   }
    // });
  }

  Future<void> _loadData() async {
    final apiService = Get.find<ApiService>();
    final response =
        await apiService.getRequest(apiUrl.useListCreatePath, {'page': page});
    if (response.statusCode != 200) {
      return;
    }
    final responseData = ResponseData.fromJson(response.data);
    final userInfos = responseData.data as List<dynamic>;
    /*
"id" -> "de5e285673d041dba520dfef1338a40f"
"password" -> "123456"
"last_login" -> null
"is_superuser" -> false
"number" -> "U2311215823"
"created_time" -> "2023-11-21T17:27:42.221159"
"updated_time" -> "2023-11-21T17:27:42.221180"
"deleted" -> false
"status" -> "init"
"username" -> "18575546060"
"display_name" -> "蒙蕤"
"wechat_name" -> "蒙蕤"
*/
    List<Map<String, String>> newData =
        List.generate(userInfos.length, (index) {
      var item = userInfos[index] as Map<String, dynamic>;
      return {
        '用户名': item['username'],
        '用户昵称': item['display_name'],
        '微信昵称': item['wechat_name'],
        '用户状态': item['status'],
        // '可用操作': 'options',
        'userId': item['id'] ?? '',
      };
    });
    userList.addAll(newData);
    page++;
    // refreshController.refreshCompleted(); // 结束刷新状态
    update();
  }

  @override
  void onClose() {
    refreshController.dispose();
    // scrollController.dispose();
    super.onClose();
  }
}
