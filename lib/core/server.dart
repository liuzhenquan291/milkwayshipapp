import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/urls.dart';

class ApiService extends GetxService {
  String? token = "";
  bool? isLogin = false;
  late dio.Dio _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = dio.Dio();
    _dio.options.baseUrl = baseUrl;

    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (dio.RequestOptions options,
            dio.RequestInterceptorHandler handler) {
          if (isLogin == true) {
            options.headers['Authorization'] = token ?? "";
          }
          return handler.next(options);
        },
        // onResponse:
        //     (Response response, dio.ResponseInterceptorHandler handler) {
        //   // 在收到响应时做一些事情
        //   return handler.next(response);
        // },
        onError:
            (dio.DioError dioError, dio.ErrorInterceptorHandler handler) async {
          // 在发生错误时做一些事情
          if (dioError.response?.statusCode == 401) {
            if (token != "") {
              token = "";
              Get.dialog(
                const Text("登录信息已过期, 请重新登录..."),
              );
            }
            Get.dialog(
              const Text("请登录..."),
            );
            Get.offAllNamed('/login'); // 你的登录页面路由
          } else if (dioError.response?.statusCode == 404) {
            // 弹窗请求错误
            Get.defaultDialog(
              title: '未找到资源',
              content: const Text('未找到资源...'),
              confirm: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('OK'),
              ),
            );
          } else {
            return handler.next(dioError);
          }
        },
      ),
    );
  }

  Future<dio.Response> getRequest(String url, dynamic data) async {
    try {
      final response = await _dio.get(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dio.Response?> postRequest(String url, dynamic data) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
