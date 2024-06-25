// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paticipant_feedback.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantFeedbackDTO _$ParticipantFeedbackDTOFromJson(
        Map<String, dynamic> json) =>
    ParticipantFeedbackDTO(
      campaignRate: (json['campaignRate'] as num?)?.toInt() ?? 0,
      campaignFeedback: json['campaignFeedback'] as String?,
      organizationRate: (json['organizationRate'] as num?)?.toInt() ?? 0,
      organizationFeedback: json['organizationFeedback'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      campaignId: (json['campaignId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ParticipantFeedbackDTOToJson(
    ParticipantFeedbackDTO instance) {
  final val = <String, dynamic>{
    'campaignRate': instance.campaignRate,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('organizationFeedback', instance.organizationFeedback);
  val['organizationRate'] = instance.organizationRate;
  writeNotNull('campaignFeedback', instance.campaignFeedback);
  return val;
}
