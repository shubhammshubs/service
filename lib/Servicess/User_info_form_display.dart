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
  final String Last_Edu;
  final String Last_Edu_Year;
  final String PAN_No;
  final String Aadhar_No;
  final String Work_Exp;
  final String Bank_Name;
  final String Bank_IFSC;



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
    required this.Last_Edu,
    required this.Last_Edu_Year,
    required this.PAN_No,
    required this.Aadhar_No,
    required this.Work_Exp,
    required this.Bank_Name,
    required this.Bank_IFSC,

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
      Last_Edu: json['Last_Edu'],
      Last_Edu_Year: json['Last_Edu_Year'],
      PAN_No: json['PAN_No'],
      Aadhar_No: json['Aadhar_No'],
      Work_Exp: json['Work_Exp'],
      Bank_Name: json['Bank_Name'],
      Bank_IFSC: json['Bank_IFSC'],
    );
  }
}
