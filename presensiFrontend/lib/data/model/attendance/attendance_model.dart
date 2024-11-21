import 'package:absen_presen/data/model/user/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_model.freezed.dart';
part 'attendance_model.g.dart';

@freezed
class AttendanceModel with _$AttendanceModel {
    const factory AttendanceModel({
        int? id,
        UserModel? user,
        @JsonKey(name: 'user_id') required int userId,
        required DateTime date,
        @JsonKey(name: 'start_time') String? startTime,
        @JsonKey(name: 'end_time') String? endTime,
        String? status,
    }) = _AttendanceModel;

    factory AttendanceModel.fromJson(Map<String, dynamic> json) => _$AttendanceModelFromJson(json);
}
