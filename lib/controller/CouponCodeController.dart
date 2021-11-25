import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:saraa_kuch/helper/DataManager.dart';
import 'package:saraa_kuch/models/Coupon.dart';
import 'package:saraa_kuch/models/CouponCode.dart';
import 'package:saraa_kuch/screens/CartScreen.dart';
import 'package:saraa_kuch/services/coupon_api_services.dart';
import 'dart:io' show Platform;
import '../constants.dart';
import 'CheckOutController.dart';


class CouponCodeBloc {
  //login,validation controller
  StreamController<bool> _ProgressStreamController =
  new StreamController<bool>();
  StreamSink _progressSink;
  Stream progressStream;
  StreamController<List<String>> _validationResponse =
  new StreamController<List<String>>();
  StreamSink _validateSink;
  Stream validateStream;


  List<String> errors = [];
  CouponCode couponCodeCode=CouponCode();



/*
  final _eventStreamController = StreamController<EventAction>();
  StreamSink<EventAction> get eventSink => _eventStreamController.sink;
  Stream<EventAction> get _eventStream => _eventStreamController.stream;*/

  CouponCodeBloc() {
    //validation stream
    _validateSink = _validationResponse.sink;
    validateStream = _validationResponse.stream;
    //login  stream & sink
    _progressSink = _ProgressStreamController.sink;
    progressStream = _ProgressStreamController.stream;


    _progressSink.add(false);
    _validateSink.add(errors);

  }


// Validations
  String validateErrors(couponCode,context) {
    errors = [];
    _validateSink.add(errors);

    if (couponCode.isEmpty) {
      addError(error: emptycouponcode);
      return "";
    }

    getcouponCode(couponCode,context);
  }



  void addError({String error}) {
    if (!errors.contains(error)) {
      errors.add(error);
      _validateSink.add(errors);
    }
  }

  void removeError({String error}) {
    if (errors.contains(error)) {
      errors.remove(error);
      _validateSink.add(errors);
    }
  }

  void closeStream() {
    _ProgressStreamController.close();
    _validationResponse.close();

  }



  void getcouponCode(couponCode,context) async{
    _progressSink.add(true);
    errors = [];
    _validateSink.add(errors);

    final result =await CouponsApiServices.getCoupon(couponCode);
    _progressSink.add(false);
    if(result!=null)
    {
      //if coupon is registered
      if(result.isNotEmpty)
      {
        result.forEach((element) {
          couponCodeCode=element;
          print("coupon code each loop "+couponCodeCode.toJson().toString());
        });

        if(couponCodeCode.dateExpires!=null)
        {
          print("expire code is available");
          DateTime dateTime= DateTime.now();

          int isexpired=couponCodeCode.dateExpires.compareTo(dateTime);
          print("couponCodeCode.dateExpires"+couponCodeCode.dateExpires.toString());
          print("ateTime.toString()"+dateTime.toString());
          if(isexpired==-1 || isexpired==0)
          {

            addError(error: expredCoupon);

          }else{
            calculateCouponValue();
            Navigator.pop(context,couponCodeCode.toJson());

          }

        }else{
          //print("expire code not available");
          calculateCouponValue();
          Navigator.pop(context,couponCodeCode.toJson());


        }

      }else{
        //if no result
        addError(error: emptycouponcode);

      }

    }else{
      //if coupon is not register
      addError(error: conectivityConnection);

    }



  }


  void calculateCouponValue(){

    Coupon coupon = Coupon.instance();
    if(couponCodeCode.discountType=="fixed_cart"){
     // print("fixed price");
      DataManager.tempTotalPrice = DataManager.totalPrice ;
      DataManager.discount = double.parse(couponCodeCode.amount);
      DataManager.totalPrice = DataManager.totalPrice-DataManager.discount;
      //assign coupon value to object
      coupon.type="fixed_cart";
      coupon.discount= DataManager.discount;
      coupon.name =  couponCodeCode.code;

      CartScreen.cartController.totalPriceSink.add(DataManager.totalPrice);
      CheckOutController.cartPriceController.sink.add(DataManager.totalPrice);
      //print("fixed price discount${DataManager.totalPrice}");
    }else if(couponCodeCode.discountType=="percent"){
     // print("percentage");
      DataManager.tempTotalPrice = DataManager.totalPrice ;
      double percent = double.parse(couponCodeCode.amount);

      DataManager.discount = (percent/100)*DataManager.totalPrice;
      DataManager.totalPrice = DataManager.discount;
      //assign coupon value to object
      coupon.type="percent";
      coupon.discount= DataManager.discount;
      coupon.name =  couponCodeCode.code;

      CartScreen.cartController.totalPriceSink.add(DataManager.totalPrice);
      CheckOutController.cartPriceController.sink.add(DataManager.totalPrice);
    //  print("percentage discount${DataManager.totalPrice}");
    }

    coupon.isCouponImplemented=true;

  }


}
