import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Widgets/NavBar.dart';

class CompletedCalls extends StatefulWidget {
  final String mobileNumber;

  CompletedCalls({required this.mobileNumber});

  @override
  _CompletedCallsState createState() => _CompletedCallsState();
}

class _CompletedCallsState extends State<CompletedCalls> {
  List<Map<String, dynamic>> apiDataList = [];
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final response = await http.post(
      Uri.parse("https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readCompleted"),
      body: {"AcceptedBy": widget.mobileNumber},
    );

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(json.decode(response.body));

      if (dataList.isNotEmpty) {
        setState(() {
          apiDataList = dataList;
        });
      } else {
        throw Exception('API response is empty');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _showDetailsDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
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

                  const SizedBox(height: 10,),

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
                  // Text("Status: ${item['status']}"),
                  // const SizedBox(height: 10,),


                  // Add more text
                ],
              ),
            ),
          ),
          actions: <Widget>[
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
          'Completed Calls',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: NavBar(mobileNumber: widget.mobileNumber),
      body: SingleChildScrollView(
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
              )
              ,
            ],
          ),
        ),
      ),
    );
  }
}
