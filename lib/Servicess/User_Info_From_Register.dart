class UserRegisterInfo {
 final String username;
 final String mobile;
 final String email;
 final String gender;
 final String status;


 UserRegisterInfo({
   required this.username,
   required this.mobile,
   required this.email,
   required this.gender,
   required this.status,
 });


 factory UserRegisterInfo.fromJson(Map<String, dynamic> json) {
   return UserRegisterInfo(
     username: json['username'],
     mobile: json['mobile'],
     email: json['email'],
     gender: json['gender'],
     status: json['status'],
   );
 }
}