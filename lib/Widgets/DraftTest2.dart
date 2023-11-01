// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// // void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'API Data Example',
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late Map<String, dynamic> jsonData;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDatareg();
//   }
//
//   void fetchDatareg() async {
//     final response = await http.post(
//       Uri.parse('https://apip.trifrnd.com/Services/eng/sereng.php?apicall=personalinfo'),
//       body: {'mobile': '9519519511'}, // Replace with your mobile number
//     );
//
//     if (response.statusCode == 200) {
//       jsonData = json.decode(response.body);
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('API Data Example'),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: jsonData == null
//               ? const CircularProgressIndicator()
//               : Column(
//             children: [
//               const SizedBox(height: 16.0),
//               Align(
//                 alignment: Alignment.center,
//                 child: Column(
//                   children: [
//                     // Add CircularImage widget here if needed
//                     const SizedBox(height: 12),
//                     Text(
//                       'Last Education: ${jsonData['Last_Edu']}',
//                       style: const TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       'Last Education Year: ${jsonData['Last_Edu_Year']}',
//                       style: const TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       'PAN_No: ${jsonData['PAN_No']}',
//                       style: const TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       'Aadhar_No: ${jsonData['Aadhar_No']}',
//                       style: const TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       'Work_Exp: ${jsonData['Work_Exp']}',
//                       style: const TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       'Bank_Name: ${jsonData['Bank_Name']}',
//                       style: const TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//
//                     const SizedBox(height: 12),
//                     Text(
//                       'Bank_IFSC: ${jsonData['Bank_IFSC']}',
//                       style: const TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     // Add more Text widgets for other fields
//                     // Replace 'N/A' with actual data from jsonData
//
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
