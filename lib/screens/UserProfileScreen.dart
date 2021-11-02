import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saraa_kuch/screens/RatingScreen.dart';

class UserProfileScreen extends StatefulWidget {

  @override
  _UserProfileScreenState createState(){
    return _UserProfileScreenState();
  }
}

class _UserProfileScreenState extends State<UserProfileScreen>{

  @override
  Widget build(BuildContext context){
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
                children: [
                  Row(
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
                              children: [
                                Text("User Profile",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    child: Stack(
                      children: [
                        Container(
                          width: width*0.35,
                          height: width*0.35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1,
                                    blurRadius: 4
                                )
                              ],
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                  image: Image.asset("assets/images/shirt.jpg",).image,
                                  fit: BoxFit.fill
                              )
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(241, 241, 241, 1),
                                borderRadius: BorderRadius.circular(20),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black12,
                                //     spreadRadius: 1,
                                //     blurRadius: 8,
                                //   )
                                // ]
                              ),
                              child: SizedBox(
                                child: Icon(Icons.photo_camera_sharp,color:Color.fromRGBO(136, 136, 137, 1)),
                                width: 40,
                                height: 40,
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                 // SizedBox(height: 30,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                    child: Column(
                      //mainAxisSize: MainAxisSize.max,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 25),
                              suffixIcon: Icon(Icons.account_circle_outlined),
                              labelText: "First Name",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide(width: 4))
                          ),
                        ),
                        SizedBox(height: 15,),
                        TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 25),
                              suffixIcon: Icon(Icons.account_circle_outlined),
                              labelText: "Last Name",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                          ),
                        ),
                        SizedBox(height: 15,),
                        TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 25),
                              suffixIcon: Icon(Icons.smartphone),
                              labelText: "Phone Number",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))

                          ),
                        ),
                        SizedBox(height: 15,),
                        TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 25),
                              suffixIcon: Icon(Icons.email_outlined),
                              labelText: "Email",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                          ),
                        ),
                        SizedBox(height: 15,),
                        TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 25),
                              suffixIcon: Icon(Icons.lock),
                              labelText: "Password",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                          ),
                        ),
                        SizedBox(height: 15,),
                        TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 25),
                              suffixIcon: Icon(Icons.location_on_outlined),
                              labelText: "Address",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                          ),
                        ),
                        SizedBox(height: 15,),
                        TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 25),
                              suffixIcon: Icon(Icons.location_on_outlined),
                              labelText: "Postal Code",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                          ),
                        ),
                        SizedBox(height: 25,),
                        ElevatedButton(
                          onPressed: (){
                            var route = MaterialPageRoute(
                                builder: (BuildContext context){
                                  return RatingScreen();
                                }
                            );
                            Navigator.push(context, route);
                          },
                          child: Text("Save Changes"),
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              Size(width*0.9,50)
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                                )
                              )
                            )
                          ),
                      ],
                    ),
                  ),

                ],
              )
          ),
        ),
      ),
    );
  }
}