import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/controller/LoginSignUpController.dart';
import 'package:saraa_kuch/helper/helper.dart';
import 'package:saraa_kuch/screens/SearchScreen.dart';
import 'package:saraa_kuch/widgets/FormError.dart';

import '../constants.dart';
import 'RegisterScreen.dart';

class OtpScreen extends StatefulWidget{
  String email;
  OtpScreen({Key key, this.email}) : super(key: key);


  @override
  _OtpScreenState createState(){
    return _OtpScreenState();
  }

}

class _OtpScreenState extends State<OtpScreen>{

FocusNode f1,f2,f3,f4;
LoginSignupBloc loginSignupbloc = LoginSignupBloc();
final _formKey = GlobalKey<FormState>();
String otp1 = "";
String otp2 = "";
String otp3 = "";
String otp4 = "";

List<String> errors = [];
String secondtimer = "0";



@override
void dispose() {
  super.dispose();
}


  @override
  void initState(){
    super.initState();
    f1 = new FocusNode();
    f2 = new FocusNode();
    f3 = new FocusNode();
    f4 = new FocusNode();


    // f1.onKey = (FocusNode focusNode,RawKeyEvent event){
    //   if(focusNode.hasFocus){
    //     FocusScope.of(context).requestFocus(f2);
    //   }
    // };
    // f2.onKey = (FocusNode focusNode,RawKeyEvent event){
    //   if(focusNode.hasFocus){
    //     FocusScope.of(context).requestFocus(f3);
    //   }
    // };
    // f3.onKey = (FocusNode focusNode,RawKeyEvent event){
    //   event.physicalKey.
    //   if(focusNode.hasFocus){
    //     FocusScope.of(context).requestFocus(f4);
    //   }
    // };
    // f4.onKey = (FocusNode focusNode,RawKeyEvent event){
    //  // focusNode.nextFocus();
    // };

    // f1.addListener(() {
    //   f2.nextFocus();
    // });
    // f2.addListener(() {
    //   f3.nextFocus();
    // });
    // f3.addListener(() {
    //   f4.nextFocus();
    // });
    // f1.addListener(() {
    //   f.nextFocus();
    // });
  }

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
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: height*0.05,width: width,),
                  Text("OTP Verification",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("We sent otp code to ${widget.email}.",textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: height*0.1,width: width,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: width*0.18,
                        child:  TextFormField(
                          maxLength: 1,

                          keyboardType: TextInputType.number,
                          onSaved: (newValue) => otp1 = newValue.toString().trim(),

                          onChanged: (value){  FocusScope.of(context).requestFocus(f2);},
                          textAlign: TextAlign.center,
                          autofocus: true,
                          decoration: InputDecoration(
                              counterText: '',
                              counterStyle: TextStyle(fontSize: 0),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: width*0.18,
                        child: TextFormField(
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          onSaved: (newValue) => otp2 = newValue.toString().trim(),

                          focusNode: f2,
                          onChanged: (value){  FocusScope.of(context).requestFocus(f3);},
                          decoration: InputDecoration(
                              counterText: '',
                              counterStyle: TextStyle(fontSize: 0),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: width*0.18,
                        child: TextFormField(
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          onSaved: (newValue) => otp3 = newValue.toString().trim(),

                          focusNode: f3,
                          onChanged: (value){  FocusScope.of(context).requestFocus(f4);},
                          decoration: InputDecoration(
                              counterText: '',
                              counterStyle: TextStyle(fontSize: 0),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: width*0.18,
                        child: TextFormField(
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          onSaved: (newValue) => otp4 = newValue.toString().trim(),

                          focusNode: f4,
                          onChanged: (value){FocusScope.of(context).unfocus();},
                          decoration: InputDecoration(
                              counterText: '',
                              counterStyle: TextStyle(fontSize: 0),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              )
                          ),
                        ),
                      ),
                    ],
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
                  SizedBox(height: height * 0.075, width: width,),

                  ElevatedButton(
                      onPressed: (){
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          // if all are valid then go to success screen
                          KeyboardUtil.hideKeyboard(context);
                          loginSignupbloc.validateOtpErrors(otp1,otp2,otp3,otp4,widget.email,context);


                        }

                        /*    var route = MaterialPageRoute(
                            builder: (context){
                              return SearchScreen();
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder(
                          stream: loginSignupbloc.secondStream,
                          initialData: secondtimer,
                          builder: (context, snapshot) {
                            return snapshot.data != "0" && snapshot.data != "60"
                                ? Text("00:"+snapshot.data+" Second",style: TextStyle(color: gold))
                                :    TextButton(child: Text("Resend OTP Code",style: TextStyle(color: gold),),
                                onPressed: (){
                                  loginSignupbloc.resetPasssword(widget.email,context,"resend");

                                });
                          }),

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