import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:service/user_credientials/loginpage.dart';

import '../Widgets/NavBar.dart';

  class HomePage extends StatefulWidget {
  final String mobileNumber;
  HomePage({required this.mobileNumber});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text('Services',style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(

            child: Text("Hello User, Mobile Number: ${widget.mobileNumber}"),
          ),
        ],
      ),
    );
  }
}
