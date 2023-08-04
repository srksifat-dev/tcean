

class AddressModel {
  final String? addressName;
  final String district;
  final String area;
  final String detailsAddress;
  int? defaultIndex;
  AddressModel({
    this.addressName,
    required this.district,
    required this.area,
    required this.detailsAddress,
    this.defaultIndex,
  });

  AddressModel copyWith({
    String? addressName,
    String? district,
    String? area,
    String? detailsAddress,
    int? defaultIndex,
  }) {
    return AddressModel(
      addressName: addressName ?? this.addressName,
      district: district ?? this.district,
      area: area ?? this.area,
      detailsAddress: detailsAddress ?? this.detailsAddress,
      defaultIndex: defaultIndex ?? this.defaultIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addressName': addressName,
      'district': district,
      'area': area,
      'detailsAddress': detailsAddress,
      'defaultIndex': defaultIndex,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      addressName: map['addressName'] as String,
      district: map['district'] as String,
      area: map['area'] as String,
      detailsAddress: map['detailsAddress'] as String,
      defaultIndex: map['defaultIndex'] as int,
    );
  }
}
