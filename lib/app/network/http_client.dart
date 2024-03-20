import 'package:get/get.dart' as getx;
import 'dart:convert';
import 'package:dio/dio.dart';
import '/generated/locales.g.dart';
import '/app/core/utils/token.dart';
import '/app/core/values/app_values.dart';
import '/app/core/utils/message.dart';

class HttpClient {

  // 单例模式
  static final HttpClient _instance = HttpClient._internal();
  factory HttpClient() => _instance;
  HttpClient._internal() {
    init();
  }

  late Dio _dio;
  init() {
    BaseOptions baseOptions = BaseOptions(
      // baseUrl: 'http://192.168.2.4:9092/api/v1/',
      // baseUrl: '${AppValues.apiUrl}/api/v1/',
      contentType: 'application/json',
      headers: {
        'Accept-Language': getx.Get.locale.toString().replaceAll("_", "-")
      },
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 120),
    );
    _dio = Dio(baseOptions);
    _dio.interceptors.add(TokenInterceptor());
    _dio.interceptors.add(ExceptionInterceptor());
  }

  Future<Map<String, dynamic>> get(String uri, {Map<String, dynamic>? params}) async {
    var response = await _dio.get(uri, queryParameters: params);
    return jsonDecode(response.toString());
  }

  Future<Map<String, dynamic>> post(String uri, {data}) async {
    var response = await _dio.post(uri, data: data);
    return jsonDecode(response.toString());
  }

  Future<Map<String, dynamic>> delete(String uri) async {
    var response = await _dio.delete(uri);
    return jsonDecode(response.toString());
  }

  Future<Map<String, dynamic>> put(String uri, {data}) async {
    var response = await _dio.put(uri, data: data);
    return jsonDecode(response.toString());
  }

  Future<Map<String, dynamic>> patch(String uri, {data}) async {
    var response = await _dio.patch(uri, data: data);
    return jsonDecode(response.toString());
  }

}

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final String token = await Token.get();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}

// 全局错误处理
class ExceptionInterceptor extends Interceptor {

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data['showType'] == 4) {
      Message.success(response.data['message']);
    }
    if (response.data['showType'] == 2) {
      Message.error(response.data['message']);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, handler) {
    String errorMsg = '';
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (err.response != null) {
      errorMsg = err.response?.data['message'] ?? LocaleKeys.common_netError.tr;
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      errorMsg = '${err.type} - ${err.message}';
    }
    Message.error(errorMsg);
    super.onError(err, handler);
  }

}
