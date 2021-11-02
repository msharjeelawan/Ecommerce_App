import 'package:flutter/material.dart';

import 'RegisterScreen.dart';

class ConfirmPassword extends StatefulWidget{

  @override
  _ConfirmPasswordState createState(){
    return _ConfirmPasswordState();
  }

}


class _ConfirmPasswordState extends State<ConfirmPassword>{


  @override
  Widget build(BuildContext){
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text("Forgot Password"),
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
                Text("Confirm Password",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Please enter your new password",textAlign: TextAlign.center,),
                ),
                SizedBox(height: height*0.1,width: width,),
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
                SizedBox(height: height*0.15,width: width,),
                ElevatedButton(
                    onPressed: (){
                      var route = MaterialPageRoute(
                          builder: (context){
                            return RegisterScreen();
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
                    Text("Don't have an account?"),
                    TextButton(child: Text("Sign Up",style: TextStyle(color: Colors.deepOrange),),
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