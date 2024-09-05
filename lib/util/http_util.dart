import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../generated/l10n.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._();
  late Dio _dio;
  BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10));

  CancelToken cancelToken = CancelToken();

  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._() {
    _dio = Dio(options)
      ..interceptors.add(LogInterceptor(
          requestBody: true, responseBody: true, logPrint: LogUtil.v));
  }

  Future<T?> getRequest<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      bool isShowLoading = true}) async {
    LogUtil.v('GetRequest::::::$path');
    if (isShowLoading) EasyLoading.show();
    Response? response;
    try {
      response = await _dio.get<T>(path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      if (isShowLoading) EasyLoading.dismiss();
    } on DioException catch (e) {
      if (isShowLoading) EasyLoading.dismiss();
      formatError(e, isShowLoading);
    }
    return response?.data;
  }

  Future<int?> downloadFile(String url, String savePath,
      {ValueChanged<double>? progressCallback}) async {
    Response? response;
    try {
      // await _dio.head(url);
      response = await _dio.download(
        url,
        savePath,
        options: Options(
          receiveTimeout: const Duration(seconds: 60),
          headers: {
            HttpHeaders.acceptEncodingHeader: '*',
            HttpHeaders.userAgentHeader:
                'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36',
          },
        ),
        onReceiveProgress: (received, total) {
          if (total <= 0) return;
          progressCallback?.call((received / total));
        },
      );
      if (response.statusCode != 200) {
        throw DioException(
            requestOptions: response.requestOptions,
            error: 'status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      formatError(e, true);
    }
    return response?.statusCode ?? 500;
  }
}

void formatError(DioException e, bool isShowLoading) {
  LogUtil.v('DioException>>>>>$e');
  if (!isShowLoading) return;
  if (e.type == DioExceptionType.connectionTimeout) {
    EasyLoading.showToast(S.current.netTimeOut);
  } else if (e.type == DioExceptionType.sendTimeout) {
    EasyLoading.showToast(S.current.netSendTimeout);
  } else if (e.type == DioExceptionType.receiveTimeout) {
    EasyLoading.showToast(S.current.netReceiveTimeout);
  } else if (e.type == DioExceptionType.badResponse) {
    EasyLoading.showToast(
        S.current.netBadResponse(e.response?.statusCode ?? ''));
  } else if (e.type == DioExceptionType.cancel) {
    EasyLoading.showToast(S.current.netCancel);
  } else {
    EasyLoading.showToast(e.message.toString());
  }
}
