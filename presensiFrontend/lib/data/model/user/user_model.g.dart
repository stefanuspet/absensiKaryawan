// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num?)?.toInt(),
      password: json['password'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String,
      departmentId: (json['department_id'] as num).toInt(),
      department: json['department'] == null
          ? null
          : DepartmentsModel.fromJson(
              json['department'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'password': instance.password,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'role': instance.role,
      'department_id': instance.departmentId,
      'department': instance.department,
    };

_$AuthModelImpl _$$AuthModelImplFromJson(Map<String, dynamic> json) =>
    _$AuthModelImpl(
      user: UserModel.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$$AuthModelImplToJson(_$AuthModelImpl instance) =>
    <String, dynamic>{
      'data': instance.user,
      'token': instance.token,
    };
