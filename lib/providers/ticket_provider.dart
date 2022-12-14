
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_scan/api/request/ticket_request.dart';
import 'package:ticket_scan/api/response/verifications_response.dart';
import 'package:ticket_scan/api/response/verify_ticket_response.dart';
import 'package:ticket_scan/models/verification.dart';

import '../routes/route.dart';

class TicketProvider with ChangeNotifier {

  List<Verification?>? verifications = [];
  bool loading = false;

  setLoading(bool value){
    loading = value;
    notifyListeners();
  }

  previousVerifications(BuildContext context) async {
    loading = true;
    notifyListeners();
    SharedPreferences preference = await SharedPreferences.getInstance();
    final String? apiToken = preference.getString("api_token");
    if(apiToken != null){
      VerificationsResponse? response= await TicketRequest.verifications(apiToken);
      if(response != null && response.status == "success"){
        verifications = response.verifications ;
      }
    }
    loading = false;
    notifyListeners();
  }

  verify(BuildContext context, String ticketCode) async{
    SharedPreferences preference = await SharedPreferences.getInstance();
    final String? apiToken = preference.getString("api_token");
    if(apiToken != null){
      VerifyTicketResponse? response = await TicketRequest.verify(ticketCode, apiToken);
      if(response != null && response.status == "success"){
        Verification? verification = response.verification ;
        verifications!.add(verification);
        notifyListeners();
        EasyLoading.showSuccess('Successfully Verified');
      }else if(response != null && response.status == "error"){
        EasyLoading.showError('Unable to Verify....');
      }
    }
  }

}