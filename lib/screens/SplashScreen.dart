import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/SharedPref/SharedPrefren.dart';
import 'package:saraa_kuch/controller/HomeController.dart';
import 'package:saraa_kuch/helper/MyDatabase.dart';
import 'package:saraa_kuch/models/CheckoutScreen/User.dart';
import 'HomeScreen.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    splashtoOther(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: Colors.white,
        backwardsCompatibility: false,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Image.asset("assets/images/logo.png"),
          //child: Text("Welcome"),
        ),
      ),
    );
  }

  void splashtoOther(context){
    HomeController controller = new HomeController();
    HomeScreen.controller = controller;
    //get products from cart table
    fetchCartAndFavoriteFromDB();

    Future.delayed(const Duration(milliseconds: 2000),() async{
      String isFirstTime = await SharedPref.isFirstTimeUser();

      if(isFirstTime.isNotEmpty){
        Navigator.pushReplacementNamed(context, "/home");
      }else{
        Navigator.pushReplacementNamed(context, "/slider");
      }

    });
  }

  void fetchCartAndFavoriteFromDB() async{
    MyDatabase myDatabase = MyDatabase();
    await myDatabase.initDB();
    await myDatabase.readCartProducts();
    await myDatabase.readFavoriteProducts();

    String loginResponse = await SharedPref.getCustomerDetail();
    if(loginResponse.isNotEmpty){
      Map<String, dynamic> user = jsonDecode(loginResponse);
      User _user = User();
      _user.id = user['id'];
      _user.email = user["email"];
      Map<String,dynamic> shipping = user['shipping'];
      _user.fname = shipping['first_name'];
      _user.lname = shipping['last_name'];
      _user.address = shipping['address_1'];
      _user.phoneNo = shipping['phone'];
      _user.isLogin= true;
    }

  }


}