
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saraa_kuch/controller/HomeController.dart';
import 'package:saraa_kuch/controller/SearchController.dart';
import 'package:saraa_kuch/helper/DataManager.dart';
import 'package:saraa_kuch/helper/MyDatabase.dart';
import 'package:saraa_kuch/screens/CategoryScreen.dart';

import '../../../constants.dart';




class SuccessfullyOrderPlaced extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<SuccessfullyOrderPlaced> {
  Future<bool> _onWillPop() async {
    // implment method if user will click back button

    return true;
  }

  @override
  Widget build(BuildContext context) {
    //remove cart data
    DataManager.cart = {};
    DataManager.totalPrice=0;
    DataManager.tempTotalPrice=0;
    DataManager.discount=0;
    MyDatabase myDatabase = MyDatabase();
    myDatabase.clearCart();
    HomeController.cartCountController.sink.add(0);
    SearchController.cartCountController.sink.add(0);
    CategoryScreen.categoryController.categoryCartSink.add(0);


    var width = MediaQuery.of(context).size.width;

    // create:final locationData= Provider.of<LocationProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: WillPopScope(
            onWillPop:_onWillPop,
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,

                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height:  MediaQuery.of(context).size.height/20,
                      ),
                      // use below image any one for now
                      Image.asset(
                        'assets/images/order_success.png',
                        width: width*0.8,
                      ),
                      SizedBox(
                        height:  MediaQuery.of(context).size.height/20,
                      ),
                      Text(
                        "Successfully placed order",
                        style: TextStyle(
                          fontSize: width*0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height:  MediaQuery.of(context).size.height/20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/home');

                          },
                          child: Text("Go to dashboard"),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(gold),
                              fixedSize: MaterialStateProperty.all(
                                  Size(width * 0.58, 50)),
                              // backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))))),


                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }






}
