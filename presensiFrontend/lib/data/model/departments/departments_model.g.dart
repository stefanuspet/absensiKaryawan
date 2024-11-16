// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DepartmentsModelImpl _$$DepartmentsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DepartmentsModelImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      location: json['location'] as String,
    );

Map<String, dynamic> _$$DepartmentsModelImplToJson(
        _$DepartmentsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
    };
