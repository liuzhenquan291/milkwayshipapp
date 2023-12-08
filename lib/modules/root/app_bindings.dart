// app_bindings.dart

import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/login/global_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // 初始化 GlobalController
    // Get.put(GlobalController());
    Get.lazyPut(() => GlobalController());

    // 初始化其他控制器
    // Get.put(OtherController());
    // 添加其他控制器的初始化...
  }
}
