import 'package:absen_presen/data/api/dio_config.dart';
import 'package:dio/dio.dart';

Future<Response<dynamic>> registerEmployee({
  required String name,
  required String email,
  required String password,
  required String phone,
required int departmentId,
}) async {
  final data = {
    'name': name,
    'email': email,
    'password': password,
    'phone': phone,
    'department_id': departmentId,
  };
  try {
    final response = await dio.post(
      'register',
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return response;
  } on DioException {
    rethrow;
  }
}
