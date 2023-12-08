import 'package:get/get.dart';

class GlobalController extends GetxController {
  final RxString token = ''.obs;

  static GlobalController get to => Get.find();
}
