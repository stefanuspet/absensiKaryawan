import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_model.freezed.dart';
part 'attendance_model.g.dart';

@freezed
class AttendanceModel with _$AttendanceModel {
    const factory AttendanceModel({
        int? id,
        required DateTime date,
        @JsonKey(name: 'start_time') required DateTime startTime,
        @JsonKey(name: 'end_time') required DateTime endTime,
        required String status,
    }) = _AttendanceModel;

    factory AttendanceModel.fromJson(Map<String, dynamic> json) => _$AttendanceModelFromJson(json);
}
