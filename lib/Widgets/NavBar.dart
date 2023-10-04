import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service/user_credientials/info_form.dart';
import 'package:service/user_credientials/info_form_2_register.dart';
import 'package:service/user_credientials/loginpage.dart';
import 'package:service/user_credientials/user_documents_page.dart';

import '../Screens/Home_screen.dart';

class NavBar extends StatelessWidget {
  
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return
      // Drawer(
      // child: ListView(
      //   padding: EdgeInsets.zero,
      //   children: [
      //
      //     UserAccountsDrawerHeader(accountName: const Text('Hello'),
      //       accountEmail: const Text("user@gmail.com"),
      //       currentAccountPicture:
      //
      //       CircleAvatar(
      //
      //         child: ClipOval(
      //           child: Image.asset(
      //             'assets/image/splash.png',
      //             width: 90,
      //             height: 90,
      //
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ),
      //       decoration: const BoxDecoration(
      //           color: Colors.teal,
      //           image: DecorationImage(
      //             image: AssetImage('assets/image/img.png',
      //             ),
      //             fit: BoxFit.cover,
      //           )
      //       ),
      //     ),
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
                  const Positioned(
                    top: 77.0, // Adjust the top position as needed
                    left: 8.0, // Adjust the left position as needed
                    child: CircleAvatar(
                      radius: 44, // Adjust the size of the image as needed
                      backgroundImage: AssetImage('assets/image/splash.png'),
                    ),
                  ),
                  // Account name and email
                  const Positioned(
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
                        Text(
                          'user@gmail.com',
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
                  MaterialPageRoute(builder: (context) => HomePage(mobileNumber: '',),)
              );
            }
          ),
          ExpansionTile(
            textColor: Colors.teal,
            iconColor: Colors.teal,
            // collapsedTextColor: Colors.white,
            leading: const Icon(Icons.perm_contact_cal_outlined),
            title: const Text('Profile'),

            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.arrow_right),
                title: const Text('Information'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => userInfoPage(),),
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
                    MaterialPageRoute(builder: (context) => registerInfoPage(),),
                  );
                  // Handle Registration sub-menu item click
                  // Navigator.of(context).pop(); // Close the drawer if needed
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_right),
                title: const Text('Documents'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DocumentUploadPage(),),
                  );
                  // Handle Documents sub-menu item click
                  // Navigator.of(context).pop(); // Close the drawer if needed
                },
              ),
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
              // Handle Service Calls menu item click
              // Navigator.of(context).pop(); // Close the drawer if needed
            },
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
                  // Handle Accepted Calls sub-menu item click
                  // Navigator.of(context).pop(); // Close the drawer if needed
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_right),

                title: const Text('In-Process Calls'),
                onTap: () {
                  // Handle In-Process Calls sub-menu item click
                  // Navigator.of(context).pop(); // Close the drawer if needed
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_right),
                title: const Text('Hold Calls'),
                onTap: () {
                  // Handle Hold Calls sub-menu item click
                  // Navigator.of(context).pop(); // Close the drawer if needed
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_right),
                title: const Text('Completed Calls'),
                onTap: () {
                  // Handle Completed Calls sub-menu item click
                  // Navigator.of(context).pop(); // Close the drawer if needed
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.contact_phone_outlined),
            title: const Text("Call History"),
            onTap: () {

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
            onTap: () {

                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
            },
          )
        ],
      ),
    );
  }
}
