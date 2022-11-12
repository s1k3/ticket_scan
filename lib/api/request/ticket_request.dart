import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ticket_scan/api/response/verifications_response.dart';
import 'package:ticket_scan/api/response/verify_ticket_response.dart';
import '../url.dart';

class TicketRequest{

  static Future<VerificationsResponse?> verifications(String apiToken) async {
    var url = Uri.parse("$VERIFICATIONS_URL?api_token=$apiToken");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return VerificationsResponse.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<VerifyTicketResponse?> verify(String ticketCode, String apiToken) async {
    var url = Uri.parse(VERIFY_TICKET_URL);
    var params = <String, dynamic>{};
    params['api_token'] = apiToken;
    params['ticket_code'] = ticketCode;
    final response = await http.post(url, body: params);
    if (response.statusCode == 200) {
      return VerifyTicketResponse.fromJson(jsonDecode(response.body));
    }
    return null;
  }

}