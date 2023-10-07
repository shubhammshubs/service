import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Widgets/NavBar.dart'; // Import the services library

class HomePage extends StatefulWidget {
  final String mobileNumber;
  HomePage({required this.mobileNumber});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press here
        // You can use the following code to exit the app:
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        drawer: NavBar(mobileNumber: '${widget.mobileNumber}' ,),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text('Services',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Hello User, Mobile Number: ${widget.mobileNumber}"),
            ),
          ],
        ),
      ),
    );
  }
}
