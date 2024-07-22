class Address {
  final double latitude;
  final double longitude;
  String formattedAddress;
  String? customName;

  Address({required this.latitude, required this.longitude, required this.formattedAddress, this.customName});
}
