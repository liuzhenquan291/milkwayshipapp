// app_bindings.dart

import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/login/global_controller.dart';
import 'package:milkwayshipapp/core/server.dart';
import 'package:milkwayshipapp/core/utils.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GlobalController());
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => EncrypterController());

    // 初始化其他控制器
    // 添加其他控制器的初始化...
  }
}
