import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

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
          title: const Text(
            'Services',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body:   LiquidPullToRefresh(
          color: Colors.teal,
          springAnimationDurationInMilliseconds: 500,
          onRefresh:  () async {
            // Implement your refresh logic here
            await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
            // fetchData(); // Fetch your data again
          },
          showChildOpacityTransition: false, // Disable child opacity transition
          child: SingleChildScrollView(
            child: Column(
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
                Container(
                  height: 690, // Adjust the height as needed
                ),

                // buildApiEntry(apiData),



                // Wrap the text and button inside a square Container

              ],
            ),
          ),
        ),
      ),
    );
  }
}
