import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:service/Screens/Home_screen.dart';

import '../API/Update_status_call_inAccepted.dart';
import '../Widgets/NavBar.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';


class HoldCalls extends StatefulWidget {
  final String mobileNumber;

  HoldCalls({required this.mobileNumber});

  @override
  _HoldCallsState createState() => _HoldCallsState();
}

class _HoldCallsState extends State<HoldCalls> {
  late BuildContext myContext;

  List<Map<String, dynamic>> apiDataList = [];
  double screenHeight = 0;
  double screenWidth = 0;
  bool isLoading = false; // Add this variable
  bool _isMounted = false; // Add this variable



  @override
  void initState() {
    super.initState();
    _isMounted = true; // Widget is mounted

    fetchData();
  }
  @override
  void dispose() {
    _isMounted = false; // Widget is no longer mounted
    super.dispose();
  }

  void fetchData() async {
    final response = await http.post(
      Uri.parse("https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readnotcompleted"),
      body: {"AcceptedBy": widget.mobileNumber},
    );

    if (_isMounted) {
      setState(() {
        isLoading = true; // Show the loading symbol
      });
    } else {
      return; // Widget is not mounted, don't call setState
    }

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(json.decode(response.body));

      if (dataList.isNotEmpty) {
        setState(() {
          // Filter the data to only include items with Status equal to "Hold"
          apiDataList = dataList.where((item) => item['status'] == "Hold").toList();
        });
      } else {
        throw Exception('API response is empty');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
  // For Take ACtion Button
  void showUpdateDialog(BuildContext context, String callId) {
    String selectedStatus = 'Hold';
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
        return;
      }

      if (callRemark.isEmpty) {
        Fluttertoast.showToast(
          msg: 'Please enter a remark.',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        return;
      }
      setState(() {
        isLoading = true; // Show the loading symbol
      });

      final response = await updateCallStatus(callId, status, callRemark);

      if (_isMounted) {
        setState(() {
          isLoading = false; // Hide the loading symbol
        });
      } else {
        return; // Widget is not mounted, don't call setState
      }

      // await Future.delayed(Duration(seconds: 10)); // Wait for 1 second

      if (response.statusCode == 200) {
        // Successfully updated the status and remark
        print(response.body);
        print(response.statusCode);

        Fluttertoast.showToast(msg: "Status updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        // After updating, fetch the data again to reflect the changes
        fetchData();

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HoldCalls(mobileNumber: widget.mobileNumber),
          ),
        );

        Navigator.of(context).pop();
      }

      else {
        print(response.body);
        print(response.statusCode);
        // Handle the case where the API request fails
        Fluttertoast.showToast(msg: 'Failed to Update Status',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );

        // setState(() {
        //   isLoading = false; // Hide the loading symbol
        // });
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
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) => HomePage(mobileNumber: widget.mobileNumber),
                //   ),
                // );
              },
              // onPressed: handleUpdate,
            ),
          ],
        );
      },
    );
  }


  void _showDetailsDialog(Map<String, dynamic> item) {
    showDialog(
      context: context, // Use the context of the parent dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            color: Colors.teal, // Set the background color
            padding: const EdgeInsets.all(10), // Add padding for spacing
            child: const Text(
              "Call Details",
              style: TextStyle(
                color: Colors.white, // Text color
                fontSize: 18, // Text size
              ),
            ),
          ),
          content: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.teal, // Border color
                  width: 2.0, // Border width
                ),
              ),
            ), // Add padding for spacing
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  RichText(text: TextSpan(
                      text: "Call ID: ${item['id']}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth / 16,
                      )
                  )),
                  const SizedBox(height: 10,),


                  RichText(
                    text: TextSpan(
                      text: "Call Title: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black, // Set text color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: item['callTitle'],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // Reset to normal font weight
                            color: Colors.black, // Set text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  RichText(
                    text: TextSpan(
                      text: "Client Name: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black, // Set text color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: item['Client_Name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // Reset to normal font weight
                            color: Colors.black, // Set text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),


                  // Text("Client Name: ${item['Client_Name']}"),

                  // const SizedBox(height: 10,),

                  // Text("category: ${item['category']}"),
                  RichText(
                    text: TextSpan(
                      text: "Category: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black, // Set text color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: item['category'],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // Reset to normal font weight
                            color: Colors.black, // Set text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  // Text("Subcategory: ${item['subcategory']}"),
                  RichText(
                    text: TextSpan(
                      text: "Subcategory: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black, // Set text color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: item['subcategory'],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // Reset to normal font weight
                            color: Colors.black, // Set text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  // Text("Call Type: ${item['callType']}"),
                  RichText(
                    text: TextSpan(
                      text: "Call Type: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black, // Set text color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: item['callType'],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // Reset to normal font weight
                            color: Colors.black, // Set text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  // Text("Call Registered Date: ${item['regDate']}"),
                  RichText(
                    text: TextSpan(
                      text: "Call Registered Date: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black, // Set text color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: item['regDate'],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // Reset to normal font weight
                            color: Colors.black, // Set text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  // Text("Call Booked On: ${item['callBooked']}"),
                  RichText(
                    text: TextSpan(
                      text: "Call Booked On: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black, // Set text color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: item['callBooked'],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // Reset to normal font weight
                            color: Colors.black, // Set text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  // Text("Call Accepted On: ${item['AcceptedAt']}"),
                  RichText(
                    text: TextSpan(
                      text: "Call Accepted On: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black, // Set text color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: item['AcceptedAt'],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // Reset to normal font weight
                            color: Colors.black, // Set text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  // Text("Call Completed On: ${item['lastUpdationDate']}"),
                  RichText(
                    text: TextSpan(
                      text: "Call Completed On: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black, // Set text color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: item['lastUpdationDate'],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // Reset to normal font weight
                            color: Colors.black, // Set text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  // Text("District: ${item['district']}"),
                  RichText(
                    text: TextSpan(
                      text: "District: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black, // Set text color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: item['district'],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // Reset to normal font weight
                            color: Colors.black, // Set text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  // Text("City: ${item['city']}"),
                  RichText(
                    text: TextSpan(
                      text: "City: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black, // Set text color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: item['city'],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // Reset to normal font weight
                            color: Colors.black, // Set text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  // Text("Call Details: ${item['callDetails']}"),
                  RichText(
                    text: TextSpan(
                      text: "Call Details: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black, // Set text color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: item['callDetails'],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // Reset to normal font weight
                            color: Colors.black, // Set text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  //

                  // Text("Remark: ${item['callremark']}"),
                  RichText(
                    text: TextSpan(
                      text: "Remark: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black, // Set text color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: item['callremark'],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // Reset to normal font weight
                            color: Colors.black, // Set text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  RichText(
                    text: TextSpan(
                      text: "Status: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make it bold
                        color: Colors.black, // Set text color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: item['status'],
                          style: const TextStyle(
                            fontWeight: FontWeight.normal, // Reset to normal font weight
                            color: Colors.black, // Set text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),


                  // Add more text
                ],
              ),
            ),
          ),
          actions: <Widget>[

            ElevatedButton(
              onPressed: () {
                // onPressed: () {
                Navigator.of(context).pop();
                final callId = (item['id'] ?? 0).toString();
                // Call the method to show the update dialog directly from here
                showUpdateDialog(context, callId);
              },
              child: const Text('Take Action'),
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
          'Hold Calls',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: NavBar(mobileNumber: widget.mobileNumber),
      body:  LiquidPullToRefresh(
        color: Colors.teal,
        springAnimationDurationInMilliseconds: 500,
        onRefresh:  () async {
          // Implement your refresh logic here
          await Future.delayed(Duration(seconds: 2)); // Simulate a delay
          fetchData(); // Fetch your data again
        },
        showChildOpacityTransition: false, // Disable child opacity transition
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                if (apiDataList.isEmpty)
                  const Column(
                    children: [
                      SizedBox(height: 250,),
                      Center(
                        child: Text(
                          'No Completed Calls.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (apiDataList.isNotEmpty)
                  const SizedBox(height: 20,),
                DataTable(
                  columnSpacing:10,
                  // dividerThickness: 1,
                  columns: const [
                    DataColumn(
                      label: Center(child: Text("Call ID")),
                    ),
                    DataColumn(
                      label: Center(child: Text("Call Booked \nDate")),
                    ),
                    DataColumn(
                      label: Center(child: Text("Call \nTitle")),
                    ),
                    DataColumn(
                      label: Center(child: Text("   Action")),
                    ),
                  ],
                  rows: apiDataList.map((item) {
                    int index = apiDataList.indexOf(item) + 1;
                    return DataRow(
                      cells: [

                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10), // Adjust the padding to control cell spacing
                            child: Text(item['id'].toString().trim()),
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15), // Adjust the padding to control cell spacing
                            child: Text(item['callBooked'].toString().trim()),
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5), // Adjust the padding to control cell spacing
                            child: Text(item['callTitle'].toString().trim()),
                          ),
                        ),
                        // DataCell(
                        //   Container(
                        //     padding: EdgeInsets.symmetric(horizontal: 10), // Adjust the padding to control cell spacing
                        //     child: Text(item['city'].toString()),
                        //   ),
                        // ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10), // Adjust the padding to control cell spacing
                            child: ElevatedButton(

                              onPressed: () {
                                _showDetailsDialog(item);
                              },
                              child: const Text("View"),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                Container(
                  height: 600, // Adjust the height as needed
                ),
              ],
            ),
          ),
        ),
      ),
      // ... Your UI code remains the same
    );
  }
}
