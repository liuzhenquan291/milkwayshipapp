import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as myGet;

import 'apps.dart';
import 'urls.dart';

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

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: apiUrl.baseUrl, // 你的 API 基础地址
      connectTimeout: 5000, // 连接超时时间
      receiveTimeout: 5000, // 接收超时时间
    );
    _dio = Dio(options);

    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError dioError, ErrorInterceptorHandler handler) async {
        // 在发生错误时做一些事情
        if (dioError.response?.statusCode == 401) {
          token = null;

          myGet.Get.dialog(const Text("登录信息已过期, 请重新登录..."));

          myGet.Get.offAllNamed(AppRoute.loginPage); // 你的登录页面路由
        } else if (dioError.response?.statusCode == 404) {
          // 弹窗请求错误
          myGet.Get.defaultDialog(
            title: '未找到资源',
            content: const Text('未找到资源...'),
            confirm: TextButton(
              onPressed: () {
                myGet.Get.back();
              },
              child: const Text('OK'),
            ),
          );
        } else if (dioError.response?.statusCode != 200) {
          String message = '服务器错误...';
          try {
            final data = dioError.response?.data;
            if (data == null) {
              message = "";
            } else {
              message = data['message'];
            }
          } catch (e) {
            rethrow;
          }
          myGet.Get.defaultDialog(
            title: '服务器错误',
            content: Text(message),
            confirm: TextButton(
              onPressed: () {
                myGet.Get.back();
              },
              child: const Text('OK'),
            ),
          );
        } else {
          return handler.next(dioError);
        }
      },
    ));
  } // 私有构造函数

  late final Dio _dio;
  String? _token;

  Dio get dio => _dio;

  String? get token => _token;

  set token(String? newToken) {
    _token = newToken;
    if (_token != null) {
      _dio.options.headers['Authorization'] = 'Token $_token';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  Future<Response> getRequest(String url, Map<String, dynamic>? data) async {
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

  Future<Response> postRequest(String url, Map<String, dynamic>? data) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response?> deleteRequest(
      String url, Map<String, dynamic>? data) async {
    try {
      final response = await _dio.delete(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> putRequest(String url, Map<String, dynamic>? data) async {
    try {
      final response = await _dio.put(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
