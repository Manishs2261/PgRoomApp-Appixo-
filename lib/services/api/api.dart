import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_constant.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final Dio _dio = Dio();
  final _storage = const FlutterSecureStorage();



  Future<void> init() async {
    _dio.options.baseUrl = ApiConstant.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);

    // Attach interceptors
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // handle success globally if needed
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          // Token expired — trigger logout
          await handleLogout();
        }
        return handler.next(e);
      },
    ));
  }

  Future<void> handleLogout() async {
    await _storage.deleteAll();
    // You can add navigation logic here if using Navigator or GetX
    debugPrint("User logged out due to expired session.");
  }

  Future<Response?> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.get(endpoint, queryParameters: params);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Response?> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Response?> put(String endpoint, {dynamic data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Response?> delete(String endpoint, {dynamic data}) async {
    try {
      return await _dio.delete(endpoint, data: data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Response? _handleError(DioException e) {
    String message = "Something went wrong";

    if (e.type == DioExceptionType.connectionTimeout) {
      message = "Connection Timeout";
    } else if (e.type == DioExceptionType.receiveTimeout) {
      message = "Receive Timeout";
    } else if (e.type == DioExceptionType.badResponse) {
      message = "Server Error: ${e.response?.statusCode}";
    } else if (e.type == DioExceptionType.unknown) {
      message = "No Internet Connection";
    }

    debugPrint("❌ API Error: $message");
    return e.response;
  }
}
