import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../app_launch.dart';
import '../../core/constant/app_url.dart';
import '../../presentation/views/widgets/flutter_toast.dart';
import '../models/response/auth/auth_token.dart';
import '../models/response/auth/login_response.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;

  late final Dio _dio;

  HttpUtil._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: AppUrl.baseUrl,
      connectTimeout: const Duration(seconds: 40),
      receiveTimeout: const Duration(seconds: 45),
      headers: {
        // 'Accept': '*/*',
        'Accept-Charset': 'UTF-8',
      },
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,

    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = getIt<AuthToken>().authToken;
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) => handler.next(response),
      onError: (error, handler) {
        // final message = _getErrorMessage(error);
        // showToast(message: message);
        handler.next(error);
      },
    ));

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        logPrint: (log) => debugPrint(log.toString()),
      ));
    }
  }

  static const Duration _defaultTimeout = Duration(minutes: 5);

  Future<Response> get(
      String url, {
        Map<String, dynamic>? queryParameters,
      }) async {
    return _performRequest(() => _dio.get(
      url,
      queryParameters: queryParameters,
    ));
  }

  Future<Response> post(
      String url, {
        Object? data,
        Map<String, dynamic>? queryParameters,
      }) async {
    return _performRequest(() => _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
    ));
  }

  Future<Response> put(
      String url, {
        Object? data,
        Map<String, dynamic>? queryParameters,
      }) async {
    return _performRequest(() => _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
    ));
  }

  Future<Response> delete(
      String url, {
        Object? data,
        Map<String, dynamic>? queryParameters,
      }) async {
    return _performRequest(() => _dio.delete(
      url,
      data: data,
      queryParameters: queryParameters,
    ));
  }

  Future<Response> patch(
      String url, {
        Object? data,
        Map<String, dynamic>? queryParameters,
      }) async {
    return _performRequest(() => _dio.patch(
      url,
      data: data,
      queryParameters: queryParameters,
    ));
  }

  Future<Response> _performRequest(Future<Response> Function() request) async {
    try {
      return await request().timeout(_defaultTimeout);
    } on DioException catch (_) {
      // showToast(message: _getErrorMessage(error));
      rethrow;
    } catch (e) {
      // showToast(message: errorDefaultMessage);
      rethrow;
    }
  }
}

extension ResponseExt on Response {
  bool get isSuccessful => statusCode != null && statusCode! >= 200 && statusCode! < 300;
  dynamic get body => data;
}

const String errorDefaultMessage = 'An error occurred';

String networkErrorHandler(DioException error, {Function(DioException e)? onResponseError}) {
  switch (error.type) {
    case DioExceptionType.badCertificate:
      return NetworkErrorMessage.errorOccurred;
    case DioExceptionType.connectionTimeout:
      return NetworkErrorMessage.noInternetConnection;
    case DioExceptionType.badResponse:
      return error.response?.data["message"] ?? errorDefaultMessage;
    case DioExceptionType.unknown:
      return error.response?.data["message"] ?? errorDefaultMessage;
    default:
      return errorDefaultMessage;
  }
}


void handleError(
    dynamic error, {
      required Function(String message) onEmit,
    }) {
  String errorMessage = "Something went wrong. Please try again.";

  if (error is DioException) {
    try {
      final responseData = error.response?.data;

      if (responseData is Map && responseData.containsKey("error")) {
        errorMessage = responseData["error"].toString();
      } else if (responseData is String && responseData.isNotEmpty) {
        errorMessage = responseData;
      } else if (error.response?.statusCode == 503) {
        errorMessage = "Service temporarily unavailable. Please try again later.";
      } else if (responseData["error"].toLowerCase() == "token is not valid") {
        errorMessage = "Session expired. Please login again";

        if (kDebugMode) {
          print("got here");
        }
        //TODO: NavHelper.navToLoginScreen();
      }
      else {
        errorMessage = "Network error. Please try again.";
      }
    } catch (_) {
      errorMessage = "Unexpected error. Please try again.";
    }
  } else if (error is FormatException) {
    errorMessage = "Invalid data format received from server.";
  } else if (error is TimeoutException) {
    errorMessage = "Request timed out. Please check your internet connection.";
  }

  // Emit and show the error
  onEmit(errorMessage);
  showToast(message: errorMessage);
}

class NetworkErrorMessage {

  static const errorOccurred = "An error occurred";

  static const noInternetConnection = "No internet connection";

  static const timeOut = "Please check your internet connection";

  static const serviceUnavailable = "Service unavailable";

  static const tooManyRequests = "Take a little breather and try again shortly";

}