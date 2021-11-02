import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/screens/ForgotPasswordScreen.dart';

class LoginScreen extends StatefulWidget{

  @override
  _LoginScreenState createState(){
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen>{

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
                          Text("Sign In",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
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
                      Text("Welcome Back",style:TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
                      SizedBox(
                        height: height*0.02,
                      ),
                      Text("Sign in with your email and password or countinue with social media",textAlign: TextAlign.center,),
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
                      SizedBox(
                        height: height*0.03,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Icon(Icons.cancel_outlined,color: Colors.deepOrange,),
                          SizedBox(width: 5,),
                          Text("Incorrect email or password",style: TextStyle(color: Colors.deepOrange),),
                        ],
                      ),
                      SizedBox(height: height*0.02,),
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (value){

                          }),
                          Text("Remember me"),
                          Expanded(child: SizedBox()),
                          TextButton(onPressed: (){}, child: Text("Forgot Password",style: TextStyle(decoration: TextDecoration.underline),))
                        ],
                      ),
                      SizedBox(
                        height: height*0.02,
                      ),
                      ElevatedButton(
                          onPressed: (){
                            var route = MaterialPageRoute(
                                builder: (BuildContext context){
                                  return ForgotPasswordScreen();
                                }
                            );
                            Navigator.push(context, route);
                          },
                          child: Text("Submit"),
                          style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  Size(width*0.88,50)
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(child: Text("Sign Up",style: TextStyle(color: Colors.deepOrange),),
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