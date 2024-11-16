import 'package:dio/dio.dart';

/// Dio instance for API calls
final Dio dio = Dio(
  BaseOptions(
    baseUrl: 'localhost:8000/api/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
);
