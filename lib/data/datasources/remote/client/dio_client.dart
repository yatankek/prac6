import 'package:dio/dio.dart';
import 'package:prac6/data/datasources/remote/api/api_config.dart';
import 'package:prac6/data/datasources/remote/interceptors/error_interceptor.dart';

class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            connectTimeout: ApiConfig.connectTimeout,
            receiveTimeout: ApiConfig.receiveTimeout,
            responseType: ResponseType.json,
          ),
        ) {
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (object) {
          print('DIO LOG: $object');
        },
      ),
    );

    _dio.interceptors.add(ErrorInterceptor());
  }

  Dio get dio => _dio;
}
