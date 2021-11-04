import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/controller/LoginSignUpController.dart';
import 'package:saraa_kuch/helper/helper.dart';
import 'package:saraa_kuch/screens/CompleteProfileScreen.dart';
import 'package:saraa_kuch/services/LoginSignUpService.dart';
import 'package:saraa_kuch/widgets/FormError.dart';

import '../constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  LoginSignupBloc loginSignupbloc = LoginSignupBloc();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String conform_password = "";
  List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
                        "Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color.fromRGBO(139, 139, 139, 1)),
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
                      "Register Account",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Text(
                        "Complete your details or continue with social media",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromRGBO(139, 139, 139, 1)),
                      ),
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
                      onSaved: (newValue) =>
                          password = newValue.toString().trim(),
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
                      height: height * 0.02,
                    ),
                    TextFormField(
                      obscureText: true,
                      onSaved: (newValue) =>
                          conform_password = newValue.toString().trim(),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          labelText: "Confirm Password",
                          hintText: "Re-enter your password",
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
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            // if all are valid then go to success screen
                            KeyboardUtil.hideKeyboard(context);
                            loginSignupbloc.validateSignupErrors(email,password,conform_password,context);
                            /*
                            LoginSignupScreen.RegisterCustomer(
                                "kts1111@gmail.com", "123456789");
*/

                          }

                          /*   var route = MaterialPageRoute(
                                  builder: (BuildContext context){
                                    return CompleteProfileScreen();
                                  }
                              );
                              Navigator.push(context, route);

                            */
                        },
                        child: Text("Continue"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(gold),
                            fixedSize: MaterialStateProperty.all(
                                Size(width * 0.88, 45)),
                            // backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))))),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(Icons.facebook), onPressed: () {}),
                        IconButton(
                            icon: Icon(Icons.facebook), onPressed: () {}),
                        IconButton(
                            icon: Icon(Icons.facebook), onPressed: () {}),
                      ],
                    ),
                    Center(
                      child: Text(
                        "By continuing your confirm that you agree with our Term and Condition",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color.fromRGBO(139, 139, 139, 1)),
                      ),
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
