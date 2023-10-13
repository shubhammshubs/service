import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../API/Personal_Information_APi.dart';
import '../Servicess/User_info_form_display.dart';
import '../Widgets/DraftTest2.dart';
import '../user_credientials/info_form.dart';
import 'package:flutter/material.dart';



class MyApp12 extends StatefulWidget {
  final String mobileNumber;
  MyApp12({required this.mobileNumber});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<MyApp12> {
  ApiProvider apiProvider = ApiProvider();
  UserProfile? userProfile;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
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
            ? const CircularProgressIndicator()
            : UserProfileWidget(userProfile: userProfile!, mobileNumber: widget.mobileNumber,),
      ),
    );
  }
}
class UserProfileWidget extends StatelessWidget {
  final UserProfile userProfile;
  final String mobileNumber;
  double screenHeight = 0;
  double screenWidth = 0;
  UserProfileWidget({required this.userProfile, required this.mobileNumber});

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(

      body: Scaffold(
        body: SingleChildScrollView(


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
                    CircularImage(),
                    Text(
                      '${userProfile.fName} ${userProfile.mName ?? ""} ${userProfile.lName}', // Replace with the desired name
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12,),
                    const Text(
                      'email: User@gmail.com', // Replace with the desired name
                      style: TextStyle(
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
                                const Icon(Icons.date_range, // Icon you want to use
                                  color: Colors.teal, // Icon color
                                ),
                                const SizedBox(width: 8), // Add some space between the icon and text
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
                            borderRadius: BorderRadius.circular(20), // Border radius
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16.0), // Padding within the border
                            child:
                            Row(
                              children: <Widget>[
                              const Icon(Icons.home, // Icon you want to use
                              color: Colors.teal, // Icon color
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
                    // Container(
                    //   margin: const EdgeInsets.only(top: 20),
                    //   width: screenWidth,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //       color: Colors.black, // Border color
                    //       width: 1.0, // Border width
                    //     ),
                    //     borderRadius: BorderRadius.circular(20), // Border radius
                    //   ),
                    //   child: Container(
                    //     padding: const EdgeInsets.all(16.0), // Padding within the border
                    //     child:
                    //         Column(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 Container(
                    //                   margin: const EdgeInsets.only(top: 20),
                    //                   width: 160,
                    //                   decoration: BoxDecoration(
                    //                     border: Border.all(
                    //                       color: Colors.black, // Border color
                    //                       width: 1.0, // Border width
                    //                     ),
                    //                     borderRadius: BorderRadius.circular(20), // Border radius
                    //                   ),
                    //
                    //                   child: Container(
                    //                     padding: const EdgeInsets.all(16.0), // Padding within the border
                    //                     child: Row(
                    //                         children: <Widget>[
                    //                           const Icon(FontAwesomeIcons.mapPin, // Icon you want to use
                    //                             color: Colors.teal, // Icon color
                    //                           ),
                    //                           const SizedBox(width: 8),
                    //                           Text(
                    //                             '${userProfile.state}',
                    //                             style: const TextStyle(
                    //                               fontSize: 13.0,
                    //                               fontWeight: FontWeight.bold,
                    //                             ),
                    //                           ),
                    //                         ]
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 const SizedBox(width: 16),
                    //
                    //                 Container(
                    //                   margin: const EdgeInsets.only(top: 20),
                    //                   width: 160,
                    //                   decoration: BoxDecoration(
                    //                     border: Border.all(
                    //                       color: Colors.black, // Border color
                    //                       width: 1.0, // Border width
                    //                     ),
                    //                     borderRadius: BorderRadius.circular(20), // Border radius
                    //                   ),
                    //                   child: Container(
                    //                     padding: const EdgeInsets.all(16.0), // Padding within the border
                    //                     child: Row(
                    //                         children: <Widget>[
                    //                           const Icon(FontAwesomeIcons.mapPin, // Icon you want to use
                    //                             color: Colors.teal, // Icon color
                    //                           ),
                    //                           const SizedBox(width: 8),
                    //                           Text(
                    //                             '${userProfile.state}',
                    //                             style: const TextStyle(
                    //                               fontSize: 13.0,
                    //                               fontWeight: FontWeight.bold,
                    //                             ),
                    //                           ),
                    //                         ]
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             )
                    //           ],
                    //         )
                    //
                    //   ),
                    // ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return
//     Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: <Widget>[
//       // Text("Hello User, Mobile Number: ${widget.mobileNumber}"),
//
//       Container(
//         padding: const EdgeInsets.symmetric(horizontal: 30),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.black, // Border color
//             width: 2.0,           // Border width
//           ),
//           borderRadius: BorderRadius.circular(60), // Border radius
//         ),
//         child: Text('First Name: ${userProfile.fName}'),
//       ),
//       const SizedBox(height: 25),
//
//       Text('Middle Name: ${userProfile.mName ?? "N/A"}'), // Use "N/A" if middle name is null
//       Text('Last Name: ${userProfile.lName}'),
//
//       Text('DOB: ${userProfile.dob ?? "N/A"}'), // Use "N/A" if date of birth is null
//       Text('Address: ${userProfile.address}'),
//       Text('District: ${userProfile.district}'),
//       Text('City: ${userProfile.city}'),
//       Text('Pincode: ${userProfile.pincode}'),
//       Text('State: ${userProfile.state}'),
//     ],
//   );
// }

class CircularImage extends StatelessWidget {
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

                          Image.asset(
                            'assets/image/splash.png', // Replace with the path to your image
                            width: 300, // Adjust the size of the enlarged image
                            height: 200,

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
          child: const CircleAvatar(
            radius: 55, // Adjust the size of the image as needed
            backgroundImage: AssetImage('assets/image/splash.png',),
            backgroundColor: Colors.white,
          ),
        ),
      );
  }
}
