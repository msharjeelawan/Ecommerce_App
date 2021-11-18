import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class SharedPref {
  //Login Detail
  static Future<bool> addLoginDetail(loginresponse1) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(loginResponse, loginresponse1.toString());
    return true;
  }

  static Future<String> getLoginDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString(loginResponse) ?? "";
    return stringValue;
  }

  static Future<bool> removeLoginDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove(loginResponse);
    return true;
  }

  //Registraion Data
   static Future<bool> addCustomerDetail(customerResponse1) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(customerResponse, customerResponse1.toString());

    return true;
  }


  static Future<String> getCustomerDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString(customerResponse) ?? "";
    return stringValue;
  }

  static Future<bool> removeCustomerDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove(customerResponse);
    return true;
  }

}
