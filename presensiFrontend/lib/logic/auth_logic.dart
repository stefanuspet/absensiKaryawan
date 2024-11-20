import 'package:absen_presen/data/api/auth_api.dart';
import 'package:absen_presen/data/api/department_api.dart';
import 'package:absen_presen/data/model/departments/departments_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/model/user/user_model.dart';

part 'auth_logic.g.dart';

@riverpod
class AuthLogic extends _$AuthLogic {
  @override
  Future<AuthModel?> build() async {
    return null;
  }

  Future<void> doLogin(String username, String password) async {
    state = const AsyncLoading();
    try {
      final response = await login(username, password);
      final data = AuthModel.fromJson(response.data);

      // Fetch department data
      final department = await getDepartment(data.token, id: data.user.departmentId);
      final departmentData = DepartmentsModel.fromJson(department.data['data']);

      state = AsyncData(
        AuthModel(
          user: data.user.copyWith(department: departmentData),
          token: data.token,
        ),
      );
    } catch (e) {
      print(e);
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  Future<void> doLogout() async {
    state = const AsyncLoading();
    try {
      if (state.value != null) {
        final response = await logout(state.value?.token ?? '');
        if (response.statusCode == 200) {
          state = AsyncData(null);
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
