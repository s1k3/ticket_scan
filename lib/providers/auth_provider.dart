
import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_scan/api/request/auth_request.dart';
import 'package:ticket_scan/api/response/verify_user_response.dart';
import '../api/response/login_response.dart';
import '../routes/route.dart';

class AuthProvider with ChangeNotifier {

  LogInResponse? logInResponse;
  VerifyUserResponse? verifyUserResponse = VerifyUserResponse();

  login(BuildContext context, email, password) async{
    logInResponse = await AuthRequest.login(email, password);
    if (logInResponse != null) {
      if (logInResponse!.status == "success") {
        SharedPreferences preference = await SharedPreferences.getInstance();
        await preference.setString("api_token", logInResponse!.apiToken ?? '');
        await preference.setString("user", jsonEncode(logInResponse!.user!.toJson()));
        Routes.router.navigateTo(context, "previous/scans",transition: TransitionType.material);
      }else{
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Error!!!"),
                content: Text(logInResponse!.message ?? 'Email or Password is Wrong'),
                actions: [
                  TextButton(
                    child: Text("Close"),
                    onPressed: () {
                      Routes.router.pop(context);
                    },
                  )
                ],
              );
            });
      }
    }
  }

  verify(BuildContext context) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    final String? apiToken = preference.getString("api_token");
    if(apiToken == null){
      Routes.router.navigateTo(context, "login",transition: TransitionType.material);
    }else{
      verifyUserResponse = await AuthRequest.verify(apiToken);
      if(verifyUserResponse == null){
        Routes.router.navigateTo(context, "login",transition: TransitionType.material);
      }else if(verifyUserResponse?.status == "error"){
        Routes.router.navigateTo(context, "login",transition: TransitionType.material);
      }else{
        Routes.router.navigateTo(context, "previous/scans",transition: TransitionType.material);
      }
    }
  }

  logout(BuildContext context) async{
    SharedPreferences preference = await SharedPreferences.getInstance();
    bool cleared = await preference.clear();
    if(cleared){
      Routes.router.navigateTo(context, "login");
    }
  }

}