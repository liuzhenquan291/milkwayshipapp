import 'package:get/get.dart';

class GlobalController extends GetxController {
  final RxString token = ''.obs;
  final RxBool isLogin = false.obs;
  final RxString username = ''.obs;
  final RxString userDisplayName = ''.obs;
  final RxString userRole = ''.obs;

  static GlobalController get to => Get.find();
}
