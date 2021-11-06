import 'dart:async';
import 'package:flutter/material.dart';
import 'package:saraa_kuch/SharedPref/SharedPrefren.dart';
import 'package:saraa_kuch/models/Customer.dart';
import 'package:saraa_kuch/models/EventActionEnum.dart';
import 'package:saraa_kuch/models/OrderHistoryCustomer.dart';
import 'package:saraa_kuch/models/login_response.dart';
import 'package:saraa_kuch/screens/CompleteProfileScreen.dart';
import 'package:saraa_kuch/screens/ConfirmPassword.dart';
import 'package:saraa_kuch/screens/HomeScreen.dart';
import 'package:saraa_kuch/screens/OtpScreen.dart';
import 'package:saraa_kuch/services/LoginSignUpService.dart';
import 'package:saraa_kuch/services/OrderHistoryService.dart';
import 'package:saraa_kuch/services/ResetPassword.dart';

import '../constants.dart';
import '../services/HomeService.dart';

class OrderHistoryBloc {
  //login,validation controller
  StreamController<List<Order>> _orderHistoryController =
  new StreamController<List<Order>>();
  StreamSink _orderlistSink;
  Stream orderlistStream;
  List<Order> orderHistorylist=[];
  OrderHistoryBloc() {

    //login  stream & sink
    _orderlistSink = _orderHistoryController.sink;
    orderlistStream = _orderHistoryController.stream;
    getorderList();


  }

  void getorderList() async {
    orderHistorylist=[];
    _orderlistSink.add(orderHistorylist);

    final results = await OrderApi.getCustomerOrderHistory("24");
    // _controller.sink.add(results);

     _orderlistSink.add(results);
        results.forEach((element) {
          print("\n \n results[1].id " + element.id.toString());


        });





  }

}

