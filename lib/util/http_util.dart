import 'package:dio/dio.dart';
import 'package:easy_tv_live/util/log_util.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._();
  late Dio _dio;
  BaseOptions options = BaseOptions(connectTimeout: 5000, receiveTimeout: 8000);

  CancelToken cancelToken = CancelToken();

  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._() {
    _dio = Dio(options)..interceptors.add(LogInterceptor(requestBody:true,responseBody:true,logPrint: LogUtil.v));
  }

  Future<T?> getRequest<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
     EasyLoading.show();
     Response? response;
     try {
       response = await _dio
           .get<T>(path,
           queryParameters: queryParameters,
           options: options,
           cancelToken: cancelToken,
           onReceiveProgress: onReceiveProgress);
       EasyLoading.dismiss();
     }on DioError catch(e){
       EasyLoading.dismiss();
       formatError(e);
     }
     return response?.data;
  }
}


void formatError(DioError e) {
  if (e.type == DioErrorType.connectTimeout) {
    EasyLoading.showToast("连接超时");
  } else if (e.type == DioErrorType.sendTimeout) {
    EasyLoading.showToast("请求超时");
  } else if (e.type == DioErrorType.receiveTimeout) {
    EasyLoading.showToast("响应超时");
  } else if (e.type == DioErrorType.response) {
    EasyLoading.showToast("出现异常");
  } else if (e.type == DioErrorType.cancel) {
    EasyLoading.showToast("请求取消");
  } else {
    EasyLoading.showToast(e.message.toString());
  }
}

