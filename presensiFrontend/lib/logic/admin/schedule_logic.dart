import 'package:absen_presen/data/api/department_api.dart';
import 'package:absen_presen/data/api/employee_api.dart';
import 'package:absen_presen/data/api/schedule_api.dart';
import 'package:absen_presen/data/model/departments/departments_model.dart';
import 'package:absen_presen/data/model/schedule/schedule_model.dart';
import 'package:absen_presen/logic/auth_logic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/user/user_model.dart';

part 'schedule_logic.g.dart';

@Riverpod(keepAlive: true)
class ScheduleLogic extends _$ScheduleLogic {
  @override
  Future<List<ScheduleModel>> build() async {
    await fetchSchedules();
    return state.value ?? [];
  }

  Future<void> fetchSchedules() async {
    state = const AsyncLoading();
    final token = ref.read(authLogicProvider).value?.token;
    try {
      final response = await getAllSchedule(token ?? '');
      final responseData = response.data['data'] as List<dynamic>;
      final data = responseData.map(
            (e) => ScheduleModel.fromJson(e),
      ).toList();

      final userResponse = await getUsers(token ?? '');
      final userResponseData = userResponse.data['data'] as List<dynamic>;
      final userList = userResponseData.map(
            (e) => UserModel.fromJson(e),
      ).toList();

      for (var i = 0; i < data.length; i++) {
        for (var j = 0; j < userList.length; j++) {
          if (data[i].userId == userList[j].id) {
            data[i] = data[i].copyWith(user: userList[j]);
          }
        }
      }

      state = AsyncData(data);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }
}
