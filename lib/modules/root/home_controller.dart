import 'package:get/get.dart';
import 'package:milkwayshipapp/modules/login/global_controller.dart';

class HomeController extends GetxController {
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkToken();
  }

  void checkToken() {
    // 这里模拟从Global中获取token的逻辑
    final token = Get.find<GlobalController>().token;

    if (token.isNotEmpty) {
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = false;
    }
  }
}
