import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/SharedPref/SharedPrefren.dart';
import 'package:saraa_kuch/controller/LoginSignUpController.dart';
import 'package:saraa_kuch/helper/helper.dart';
import 'package:saraa_kuch/models/Customer.dart';
import 'package:saraa_kuch/models/login_response.dart';
import 'package:saraa_kuch/screens/CompleteProfileScreen.dart';
import 'package:saraa_kuch/screens/ForgotPasswordScreen.dart';
import 'package:saraa_kuch/screens/ProfileScreen.dart';

import 'package:saraa_kuch/services/LoginSignUpService.dart';
import 'package:saraa_kuch/widgets/FormError.dart';

import '../constants.dart';
import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  LoginSignupBloc loginSignupbloc = LoginSignupBloc();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    //initialize context datamenber in LoginSignupBloc class for using in navigator
    loginSignupbloc.context = context;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
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
                          Navigator.pop(context,false);
                        },
                      ),
                    ),
                    Container(
                      width: width * 0.6,
                      child: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          "Welcome Back",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Text(
                          "Sign in with your email and password or countinue with social media",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (newValue) => email = newValue.toString().trim(),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              labelText: "Email",
                              hintText: "Enter your email",
                              suffixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        TextFormField(
                          obscureText: true,
                          onSaved: (newValue) => password = newValue.toString().trim(),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              labelText: "Password",
                              hintText: "Enter your password",
                              suffixIcon: Icon(Icons.lock_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        StreamBuilder(
                            stream: loginSignupbloc.validateStream,
                            initialData: errors,
                            builder: (context, snapshot) {
                              return snapshot.data != ""
                                  ? FormError(errors: snapshot.data)
                                  : Container();
                            }),
                        StreamBuilder(
                            stream: loginSignupbloc.progressStream,
                            initialData: false,
                            builder: (context, snapshot) {
                              return snapshot.data == true
                                  ? Center(
                                child: CircularProgressIndicator(),
                              )
                                  : Container();
                            }),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          children: [
                            Expanded(child: SizedBox()),
                            TextButton(
                                onPressed: () {
                                  final route = MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return ForgotPasswordScreen();
                                      });
                                  Navigator.push(context, route);
                                },
                                child: Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: gold),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                // if all are valid then go to success screen
                                KeyboardUtil.hideKeyboard(context);
                                loginSignupbloc.validateErrors(email, password);
                              }
                              /*     loginSignupbloc.loginCustomer(
                              "ks@gmail.com", "123456789");*/
                              //  LoginSignupScreen.loginCustomer("kts@gmail.com","123456789");
                              /*   var route = MaterialPageRoute(
                                  builder: (BuildContext context){
                                    return ForgotPasswordScreen();
                                  }
                              );
                              Navigator.push(context, route);*/
                            },
                            child: Text("Submit"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(gold),
                                fixedSize: MaterialStateProperty.all(
                                    Size(width * 0.88, 50)),
                                // backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30))))),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: boxDecorationRoundedWithShadow(16),
                              padding: EdgeInsets.all(16),
                              child: GestureDetector(
                                child: Image.asset(
                                    'assets/images/wa_facebook.png',
                                    width: 40,
                                    height: 40),
                                onTap: (){
                                  loginSignupbloc.facebookLogin(context);

                                },
                              ),

                            ),
                            SizedBox(
                              width: width * 0.1,
                            ),
                            Container(
                              decoration: boxDecorationRoundedWithShadow(16),
                              padding: EdgeInsets.all(16),
                              child: GestureDetector(
                                child: Image.asset(
                                    'assets/images/wa_google_logo.png',
                                    width: 40,
                                    height: 40),
                                onTap: () {
                                  loginSignupbloc.googleLogin();
                                },
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            TextButton(
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(color: gold),
                                ),
                                onPressed: () {
                                  //    googleSignIn();

                                  final  route = MaterialPageRoute(
                                      builder: (BuildContext context){
                                        return RegisterScreen();
                                      }
                                  );
                                  Navigator.push(context, route);
                                })
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }


}