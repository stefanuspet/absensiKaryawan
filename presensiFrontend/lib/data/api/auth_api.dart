import 'package:absen_presen/data/api/dio_config.dart';
import 'package:absen_presen/data/model/user/user_model.dart';
import 'package:dio/dio.dart';

Future<Response<dynamic>> login(String email, String password) async {
  final data = {
    'email': email,
    'password': password,
  };
  try {
    final response = await dio.post(
      'login',
      data: data,
    );
    return response;
  } on DioException {
    rethrow;
  }
}

Future<Response<dynamic>> logout(String token) async {
  try {
    final response = await dio.get(
      'logout',
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

Future<Response<dynamic>> registerEmployee(String token, {
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
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response;
  } on DioException {
    rethrow;
  }
}

Future<Response<dynamic>> updateUser(String token, UserModel newUserData) async {
  final data = newUserData.toJson();
  try {
    final response = await dio.post(
      'register',
      data: data,
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

Future<Response<dynamic>> getProfile(String token) async {
  try {
    final response = await dio.get(
      'profile',
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

Future<Response<dynamic>> getUsers(String token) async {
  try {
    final response = await dio.get(
      'users',
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
