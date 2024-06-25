// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      province: json['city'] as String,
      district: json['district'] as String,
      ward: json['ward'] as String,
      specificAddress: json['specificAddress'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) {
  final val = <String, dynamic>{
    'city': instance.province,
    'district': instance.district,
    'ward': instance.ward,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('specificAddress', instance.specificAddress);
  return val;
}
