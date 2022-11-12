import '../../models/user.dart';

class LogInResponse {
  String? status;
  User? user;
  String? message;
  String? apiToken;


  LogInResponse({this.status, this.user, this.message, this.apiToken});

  LogInResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
    message = json['message'];
    apiToken = json['api_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['user'] = user != null ? user?.toJson() : null;
    data['message'] = message;
    data['api_token'] = apiToken;
    return data;
  }
}