import '../../models/user.dart';

class VerifyUserResponse {
  String? status;
  String? message;
  User? user;

  VerifyUserResponse({this.status, this.message, this.user});

  VerifyUserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['user'] = user!.toJson();
    return data;
  }
}
