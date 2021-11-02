import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/screens/FavoriteScreen.dart';

class CheckOutScreen extends StatefulWidget {

  _CheckOutScreenState createState(){
    return _CheckOutScreenState();
  }

}


class _CheckOutScreenState extends State<CheckOutScreen> {
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
                              Text("4 items")
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
                          child: TextButton(onPressed: (){}, child: Text("View All",style: TextStyle(color: Color.fromRGBO(187, 189, 195, 1)),)),
                        ),
                        SizedBox(width: 15,)
                      ],
                    ),
                    Container(
                      width: width,
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                         // physics: NeverScrollableScrollPhysics(),
                         // shrinkWrap: true,
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
                                ],
                              ),
                            );
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
                          child: TextButton(onPressed: (){}, child: Text("Edit Address",style: TextStyle(color: Color.fromRGBO(187, 189, 195, 1)),)),
                        ),
                        SizedBox(width: 15,)
                      ],
                    ),
                    Container(
                      child: Text("citi housing jhelum, Punjab, pakistan 49000",overflow: TextOverflow.ellipsis,maxLines: 3,),
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
                          child: TextButton(onPressed: (){}, child: Text("View All",style: TextStyle(color: Color.fromRGBO(187, 189, 195, 1)),)),
                        ),
                        SizedBox(width: 15,)
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                width: width,
                height: height*0.2,
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
                                    return FavoriteScreen();
                                  }
                              );
                              Navigator.push(context, route);
                            },
                            child: Text("Pay Now"),
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
            ],
          ),
        ),
      ),
    );
  }
}