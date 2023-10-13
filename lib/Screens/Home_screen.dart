import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Widgets/NavBar.dart';
import '../draftTest.dart';
class HomePage extends StatefulWidget {
  final String mobileNumber;

  HomePage({required this.mobileNumber});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press here
        // You can use the following code to exit the app:
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        drawer: NavBar(mobileNumber: widget.mobileNumber),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text(
            'Services',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   width: screenWidth, // Adjust the width as needed
            //   height: 50.0,
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       width: 2.0,
            //       color: Colors.teal
            //     )
            //   ),// Adjust the height as needed
            //   // child: Row(
            //   //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   //   children: [
            //   //     const Text("Please Register Before Continuing"),
            //   //     ElevatedButton(
            //   //       onPressed: () {
            //   //         Navigator.push(
            //   //           context,
            //   //           MaterialPageRoute(
            //   //             builder: (context) => StepperPage(mobileNumber: widget.mobileNumber,),),
            //   //         );
            //   //
            //   //       },
            //   //       child: Text("Register Now"),
            //   //     ),
            //   //   ],
            //   // ),
            // ),
            Center(
              child: Text("Hello User, Mobile Number: ${widget.mobileNumber}"),
            ),

            // buildApiEntry(apiData),



            // Wrap the text and button inside a square Container

          ],
        ),
      ),
    );
  }
}
