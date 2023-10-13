  // import 'dart:convert';
  // import 'package:flutter/material.dart';
  // import 'package:http/http.dart' as http;
  // import '../API/Personal_Information_APi.dart';
  // import '../Screens/Profile_Screen.dart';
  // import '../Servicess/User_info_form_display.dart';
  // import '../Widgets/NavBar.dart';
  //
  // class newcall extends StatefulWidget {
  //   final String mobileNumber;
  //   newcall({required this.mobileNumber});
  //
  //   @override
  //   State<newcall> createState() => _newcallState();
  // }
  //
  // class _newcallState extends State<newcall> {
  //   double screenHeight = 0;
  //   double screenWidth = 0;
  //   Color primary = const Color(0xffeef444c);
  //
  //
  //   ApiProvider apiProvider = ApiProvider();
  //   UserProfile? userProfile;
  //   Map<String, dynamic> apiData = {};
  //
  //   @override
  //   void initState() {
  //     super.initState();
  //     fetchUserProfile();
  //   }
  //
  //   void fetchUserProfile() async {
  //     try {
  //       UserProfile? user = await apiProvider.fetchUserProfile(widget.mobileNumber);
  //       setState(() {
  //         userProfile = user;
  //         // When the user profile is fetched, fetch data for the user's district.
  //         fetchData(userProfile!.district);
  //       });
  //     } catch (e) {
  //       // Handle error here
  //       print(e);
  //     }
  //   }
  //
  //   void fetchData(String district) async {
  //     final response = await http.post(
  //       Uri.parse("https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readnewcalls"),
  //       body: {"district": district},
  //     );
  //
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         apiData = json.decode(response.body);
  //       });
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   }
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     screenHeight = MediaQuery.of(context).size.height;
  //     screenWidth = MediaQuery.of(context).size.width;
  //
  //     return MaterialApp(
  //       home: Scaffold(
  //         drawer: NavBar(mobileNumber: widget.mobileNumber),
  //
  //         appBar: AppBar(
  //           backgroundColor: Colors.teal,
  //           centerTitle: true,
  //           title: const Text(
  //             'New Calls',
  //             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //           ),
  //         ),
  //
  //         body: SingleChildScrollView(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: <Widget>[
  //
  //               apiData.isNotEmpty
  //                   ?
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisSize: MainAxisSize.min, // Set the mainAxisSize to min
  //
  //                 children: <Widget>[
  //
  //                   Center(
  //                     child: Container(
  //                       margin: const EdgeInsets.only(top: 10),
  //                       // height: 250,
  //                       width: 360,
  //                       decoration: const BoxDecoration(
  //                         color: Colors.white,
  //                         boxShadow: [
  //                           BoxShadow(
  //                               color: Colors.black26,
  //                               blurRadius: 10,
  //                               offset: Offset(2, 2)
  //                           ),
  //                         ],
  //                         borderRadius: BorderRadius.all(Radius.circular(20)),
  //                       ),
  //                       child:
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           children: [
  //                             Expanded(
  //                                 child: Column(
  //                                   mainAxisAlignment: MainAxisAlignment.center,
  //                                   crossAxisAlignment: CrossAxisAlignment.start,
  //                                   children: [
  //                                     Row(
  //                                       mainAxisAlignment: MainAxisAlignment.center,
  //                                       crossAxisAlignment: CrossAxisAlignment.center,
  //
  //                                         children: [
  //                                           // SizedBox(width: 8), // Add some spacing between the icon and text
  //
  //                                           RichText(text: TextSpan(
  //
  //                                               text: "Call ID: ${apiData['Comp_Id']}",
  //                                               style: TextStyle(
  //                                                 color: Colors.black,
  //                                                 fontSize: screenWidth / 16,
  //                                               )
  //                                           ))
  //                                         ]
  //                                     ),
  //                                     const SizedBox(height: 10,),
  //                                     Row(
  //                                       children: [
  //                                           const SizedBox(width: 1), // Add some spacing between the icon and text
  //
  //                                         Icon(
  //                                           Icons.headset_mic_outlined, // You can use any desired icon from the Icons class
  //                                           color: Colors.deepOrange[300],
  //                                           // color: Colors.blueGrey,
  //                                           size: screenWidth / 20,
  //                                         ),
  //                                         const SizedBox(width: 3), // Add some spacing between the icon and text
  //
  //                                         Text("Call Type:",
  //                                           style: TextStyle(
  //                                               fontFamily: "NexaRegular",
  //                                               fontSize: screenWidth / 20,
  //                                               color: Colors.black54
  //                                           ),
  //                                         ),
  //                                         Text(
  //                                           '${apiData['callType']}', // Format and display Check Out time
  //                                           style: TextStyle(
  //                                             fontFamily: "NexaBoald",
  //                                             fontSize: screenWidth / 20,
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     const SizedBox(height: 10,),
  //                                     Row(
  //                                       children: [
  //                                         const SizedBox(width: 1), // Add some spacing between the icon and text
  //
  //                                         Icon(
  //                                           Icons.call, // You can use any desired icon from the Icons class
  //                                           color: Colors.deepOrange[300],
  //                                           size: screenWidth / 20,
  //                                         ),
  //                                         const SizedBox(width: 3), // Add some spacing between the icon and text
  //
  //                                         Text("Call Title:",
  //                                           style: TextStyle(
  //                                               fontFamily: "NexaRegular",
  //                                               fontSize: screenWidth / 20,
  //                                               color: Colors.black54
  //                                           ),
  //                                         ),
  //                                         Text(
  //                                           '${apiData['callTitle']}', // Format and display Check Out time
  //                                           style: TextStyle(
  //                                             fontFamily: "NexaBoald",
  //                                             fontSize: screenWidth / 20,
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     const SizedBox(height: 10,),
  //                                     Row(
  //                                       children: [
  //                                         const SizedBox(width: 1), // Add some spacing between the icon and text
  //
  //                                         Icon(
  //                                           Icons.map_outlined, // You can use any desired icon from the Icons class
  //                                           color: Colors.deepOrange[300],
  //                                           size: screenWidth / 20,
  //                                         ),
  //                                         const SizedBox(width: 3), // Add some spacing between the icon and text
  //
  //                                         Text("District:",
  //                                           style: TextStyle(
  //                                               fontFamily: "NexaRegular",
  //                                               fontSize: screenWidth / 20,
  //                                               color: Colors.black54
  //                                           ),
  //                                         ),
  //                                         Text(
  //                                           ' ${apiData['district']}', // Format and display Check Out time
  //                                           style: TextStyle(
  //                                             fontFamily: "NexaBoald",
  //                                             fontSize: screenWidth / 20,
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //
  //                                     const SizedBox(height: 10,),
  //                                     Row(
  //                                       children: [
  //                                         const SizedBox(width: 1), // Add some spacing between the icon and text
  //
  //                                         Icon(
  //                                           Icons.location_city_outlined, // You can use any desired icon from the Icons class
  //                                           color: Colors.deepOrange[300],
  //                                           size: screenWidth / 20,
  //                                         ),
  //                                         const SizedBox(width: 3), // Add some spacing between the icon and text
  //
  //                                         Text("City:",
  //                                           style: TextStyle(
  //                                               fontFamily: "NexaRegular",
  //                                               fontSize: screenWidth / 20,
  //                                               color: Colors.black54
  //                                           ),
  //                                         ),
  //                                         Text(
  //                                           ' ${apiData['city']}', // Format and display Check Out time
  //                                           style: TextStyle(
  //                                             fontFamily: "NexaBoald",
  //                                             fontSize: screenWidth / 20,
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //
  //                                     const SizedBox(height: 10,),
  //                                     Row(
  //                                       children: [
  //                                         const SizedBox(width: 1), // Add some spacing between the icon and text
  //
  //                                         Icon(
  //                                           Icons.more_time, // You can use any desired icon from the Icons class
  //                                           color: Colors.deepOrange[300],
  //                                           size: screenWidth / 20,
  //                                         ),
  //                                         const SizedBox(width: 3), // Add some spacing between the icon and text
  //
  //                                         Text("Call Time:",
  //                                           style: TextStyle(
  //                                               fontFamily: "NexaRegular",
  //                                               fontSize: screenWidth / 20,
  //                                               color: Colors.black54
  //                                           ),
  //                                         ),
  //                                         Text(
  //                                           ' ${apiData['callBooked']}', // Format and display Check Out time
  //                                           style: TextStyle(
  //                                             fontFamily: "NexaBoald",
  //                                             fontSize: screenWidth / 20,
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //
  //                                     const SizedBox(height: 10,),
  //                                     Row(
  //                                       children: [
  //                                         const SizedBox(width: 1), // Add some spacing between the icon and text
  //
  //                                         Icon(
  //                                           Icons.info_outline, // You can use any desired icon from the Icons class
  //                                           color: Colors.deepOrange[300],
  //                                           size: screenWidth / 20,
  //                                         ),
  //                                         const SizedBox(width: 3), // Add some spacing between the icon and text
  //
  //                                         Text("Call Details:",
  //                                           style: TextStyle(
  //                                               fontFamily: "NexaRegular",
  //                                               fontSize: screenWidth / 20,
  //                                               color: Colors.black54
  //                                           ),
  //                                         ),
  //                                         Text(
  //                                           ' ${apiData['callDetails']}', // Format and display Check Out time
  //                                           style: TextStyle(
  //                                             fontFamily: "NexaBoald",
  //                                             fontSize: screenWidth / 20,
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     const SizedBox(height: 10,),
  //                                     Row(
  //                                         mainAxisAlignment: MainAxisAlignment.center,
  //                                         crossAxisAlignment: CrossAxisAlignment.center,
  //
  //                                         children: [
  //                                           // SizedBox(width: 8), // Add some spacing between the icon and text
  //
  //                                           ElevatedButton(
  //                                             onPressed: () {
  //                                               // Add your button's action here
  //                                             },
  //                                             child: const Text('Accept'),
  //                                           )
  //                                         ]
  //                                     )
  //                                   ],
  //                                 ),
  //                             ),
  //                           ],
  //                         ),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //                   : const SizedBox(), // Hide data if not fetched
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }



  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:fluttertoast/fluttertoast.dart';
  import 'package:http/http.dart' as http;
  import '../API/Acceped_Call_API.dart';
  import '../API/Personal_Information_APi.dart';
  import '../Screens/Profile_Screen.dart';
  import '../Servicess/User_info_form_display.dart';
  import '../Widgets/NavBar.dart';

  class newcall extends StatefulWidget {
    final String mobileNumber;
    newcall({required this.mobileNumber});

    @override
    State<newcall> createState() => _newcallState();
  }

  class _newcallState extends State<newcall> {
    double screenHeight = 0;
    double screenWidth = 0;
    Color primary = const Color(0xffeef444c);

    ApiProvider apiProvider = ApiProvider();
    UserProfile? userProfile;
    List<Map<String, dynamic>> apiDataList = [];

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
        final dynamic data = json.decode(response.body);

        if (data is Map<String, dynamic>) {
          // Check that the response contains the expected keys
          if (data.containsKey("id") &&
              data.containsKey("callType") &&
              data.containsKey("callTitle") &&
              data.containsKey("district") &&
              data.containsKey("city") &&
              data.containsKey("callBooked") &&
              data.containsKey("callDetails")) {
            // Create a list with the single object
            final List<Map<String, dynamic>> dataList = [data];

            setState(() {
              apiDataList = dataList;
            });
          } else {
            throw Exception('API response is missing expected keys');
          }
        } else {
          throw Exception('API response is not in the expected format (Map<String, dynamic>)');
        }
      } else {
        throw Exception('Failed to load data');
      }
    }

    @override
    Widget build(BuildContext context) {
      screenHeight = MediaQuery.of(context).size.height;
      screenWidth = MediaQuery.of(context).size.width;

      return MaterialApp(
        home: Scaffold(
          drawer: NavBar(mobileNumber: widget.mobileNumber),
          appBar: AppBar(
            backgroundColor: Colors.teal,
            centerTitle: true,
            title: const Text(
              'New Calls',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Display "No new Calls" if apiDataList is empty
                if (apiDataList.isEmpty)
                  const Column(
                    children: [
                      SizedBox(height: 250,),
                      Center(
                        child: Text(
                          'New Calls Are Not Available At The Movement.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]
                  ),
                // Display multiple API entries
                for (var apiData in apiDataList)
                  Column(
                    children: [
                      // Display each entry in a separate box
                      _buildApiEntry(apiData),
                      const SizedBox(height: 20), // Add some spacing between entries
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildApiEntry(Map<String, dynamic> apiData) {
      return Center(
        child:
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 360,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(2, 2),
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                // SizedBox(width: 8), // Add some spacing between the icon and text

                RichText(text: TextSpan(

                    text: "Call ID: ${apiData['id']}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth / 16,
                    )
                ))
              ]
          ),
          const SizedBox(height: 10,),

              Row(
                children: [
                  const SizedBox(width: 1), // Add some spacing between the icon and text

                  Icon(
                    Icons.headset_mic_outlined, // You can use any desired icon from the Icons class
                    color: Colors.deepOrange[300],
                    // color: Colors.blueGrey,
                    size: screenWidth / 20,
                  ),
                  const SizedBox(width: 3), // Add some spacing between the icon and text

                  Text("Call Type:",
                    style: TextStyle(
                        fontFamily: "NexaRegular",
                        fontSize: screenWidth / 20,
                        color: Colors.black54
                    ),
                  ),
                  Text(
                    '${apiData['callType']}', // Format and display Check Out time
                    style: TextStyle(
                      fontFamily: "NexaBoald",
                      fontSize: screenWidth / 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const SizedBox(width: 1), // Add some spacing between the icon and text

                  Icon(
                    Icons.call, // You can use any desired icon from the Icons class
                    color: Colors.deepOrange[300],
                    size: screenWidth / 20,
                  ),
                  const SizedBox(width: 3), // Add some spacing between the icon and text

                  Text("Call Title:",
                    style: TextStyle(
                        fontFamily: "NexaRegular",
                        fontSize: screenWidth / 20,
                        color: Colors.black54
                    ),
                  ),
                  Text(
                    '${apiData['callTitle']}', // Format and display Check Out time
                    style: TextStyle(
                      fontFamily: "NexaBoald",
                      fontSize: screenWidth / 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const SizedBox(width: 1), // Add some spacing between the icon and text

                  Icon(
                    Icons.map_outlined, // You can use any desired icon from the Icons class
                    color: Colors.deepOrange[300],
                    size: screenWidth / 20,
                  ),
                  const SizedBox(width: 3), // Add some spacing between the icon and text

                  Text("District:",
                    style: TextStyle(
                        fontFamily: "NexaRegular",
                        fontSize: screenWidth / 20,
                        color: Colors.black54
                    ),
                  ),
                  Text(
                    ' ${apiData['district']}', // Format and display Check Out time
                    style: TextStyle(
                      fontFamily: "NexaBoald",
                      fontSize: screenWidth / 20,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10,),
              Row(
                children: [
                  const SizedBox(width: 1), // Add some spacing between the icon and text

                  Icon(
                    Icons.location_city_outlined, // You can use any desired icon from the Icons class
                    color: Colors.deepOrange[300],
                    size: screenWidth / 20,
                  ),
                  const SizedBox(width: 3), // Add some spacing between the icon and text

                  Text("City:",
                    style: TextStyle(
                        fontFamily: "NexaRegular",
                        fontSize: screenWidth / 20,
                        color: Colors.black54
                    ),
                  ),
                  Text(
                    ' ${apiData['city']}', // Format and display Check Out time
                    style: TextStyle(
                      fontFamily: "NexaBoald",
                      fontSize: screenWidth / 20,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10,),
              Row(
                children: [
                  const SizedBox(width: 1), // Add some spacing between the icon and text

                  Icon(
                    Icons.more_time, // You can use any desired icon from the Icons class
                    color: Colors.deepOrange[300],
                    size: screenWidth / 20,
                  ),
                  const SizedBox(width: 3), // Add some spacing between the icon and text

                  Text("Call Time:",
                    style: TextStyle(
                        fontFamily: "NexaRegular",
                        fontSize: screenWidth / 20,
                        color: Colors.black54
                    ),
                  ),
                  Text(
                    ' ${apiData['callBooked']}', // Format and display Check Out time
                    style: TextStyle(
                      fontFamily: "NexaBoald",
                      fontSize: screenWidth / 20,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10,),
              Row(
                children: [
                  const SizedBox(width: 1),
                  Icon(
                    Icons.info_outline,
                    color: Colors.deepOrange[300],
                    size: screenWidth / 20,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    "Call Details:",
                    style: TextStyle(
                      fontFamily: "NexaRegular",
                      fontSize: screenWidth / 20,
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      ' ${apiData['callDetails']}',
                      style: TextStyle(
                        fontFamily: "NexaBoald",
                        fontSize: screenWidth / 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              // const SizedBox(height: 10,),

              ElevatedButton(
                onPressed: () {
                  // We are passing this data to acceptcall class present in Acceped_Call_API
                  acceptCall(apiData['id'],widget.mobileNumber);

                },
                child: const Text('Accept'),
              ),
            ],
          ),
        ),
      );
    }
  }
