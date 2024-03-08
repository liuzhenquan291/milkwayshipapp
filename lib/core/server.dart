import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkwayshipapp/core/urls.dart';

import '../modules/login/global_controller.dart';
import 'apps.dart';

class ResponseData {
  int? code;
  String? message;
  dynamic data;

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
}

class ApiService extends GetxService {
  String? token = "";
  bool? isLogin = false;
  late dio.Dio _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = dio.Dio();
    _dio.options.baseUrl = apiUrl.baseUrl;

    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (dio.RequestOptions options,
            dio.RequestInterceptorHandler handler) {
          if (isLogin == true) {
            options.headers['Authorization'] = token ?? "";
          } else {
            final gc = Get.find<GlobalController>();
            if (gc.isLogin != null && gc.isLogin == true) {
              isLogin = true;
              token = "Token ${gc.token}";
              options.headers['Authorization'] = token ?? "";
            }
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
            Get.offAllNamed(appRoute.loginPage); // 你的登录页面路由
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
          } else if (dioError.response?.statusCode != 200) {
            String message = '服务器错误...';
            try {
              final data = dioError.response?.data as Map<String, dynamic>;
              message = data['message'];
            } catch (e) {
              print(e);
            }
            print(message);
            Get.defaultDialog(
              title: '服务器错误',
              content: Text(message),
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

  Future<dio.Response> getRequest(
      String url, Map<String, dynamic>? data) async {
    try {
      if (data != null && data.isNotEmpty) {
        url = "$url?_i=0";
        data.forEach((key, value) {
          url = "$url&$key=$value";
        });
      }
      final response = await _dio.get(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dio.Response?> postRequest(
      String url, Map<String, dynamic>? data) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dio.Response?> deleteRequest(
      String url, Map<String, dynamic>? data) async {
    try {
      final response = await _dio.delete(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
