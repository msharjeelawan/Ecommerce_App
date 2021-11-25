import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/controller/CouponCodeController.dart';
import 'package:saraa_kuch/helper/helper.dart';
import 'package:saraa_kuch/screens/HomeScreen.dart';
import 'package:saraa_kuch/widgets/FormError.dart';

import '../config.dart';
import '../constants.dart';

class couponCodeScreen extends StatefulWidget {
  const couponCodeScreen({Key key}) : super(key: key);

  @override
  _couponCodeScreenState createState() => _couponCodeScreenState();
}

class _couponCodeScreenState extends State<couponCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  String couponsCode="r94a33vq";
  final TextEditingController couponContoller=TextEditingController();
  CouponCodeBloc couponCodeBloc=CouponCodeBloc();
  List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
      ),
      body:  SingleChildScrollView(
          child: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: width * 0.2,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 17,
                                  color: Color.fromRGBO(25, 25, 25, 1),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Container(
                              width: width * 0.6,
                              child: Column(
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Apply Coupon Code",
                                    style: TextStyle(
                                        fontSize: 17, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Center(
                      child: Card(
                        child: Column(

                          children: [

                            Row(
                              children: [

                                Container(
                                  width: width*0.9,
                                  margin: EdgeInsets.only(left: 4, top: 10, right: 4, bottom: 10),

                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "";
                                      }
                                    },
                                    onSaved: (newValue) => couponsCode = newValue.toString().trim(),


                                    controller: couponContoller,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: width*0.04,
                                        vertical: height*0.01,


                                      ),

                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: "Apply Coupon Code",

                                    ),

                                  ),
                                ),



                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                width: width*0.4,
                                margin: EdgeInsets.only(left: 4, top: 10, right: 4, bottom: 10),
                                padding: EdgeInsets.symmetric(
                                  horizontal: width*0.1,
                                  vertical: height*0.015,
                                ),
                                decoration: BoxDecoration(
                                  color: gold,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child:  GestureDetector(
                                    onTap: () async{
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        // if all are valid then go to success screen
                                        KeyboardUtil.hideKeyboard(context);
                                        couponCodeBloc.validateErrors(couponsCode,context);
                                      }
                                    },

                                    child: Text("Apply",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),

                                  /*


                                */
                                )
                            ),


                          ],
                        ),
                      ),

                    ),
                    StreamBuilder(
                        stream: couponCodeBloc.validateStream,
                        initialData: errors,
                        builder: (context, snapshot) {
                          List list = snapshot.data;
                          return snapshot.data != ""
                              ? Container(padding: const EdgeInsets.all(8.0),child: Text(list.length>0?list[0]:"" ,style: TextStyle(color: MyColors.gold),))
                              : Container();
                        }),
                    StreamBuilder(
                        stream: couponCodeBloc.progressStream,
                        initialData: false,
                        builder: (context, snapshot) {
                          return snapshot.data == true
                              ? Center(
                            child: CircularProgressIndicator(),
                          )
                              : Container();
                        }),
                  ],
                ),
              )

          )


      ),
    );

  }
}
