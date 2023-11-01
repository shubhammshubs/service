import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../API/Display_Image.dart';
import '../API/Personal_Information_APi.dart';
import '../API/Registered_info_Display.dart';
import '../CallS/New_Calls.dart';
import '../Servicess/User_Info_From_Register.dart';
import '../Servicess/User_info_form_display.dart';
import '../Widgets/DraftTest2.dart';
import '../user_credientials/info_form.dart';
import 'package:flutter/material.dart';



class UserProfileScreen extends StatefulWidget {
  final String mobileNumber;
  UserProfileScreen({required this.mobileNumber});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  ApiProvider apiProvider = ApiProvider();
  UserProfile? userProfile;
  UserRegisterInfo? userRegisterInfo;
  String email = '';


  @override
  void initState() {
    super.initState();
    fetchData();
    fetchUserProfile();
  }

  Future<void> fetchData() async {
    // Call the API service to get user data
    final userRegData = await ApiRegiserDisplayService.getUserInfo(widget.mobileNumber);

    if (userRegData != null) {
      setState(() {
        email = userRegData['email'];
        // status = userData['status'] ?? 'Status not available';
      });
    }
  }



  void fetchUserProfile() async {
    try {
      UserProfile? user = await apiProvider.fetchUserProfile(widget.mobileNumber);
      setState(() {
        userProfile = user;
      });
    } catch (e) {
      // Handle error here
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (userProfile == null) {
    //   return const Scaffold(
    //
    //     body: Center(
    //       child: Text(
    //         'No Data Found',
    //         style: TextStyle(
    //           fontSize: 20,
    //           color: Colors.black,
    //         ),
    //       ),
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.teal,
      centerTitle: true,
      title: const Text(
        'Services',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
      body: Center(
        child: userProfile == null
            ? const Text(
          'No Data Found',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        )
            : UserProfileWidget(userProfile: userProfile!, mobileNumber: widget.mobileNumber,
          email: email,
          // userProfileRegistered: userProfileRegistered!, // Pass the email parameter
        ),

      ),
    );
  }
}
class UserProfileWidget extends StatelessWidget {
  final UserProfile userProfile;
  final String mobileNumber;
  final String email; // Add the email parameter
  // final UserProfileRegistered userProfileRegistered;

  // final UserRegisterInfo userRegisterInfo;
  double screenHeight = 0;
  double screenWidth = 0;

  UserProfileWidget({super.key,
    required this.userProfile,
    required this.email, // Add the email parameter

    required this.mobileNumber,
    // required this.userProfileRegistered,
    // required this.userRegisterInfo
  });

  void _updateProfilePageData() async {
  await fetchImageUrl(mobileNumber);
  await userProfile;
  await email;

  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(

      body: Scaffold(
        body: LiquidPullToRefresh(
          color: Colors.teal,
          springAnimationDurationInMilliseconds: 200,
          onRefresh: () async {
            // Implement your refresh logic here
            await Future.delayed(const Duration(seconds: 1)); // Simulate a delay
            _updateProfilePageData(); // Fetch your data again
            print('Refreshing...'); // Add this line

          },
          showChildOpacityTransition: false,
          child: SingleChildScrollView(


            child: Center(
              child: userProfile == null
                  ? const CircularProgressIndicator()
                  : Column(
                children: [
                  const SizedBox(
                    height: 16.0, // Add some spacing
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        CircularImage(mobileNumber: mobileNumber,),
                        const SizedBox(height: 12,),
                        Text(
                          '${userProfile.fName} ${userProfile.mName ?? ""} ${userProfile.lName}', // Replace with the desired name
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Text(
                        //   '${userProfileRegistered.Last_Edu} ${userProfileRegistered.Last_Edu_Year ?? ""} ${userProfile.lName}', // Replace with the desired name
                        //   style: const TextStyle(
                        //     fontSize: 16.0,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        const SizedBox(height: 12,),
                         Text(
                           'Email: $email',
                               // '?? "N/A"',
                           // Replace with the desired name
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12,),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          child: Divider(
                            color: Colors.black,
                            thickness: 1.5,
                          ),
                        ),

                        // SizedBox(height: 2,),
                        Text(
                          'Personal Information',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.teal.shade300,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.date_range,
                                      color: Colors.teal,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${userProfile.dob ?? "N/A"}',
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black, // Border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child:
                                Row(
                                    children: <Widget>[
                                      const Icon(Icons.home,
                                        color: Colors.teal,
                                      ),
                                      const SizedBox(width: 8),Text(
                                        '${userProfile.address}',
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black, // Border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(20), // Border radius
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0), // Padding within the border
                                child: Row(
                                    children: <Widget>[
                                      const Icon(FontAwesomeIcons.mapLocationDot, // Icon you want to use
                                        color: Colors.teal, // Icon color
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${userProfile.district}',
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black, // Border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(20), // Border radius
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0), // Padding within the border
                                child: Row(
                                    children: <Widget>[
                                      const Icon(Icons.location_pin, // Icon you want to use
                                        color: Colors.teal, // Icon color
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${userProfile.city}',
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black, // Border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(20), // Border radius
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0), // Padding within the border
                                child: Row(
                                    children: <Widget>[
                                      const Icon(Icons.location_city, // Icon you want to use
                                        color: Colors.teal, // Icon color
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${userProfile.pincode}',
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black, // Border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(20), // Border radius
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0), // Padding within the border
                                child: Row(
                                    children: <Widget>[
                                      const Icon(FontAwesomeIcons.mapPin, // Icon you want to use
                                        color: Colors.teal, // Icon color
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${userProfile.state}',
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ],

                        ),
                        const SizedBox(height: 12,),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          child: Divider(
                            color: Colors.black,
                            thickness: 1.5,
                          ),
                        ),

                        // SizedBox(height: 2,),
                        Text(
                          'Registered Information',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.teal.shade300,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.school,
                                      color: Colors.teal,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${userProfile.Last_Edu ?? "N/A"}',
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black, // Border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child:
                                Row(
                                    children: <Widget>[
                                      const Icon(FontAwesomeIcons.calendarCheck,
                                        color: Colors.teal,
                                      ),
                                      const SizedBox(width: 8),Text(
                                        '${userProfile.Last_Edu_Year}',
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Reg Info row 2

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.credit_card,
                                      color: Colors.teal,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${userProfile.PAN_No ?? "N/A"}',
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black, // Border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child:
                                Row(
                                    children: <Widget>[
                                      const Icon(FontAwesomeIcons.solidAddressCard,
                                        color: Colors.teal,
                                      ),
                                      const SizedBox(width: 8),Text(
                                        '${userProfile.Aadhar_No}',
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Reg Info row 3

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: <Widget>[
                                    const Icon(FontAwesomeIcons.briefcase,
                                      color: Colors.teal,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${userProfile.Work_Exp ?? "N/A"}',
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black, // Border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child:
                                Row(
                                    children: <Widget>[
                                      const Icon(FontAwesomeIcons.buildingColumns,
                                        color: Colors.teal,
                                      ),
                                      const SizedBox(width: 8),Text(
                                        '${userProfile.Bank_Name}',
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Reg Info row 4
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: <Widget>[
                                    const Icon(Icons.share_location_outlined,
                                      color: Colors.teal,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${userProfile.Bank_IFSC ?? "N/A"}',
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Empty 2nd entry of last row
                            // Container(
                            //   margin: const EdgeInsets.only(top: 20),
                            //   width: 170,
                            //   decoration: BoxDecoration(
                            //     border: Border.all(
                            //       color: Colors.black, // Border color
                            //       width: 1.0, // Border width
                            //     ),
                            //     borderRadius: BorderRadius.circular(20),
                            //   ),
                            //   child: Container(
                            //     padding: const EdgeInsets.all(16.0),
                            //     child:
                            //     Row(
                            //         children: <Widget>[
                            //           const Icon(Icons.home,
                            //             color: Colors.teal,
                            //           ),
                            //           const SizedBox(width: 8),Text(
                            //             '${userProfile.Bank_Name}',
                            //             style: const TextStyle(
                            //               fontSize: 13.0,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //         ]
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 12,),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          child: Divider(
                            color: Colors.black,
                            thickness: 1.5,
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class CircularImage extends StatefulWidget {
  final String mobileNumber;
  CircularImage({required this.mobileNumber});

  @override
  State<CircularImage> createState() => _CircularImageState();
}

class _CircularImageState extends State<CircularImage> {
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    loadImage();

  }

  // This is code is for Displaying the Image Fetched for Display
  Future<void> loadImage() async {
    imageUrl = await fetchImageUrl(widget.mobileNumber); // Replace with your mobile number
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return
      ClipOval(
        // child:
        child: GestureDetector(
          onTap: () {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent, // Set background color to transparent
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Image.network(
                      imageUrl!,
                      width: 300,
                      height: 200,
                      // fit: BoxFit.cover,
                    ),
                    // Text('User Profile Picture'),
                  ],
                ),
                Positioned(
                  // top: 1.0,
                  bottom: 170,// Adjust the top position of the close button
                  right: 50.0, // Adjust the right position of the close button
                  child: IconButton(
                    icon: const Icon(Icons.close,
                      color: Colors.white,),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
          child: imageUrl != null
              ? CircleAvatar(
            radius: 55,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(imageUrl!), // Use NetworkImage to load an image from a URL
          )
              : const Text("Image not found"),
    ),
      );
  }
}
