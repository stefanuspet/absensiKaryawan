import 'package:freezed_annotation/freezed_annotation.dart';

part 'departments_model.freezed.dart';
part 'departments_model.g.dart';

@freezed
class DepartmentsModel with _$DepartmentsModel {
  const factory DepartmentsModel({
    int? id,
    required String name,
    required String location,
}) = _DepartmentsModel;

  factory DepartmentsModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentsModelFromJson(json);
}
