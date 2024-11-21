import 'package:absen_presen/data/api/department_api.dart';
import 'package:absen_presen/data/api/employee_api.dart';
import 'package:absen_presen/data/model/departments/departments_model.dart';
import 'package:absen_presen/data/model/user/user_model.dart';
import 'package:absen_presen/logic/auth_logic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_list_logic.g.dart';

@Riverpod(keepAlive: true)
class UsersListLogic extends _$UsersListLogic {
  @override
  Future<List<UserModel>> build() async {
    fetchAllUser();
    return state.value ?? [];
  }

  Future<void> fetchAllUser() async {
    final token = ref.read(authLogicProvider).value?.token;

    try {
      state = const AsyncLoading();

      // User list
      final response = await getUsers(token ?? '');
      final responseData = response.data['data'] as List<dynamic>;
      final data = responseData.map(
        (e) => UserModel.fromJson(e),
      ).toList();

      // Department list
      final departmentResponse = await getDepartment(token ?? '');
      final departmentResponseData = departmentResponse.data['data'] as List<dynamic>;
      final departmentData = departmentResponseData.map(
        (e) => DepartmentsModel.fromJson(e),
      ).toList();

      for (var i = 0; i < data.length; i++) {
        for (var j = 0; j < departmentData.length; j++) {
          if (data[i].departmentId == departmentData[j].id) {
            data[i] = data[i].copyWith(department: departmentData[j]);
          }
        }
      }

      state = AsyncData(data);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }
}
