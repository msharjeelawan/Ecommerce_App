import 'package:flutter/material.dart';
import 'package:saraa_kuch/screens/SearchScreen.dart';

import 'RegisterScreen.dart';

class OtpScreen extends StatefulWidget{

  @override
  _OtpScreenState createState(){
    return _OtpScreenState();
  }

}

class _OtpScreenState extends State<OtpScreen>{

FocusNode f1,f2,f3,f4;
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
        elevation: 0,
        title: Text("OTP Verification"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){

          },
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: height*0.05,width: width,),
                Text("OTP Verification",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("We sent your code to +9234455***** This code will expire in 00:30",textAlign: TextAlign.center,),
                ),
                SizedBox(height: height*0.1,width: width,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width*0.18,
                      child: TextField(
                        onChanged: (value){  FocusScope.of(context).requestFocus(f2);},
                        textAlign: TextAlign.center,
                        autofocus: true,
                        obscureText: true,
                        decoration: InputDecoration(
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
                      child: TextField(
                        focusNode: f2,
                        obscureText: true,
                        onChanged: (value){  FocusScope.of(context).requestFocus(f3);},
                        decoration: InputDecoration(
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
                      child: TextField(
                        focusNode: f3,
                        obscureText: true,
                        onChanged: (value){  FocusScope.of(context).requestFocus(f4);},
                        decoration: InputDecoration(
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
                      child: TextField(
                        focusNode: f4,
                        obscureText: true,
                        onChanged: (value){FocusScope.of(context).unfocus();},
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height*0.15,width: width,),
                ElevatedButton(
                    onPressed: (){
                      var route = MaterialPageRoute(
                          builder: (context){
                            return SearchScreen();
                          }
                      );
                      Navigator.push(context, route);
                    },
                    child: Text("Continue"),
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
                SizedBox(height: height*0.15,width: width,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(child: Text("Resend OTP Code",style: TextStyle(color: Colors.deepOrange),),
                        onPressed: (){

                        })
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}