import 'dart:convert';
import 'package:http/http.dart' as http;

import '../response/login_response.dart';
import '../response/verify_user_response.dart';
import '../url.dart';

class AuthRequest{

  static Future<LogInResponse?> login(String email, String password) async {
    var url = Uri.parse(LOGIN_URL);
    var params = <String, dynamic>{};
    params['email'] = email;
    params['password'] = password;
    final response = await http.post(url, body: params);
    if (response.statusCode == 200) {
      return LogInResponse.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<VerifyUserResponse?> verify(String apiToken) async {
    var url = Uri.parse(VERIFY_USER_URL);
    var params = <String, dynamic>{};
    params['api_token'] = apiToken;
    final response = await http.post(url, body: params);
    if (response.statusCode == 200) {
      return VerifyUserResponse.fromJson(jsonDecode(response.body));
    }
    return null;
  }

}