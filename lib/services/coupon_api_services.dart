import 'dart:convert' as convert;
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saraa_kuch/models/CouponCode.dart';


import '../constants.dart';

class CouponsApiServices {
  static var client = http.Client();





  static Future<List<CouponCode>> getCoupon(String coupons) async {
    final responseBody = (await http.get(Uri.parse(weburl +
        '/wp-json/wc/v3/coupons?code=$coupons&consumer_key=$consumerKey&consumer_secret=$secreteKey')))
        .body;
    var couponlistlis = CouponCode.fromJsonList(json.decode(responseBody));
    if(couponlistlis==null)
      couponlistlis = List<CouponCode>.empty();


    print("on Changed Api" + coupons);
    //  The response body is an array of items.
    // print("body body response "+responseBody);

    return couponlistlis; //imageList;
  }

}
