import 'dart:convert' as convert;
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saraa_kuch/models/ResetPassword.dart';

import '../constants.dart';

class ResetPasswordAPi {
  static var client = http.Client();


  static Future<ResetPassword> getResetPassword(String email) async {
    final responseBody = (await http.post(Uri.parse(weburl +
        '/wp-json/bdpwr/v1/reset-password?email=$email&consumer_key=$consumerKey'
            'consumer_secret=$secreteKey')))
        .body;
    //  The response body is an array of items.
    // print("body body response "+responseBody);
        print("Rested Password"+responseBody);
    ResetPassword  resetPassword=ResetPassword.fromJson(json.decode(responseBody));
    return resetPassword; //imageList;
  }
  static Future<ResetPassword> verificationPassword(String email,String securityCode) async {
    final responseBody = (await http.post(Uri.parse(weburl +
        '/wp-json/bdpwr/v1/validate-code?email=$email&code=$securityCode&consumer_key=$consumerKey'
            'consumer_secret=$secreteKey')))
        .body;
    //  The response body is an array of items.
    // print("body body response "+responseBody);
    print("Rested Password"+responseBody);
    ResetPassword  resetPassword=ResetPassword.fromJson(json.decode(responseBody));
    return resetPassword; //imageList;
  }


  static Future<ResetPassword> savePassword(String email,String password,securityCode) async {
    final responseBody = (await http.post(Uri.parse(weburl +
        '/wp-json/bdpwr/v1/set-password?email=$email&password=$password&code=$securityCode&consumer_key=$consumerKey&consumer_secret=$secreteKey')))
        .body;
    //  The response body is an array of items.
    // print("body body response "+responseBody);
    ResetPassword  resetPassword=ResetPassword.fromJson(json.decode(responseBody));
    return resetPassword; //imageList;
  }
}
