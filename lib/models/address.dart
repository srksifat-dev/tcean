class Address {
  final String addressName;
  final String district;
  final String area;
  final String detailsAddress;

  Address(
      {required this.addressName,
      required this.district,
      required this.area,
      required this.detailsAddress});
}

class CourierBruch {
  final String addressName;
  final String branch;

  CourierBruch({required this.addressName, required this.branch});
}
