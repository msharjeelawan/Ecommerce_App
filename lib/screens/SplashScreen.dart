import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomeScreen.dart';
import 'LoginScreen.dart';
import 'OrderHistoryList.dart';

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
    Future.delayed(const Duration(milliseconds: 2000),(){

      var route = MaterialPageRoute(builder: (BuildContext context){
          return OrderHistory();

            //HomeScreen();
      });
      Navigator.push(context, route);
    });
  }

}