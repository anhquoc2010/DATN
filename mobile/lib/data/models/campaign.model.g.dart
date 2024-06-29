// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignModel _$CampaignModelFromJson(Map<String, dynamic> json) =>
    CampaignModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      location: json['location'] == null
          ? null
          : AddressModel.fromJson(json['location'] as Map<String, dynamic>),
      address: json['address'] as String?,
      specificAddress: json['specificAddress'] as String?,
      isUserJoined: json['joined'] as bool? ?? false,
      isUserGaveFeedback: json['gaveFeedback'] as bool? ?? false,
      description: json['description'] as String?,
      startDate: const JsonSerializableDateTime()
          .fromJson(json['startDate'] as String),
      endDate:
          const JsonSerializableDateTime().fromJson(json['endDate'] as String),
      registerLink: json['registerLink'] as String?,
      donationRequirement: json['donationRequirement'] as String?,
      otherInformation: json['otherInformation'] as String?,
      image: json['image'] as String?,
      userFeedbacks: (json['userFeedbacks'] as List<dynamic>?)
              ?.map((e) =>
                  ParticipantFeedbackDTO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      feedback: json['feedback'] == null
          ? null
          : FeedbackToCampaignDTO.fromJson(
              json['feedback'] as Map<String, dynamic>),
      coordinate: (json['coordinate'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      organization: json['organization'] == null
          ? null
          : OrganizationModel.fromJson(
              json['organization'] as Map<String, dynamic>),
      volunteers: (json['volunteers'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      donors: (json['donors'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CampaignModelToJson(CampaignModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['image'] = instance.image;
  writeNotNull('location', instance.location?.toJson());
  writeNotNull('address', instance.address);
  val['specificAddress'] = instance.specificAddress;
  val['coordinate'] = instance.coordinate;
  val['description'] = instance.description;
  val['startDate'] =
      const JsonSerializableDateTime().toJson(instance.startDate);
  val['endDate'] = const JsonSerializableDateTime().toJson(instance.endDate);
  val['registerLink'] = instance.registerLink;
  val['donationRequirement'] = instance.donationRequirement;
  val['otherInformation'] = instance.otherInformation;
  val['organization'] = instance.organization?.toJson();
  return val;
}
