import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/SharedPref/SharedPrefren.dart';
import 'package:saraa_kuch/controller/CartController.dart';
import 'package:saraa_kuch/controller/HomeController.dart';
import 'package:saraa_kuch/controller/SearchController.dart';
import 'package:saraa_kuch/helper/DataManager.dart';
import 'package:saraa_kuch/models/CheckoutScreen/User.dart';
import 'package:saraa_kuch/models/HomeScreen/Product.dart';
import 'package:saraa_kuch/screens/CheckOutScreen.dart';
import 'package:saraa_kuch/screens/HomeScreen.dart';

import 'CategoryScreen.dart';
import 'FavoriteScreen.dart';

class CartScreen extends StatefulWidget{
  static CartController cartController;
  _CartScreenState createState(){
    return _CartScreenState();
  }

}


class _CartScreenState extends State<CartScreen>{

 CartController _cartController;


  @override
  void initState(){
    super.initState();
    _cartController = CartController();
    CartScreen.cartController = _cartController;//for external use in coupon code
  }

  @override
  Widget build(BuildContext context){
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    List<int> keys = [];
    double price = 0.0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white
        ),
      ),
        body: Container(
          color: Colors.white,
          child: Stack(
            fit: StackFit.expand,
            children:[
              SingleChildScrollView(
                child: Column(
                  children: [
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
                              Text("Your Cart",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                              StreamBuilder<int>(
                                initialData: DataManager.cart.length,
                                stream: _cartController.cartCountController.stream,
                                builder: (context, snapshot) {
                                  return Text(snapshot.data>0? "${snapshot.data} items": "empty");
                                }
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    DataManager.cart.length>0? StreamBuilder<Map<int,Product>>(
                      stream: _cartController.updateCartStream,
                      builder: (context, snapshot) {
                        price=0.0;
                        keys = DataManager.cart.keys.toList();
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:DataManager.cart.length+1,
                            itemBuilder: (context,index){
                              if(index<DataManager.cart.length) {
                                int normalPrice = DataManager.cart[keys[index]].price;
                                int discountPrice = DataManager.cart[keys[index]].discountPrice;
                                int single_product_price = normalPrice>discountPrice && discountPrice!=0? discountPrice:normalPrice;
                                price += single_product_price * DataManager.cart[keys[index]].tempQty;

                                return Dismissible(
                                  key: Key(keys[index].toString()),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction){
                                     if(direction == DismissDirection.startToEnd){
                                       DataManager.cart.remove(keys[index]);
                                       _cartController.updateCartSink.add(DataManager.cart);
                                       _cartController.cartCountController.add(DataManager.cart.length);
                                       HomeController.cartCountController.sink.add(DataManager.cart.length);
                                       if(CategoryScreen.categoryController!=null)
                                       CategoryScreen.categoryController.categoryCartSink.add(DataManager.cart.length);
                                       if(SearchController.cartCountController!=null)
                                       SearchController.cartCountController.sink.add(DataManager.cart.length);

                                       setState(() {

                                       });
                                       _cartController.deleteCartItem(id:keys[index]);
                                     }
                                  },
                                  background: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    color: Colors.red,
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete,color: Colors.white,),
                                        SizedBox(width: 3,),
                                        Text("Remove",style:TextStyle(color: Colors.white))
                                      ],
                                    ),
                                  ),
                                  secondaryBackground: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    color: Colors.white,
                                    // child: Row(
                                    //   children: [
                                    //     Icon(Icons.delete,color: Colors.white,),
                                    //     Text("Remove")
                                    //   ],
                                    // ),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 15, top: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: width * 0.3,
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
                                                  image: Image
                                                      .network(
                                                      DataManager.cart[keys[index]]
                                                          .Images[0])
                                                      .image
                                              )
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.65,
                                          padding: EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              SizedBox(
                                                  width: width * 0.7,
                                                  child: Text(
                                                    DataManager.cart[keys[index]]
                                                        .title,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,)
                                              ),
                                              SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  Text(single_product_price.toString(),
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            255, 118, 67, 1)),),
                                                  Text(" x${DataManager
                                                      .cart[keys[index]].tempQty}"),
                                                  Expanded(child: SizedBox()),
                                                  TextButton(
                                                    onPressed: () {
                                                      _cartController.changeQuantity(action:"minus",id:DataManager.cart[keys[index]].id);
                                                    },
                                                    child: Icon(Icons.remove, size: 15, color: Colors.black54,),
                                                    style: ButtonStyle(
                                                        backgroundColor: MaterialStateProperty
                                                            .all(
                                                            Color.fromRGBO(
                                                                241, 241, 241, 1.0)
                                                        ),
                                                        minimumSize: MaterialStateProperty
                                                            .all(
                                                            Size(width * 0.15, 15)),
                                                        shape: MaterialStateProperty
                                                            .all(
                                                            RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .circular(25))
                                                        )
                                                    ),
                                                  ),
                                                  SizedBox(width: 2,),
                                                  Text(DataManager.cart[keys[index]]
                                                      .tempQty.toString()),
                                                  SizedBox(width: 2,),
                                                  TextButton(
                                                    onPressed: () {
                                                      _cartController.changeQuantity(action:"plus",id:DataManager.cart[keys[index]].id);
                                                    },
                                                    child: Icon(Icons.add, size: 15,color: Colors.black54,),
                                                    style: ButtonStyle(
                                                        minimumSize: MaterialStateProperty
                                                            .all(
                                                            Size(width * 0.15, 15)),
                                                        backgroundColor: MaterialStateProperty
                                                            .all(
                                                            Color.fromRGBO(
                                                                241, 241, 241, 1.0)
                                                        ),
                                                        shape: MaterialStateProperty
                                                            .all(
                                                            RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .circular(25))
                                                        )
                                                    ),
                                                  ),
                                                  SizedBox(width: 10,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }else{
                                //this will call at the end
                                _cartController.updateTotalPrice(price);
                                return SizedBox(height: 130,);
                              }
                            }
                        );
                      }
                    ):
                    Container(
                      width: width,
                      height: height*0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: SizedBox(height: 1,)),
                          Image.asset("assets/images/cart.png",width: width,height: 230,),
                          Expanded(child: SizedBox(height: 1,)),
                          Text("Your Cart is Empty",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                          SizedBox(height: 10,),
                          SizedBox(width:200,height: 40,child: Text("You haven't added anything to your cart yet",textAlign:TextAlign.center,)),
                          Expanded(child: SizedBox(height: 1,)),
                          ElevatedButton(
                              onPressed: (){
                              //  Navigator.pushReplacementNamed(context, '/home');
                              Navigator.of(context).pop();
                              },
                              child: Text("Start Shopping"),
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(Size(width*0.7,50)),
                              backgroundColor: MaterialStateProperty.all(MyColors.gold),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)))
                            ),
                          ),
                          Expanded(child: SizedBox(height: 1,)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DataManager.cart.length>0 ? Positioned(
                width: width,
                height: height*0.15,
               // top: height*0.8,
                bottom: 0,
                child: Container(
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
                         // SizedBox(height: 5,),
                          // Card(
                          //   color: Color.fromRGBO(241, 241, 241, 1.0),
                          //   child: SizedBox(width:30,height:30,child: Icon(Icons.content_paste_sharp)),
                          // ),
                          SizedBox(height: 5,),
                          Text("Total:"),
                          StreamBuilder<double>(
                            initialData: 0.0,
                            stream: _cartController.totalPriceStream,
                            builder: (context, snapshot) {
                              return Text("Rs ${snapshot.data}",style: TextStyle(fontWeight: FontWeight.bold),);
                            }
                          ),
                          SizedBox(height: 5,),
                        ],
                      ),
                      SizedBox(),
                      SizedBox(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 5,),
                          //TextButton(child: Text("Add voucher code    >"),),
                          ElevatedButton(
                            onPressed: () async{
                              //check user is user is login open checkout else login screen
                               String loginResponse = await SharedPref.getCustomerDetail();
                               if(loginResponse.isNotEmpty){
                               bool isComplete = parseLoginResponse(loginResponse);
                                 if(isComplete){
                                   print("iscomplete");
                                   print("login response"+loginResponse);
                                     Navigator.pushNamed(context, '/checkout');
                                 }else{
                                   print("isnotcomplete");
                                   print("login response"+loginResponse);
                                 }
                               }else{
                                 //user not login
                                 bool isLogin = await Navigator.pushNamed(context, '/login') as bool;
                                 if(isLogin){
                                   //if user login is true then check that user profile is complete or not
                                   String loginResponse = await SharedPref.getCustomerDetail();
                                   bool isComplete = parseLoginResponse(loginResponse);
                                   if(isComplete)
                                     Navigator.pushNamed(context, '/checkout');
                                 }
                               }
                             },
                            child: Text("Check Out"),
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
              ):SizedBox()
            ]
          ),
        )
    );
  }


  bool parseLoginResponse(String loginResponse){
    //is login response is not empty then it will convert else throw exception
    if(loginResponse.isNotEmpty){
      Map<String, dynamic> user = jsonDecode(loginResponse);
      Map<String,dynamic> shipping = user['shipping'];
      int id = user['id'];
      User _user = User();
      _user.email = user["email"];
      return SharedPref.isUserProfileComplete(shipping,context,id);
    }
    return false;
  }

}