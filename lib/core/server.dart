import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

class ApiService extends GetxService {
  late dio.Dio _dio;
  // var _dio = dio.Dio(dio.BaseOptions(
  //   baseUrl: "",
  //   headers: {
  //     HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
  //         "application/vnd.github.symmetra-preview+json",
  //   },
  // ));

  @override
  void onInit() {
    super.onInit();
    _dio = dio.Dio();
  }

  Future<dio.Response> getRequest(String url, dynamic data) async {
    try {
      final response = await _dio.get(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dio.Response> postRequest(String url, dynamic data) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
