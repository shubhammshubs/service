import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service/CallS/Call_History.dart';
import 'package:service/CallS/Completed_Calls.dart';
import 'package:service/user_credientials/info_form.dart';
import 'package:service/user_credientials/info_form_2_register.dart';
import 'package:service/user_credientials/loginpage.dart';
import 'package:service/user_credientials/user_documents_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API/Display_Image.dart';
import '../API/Personal_Information_APi.dart';
import '../API/Registered_info_Display.dart';
import '../CallS/Accepted_Calls.dart';
import '../CallS/Hold_Calls.dart';
import '../CallS/InProcess_Calls.dart';
import '../CallS/Incomplete_Calls.dart';
import '../CallS/New_Calls.dart';
import '../Screens/Home_screen.dart';
import '../Screens/Profile_Screen.dart';
import '../Servicess/User_info_form_display.dart';
import '../draftTest.dart';
import '../main.dart';
import 'DraftTest2.dart';

class NavBar extends StatefulWidget {
  final String mobileNumber;
  NavBar({required this.mobileNumber});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String? imageUrl;

  // const NavBar({super.key});
  String username = '';


  @override
  void initState() {
    super.initState();
    loadImage();
    // Fetch user data when the widget is initialized
    fetchData();
  }
  Future<void> loadImage() async {
    imageUrl = await fetchImageUrl(widget.mobileNumber); // Replace with your mobile number
    setState(() {});
  }

  Future<void> fetchData() async {
    // Call the API service to get user data
    final userRegData = await ApiRegiserDisplayService.getUserInfo(widget.mobileNumber);

    if (userRegData != null) {
      setState(() {
        username = userRegData['username'];
        // status = userData['status'] ?? 'Status not available';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return
      Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Colors.teal,
              height: 190, // Adjust the height as needed
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Image.asset(
                      'assets/image/img_2.png',
                      fit: BoxFit.fill,
                    ),
                  ),

                  // Account picture
                   Positioned(
                    top: 79.0, // Adjust the top position as needed
                    left: 8.0, // Adjust the left position as needed

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
                                        width: 200,
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
                                      icon: Icon(Icons.close,
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
                        radius: 45,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(imageUrl!), // Use NetworkImage to load an image from a URL
                      )
                          : Text("Image not found"),
                    ),

                  ),
                  // Account name and email
                   Positioned(
                    top: 145.0, // Adjust the top position as needed
                    left: 100.0, // Adjust the left position as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                    // Display the user name by fetching the fetchData API
                    Text(
                      username ,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomePage(mobileNumber: widget.mobileNumber,),)
              );
            }
          ),
            // ListTile(
            //     leading: const Icon(Icons.dashboard),
            //     title: const Text('Example'),
            //     onTap: () {
            //       Navigator.of(context).push(
            //           MaterialPageRoute(builder: (context) => UserProfilePage(mobileNumber: widget.mobileNumber,),)
            //       );
            //     }
            // ),
            ListTile(
                leading: const Icon(Icons.perm_contact_cal_outlined),
                title: const Text('Show Profile'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserProfileScreen(mobileNumber: widget.mobileNumber, ),)
                  );
                }
            ),
            // ListTile(
            //     leading: const Icon(Icons.dashboard),
            //     title: const Text('Show Image'),
            //     onTap: () {
            //       Navigator.of(context).push(
            //           MaterialPageRoute(builder: (context) => CompletedCallsDemo(mobileNumber: mobileNumber,),)
            //       );
            //     }
            // ),
          ExpansionTile(
            textColor: Colors.teal,
            iconColor: Colors.teal,
            // collapsedTextColor: Colors.white,
            leading: const Icon(Icons.perm_contact_cal_outlined),
            title: const Text('Profile'),

            children: <Widget>[
              // ListTile(
              //   leading: const Icon(Icons.arrow_right),
              //   title: const Text('StepperExample'),
              //   onTap: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(builder: (context) => StepperPage(mobileNumber: mobileNumber,),),
              //     );
              //     // Handle Information sub-menu item click
              //     // Navigator.of(context).pop(); // Close the drawer if needed
              //   },
              // ),
              ListTile(
                leading: const Icon(Icons.arrow_right),
                title: const Text('Information'),
                // trailing: const Icon(Icons.check,color: Colors.green,), // Icon on the right side

                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UserInfoPage(mobileNumber: widget.mobileNumber,),),
                  );
                  // Handle Information sub-menu item click
                  // Navigator.of(context).pop(); // Close the drawer if needed
                },

              ),
              ListTile(
                leading: const Icon(Icons.arrow_right),
                title: const Text('Registration'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => registerInfoPage(mobileNumber: widget.mobileNumber,),),
                  );
                  // Handle Registration sub-menu item click
                  // Navigator.of(context).pop(); // Close the drawer if needed
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.arrow_right),
              //   title: const Text('Documents'),
              //   onTap: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(builder: (context) => DocumentUploadPage(mobileNumber: widget.mobileNumber,),),
              //     );
              //     // Handle Documents sub-menu item click
              //     // Navigator.of(context).pop(); // Close the drawer if needed
              //   },
              // ),
            ],
          ),
          const ListTile(
            title: Text('Service Calls',
              style: TextStyle(color: Colors.grey,fontSize: 16),),
          ),
          // Divider(),
          ListTile(
            leading: const Icon(Icons.add_ic_call_sharp),
            title: const Text('New Calls'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => newcall(mobileNumber: widget.mobileNumber,),)
                );
              }
          ),
          ExpansionTile(
            textColor: Colors.teal,
            iconColor: Colors.teal,
            leading: const Icon(Icons.clear_all_outlined),
            title: const Text('Call Details'),
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.arrow_right),
                title: const Text('Accepted Calls'),
                onTap: () {

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DisplayAcceptedCall(mobileNumber: widget.mobileNumber,),)
                  );
                  // Handle Accepted Calls sub-menu item click
                  // Navigator.of(context).pop(); // Close the drawer if needed
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_right),

                title: const Text('In-Process Calls'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => InProcessCalls(mobileNumber: widget.mobileNumber,),)
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_right),
                title: const Text('Hold Calls'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HoldCalls(mobileNumber: widget.mobileNumber,),)
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_right),
                title: const Text('Completed Calls'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CompletedCalls(mobileNumber: widget.mobileNumber,),)
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_right),
                title: const Text('InCompleted Calls'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => InCompleteCalls(mobileNumber: widget.mobileNumber,),)
                  );
                },
              )
            ],
          ),
          ListTile(
            leading: const Icon(Icons.contact_phone_outlined),
            title: const Text("Call History"),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CallHistory(mobileNumber: widget.mobileNumber,),)
              );

            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.report_gmailerrorred),
            title: const Text("Report"),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Log Out"),
            onTap: () async {

              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              await sharedPreferences.remove('mobile');
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              // key.currentState!.reset(
              // );
            },
          )
        ],
      ),
    );
  }
}
