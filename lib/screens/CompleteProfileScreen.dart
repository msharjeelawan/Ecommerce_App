import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/screens/OtpScreen.dart';

class CompleteProfileScreen extends StatefulWidget{

  @override
  _CompleteProfileScreenState createState(){
    return _CompleteProfileScreenState();
  }
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen>{

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Sign Up",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 17,color: Color.fromRGBO(139, 139, 139, 1)),),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height*0.03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text("Complete Profile",style:TextStyle(fontWeight:FontWeight.bold,fontSize: 27),),
                      SizedBox(
                        height: height*0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: Text("Complete your details or skip",textAlign: TextAlign.center,style: TextStyle(fontSize: 13,color: Color.fromRGBO(139, 139, 139, 1)),),
                      ),
                      SizedBox(
                        height: height*0.05,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            labelText: "First Name",
                            hintText: "Enter your first name",
                            suffixIcon: Icon(Icons.account_circle_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                        ),
                      ),
                      SizedBox(
                        height: height*0.02,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            labelText: "Last Name",
                            hintText: "Enter your last name",
                            suffixIcon: Icon(Icons.account_circle_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                        ),
                      ),
                      SizedBox(height: height*0.02,),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            labelText: "Phone Number",
                            hintText: "Enter your phone number",
                            suffixIcon: Icon(Icons.smartphone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                        ),
                      ),
                      SizedBox(height: height*0.02,),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            labelText: "Address",
                            hintText: "Enter your address",
                            suffixIcon: Icon(Icons.location_on_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                        ),
                      ),
                      SizedBox(
                        height: height*0.02,
                      ),
                      SizedBox(
                        height: height*0.05,
                      ),
                      ElevatedButton(
                          onPressed: (){
                            var route = MaterialPageRoute(
                                builder: (BuildContext context){
                                  return OtpScreen();
                                }
                            );
                            Navigator.push(context, route);
                          },
                          child: Text("Continue"),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 118, 67, 1)),
                              fixedSize: MaterialStateProperty.all(
                                  Size(width*0.88,45)
                              ),
                              // backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)
                                  )
                              )
                          )
                      ),
                      SizedBox(
                        height: height*0.05,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Text("By continuing your confirm that you agree with our Term and Condition",maxLines: 2,)),
                          TextButton(child: Text("Skip",style: TextStyle(color: Colors.deepOrange),),
                              onPressed: (){

                              })
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}