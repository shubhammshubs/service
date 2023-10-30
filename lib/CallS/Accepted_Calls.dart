import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../API/Display_Accepted_Call_API.dart';
import '../API/Update_status_call_inAccepted.dart';
import '../Widgets/NavBar.dart';


class DisplayAcceptedCall extends StatefulWidget {
  final String mobileNumber;


  DisplayAcceptedCall({required this.mobileNumber});

  @override
  _DisplayAcceptedCall createState() => _DisplayAcceptedCall();
}

class _DisplayAcceptedCall extends State<DisplayAcceptedCall> {
  Map<String, dynamic>? apiData;
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final data = await fetchAcceptedData(widget.mobileNumber);
    if (data != null) {
      setState(() {
        apiData = data;
      });
    }
  }
  // Future<http.Response> updateCallStatus(String callId, String status, String remark) async {
  //   final response = await http.post(
  //     Uri.parse('https://apip.trifrnd.com/Services/eng/sereng.php?apicall=updatestatus'),
  //     body: {
  //       'id': callId,
  //       'status': status,
  //       'callremark': remark,
  //     },
  //   );
  //   return response;
  // }

  void showUpdateDialog(BuildContext context, String callId) {
    String selectedStatus = 'Select Status';
    String remark = '';

    void handleUpdate() async {
      final status = selectedStatus;
      final callRemark = remark;

      if (status == 'Select Status') {
        // Handle invalid status selection, e.g., show an error message.
        Fluttertoast.showToast(msg: 'Please select a status.',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Please select a status.')),
        // );
        return;
      }

      final response = await updateCallStatus(callId, status, callRemark);

      if (response.statusCode == 200) {
        // Successfully updated the status and remark
        print(response.body);
        print(response.statusCode);
        Fluttertoast.showToast(msg: "Status updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Navigator.of(context).pop();

      } else {
        print(response.body);
        print(response.statusCode);
        // Handle the case where the API request fails
        Fluttertoast.showToast(msg: 'Failed to Update Status',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Take Action'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Call ID: $callId'),
                  SizedBox(height: 10),
                  Text('Status:'),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton<String>(
                      value: selectedStatus,
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value!;
                        });
                      },
                      items: <String>[
                        'Select Status',
                        'Completed',
                        'Hold',
                        'In Process',
                        'Incomplete',
                      ].map((String status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Remark:'),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Enter your remark',
                        border: InputBorder.none,
                      ),
                      maxLines: 3,
                      onChanged: (value) {
                        setState(() {
                          remark = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),

                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () {
                handleUpdate();
                Navigator.of(context).pop();
              },
              // onPressed: handleUpdate,
            ),
          ],
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          'Accepted Calls',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: NavBar(mobileNumber: widget.mobileNumber),
      body: apiData == null
          ?
      const Center(
        child: Text(
          'You Have Not Accepted Any Calls Yet.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ) // Show loading indicator while fetching data.
          :
      SingleChildScrollView(

          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 360,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2)
                  ),
                ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),


          ),
            child:
            Column(
              children: [
                const SizedBox(height: 10,),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      // SizedBox(width: 8), // Add some spacing between the icon and text

                      RichText(text: TextSpan(

                          text: "Call ID: ${apiData?['id']}",
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

                    Text("Client Name:",
                      style: TextStyle(
                          fontFamily: "NexaRegular",
                          fontSize: screenWidth / 20,
                          color: Colors.black54
                      ),
                    ),

                    Text(
                      '${apiData?['Client_Name']}', // Format and display Check Out time
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
                      Icons.call, // You can use any desired icon from the Icons class
                      color: Colors.deepOrange[300],
                      size: screenWidth / 20,
                    ),
                    const SizedBox(width: 3), // Add some spacing between the icon and text
                    //     Text("Category: ${apiData?['category']}"),

                    Text("Category:",
                      style: TextStyle(
                          fontFamily: "NexaRegular",
                          fontSize: screenWidth / 20,
                          color: Colors.black54
                      ),
                    ),
                    Text(
                      '${apiData?['category']}', // Format and display Check Out time
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
                    //     Text("Subcategory: ${apiData?['subcategory']}"),

                    Text("Subcategory:",
                      style: TextStyle(
                          fontFamily: "NexaRegular",
                          fontSize: screenWidth / 20,
                          color: Colors.black54
                      ),
                    ),
                    Text(
                      ' ${apiData?['subcategory']}', // Format and display Check Out time
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
                    //     Text("Call Type: ${apiData?['callType']}"),

                    Text("Call Type:",
                      style: TextStyle(
                          fontFamily: "NexaRegular",
                          fontSize: screenWidth / 20,
                          color: Colors.black54
                      ),
                    ),
                    Text(
                      ' ${apiData?['callType']}', // Format and display Check Out time
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
                    //     Text("District: ${apiData?['district']}"),

                    Text("District:",
                      style: TextStyle(
                          fontFamily: "NexaRegular",
                          fontSize: screenWidth / 20,
                          color: Colors.black54
                      ),
                    ),
                    Text(
                      ' ${apiData?['district']}', // Format and display Check Out time
                      style: TextStyle(
                        fontFamily: "NexaBoald",
                        fontSize: screenWidth / 20,
                      ),
                    ),
                  ],
                ),
                //     Text("City: ${apiData?['city']}"),

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
                      "City:",
                      style: TextStyle(
                        fontFamily: "NexaRegular",
                        fontSize: screenWidth / 20,
                        color: Colors.black54,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ' ${apiData?['city']}',
                        style: TextStyle(
                          fontFamily: "NexaBoald",
                          fontSize: screenWidth / 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                //     Text("Call Title: ${apiData?['callTitle']}"),

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
                      "call Title:",
                      style: TextStyle(
                        fontFamily: "NexaRegular",
                        fontSize: screenWidth / 20,
                        color: Colors.black54,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ' ${apiData?['callTitle']}',
                        style: TextStyle(
                          fontFamily: "NexaBoald",
                          fontSize: screenWidth / 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                //     Text("Call Details: ${apiData?['callDetails']}"),

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
                        ' ${apiData?['callDetails']}',
                        style: TextStyle(
                          fontFamily: "NexaBoald",
                          fontSize: screenWidth / 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                    final callId = (apiData?['id'] ?? 0).toString();
                    showUpdateDialog(context, callId);

                  },
                  child: const Text('Take Action'),
                )
              ],
            ),
          )
      ),
    )
    );
  }
}
