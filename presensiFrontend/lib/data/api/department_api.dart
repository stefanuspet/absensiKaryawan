import 'package:absen_presen/data/api/dio_config.dart';
import 'package:absen_presen/data/model/departments/departments_model.dart';
import 'package:dio/dio.dart';

Future<Response<dynamic>> getDepartment(String token, {int? id}) async {
  try {
    final response = await dio.get(
      id != null ? 'department/$id' : 'department',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response;
  } on DioException {
    rethrow;
  }
}

Future<Response<dynamic>> addDepartment(String token, DepartmentsModel newDepartment) async {
  try {
    final response = await dio.get(
      'department',
      data: newDepartment.toJson(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response;
  } on DioException {
    rethrow;
  }
}

Future<Response<dynamic>> editDepartment(String token, DepartmentsModel newDepartment) async {
  try {
    final response = await dio.put(
      'department/${newDepartment.id}',
      data: newDepartment.toJson(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response;
  } on DioException {
    rethrow;
  }
}

Future<Response<dynamic>> deleteDepartment(String token, int departmentId) async {
  try {
    final response = await dio.put(
      'department/$departmentId',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response;
  } on DioException {
    rethrow;
  }
}
