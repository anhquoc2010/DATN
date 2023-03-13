// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      birthDay: json['birth_day'] == null
          ? null
          : DateTime.parse(json['birth_day'] as String),
      gender: json['gender'] as bool?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      avatar: json['avatar'] as String?,
      projectPending: json['project_pending'] as int?,
      projectCompleted: json['project_completed'] as int?,
      projectOnGoing: json['project_on_going'] as int?,
      school: json['school'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'birth_day': instance.birthDay?.toIso8601String(),
      'gender': instance.gender,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      'avatar': instance.avatar,
      'project_pending': instance.projectPending,
      'project_completed': instance.projectCompleted,
      'project_on_going': instance.projectOnGoing,
      'school': instance.school,
    };
