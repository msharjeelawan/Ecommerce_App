import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:saraa_kuch/models/OrderHistoryCustomer.dart';
import 'dart:collection';


import '../constants.dart';
class OrderApi {
  static var client = http.Client();

  static Future<List<Order>> getCustomerOrderHistory(customerId) async {
    Map<String, String> requestheader = {
      'Content-type': 'application/x-www-form-urlencoded',
    };
    var response = await client.get(
      Uri.parse(weburl +
          "/wp-json/wc/v3/orders?customers=$customerId&consumer_key=$consumerKey&consumer_secret=$secreteKey"),
      headers: requestheader,

    );
   // print("response.statusCode" + response.body.toString());
    List<Order> orderList = Order.fromJsonList(json.decode(response.body));
    if(orderList==null)
      orderList=[];

    return orderList; //imageList;
  }
}