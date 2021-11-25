import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:saraa_kuch/models/Customer.dart';
import 'package:saraa_kuch/models/placed_order.dart';
import 'dart:collection';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import '../constants.dart';

class PlaceOrderApi {
  static var client = http.Client();

  static Future<dynamic> placedOrder(PlacedOrder placeorder) async {
    print("placedOrder response" +
        placeorder.toJson().toString());
    String g = jsonEncode(placeorder.toJson());
    var response=await client.post(
        Uri.parse(weburl+"/wp-json/wc/v3/orders?consumer_key=$consumerKey&consumer_secret=$secreteKey"),
        //headers:requestheader,

        headers: <String, String>{
          'Content-type':'application/json',

        },
        body:g

    );
    print("Create Order successfully response" +
        response.body+"// Status"+response.statusCode.toString());



    return response;
  }
}



