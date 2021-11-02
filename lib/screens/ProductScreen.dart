import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/screens/CartScreen.dart';

class ProductScreen extends StatefulWidget{

  @override
  _ProductScreenState createState(){
    return new _ProductScreenState();
  }

}

class _ProductScreenState extends State<ProductScreen>{

  @override
  Widget build(BuildContext context){
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var h1 = height*0.29;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 50,
        backwardsCompatibility: false,
        backgroundColor: Color.fromRGBO(241, 241, 241, 1.0),
        leading: Padding(
          padding: const EdgeInsets.only(left:15,top:10,right:0,bottom:0),
          child: TextButton(
            onPressed: (){
                Navigator.pop(context);
                },
            child: Icon(Icons.arrow_back_ios,
                size: 17,
                color: Color.fromRGBO(25, 25, 25, 1),
            ),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(20, 20)),
              alignment: Alignment.centerRight,
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                  )
              )
            ),
          ),
        ),
        actions: [
          InkWell(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              width: 60,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("4.5",style: TextStyle(color: Color.fromRGBO(103, 103, 103, 1)),),

                  Icon(Icons.star_rate,color: Color.fromRGBO(255, 213, 37, 1),size: 12,)
                ],
              ),
            ),
            onTap: (){
              var route = MaterialPageRoute(
                builder: (BuildContext context){
                  return CartScreen();
                }
              );
              Navigator.push(context, route);
            },
          ),
          SizedBox(width: 15,)
        ],
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color.fromRGBO(241, 241, 241, 1.0)
        ),
      ),
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
                top: 0,
                width: width,
                height: height,
                child: Container(
                  color: Color.fromRGBO(241, 241, 241, 1.0),
                 // height: 200,
                  child: Column(
                   // mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/Saraakuch_logo.png",width: 100,height: h1/1.6,),
                      Container(
                        width: width*0.8,
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context,index){
                              return Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white
                                ),
                                child: GestureDetector(
                                  child: Image.asset("assets/images/Saraakuch_logo.png"),
                                  onTap: (){},
                                ),
                              );
                            }
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Positioned(
              width: width,
               top: h1,
              height: height,
                child: Container(
                  padding: EdgeInsets.only(left: 15,top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("test product",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("1000Rs"),
                          ),
                          Expanded(child: SizedBox()),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 60,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(241, 241, 241, 1.0),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
                              ),
                              child: Icon(Icons.adjust),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(right: 60.0),
                        child: Text("test product test product test product test product test product test product test producttest producttest producttest producttest producttest product",maxLines: 3,overflow: TextOverflow.ellipsis,textAlign: TextAlign.justify,),
                      ),
                      //SizedBox(height: 5,),
                      TextButton(
                        onPressed: (){
                          
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero)
                        ), 
                          child: Text("See More Detail >")
                      )
                    ],
                  ),
                )
            ),
            Positioned(
              top: h1*2.1,
                height: height,
                width: width,
                child: Container(
                  padding: EdgeInsets.only(top: height*0.015),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                      color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //TextButton(onPressed: onPressed, child: child)
                          TextButton(
                            onPressed: (){}, 
                            child: Icon(Icons.add), 
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.white
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                              )
                            ),
                          ),
                          SizedBox(width: 7,),
                          Text("1"),
                          SizedBox(width: 7,),
                          TextButton(
                            onPressed: (){},
                            child: Icon(Icons.remove),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.white
                                ),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                                )
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            ),
            Positioned(
                top: height*0.73,
                height: height,
                width: width,
                child: Container(
                  padding: EdgeInsets.only(top: height*0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: (){},
                        child: Text("Add to Cart",style: TextStyle(fontSize: 17),),
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(width*0.7, height*0.08)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(18)))
                        ),
                      )

                    ]
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

}