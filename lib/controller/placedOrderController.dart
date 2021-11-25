import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:saraa_kuch/SharedPref/SharedPrefren.dart';
import 'package:saraa_kuch/models/Customer.dart';
import 'package:saraa_kuch/models/EventActionEnum.dart';
import 'package:saraa_kuch/models/GeneralResponse.dart';
import 'package:saraa_kuch/models/couponCode.dart';
import 'package:saraa_kuch/models/login_response.dart';
import 'package:saraa_kuch/models/placed_order.dart';
import 'package:saraa_kuch/screens/CompleteProfileScreen.dart';
import 'package:saraa_kuch/screens/ConfirmPassword.dart';
import 'package:saraa_kuch/screens/HomeScreen.dart';
import 'package:saraa_kuch/screens/OtpScreen.dart';
import 'package:saraa_kuch/screens/SuccessfullyOrderPlaced.dart';
import 'package:saraa_kuch/services/LoginSignUpService.dart';
import 'package:saraa_kuch/services/ResetPassword.dart';
import 'package:saraa_kuch/services/coupon_api_services.dart';
import 'package:saraa_kuch/services/place_order_api.dart';
import 'dart:io' show Platform;
import '../constants.dart';
import '../services/HomeService.dart';

class PlaceOrderController {
// placedOrder
  StreamController<PlacedOrder> _validationResponse =
  new StreamController<PlacedOrder>();
  StreamSink validateSink;
  Stream validateStream;

  List<String> errors = [];
  PlacedOrder placedOrder=PlacedOrder();

  PlaceOrderController() {
    //validation stream
    validateSink = _validationResponse.sink;
    validateStream = _validationResponse.stream;


  }

  void placeOrder(placeOrder,context) async{
    showLoaderDialog(context);
    final result =await PlaceOrderApi.placedOrder(placeOrder);
    Navigator.pop(context);
    if(result.statusCode==201)
      {

       // PlacedOrder placedOrder=PlacedOrder.fromJson(jsonDecode(result.body));
       // print("place Order"+placedOrder.toJson().toString()+"result.statusCode"+result.statusCode.toString());
        var route = MaterialPageRoute(
            builder: (BuildContext context){
              return SuccessfullyOrderPlaced();
            }
        );
        Navigator.pushReplacement(context, route);

      }else{
      GeneralResponse generalResponse=GeneralResponse.fromJson(jsonDecode(result.body));

      showAlertDialog(context,"Error Code: "+generalResponse.data.status.toString()+"\nMessage: "+generalResponse.message);
    }



  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("please wait.." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
  void showAlertDialog(BuildContext context,String message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alert',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content:Text(message),
        actions: <Widget>[

          TextButton(
            onPressed: () async{

              Navigator.pop(context);


            },
            child: const Text('OK',
              style: TextStyle(fontWeight: FontWeight.bold,color: gold),
            ),
          ),
        ],
      ),
    );

  }
}
