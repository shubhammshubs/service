import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> fetchImageUrl(String mobile) async {
  String apiUrl = "https://apip.trifrnd.com/services/eng/sereng.php?apicall=userimg";

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {"mobile": mobile},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final imageName = data["userImage"];
      return "https://apip.trifrnd.com/services/eng/$imageName";
    } else {
      // Handle the case when the API call fails or returns an error
      return null;
    }
  } catch (error) {
    // Handle the case when an error occurs during the API call
    return null;
  }
}

