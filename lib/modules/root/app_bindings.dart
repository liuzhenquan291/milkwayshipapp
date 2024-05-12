// app_bindings.dart

import 'package:get/get.dart';

import '../../core/auth.dart';
import '../../modules/root/splash_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.putAsync(() => AuthService().init());
    Get.lazyPut(() => SplashService());

    // 初始化其他控制器
    // 添加其他控制器的初始化...
  }
}
