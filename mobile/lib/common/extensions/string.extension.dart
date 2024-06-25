import 'package:mobile/data/models/address.model.dart';

extension StringExtension on String {
  bool get isEmail {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this);
  }

  AddressModel toAddressModel() {
    final address = split(', ');
    return AddressModel(
      province: address.isNotEmpty ? address.last : '',
      district: address.length > 1 ? address[address.length - 2] : '',
      ward: address.length > 2 ? address[address.length - 3] : '',
    );
  }
}

extension XString on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
