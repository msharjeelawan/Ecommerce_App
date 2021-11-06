import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/controller/LoginSignUpController.dart';
import 'package:saraa_kuch/helper/helper.dart';
import 'package:saraa_kuch/widgets/FormError.dart';

import '../constants.dart';
import 'RegisterScreen.dart';

class ConfirmPassword extends StatefulWidget{
  String email;
  String securityCode;
  ConfirmPassword({Key key,this.email,this.securityCode}) : super(key: key);


  @override
  _ConfirmPasswordState createState(){
    return _ConfirmPasswordState();
  }

}


class _ConfirmPasswordState extends State<ConfirmPassword>{
  LoginSignupBloc loginSignupbloc = LoginSignupBloc();
  final _formKey = GlobalKey<FormState>();
  String password = "";
  String conform_password = "";
  List<String> errors = [];


  @override
  Widget build(BuildContext){
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: Form(
              key:_formKey,
              child: Column(
                children: [

                  SizedBox(height: height*0.05,width: width,),
                  Text("Change Password",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Please enter your new password",textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: height*0.1,width: width,),
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

                  SizedBox(height: height*0.075,width: width,),
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
                    height: height * 0.075,
                  ),


                  ElevatedButton(
                      onPressed: (){
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          // if all are valid then go to success screen
                          KeyboardUtil.hideKeyboard(context);
                          loginSignupbloc.validateChangePasswordErrors(widget.email,widget.securityCode,password,conform_password,context);
                          /*
                            LoginSignupScreen.RegisterCustomer(
                                "kts1111@gmail.com", "123456789");
*/

                        }
                       /* var route = MaterialPageRoute(
                            builder: (context){
                              return RegisterScreen();
                            }
                        );
                        Navigator.push(context, route);*/
                      },
                      child: Text("Continue"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(gold),
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
                  SizedBox(height: height*0.15,width: width,),

                ],
              ),
            ),
          )
      ),
    );
  }
}