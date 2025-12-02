import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:tf_dio_cache/tf_dio_cache.dart';

import '../utils/local_storage.dart';
import 'api_response.dart';

class ApiClient {
  final Dio _dio;
  final Logger _logger;
  final DioCacheManager cacheManager;

  ApiClient._(this._dio, this.cacheManager) : _logger = Logger('ApiClient');

  factory ApiClient(
    String baseUrl, {
    required LocalStorage storage,
    List<Interceptor> interceptors = const [],
    DioCacheManager? cacheManager,
  }) {
    final dioCacheManager =
        cacheManager ?? DioCacheManager(CacheConfig(defaultMaxAge: const Duration(days: 7), baseUrl: baseUrl));
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    dio.interceptors.add(dioCacheManager.interceptor);
    dio.interceptors.addAll(interceptors);

    return ApiClient._(dio, dioCacheManager);
  }

  Future<ApiResponse<T>> get<T>(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    required T Function(dynamic data) converter,
  }) {
    return request<T>(url, 'get', converter: converter, params: params, options: options);
  }

  Future<ApiResponse<T>> post<T>(String url, {T Function(dynamic data)? converter, dynamic data, Options? options}) {
    return request<T>(url, 'POST', converter: converter, data: data, options: options);
  }

  Future<ApiResponse<T>> put<T>(String url, {T Function(dynamic data)? converter, dynamic data}) {
    return request<T>(url, 'PUT', converter: converter, data: data);
  }

  Future<ApiResponse<T>> patch<T>(String url, {T Function(dynamic data)? converter, dynamic data}) {
    return request<T>(url, 'PATCH', converter: converter, data: data);
  }

  Future<ApiResponse<T>> delete<T>(String url, {T Function(dynamic data)? converter, dynamic params}) {
    return request<T>(url, 'DELETE', converter: converter, params: params);
  }

  Future<ApiResponse<T>> request<T>(
    String url,
    String method, {
    required T Function(dynamic data)? converter,
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
  }) async {
    final model = ApiResponse<T>();
    try {
      final response = await _dio.request(
        url,
        queryParameters: params,
        data: data,
        options: (options ?? Options()).copyWith(method: method),
      );

      _logger.info('request $url \nstatus-code:${response.statusCode};');
      model.result = converter?.call(response.data);
      model.statusCode = response.statusCode;
    } on DioException catch (e) {
      model.statusCode = e.response?.statusCode;

      _logger.warning('endpoind: $url, status code:${e.response?.statusCode}');
      _logger.warning(data);
      _logger.warning(e.response?.data);
      _copyToClipboard(e.response?.data);
      model.errorData = e.response?.data;
      _logger.warning('----------------------------');
      _logger.warning('request error: ');
      _logger.warning('$e');
      if (method != 'GET') _logger.warning('params $data');
      _logger.warning('----------------------------');
    } catch (e, trace) {
      _logger.warning('----------------------------');
      _logger.warning('request error: ');
      _logger.warning('$url $e');
      _logger.warning(trace);
      if (method != 'GET') _logger.warning('params $data');
      _logger.warning('----------------------------');
    }

    return model;
  }

  void _copyToClipboard(dynamic data) {
    if (kReleaseMode) return;
    Clipboard.setData(ClipboardData(text: data.toString()));
  }
}
