import 'dart:async';
import 'package:flutter/material.dart';
import 'package:saraa_kuch/SharedPref/SharedPrefren.dart';
import 'package:saraa_kuch/models/CheckoutScreen/User.dart';
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
  StreamController<bool> _progressbarController =
  new StreamController<bool>();
  StreamSink _progressSink;
  Stream progressStream;
  //login,validation controller
  StreamController<List<Order>> _orderHistoryController =
  new StreamController<List<Order>>();
  StreamSink _orderlistSink;
  Stream orderlistStream;
  List<Order> orderHistorylist=[];
  OrderHistoryBloc() {
//progress bar
    _progressSink = _progressbarController.sink;
    progressStream = _progressbarController.stream;

    //login  stream & sink
    _orderlistSink = _orderHistoryController.sink;
    orderlistStream = _orderHistoryController.stream;
    _progressSink.add(false);
    getorderList();


  }

  void getorderList() async {
    _progressSink.add(true);

    orderHistorylist=[];
    _orderlistSink.add(orderHistorylist);

    final results = await OrderApi.getCustomerOrderHistory(User().id);
    // _controller.sink.add(results);
    _progressSink.add(false);

    _orderlistSink.add(results);
    results.forEach((element) {
      print("\n \n results[1].id " + element.id.toString());


    });





  }

}