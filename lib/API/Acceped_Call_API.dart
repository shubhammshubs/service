import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<void> acceptCall(int callId, String mobileNumber) async {
  final acceptedAt = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final response = await http.post(
    Uri.parse("https://apip.trifrnd.com/Services/eng/sereng.php?apicall=updateAccept"),
    body: {
      "AcceptedBy": mobileNumber,
      "AcceptedAt": acceptedAt,
      "id": callId.toString(),
    },
  );

  if (response.statusCode == 200) {
    // The request was successful.
    final responseBody = response.body; // Get the response content
    print('Call accepted successfully: $responseBody , $mobileNumber , $acceptedAt , $callId');

    // You can handle the response content here, depending on your API's response format.
    // For example, you can parse JSON if your API returns JSON data.
    Fluttertoast.showToast(
      msg: 'Response Body: ${response.body}',
      toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );


    // You might want to show a message to the user to inform them about the successful call acceptance.
  } else {
    // The request was not successful. Handle errors here.
    print('Failed to accept the call: ${response.statusCode},  $mobileNumber , $acceptedAt , $callId');

    Fluttertoast.showToast(
      msg: 'Response Body: ${response.statusCode}',
      toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );

    // You can also handle error messages from the API here and show them to the user.
  }
}