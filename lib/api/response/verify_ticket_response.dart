import '../../models/verification.dart';

class VerifyTicketResponse {
  String? status;
  Verification? verification;
  String? message;

  VerifyTicketResponse({this.status, this.verification, this.message});

  VerifyTicketResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    verification = json['verification'] != null ? Verification?.fromJson(json['verification']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['verification'] = verification!.toJson();
    data['message'] = message;
    return data;
  }
}
