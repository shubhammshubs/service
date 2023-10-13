import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<Map<String, dynamic>?> fetchAcceptedData(String mobileNumber) async {
  final url = Uri.parse("https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readAccepted");

  final response = await http.post(
    url,
    body: {
      "AcceptedBy": mobileNumber,
    },
  );

  if (response.statusCode == 200) {
    final dynamic data = json.decode(response.body);
    if (data is Map<String, dynamic>) {
      return data;
    }
  }

  return null; // Return null if there was an issue fetching data.
}
