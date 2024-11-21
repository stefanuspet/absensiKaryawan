import 'package:absen_presen/data/model/departments/departments_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    int? id,
    String? password,
    required String name,
    required String email,
    required String phone,
    required String role,
    @JsonKey(name: 'department_id') required int departmentId,
    DepartmentsModel? department,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class AuthModel with _$AuthModel {
  const factory AuthModel({
    @JsonKey(name: 'data') required UserModel user,
    required String token,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
}
