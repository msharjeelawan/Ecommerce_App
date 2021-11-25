import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saraa_kuch/models/CheckoutScreen/User.dart';
import 'package:saraa_kuch/models/Customer.dart';
import 'package:saraa_kuch/models/login_response.dart';

import '../constants.dart';

class LoginSignupScreen {
  static var client = http.Client();

  static Future<LoginResponse> loginCustomer(String email, String password) async {
    print("email+password " + email.toString() + password.toString());
    bool flag = false;
    Map<String, String> requestheader = {
      'Content-type': 'application/x-www-form-urlencoded'
    };

    var response = await client.post(
        Uri.parse(weburl + "/wp-json/jwt-auth/v1/token"),
        headers: requestheader,
        body: {
          "username": email,
          "password": password,
        });


    // If the server did return a 200 OK response,
    // then parse the JSON.

    LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
    User _user = User.instance;
    _user.isLogin = true;
    _user.email = loginResponse.data.email;
    _user.fname = loginResponse.data.firstName;
    _user.lname = loginResponse.data.lastName;
    return loginResponse;

  }
// Social Media Login
  static Future<LoginResponse> SocialMediaustomer(String email) async {
    print("email+password " + email.toString() + password.toString());
    bool flag = false;
    Map<String, String> requestheader = {
      'Content-type': 'application/x-www-form-urlencoded'
    };

    var response = await client.post(
        Uri.parse(weburl + "/wp-json/jwt-auth/v1/token"),
        headers: requestheader,
        body: {
          "username": email,
          "social_login": "true",
        });


    // If the server did return a 200 OK response,
    // then parse the JSON.
    LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
    User _user = User.instance;
    _user.isLogin = true;
    _user.email = loginResponse.data.email;
    _user.fname = loginResponse.data.firstName;
    _user.lname = loginResponse.data.lastName;
    return loginResponse;

  }
  static Future<Customer> RegisterCustomer(String email, String password) async {
    print("email+password " + email.toString() + password.toString());
    Map<String, String> requestheader = {
      'Content-type': 'application/x-www-form-urlencoded',
    };

    var response = await client.post(
        Uri.parse(weburl +
            "/wp-json/wc/v3/customers?&consumer_key=$consumerKey&consumer_secret=$secreteKey"),
        headers: requestheader,
        body: {
          'email': email,
          'password': password,
        });
    if (response.statusCode == 201) {
      print("response.statusCode" + response.body.toString());
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      print("response.statusCode"+response.statusCode.toString() +"Response"+ response.body.toString());
      // only here we will assume firstName=response.statusCode
      Customer loginResponse=Customer(firstName: response.statusCode.toString());
      return loginResponse;
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load login');
    }
  }


  static Future<Customer> updateCustomerProfile(Customer customerss,
      Ing shippingAddress, Ing billing, String id) async {
    Map<String, String> map22 = new Map();
//customer main profile
    Map<String, dynamic> customermap = customerss.toJson()
      ..removeWhere(
              (dynamic key, dynamic value) => key == null || value == null);
// shipping profile
    Map<String, dynamic> shippingAddres = shippingAddress.toJson()
      ..removeWhere(
              (dynamic key, dynamic value) => key == null || value == null);
    //   Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(customer3.toJson()));

    //billing profile
    Map<String, dynamic> billinginfor = billing.toJson()
      ..removeWhere(
              (dynamic key, dynamic value) => key == null || value == null);

    //make one response
    Map<String, dynamic> oneMap = {};
    oneMap.addAll(customermap);
    oneMap["shipping"] = shippingAddres;
    oneMap["billing"] = billinginfor;

    //final one if any again null
    Map<String, dynamic> finalone = oneMap
      ..removeWhere(
              (dynamic key, dynamic value) => key == null || value == null);

    Map<String, String> requestheader = {
      'Content-type': 'application/json',

    };
    var response = await client.put(
      Uri.parse(weburl +
          "/wp-json/wc/v3/customers/$id?consumer_key="
              "$consumerKey&consumer_secret=$secreteKey"),
      headers: requestheader,
      body: json.encode(finalone),
    );

    if (response.statusCode == 200) {
      print("response.statusCode" + response.body.toString());
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Customer.fromJson(jsonDecode(response.body));

    } else {
      print("response.statusCode"+response.statusCode.toString() +"Response"+ response.body.toString());
      // only here we will assume firstName=response.statusCode
      Customer loginResponse=Customer(firstName: response.statusCode.toString());
      return loginResponse;
    }

    //final bytes = File(Image.asset("assets/images/splash1.png").p).readAsBytesSync();

  }

  static Future<Customer> GetCustomerResponse(String email) async {
    print("email+password " + email.toString() + password.toString());
    Map<String, String> requestheader = {
      'Content-type': 'application/x-www-form-urlencoded',
    };

    var response = await client.get(
        Uri.parse(weburl +
            "/wp-json/wc/v3/customers?email=$email&consumer_key=$consumerKey&consumer_secret=$secreteKey"),
        headers: requestheader);
    List<Customer> customerlist = Customer.fromJsonList(json.decode(response.body));

    if (customerlist!= null && customerlist.isNotEmpty) {
      print("Get Customer Response" + response.body.toString());
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return customerlist[0];
    } else {
      print("Not Get Customer Response"+response.statusCode.toString() +"Response"+ response.body.toString());
      // only here we will assume firstName=response.statusCode
      Customer loginResponse=Customer(firstName: response.body.toString());
      return loginResponse;
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load login');
    }
  }

}