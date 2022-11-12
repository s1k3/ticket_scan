import '../../models/verification.dart';

class VerificationsResponse {
  String? status;
  String? message;
  List<Verification?>? verifications;

  VerificationsResponse({this.status, this.message, this.verifications});

  VerificationsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['verifications'] != null) {
      verifications = <Verification>[];
      json['verifications'].forEach((v) {
        verifications!.add(Verification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['verifications'] =verifications != null ? verifications!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}

