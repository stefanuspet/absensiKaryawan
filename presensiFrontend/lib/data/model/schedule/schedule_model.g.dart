// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleModelImpl _$$ScheduleModelImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleModelImpl(
      id: (json['id'] as num?)?.toInt(),
      date: DateTime.parse(json['date'] as String),
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      userId: (json['user_id'] as num).toInt(),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ScheduleModelImplToJson(_$ScheduleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'user_id': instance.userId,
      'user': instance.user,
    };
