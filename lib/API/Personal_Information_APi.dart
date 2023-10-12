import 'dart:convert';
import 'package:http/http.dart' as http;

// import 'User.dart';
import 'dart:convert';

// cimport 'dart:convert';

import 'dart:convert';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Servicess/User_info_form_display.dart';

class ApiProvider {
  final String baseUrl =
      "https://apip.trifrnd.com/Services/eng/sereng.php?apicall=readinfo";

  Future<UserProfile?> fetchUserProfile(String mobile) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: {'mobile': mobile},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResult = json.decode(response.body);
      if (jsonResult.isNotEmpty) {
        // Assuming the API returns a map containing the user profile data.
        return UserProfile.fromJson(jsonResult);
      } else {
        // Handle the case where the API returns an empty response or no matching profiles.
        return null;
      }
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}
