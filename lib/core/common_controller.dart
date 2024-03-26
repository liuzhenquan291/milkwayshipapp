import 'package:get/get.dart';

class TimePickerController extends GetxController {
  RxString selectedTime = ''.obs;

  void selectTime(DateTime pickedTime) {
    selectedTime.value = pickedTime.toString();
  }
}
