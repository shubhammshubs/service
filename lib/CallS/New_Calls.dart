import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../API/Personal_Information_APi.dart';
import '../Screens/Profile_Screen.dart';
import '../Servicess/User_info_form_display.dart';

class newcall extends StatefulWidget {
  final String mobileNumber;
  newcall({required this.mobileNumber});

  @override
  State<newcall> createState() => _newcallState();
}

class _newcallState extends State<newcall> {
  ApiProvider apiProvider = ApiProvider();
  UserProfile? userProfile;
  Map<String, dynamic> apiData = {};

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
        // When the user profile is fetched, fetch data for the user's district.
        fetchData(userProfile!.district);
      });
    } catch (e) {
      // Handle error here
      print(e);
    }
  }

  void fetchData(String district) async {
    final response = await http.post(
      Uri.parse("https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readnewcalls"),
      body: {"district": district},
    );

    if (response.statusCode == 200) {
      setState(() {
        apiData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Data Display'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            apiData.isNotEmpty
                ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Call Type: ${apiData['callType']}'),
                Text('Call Title: ${apiData['callTitle']}'),
                Text('District: ${apiData['district']}'),
                Text('City: ${apiData['city']}'),
              ],
            )
                : SizedBox(), // Hide data if not fetched
          ],
        ),
      ),
    );
  }
}
