import 'package:absen_presen/data/api/employee_api.dart';
import 'package:absen_presen/data/model/user/user_model.dart';
import 'package:absen_presen/logic/auth_logic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_list_logic.g.dart';

@riverpod
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
      final response = await getUsers(token ?? '');
      final data = response.data['data'].map(
        (e) => UserModel.fromJson(e),
      ).toList();
      state = AsyncData(data);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }
}
