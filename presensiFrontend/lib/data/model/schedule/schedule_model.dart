import 'package:absen_presen/data/model/user/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_model.freezed.dart';
part 'schedule_model.g.dart';

@freezed
class ScheduleModel with _$ScheduleModel {
    const factory ScheduleModel({
        int? id,
        required DateTime date,
        @JsonKey(name: 'start_time') required String startTime,
        @JsonKey(name: 'end_time') required String endTime,
        @JsonKey(name: 'user_id') required int userId,
        UserModel? user,
    }) = _ScheduleModel;

    factory ScheduleModel.fromJson(Map<String, dynamic> json) => _$ScheduleModelFromJson(json);
}
