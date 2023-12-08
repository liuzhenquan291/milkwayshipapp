import 'package:get/get.dart';
import 'package:milkwayshipapp/core/server.dart';

class MyController extends GetxController {
  final ApiService _apiService = ApiService();

  void fetchData() async {
    try {
      final response =
          await _apiService.getRequest('https://example.com/api/data');
      // 处理响应数据
      print(response.data);
    } catch (e) {
      // 处理错误
      print('Error: $e');
    }
  }

  void postData() async {
    try {
      final data = {'key': 'value'};
      final response =
          await _apiService.postRequest('https://example.com/api/post', data);
      // 处理响应数据
      print(response.data);
    } catch (e) {
      // 处理错误
      print('Error: $e');
    }
  }
}
