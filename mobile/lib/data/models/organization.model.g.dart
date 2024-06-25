// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationModel _$OrganizationModelFromJson(Map<String, dynamic> json) =>
    OrganizationModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      description: json['description'] as String?,
      avatar: json['avatar'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrganizationModelToJson(OrganizationModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'phoneNumber': instance.phoneNumber,
    'address': instance.address,
    'description': instance.description,
    'avatar': instance.avatar,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rating', instance.rating);
  return val;
}
