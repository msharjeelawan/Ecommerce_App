import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/SharedPref/SharedPrefren.dart';
import 'package:saraa_kuch/controller/CheckOutController.dart';
import 'package:saraa_kuch/helper/DataManager.dart';
import 'package:saraa_kuch/models/Coupon.dart';
import 'package:saraa_kuch/models/CouponCode.dart';
import 'package:saraa_kuch/screens/FavoriteScreen.dart';
import 'package:saraa_kuch/screens/HomeScreen.dart';

import 'CouponCode.dart';

class CheckOutScreen extends StatefulWidget {
  static String address="";
  _CheckOutScreenState createState(){
    return _CheckOutScreenState();
  }

}


class _CheckOutScreenState extends State<CheckOutScreen> {


  @override
  void initState(){
    super.initState();
    CheckOutController.cartPriceController = new StreamController<double>();

  }


  @override
  Widget build(BuildContext context){
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Coupon _coupon= Coupon.instance();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white
        ),
      ),
      body: Scaffold(
        body: Container(
          color: Colors.white,
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Container(
                          width: width*0.2,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 17,
                              color: Color.fromRGBO(25, 25, 25, 1),
                            ),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Container(
                          width: width*0.6,
                          child:  Column(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("CheckOut",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                              Text("${DataManager.cart.length} items")
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Your cart",style: TextStyle(fontSize: 20.0),),
                        ),
                        Expanded(child: SizedBox(),),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text("View All",style: TextStyle(color: Color.fromRGBO(187, 189, 195, 1)),)),
                        ),
                        SizedBox(width: 15,)
                      ],
                    ),
                    Container(
                      width: width,
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:DataManager.cart.length+1,
                          itemBuilder: (context,index){
                            List<int> keys = DataManager.cart.keys.toList();
                            if(index<DataManager.cart.length) {
                              return Container(
                                padding: EdgeInsets.only(left: 15,top: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      width: width*0.3,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                spreadRadius: 0,
                                                blurRadius: 4
                                            )
                                          ],
                                          image: DecorationImage(
                                              image: Image.network(DataManager.cart[keys[index]].Images[0]).image
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }else{
                              return SizedBox(width: 10,);
                            }

                          }
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Your Address",style: TextStyle(fontSize: 20.0),),
                        ),
                        Expanded(child: SizedBox(),),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(onPressed: (){
                            Navigator.pushNamed(context, "/profile");

                          }, child: Text("Edit Address",style: TextStyle(color: Color.fromRGBO(187, 189, 195, 1)),)),
                        ),
                        SizedBox(width: 15,)
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: width,
                      child: Text("${CheckOutScreen.address}",overflow: TextOverflow.ellipsis,maxLines: 3,),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Payment Methods",style: TextStyle(fontSize: 20.0),),
                        ),
                        Expanded(child: SizedBox(),),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(onPressed: (){}, child: Text("",style: TextStyle(color: Color.fromRGBO(187, 189, 195, 1)),)),
                        ),
                        SizedBox(width: 15,)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20,),
                        Text("Cash on Delivery"),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                width: width,
                height: height*0.24,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          //spreadRadius: 1
                        )
                      ],
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 5,),
                          SizedBox(width:30,height:30,child: _coupon.isCouponImplemented?  IconButton(onPressed: (){
                            _coupon.isCouponImplemented=false;
                            _coupon.name="";
                            _coupon.discount=0;
                            _coupon.type="";
                            _coupon.isPercentage=false;
                            DataManager.discount=0;
                            setState(() {

                            });
                          }, icon: Icon(Icons.highlight_remove)): Icon(Icons.content_paste_sharp)),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("SubTotal:",style: TextStyle(fontSize: 12),),
                                  SizedBox(width: 1,),
                                  Text("Shipping:",style: TextStyle(fontSize: 12),),
                                  SizedBox(width: 1,),
                                  _coupon.isCouponImplemented?Text("Coupon:",style: TextStyle(fontSize: 12),):SizedBox(),
                                  SizedBox(width: 1,),
                                  Text("Total:",style: TextStyle(fontSize: 12),),
                                  SizedBox(width: 1,),
                                  ],),
                              Column(
                                children: [
                                  Text(DataManager.tempTotalPrice.toString(),style: TextStyle(fontSize: 12),),
                                  SizedBox(width: 1,),
                                  Text(DataManager.totalPrice>5000?"0":"Rs 199",style: TextStyle(fontSize: 12),),
                                  SizedBox(width: 1,),
                                  _coupon.isCouponImplemented?Text("-"+_coupon.discount.toString(),style: TextStyle(fontSize: 12),):SizedBox(),
                                  SizedBox(width: 1,),
                                  StreamBuilder<double>(
                                      initialData: DataManager.totalPrice,
                                      stream: CheckOutController.cartPriceController.stream,
                                      builder: (context, snapshot) {
                                        return Text("Rs ${snapshot.data}",style: TextStyle(fontWeight: FontWeight.bold),);
                                      }
                                  ),
                                  SizedBox(width: 1,),
                                  ],)
                              ],
                          ),


                          // Row(children: [
                          //   Text("subTotal:",style: TextStyle(fontSize: 12),),
                          //   SizedBox(width: 1,),
                          //   Text(DataManager.tempTotalPrice.toString(),style: TextStyle(fontSize: 12),),
                          // ],),
                          // Row(children: [
                          //   Text("Shipping:",style: TextStyle(fontSize: 12),),
                          //   SizedBox(width: 1,),
                          //   Text(DataManager.totalPrice>5000?"0":"Rs 199",style: TextStyle(fontSize: 12),),
                          // ],),
                          // _coupon.isCouponImplemented?Row(children: [
                          //   Text("coupon",style: TextStyle(fontSize: 12),),
                          //   SizedBox(width: 1,),
                          //   Text("-"+_coupon.discount.toString(),style: TextStyle(fontSize: 12),),
                          // ],):SizedBox(),
                          // Row(children: [
                          //   Text("Total:",style: TextStyle(fontSize: 12),),
                          //   SizedBox(width: 1,),
                          //   StreamBuilder<double>(
                          //       initialData: DataManager.totalPrice,
                          //       stream: CheckOutController.cartPriceController.stream,
                          //       builder: (context, snapshot) {
                          //         return Text("Rs ${snapshot.data}",style: TextStyle(fontWeight: FontWeight.bold),);
                          //       }
                          //   ),
                          // ],),
                          SizedBox(height: 5,),
                        ],
                      ),
                      SizedBox(),
                      SizedBox(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 5,),
                          TextButton(child: Text(_coupon.isCouponImplemented? _coupon.name:"Add voucher code    >",style: TextStyle(color: Colors.black54),),onPressed: () async{

                            if(!_coupon.isCouponImplemented) {
                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => couponCodeScreen(),
                                    ));

                                if (result != null) {
                                  setState(() {

                                  });
                                  CouponCode couponCodeCode = CouponCode.fromJson(
                                      result);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Coupon Applied"),));


                                  print("couponCodeCode id" +
                                      couponCodeCode.id.toString() +
                                      " code " + couponCodeCode.code.toString());
                                }
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Coupon already applied please remove it"),));
                            }

                          },),
                          SizedBox(height: 5,),
                          ElevatedButton(
                            onPressed: (){
                              //create order process will start after pushing this button
                              CheckOutController.createOrder(context);
                            },
                            child: Text("Place Order"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(MyColors.gold),
                                fixedSize: MaterialStateProperty.all(Size(170,40)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ))
                            ),
                          ),
                          SizedBox(height: 5,)
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}