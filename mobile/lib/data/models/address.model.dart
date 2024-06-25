import 'package:json_annotation/json_annotation.dart';

part 'address.model.g.dart';

@JsonSerializable()
class AddressModel {
  @JsonKey(name: 'city')
  final String province;
  final String district;
  final String ward;
  @JsonKey(includeIfNull: false)
  final String? specificAddress;

  AddressModel({
    required this.province,
    required this.district,
    required this.ward,
    this.specificAddress,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
