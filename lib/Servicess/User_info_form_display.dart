class UserProfile {
  final String fName;
  final String? mName; // Make the middle name property nullable
  final String lName;
  final String? dob; // Make the date of birth property nullable
  final String address;
  final String district;
  final String city;
  final String pincode;
  final String state;

  UserProfile({
    required this.fName,
    this.mName,
    required this.lName,
    this.dob,
    required this.address,
    required this.district,
    required this.city,
    required this.pincode,
    required this.state,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      fName: json['FName'],
      mName: json['MName'],
      lName: json['LName'],
      dob: json['DoB'],
      address: json['Address'],
      district: json['District'],
      city: json['City'],
      pincode: json['Pincode'],
      state: json['State'],
    );
  }
}
