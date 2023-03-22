import 'package:dio/dio.dart';

Dio createDioClient() {
  Dio dio = Dio(
    BaseOptions(baseUrl: 'http://34.22.70.110:9090',
    ),

  );
  return dio;
}