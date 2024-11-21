import 'package:absen_presen/data/api/dio_config.dart';
import 'package:dio/dio.dart';

Future<Response<dynamic>> checkIn(String token) async {
  try {
    final response = await dio.post(
      'attendance-checkin',
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
Future<Response<dynamic>> checkOut(String token) async {
  try {
    final response = await dio.post(
      'attendance-checkout',
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
Future<Response<dynamic>> leave(String token) async {
  try {
    final response = await dio.post(
      'attendance-leave',
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

Future<Response<dynamic>> getMyAttendance(String token) async {
  try {
    final response = await dio.get(
      'myattendance',
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

Future<Response<dynamic>> adminGetAllAttendance(String token) async {
  try {
    final response = await dio.get(
      'attendance',
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

Future<Response<dynamic>> adminGetAttendanceByUser(String token, int id) async {
  try {
    final response = await dio.get(
      'attendance/$id',
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

Future<Response<dynamic>> adminUpdateAttendance(String token, int id, String status) async {
  try {
    final response = await dio.put(
      'attendance/$id',
      data: {
        'status': status,
      },
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
