import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;

Future<http.Response> updateCallStatus(String callId, String status, String remark) async {
  final response = await http.post(
    Uri.parse('https://apip.trifrnd.com/Services/eng/sereng.php?apicall=updatestatus'),
    body: {
      'id': callId,
      'status': status,
      'callremark': remark,
    },
  );
  return response;
}