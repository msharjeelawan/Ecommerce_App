import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/screens/CompleteProfileScreen.dart';

class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreenState createState(){
    return _RegisterScreenState();
  }

}

class _RegisterScreenState extends State<RegisterScreen>{

  @override
  Widget build(BuildContext context){
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
                      Text("Register Account",style:TextStyle(fontWeight:FontWeight.bold,fontSize: 27),),
                      SizedBox(
                        height: height*0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: Text("Complete your details or continue with social media",textAlign: TextAlign.center,style: TextStyle(fontSize: 13,color: Color.fromRGBO(139, 139, 139, 1)),),
                      ),
                      SizedBox(
                        height: height*0.05,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            labelText: "Email",
                            hintText: "Enter your email",
                            suffixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                        ),
                      ),
                      SizedBox(height: height*0.02,),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            labelText: "Password",
                            hintText: "Enter your password",
                            suffixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                        ),
                      ),
                      SizedBox(height: height*0.02,),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            labelText: "Confirm Password",
                            hintText: "Re-enter your password",
                            suffixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                        ),
                      ),
                      SizedBox(
                        height: height*0.03,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Icon(Icons.cancel_outlined,color: Colors.deepOrange,),
                          SizedBox(width: 5,),
                          Text("Password is too short",style: TextStyle(color: Colors.deepOrange),),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Icon(Icons.cancel_outlined,color: Colors.deepOrange,),
                          SizedBox(width: 5,),
                          Text("At least 8 character",style: TextStyle(color: Colors.deepOrange),),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Icon(Icons.cancel_outlined,color: Colors.deepOrange,),
                          SizedBox(width: 5,),
                          Text("Contains a number or symbol",style: TextStyle(color: Colors.deepOrange),),
                        ],
                      ),
                      SizedBox(
                        height: height*0.02,
                      ),
                      ElevatedButton(
                          onPressed: (){
                            var route = MaterialPageRoute(
                                builder: (BuildContext context){
                                  return CompleteProfileScreen();
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
                        height: height*0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(icon: Icon(Icons.facebook),onPressed: (){

                          }),
                          IconButton(icon: Icon(Icons.facebook),onPressed: (){

                          }),
                          IconButton(icon: Icon(Icons.facebook),onPressed: (){

                          }),
                        ],
                      ),
                      Center(
                        child: Text("By continuing your confirm that you agree with our Term and Condition",textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(139, 139, 139, 1)),),
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