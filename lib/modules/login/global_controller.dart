import 'package:get/get.dart';

class GlobalController extends GetxController {
  String? userId = '';
  String? token = '';
  bool? isLogin = false;
  String? username = '';
  String? userDisplayName = '';
  String? userRole = '';

  static GlobalController get to => Get.find();
}
