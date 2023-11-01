import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> fetchCompletedCallsCount(String mobileNumber) async {
  final response = await http.post(
    Uri.parse("https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readCompleted"),
    body: {"AcceptedBy": mobileNumber},
  );

  if (response.statusCode == 200) {
    final List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(json.decode(response.body));
    return dataList.length;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> fetchCallHistoryCount(String mobileNumber) async {
  final response = await http.post(
    Uri.parse("https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readallcalls"),
    body: {"AcceptedBy": mobileNumber},
  );

  if (response.statusCode == 200) {
    final List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(json.decode(response.body));
    return dataList.length;
  } else {
    throw Exception('Failed to load data');
  }
}



Future<int> fetchHoldCallsCount(String mobileNumber) async {
  final response = await http.post(
    Uri.parse("https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readnotcompleted"),
    body: {"AcceptedBy": mobileNumber},
  );

  if (response.statusCode == 200) {
    final List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(json.decode(response.body));
    // Filter the data to include only items with status "Hold"
    final holdItems = dataList.where((item) => item['status'] == "Hold").toList();

    return holdItems.length;  } else {
    throw Exception('Failed to load data');
  }
}



Future<int> fetchInprocessCallsCount(String mobileNumber) async {
  final response = await http.post(
    Uri.parse("https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readnotcompleted"),
    body: {"AcceptedBy": mobileNumber},
  );

  if (response.statusCode == 200) {
    final List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(json.decode(response.body));
    // Filter the data to include only items with status "Hold"
    final holdItems = dataList.where((item) => item['status'] == "In Process").toList();

    return holdItems.length;  } else {
    throw Exception('Failed to load data');
  }
}



Future<int> fetchIncompleteCallsCount(String mobileNumber) async {
  final response = await http.post(
    Uri.parse("https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readnotcompleted"),
    body: {"AcceptedBy": mobileNumber},
  );

  if (response.statusCode == 200) {
    final List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(json.decode(response.body));
    // Filter the data to include only items with status "Hold"
    final holdItems = dataList.where((item) => item['status'] == "Incomplete").toList();

    return holdItems.length;
  }
  else {
    throw Exception('Failed to load data');
  }
}

//
// Future<int> fetchAcceptedCallsCount(String mobileNumber) async {
//   final response = await http.post(
//     Uri.parse("https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readnotcompleted"),
//     body: {"AcceptedBy": mobileNumber},
//   );
//
//   if (response.statusCode == 200) {
//     final List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(json.decode(response.body));
//     final holdItems = dataList.where((item) => item['status'] == "Accpeted").toList();
//
//     return holdItems.length;  } else {
//     throw Exception('Failed to load data');
//   }
// }

Future<int> fetchAcceptedCallsCount(String mobileNumber) async {
  final response = await http.post(
    Uri.parse("https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readAccepted"),
    body: {"AcceptedBy": mobileNumber},
  );

  if (response.statusCode == 200) {
    final List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(json.decode(response.body));
    final holdItems = dataList.where((item) => item['status'] == "Accpeted").toList();

    return holdItems.length;  } else {
    throw Exception('Failed to load data');
  }
}