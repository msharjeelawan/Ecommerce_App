import 'package:flutter/material.dart';
import 'package:saraa_kuch/models/CheckoutScreen/User.dart';
import 'package:saraa_kuch/screens/CheckOutScreen.dart';
import 'package:saraa_kuch/screens/CompleteProfileScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class SharedPref {
  //Login Detail
  static Future<bool> addLoginDetail(loginresponse1) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(loginResponse, loginresponse1.toString());
    return true;
  }

  static Future<bool> addFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(newUser, "1");
    return true;
  }

  static Future<String> isFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString(newUser) ?? "";
    return stringValue;
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

  static bool isUserProfileComplete(Map<String, dynamic> billing,BuildContext context,int id){
    String first_name = billing['first_name'];
    String last_name = billing['last_name'];
    String address = billing['address_1'];
    CheckOutScreen.address = address;
    String phone = billing['phone'];

    User _user = new User();

    _user.fname = first_name;
    _user.lname = last_name;
    _user.address = address;
    _user.phoneNo = phone;
    _user.id = id;

    // String city = billing['city'];
    // String postCode = billing['postcode'];
    // String country = billing['country'];
    // String company = billing['company'];
    // String state = billing['state'];

    String error="";
    if(first_name.isEmpty){
      error = "First Name";
    }else if(last_name.isEmpty){
      error = "Last Name";
    }else if(address.isEmpty){
      error = "Address";
    }else if(phone.isEmpty){
      error = "Phone No";
    }
    // else if(city.isEmpty){
    //   error = "City";
    // }else if(postCode.isEmpty){
    //   error = "Postal Code";
    // }else if(country.isEmpty){
    //   error = "Country";
    // }

    if(error.isNotEmpty){
      // if error exist then alert user
     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please check ${error}")));
      //Navigator.pushNamed(context,"/completeProfile");
      var route = MaterialPageRoute(builder: (context){
        return CompleteProfileScreen(id: id,);
      },);
      Navigator.push(context, route);
      return false;
    }

    return true;
  }

}
