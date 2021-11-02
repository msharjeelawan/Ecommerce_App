import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/screens/CheckOutScreen.dart';

import 'FavoriteScreen.dart';

class CartScreen extends StatefulWidget{

  _CartScreenState createState(){
    return _CartScreenState();
  }

}


class _CartScreenState extends State<CartScreen>{

  @override
  Widget build(BuildContext context){
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
                              Text("4 items")
                            ],
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:10,
                        itemBuilder: (context,index){
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
                                          image: Image.asset("assets/images/shirt.jpg").image
                                      )
                                  ),
                                ),
                                Container(
                                  width: width*0.65,
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width*0.7,
                                          child: Text("Test Test Test test Test Test Test test Test Test Test test Test Test Test test",overflow: TextOverflow.ellipsis,maxLines: 2,)
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Text("Rs10",style: TextStyle(color: Color.fromRGBO(255, 118, 67, 1)),),
                                          Text(" x$index"),
                                          Expanded(child: SizedBox()),
                                          TextButton(
                                            onPressed: (){},
                                            child: Icon(Icons.add,size: 15,),
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(
                                                    Color.fromRGBO(241, 241, 241, 1.0)
                                                ),
                                                minimumSize: MaterialStateProperty.all(Size(width*0.15,15)),
                                                shape: MaterialStateProperty.all(
                                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                                                )
                                            ),
                                          ),
                                          SizedBox(width: 2,),
                                          Text("1"),
                                          SizedBox(width: 2,),
                                          TextButton(
                                            onPressed: (){},
                                            child: Icon(Icons.remove,size: 15,),
                                            style: ButtonStyle(
                                                minimumSize: MaterialStateProperty.all(Size(width*0.15,15)),
                                                backgroundColor: MaterialStateProperty.all(
                                                    Color.fromRGBO(241, 241, 241, 1.0)
                                                ),
                                                shape: MaterialStateProperty.all(
                                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
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
                          );
                        }
                    ),
                  ],
                ),
              ),
              Positioned(
                width: width,
                height: height*0.2,
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
                          SizedBox(height: 5,),
                          Card(
                            color: Color.fromRGBO(241, 241, 241, 1.0),
                            child: SizedBox(width:30,height:30,child: Icon(Icons.content_paste_sharp)),
                          ),
                          SizedBox(height: 5,),
                          Text("Total:"),
                          Text("RS1500",style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                        ],
                      ),
                      SizedBox(),
                      SizedBox(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 5,),
                          TextButton(child: Text("Add voucher code    >"),),
                          ElevatedButton(
                            onPressed: (){
                              var route = MaterialPageRoute(
                                builder: (BuildContext context){
                                  return CheckOutScreen();
                                }
                              );
                              Navigator.push(context, route);
                              },
                            child: Text("Check Out"),
                            style: ButtonStyle(
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
            ]
          ),
        )
    );
  }
}