import 'package:absen_presen/data/model/attendance/attendance_model.dart';
import 'package:absen_presen/logic/admin/users_list_logic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attendance_logic.g.dart';

@riverpod
class AttendanceLogic extends _$AttendanceLogic {
  @override
  Future<List<AttendanceModel>> build() async {
    fetchAttendanceModel();
    return state.value ?? [];
  }

  Future<void> fetchAttendanceModel() async {
    state = const AsyncLoading();
    try {
      final userData = ref.read(usersListLogicProvider).value;

    } catch (e) {

    }
  }
}
