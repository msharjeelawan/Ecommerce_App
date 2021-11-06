import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/controller/LoginSignUpController.dart';
import 'package:saraa_kuch/helper/helper.dart';
import 'package:saraa_kuch/screens/ConfirmPassword.dart';
import 'package:saraa_kuch/widgets/FormError.dart';

import '../constants.dart';

class ForgotPasswordScreen extends StatefulWidget {

  @override
  _ForgotPasswordScreenState createState() {
    return _ForgotPasswordScreenState();
  }
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  LoginSignupBloc loginSignupbloc = LoginSignupBloc();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),

          child: SafeArea(
            child: Form(
              key: _formKey,
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
                            Navigator.pop(context);
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
                              "Reset Password",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.05, width: width,),

                  Text("Change/Forgot Password", style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      "Please enter your email and we will send you an OTP to recover to your account",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: height * 0.1, width: width,),
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
                        )
                    ),
                  ),
                  SizedBox(height: height * 0.05, width: width,),
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
                  SizedBox(height: height * 0.05, width: width,),

                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          // if all are valid then go to success screen
                          KeyboardUtil.hideKeyboard(context);
                          loginSignupbloc.validateEmailErrors(email,context);

                        }

                        /*var route = MaterialPageRoute(
                            builder: (BuildContext context){
                              return ConfirmPassword();
                            }
                        );
                        Navigator.push(context, route);*/
                      },
                      child: Text("Submit"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(gold),

                          fixedSize: MaterialStateProperty.all(
                              Size(width * 0.88, 50)
                          ),
                          // backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                              )
                          )
                      )
                  ),
                  SizedBox(height: height * 0.15, width: width,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(child: Text(
                        "Sign Up", style: TextStyle(color: gold),),
                          onPressed: () {

                          })
                    ],
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}