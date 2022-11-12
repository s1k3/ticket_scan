class Verification {
  String? name;
  String? exhibitionName = "";
  String? ticketCode = "";
  String? verifiedAt = "";

  Verification({this.name, this.exhibitionName, this.ticketCode, this.verifiedAt});

  Verification.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    exhibitionName = json['exhibition_name'];
    ticketCode = json['ticket_code'];
    verifiedAt = json['verified_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['exhibition_name'] = exhibitionName;
    data['ticket_code'] = ticketCode;
    data['verified_at'] = verifiedAt;
    return data;
  }
}