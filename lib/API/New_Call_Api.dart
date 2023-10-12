import 'dart:convert';

import '../Servicess/New_Call_Class.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  final String baseUrl =
      "https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readinfo";

  // Existing code for fetching user profile data...

  Future<NewCallData?> fetchNewCallData(String district) async {
    final response = await http.get(
      Uri.parse('https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readnewcalls&district=$district'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResult = json.decode(response.body);
      if (jsonResult.isNotEmpty) {
        // Assuming the API returns a map containing the new call data.
        return NewCallData.fromJson(jsonResult);
      } else {
        // Handle the case where the API returns an empty response or no matching data.
        return null;
      }
    } else {
      throw Exception('Failed to load new call data');
    }
  }
}
