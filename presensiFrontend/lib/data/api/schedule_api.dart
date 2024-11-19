import 'package:absen_presen/data/api/dio_config.dart';
import 'package:absen_presen/data/model/schedule/schedule_model.dart';
import 'package:dio/dio.dart';

Future<Response<dynamic>> getScheduleByUser(String token, {required int id}) async {
  try {
    final response = await dio.get(
      'userschedule/$id',
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

Future<Response<dynamic>> storeSchedule(String token, ScheduleModel newSchedule) async {
  final data = newSchedule.toJson();
  data['start_time'] = '${newSchedule.startTime.hour}:${newSchedule.startTime.minute}:00';
  data['end_time'] = '${newSchedule.endTime.hour}:${newSchedule.endTime.minute}:00';

  try {
    final response = await dio.post(
      'schedules',
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

Future<Response<dynamic>> getAllSchedule(String token) async {
  try {
    final response = await dio.get(
      'schedules',
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

Future<Response<dynamic>> updateSchedule(String token, ScheduleModel newSchedule) async {
  final data = newSchedule.toJson();
  data['start_time'] = '${newSchedule.startTime.hour}:${newSchedule.startTime.minute}:00';
  data['end_time'] = '${newSchedule.endTime.hour}:${newSchedule.endTime.minute}:00';

  try {
    final response = await dio.put(
      'schedules/${newSchedule.id}',
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

Future<Response<dynamic>> deleteSchedule(String token, int scheduleId) async {
  try {
    final response = await dio.delete(
      'schedules/$scheduleId',
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
