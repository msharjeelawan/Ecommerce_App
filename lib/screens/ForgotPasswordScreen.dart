import 'package:flutter/material.dart';
import 'package:saraa_kuch/screens/ConfirmPassword.dart';

class ForgotPasswordScreen extends StatefulWidget {

  @override
  _ForgotPasswordScreenState createState() {
    return _ForgotPasswordScreenState();
  }
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>{

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,size: 15,),onPressed: (){

        }),
        centerTitle: true,
        elevation: 0,
        title: Text("Forgot Password",style: TextStyle(fontSize: 15),textAlign: TextAlign.center,),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: height*0.05,width: width,),
                Text("Forgot Password",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Please enter your email and we will send you a link to return to your account",textAlign: TextAlign.center,),
                ),
                SizedBox(height: height*0.1,width: width,),
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
                SizedBox(height: height*0.15,width: width,),
                ElevatedButton(
                    onPressed: (){
                      var route = MaterialPageRoute(
                          builder: (BuildContext context){
                            return ConfirmPassword();
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