class NewCallData {
  final String callType;
  final String callTitle;
  final String district;
  final String city;

  NewCallData({
    required this.callType,
    required this.callTitle,
    required this.district,
    required this.city,
  });

  factory NewCallData.fromJson(Map<String, dynamic> json) {
    return NewCallData(
      callType: json['callType'],
      callTitle: json['callTitle'],
      district: json['district'],
      city: json['city'],
    );
  }
}
