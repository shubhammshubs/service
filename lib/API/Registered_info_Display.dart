import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRegiserDisplayService {
  static Future<Map<String, dynamic>?> getUserInfo(String mobile) async {
    final apiUrlreg = 'https://apip.trifrnd.com/Services/eng/sereng.php?apicall=read';

    final mobileData = {'mobile': mobile};

    try {
      final response = await http.post(Uri.parse(apiUrlreg), body: mobileData);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to load data: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
