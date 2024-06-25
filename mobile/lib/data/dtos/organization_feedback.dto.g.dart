// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_feedback.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationFeedbackDTO _$OrganizationFeedbackDTOFromJson(
        Map<String, dynamic> json) =>
    OrganizationFeedbackDTO(
      images: json['image'] as List<dynamic>?,
      locationRate: (json['locationRate'] as num?)?.toInt() ?? 0,
      traffic: json['traffic'] as String?,
      weather: json['weather'] as String?,
      sanitization: json['sanitization'] as String?,
      residence: json['residence'] as String?,
      authorityCooperation: json['authorityCooperation'] as String?,
      others: json['others'] as String?,
      campaignId: (json['campaignId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrganizationFeedbackDTOToJson(
    OrganizationFeedbackDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('image', instance.images);
  val['locationRate'] = instance.locationRate;
  writeNotNull('traffic', instance.traffic);
  writeNotNull('weather', instance.weather);
  writeNotNull('sanitization', instance.sanitization);
  writeNotNull('residence', instance.residence);
  writeNotNull('authorityCooperation', instance.authorityCooperation);
  writeNotNull('others', instance.others);
  return val;
}
