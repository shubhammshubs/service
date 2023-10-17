// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../Widgets/NavBar.dart';
//
// class CompletedCallsDemo extends StatefulWidget {
//   final String mobileNumber;
//
//   CompletedCallsDemo({required this.mobileNumber});
//
//   @override
//   _CompletedCallsState createState() => _CompletedCallsState();
// }
//
// class _CompletedCallsState extends State<CompletedCallsDemo> {
//   List<Map<String, dynamic>> apiDataList = [];
//   double screenHeight = 0;
//   double screenWidth = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   void fetchData() async {
//     final response = await http.post(
//       Uri.parse("https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readCompleted"),
//       body: {"AcceptedBy": widget.mobileNumber},
//     );
//
//     if (response.statusCode == 200) {
//       final List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(json.decode(response.body));
//
//       if (dataList.isNotEmpty) {
//         setState(() {
//           apiDataList = dataList;
//         });
//       } else {
//         throw Exception('API response is empty');
//       }
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
//
//   // void _showDetailsDialog(Map<String, dynamic> item) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: Container(
//   //           color: Colors.teal, // Set the background color
//   //           padding: EdgeInsets.all(10), // Add padding for spacing
//   //           child: Center(
//   //             child: Text(
//   //               "Call Details",
//   //               style: TextStyle(
//   //                 color: Colors.white, // Text color
//   //                 fontSize: 18, // Text size
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //         content: Column(
//   //           crossAxisAlignment: CrossAxisAlignment.start,
//   //           children: [
//   //             const SizedBox(height: 10,),
//   //
//   //             RichText(text: TextSpan(
//   //
//   //                 text: "Call ID: ${item['id']}",
//   //                 style: TextStyle(
//   //                   color: Colors.black,
//   //                   fontSize: screenWidth / 16,
//   //                 )
//   //             )),
//   //             // const SizedBox(height: 10,),
//   //             Container(
//   //               padding: EdgeInsets.all(10),
//   //               decoration: BoxDecoration(
//   //                 border: Border(
//   //                   bottom: BorderSide(
//   //                     color: Colors.teal, // Border color
//   //                     width: 1.0, // Border width
//   //                   ),
//   //                 ),
//   //               ),
//   //               child:
//   //               Text("Call Title: ${item['callTitle']}"),
//   //             ),
//   //
//   //             // Text("Call Title: ${item['callTitle']}"),
//   //             // const SizedBox(height: 10,),
//   //           Container(
//   //             padding: EdgeInsets.all(8),
//   //             decoration: BoxDecoration(
//   //               border: Border(
//   //                 bottom: BorderSide(
//   //                   color: Colors.teal, // Border color
//   //                   width: 1.0, // Border width
//   //                 ),
//   //               ),
//   //             ),
//   //             child: Text("Client Name: ${item['Client_Name']}"),
//   //           ),
//   //             // Text("Client Name: ${item['Client_Name']}"),
//   //             // const SizedBox(height: 10,),
//   //             Container(
//   //               padding: EdgeInsets.all(10),
//   //               decoration: BoxDecoration(
//   //                 border: Border(
//   //                   bottom: BorderSide(
//   //                     color: Colors.teal, // Border color
//   //                     width: 1.0, // Border width
//   //                   ),
//   //                 ),
//   //               ),
//   //               child:
//   //               Text("category: ${item['category']}"),
//   //             ),
//   //
//   //             // Text("category: ${item['category']}"),
//   //             // const SizedBox(height: 10,),
//   //
//   //             Text("Subcategory: ${item['subcategory']}"),
//   //             const SizedBox(height: 10,),
//   //
//   //             Text("Call Type: ${item['callType']}"),
//   //             const SizedBox(height: 10,),
//   //
//   //             Text("Call Registered Date: ${item['regDate']}"),
//   //             const SizedBox(height: 10,),
//   //
//   //             Text("Call Booked On: ${item['callBooked']}"),
//   //             const SizedBox(height: 10,),
//   //
//   //             Text("Call Accepted On: ${item['AcceptedAt']}"),
//   //             const SizedBox(height: 10,),
//   //
//   //             Text("Call Completed On: ${item['lastUpdationDate']}"),
//   //             const SizedBox(height: 10,),
//   //
//   //             Text("District: ${item['district']}"),
//   //             const SizedBox(height: 10,),
//   //
//   //             Text("City: ${item['city']}"),
//   //             const SizedBox(height: 10,),
//   //
//   //             Text("Call Details: ${item['callDetails']}"),
//   //             // const SizedBox(height: 10,),
//   //
//   //             // Text("Status: ${item['status']}"),
//   //
//   //             // Add more details as needed
//   //           ],
//   //         ),
//   //         actions: <Widget>[
//   //           TextButton(
//   //             child: Text('Close'),
//   //             onPressed: () {
//   //               Navigator.of(context).pop();
//   //             },
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
//   void _showDetailsDialog(Map<String, dynamic> item) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Container(
//             color: Colors.teal, // Set the background color
//             padding: EdgeInsets.all(10), // Add padding for spacing
//             child: Text(
//               "Call Details",
//               style: TextStyle(
//                 color: Colors.white, // Text color
//                 fontSize: 18, // Text size
//               ),
//             ),
//           ),
//           content: Container(
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: Colors.teal, // Border color
//                   width: 2.0, // Border width
//                 ),
//               ),
//             ), // Add padding for spacing
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                             RichText(text: TextSpan(
//                                 text: "Call ID: ${item['id']}",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: screenWidth / 16,
//                                 )
//                             )),
//                             const SizedBox(height: 10,),
//
//
//                             Text("Call Title: ${item['callTitle']}"),
//                             const SizedBox(height: 10,),
//
//                             Text("Client Name: ${item['Client_Name']}"),
//                             const SizedBox(height: 10,),
//
//                             Text("category: ${item['category']}"),
//                             const SizedBox(height: 10,),
//
//                             Text("Subcategory: ${item['subcategory']}"),
//                             const SizedBox(height: 10,),
//
//                             Text("Call Type: ${item['callType']}"),
//                             const SizedBox(height: 10,),
//
//                             Text("Call Registered Date: ${item['regDate']}"),
//                             const SizedBox(height: 10,),
//
//                             Text("Call Booked On: ${item['callBooked']}"),
//                             const SizedBox(height: 10,),
//
//                             Text("Call Accepted On: ${item['AcceptedAt']}"),
//                             const SizedBox(height: 10,),
//
//                             Text("Call Completed On: ${item['lastUpdationDate']}"),
//                             const SizedBox(height: 10,),
//
//                             Text("District: ${item['district']}"),
//                             const SizedBox(height: 10,),
//
//                             Text("City: ${item['city']}"),
//                             const SizedBox(height: 10,),
//
//                             Text("Call Details: ${item['callDetails']}"),
//                             // const SizedBox(height: 10,),
//                             //
//                             // Text("Status: ${item['status']}"),
//                 // Add more text
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Close'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//     screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         centerTitle: true,
//         title: Text(
//           'Completed Calls',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//       drawer: NavBar(mobileNumber: widget.mobileNumber),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               if (apiDataList.isEmpty)
//                 const Column(
//                   children: [
//                     SizedBox(height: 250,),
//                     Center(
//                       child: Text(
//                         'No Completed Calls.',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.black26,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               if (apiDataList.isNotEmpty)
//                 SizedBox(height: 20,),
//               DataTable(
//                 columnSpacing: 10, // Adjust this value to control the spacing between columns
//               columns: const [
//               DataColumn(
//                   label: Center(child: Text("Call ID")),
//                   ),
//                   DataColumn(
//                   label: Center(child: Text("Call Booked \n Date")),
//                   ),
//                   DataColumn(
//                   label: Center(child: Text("Call Title")),
//                   ),
//                   DataColumn(
//                   label: Center(child: Text("Action")),
//                   ),
//                   ],
//                 rows: apiDataList.map((item) {
//                   int index = apiDataList.indexOf(item) + 1;
//                   return DataRow(
//                     cells: [
//
//                       DataCell(
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10), // Adjust the padding to control cell spacing
//                           child: Text(item['id'].toString()),
//                         ),
//                       ),
//                       DataCell(
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10), // Adjust the padding to control cell spacing
//                           child: Text(item['callBooked'].toString()),
//                         ),
//                       ),
//                       DataCell(
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10), // Adjust the padding to control cell spacing
//                           child: Text(item['callTitle'].toString()),
//                         ),
//                       ),
//                       // DataCell(
//                       //   Container(
//                       //     padding: EdgeInsets.symmetric(horizontal: 10), // Adjust the padding to control cell spacing
//                       //     child: Text(item['city'].toString()),
//                       //   ),
//                       // ),
//                       DataCell(
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10), // Adjust the padding to control cell spacing
//                           child: ElevatedButton(
//                             onPressed: () {
//                               _showDetailsDialog(item);
//                             },
//                             child: Text("View"),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//               )
// ,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
