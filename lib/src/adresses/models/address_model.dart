import 'dart:convert';

List<AddressModel> addressListModelFromJson(String str) => List<AddressModel>.from(json.decode(str).map((x) => AddressModel.fromJson(x)));

String addressListModelToJson(List<AddressModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

AddressModel addressModelFromJson(String str) {
  try {
    return AddressModel.fromJson(json.decode(str));
  } catch (e) {
    print('Error decoding JSON: $e');
    return AddressModel(
      id: 0,
      isDefault: false,
      address: '',
      phone: '',
      addressType: '',
      userId: 0,
    );
  }
}

class AddressModel {
  final int id;
  final bool isDefault;
  final String address;
  final String phone;
  final String addressType;
  final int userId;

  AddressModel({
    required this.id,
    required this.isDefault,
    required this.address,
    required this.phone,
    required this.addressType,
    required this.userId,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json["id"],
      isDefault: json["is_default"],
      address: json["address"],
      phone: json["phone"],
      addressType: json["address_type"],
      userId: json["user_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_default": isDefault,
    "address": address,
    "phone": phone,
    "address_type": addressType,
    "user_id": userId,
  };
}
