import 'package:absen_presen/data/api/department_api.dart';
import 'package:absen_presen/data/model/departments/departments_model.dart';
import 'package:absen_presen/logic/auth_logic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'department_logic.g.dart';

@Riverpod(keepAlive: true)
class DepartmentLogic extends _$DepartmentLogic {
  @override
  Future<List<DepartmentsModel>> build() async {
    await fetchDepartment();
    return state.value ?? [];
  }

  Future<void> fetchDepartment() async {
    state = const AsyncLoading();
    final token = ref.read(authLogicProvider).value?.token;
    try {
      final response = await getDepartment(token ?? '');
      final responseData = response.data['data'] as List<dynamic>;
      final data = responseData.map(
        (e) => DepartmentsModel.fromJson(e),
      ).toList();
      state = AsyncData(data);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }
}
