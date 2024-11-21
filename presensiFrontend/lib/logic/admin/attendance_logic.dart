import 'package:absen_presen/data/api/attendance_api.dart';
import 'package:absen_presen/data/model/attendance/attendance_model.dart';
import 'package:absen_presen/logic/admin/users_list_logic.dart';
import 'package:absen_presen/logic/auth_logic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attendance_logic.g.dart';

@Riverpod(keepAlive: true)
class AttendanceLogic extends _$AttendanceLogic {
  @override
  Future<List<AttendanceModel>> build() async {
    fetchAttendanceModel();
    return state.value ?? [];
  }

  Future<void> fetchAttendanceModel() async {
    state = const AsyncLoading();
    try {
      final authToken = ref.read(authLogicProvider).value?.token;
      final userData = ref.read(usersListLogicProvider).value;

      final response = await adminGetAllAttendance(authToken ?? '');
      final responseBody = response.data['data'] as List<dynamic>;
      final data = responseBody.map(
        (e) => AttendanceModel.fromJson(e),
      ).toList();
      print(userData);

      for (var i = 0; i < data.length; i++) {
        for (var j = 0; j < (userData?.length ?? 0); j++) {
          if (data[i].userId == userData?[j].id) {
            data[i] = data[i].copyWith(user: userData?[j]);
          }
        }
      }

      state = AsyncData(data);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }
}
