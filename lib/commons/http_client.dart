import 'dart:convert';
import 'package:dio/dio.dart';
import '/commons/index.dart';

class HttpClient {

  // 单例模式
  static final HttpClient _instance = HttpClient._internal();
  factory HttpClient() => _instance;
  HttpClient._internal() {
    init();
  }

  late Dio _dio;
  init(){
    BaseOptions baseOptions = BaseOptions(
      // baseUrl: 'http://192.168.2.100:9092/api/v1/',
      baseUrl: 'https://web.moneywhere.com/api/v1/',
      contentType: 'application/json',
      headers: {
        'Accept-Language': 'zh-CN'
      },
      connectTimeout: const Duration(seconds: 100),
      receiveTimeout: const Duration(seconds: 100),
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
    final String token = await getToken();
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
  void onError(DioError e, handler) {
    String errorMsg = e.response?.data['message'] ?? '网络错误，请稍后重试';
    print(e);
    Message.error(errorMsg);
    super.onError(e, handler);
  }

}
