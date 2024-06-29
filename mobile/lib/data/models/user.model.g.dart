// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num?)?.toInt(),
      avatar: json['avatar'] as String?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      gender: json['gender'] as bool?,
      email: json['email'] as String?,
      birthDay: json['birthDay'] == null
          ? null
          : DateTime.parse(json['birthDay'] as String),
      address: json['address'] as String?,
      workSpace: json['workSpace'] as String?,
      projectPending: (json['projectPending'] as num?)?.toInt(),
      projectCompleted: (json['projectCompleted'] as num?)?.toInt(),
      projectOnGoing: (json['projectOnGoing'] as num?)?.toInt(),
      currentOrganization: json['currentOrganization'] == null
          ? null
          : OrganizationModel.fromJson(
              json['currentOrganization'] as Map<String, dynamic>),
      pendingCampaigns: (json['totalPendingCampaigns'] as num?)?.toInt() ?? 0,
      ongoingCampaigns: (json['totalOngoingCampaigns'] as num?)?.toInt() ?? 0,
      totalFeedbacks: (json['totalFeedbacks'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
      'email': instance.email,
      'birthDay': instance.birthDay?.toIso8601String(),
      'address': instance.address,
      'workSpace': instance.workSpace,
      'projectPending': instance.projectPending,
      'projectCompleted': instance.projectCompleted,
      'projectOnGoing': instance.projectOnGoing,
      'currentOrganization': instance.currentOrganization?.toJson(),
      'totalPendingCampaigns': instance.pendingCampaigns,
      'totalOngoingCampaigns': instance.ongoingCampaigns,
      'totalFeedbacks': instance.totalFeedbacks,
    };
