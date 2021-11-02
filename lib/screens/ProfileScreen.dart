import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:saraa_kuch/screens/UserProfileScreen.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();

  String _address = ""; // create this variable

}


class _ProfileScreenState extends State<ProfileScreen>{
  List menuTitle = ["My Account", "Notifications","Settings","Help Center","Log Out"];
  List<IconData> menuIcons = [Icons.account_circle_outlined,
    Icons.notifications,
    Icons.settings,
    Icons.help_outline,
    Icons.logout];
  @override
  Widget build(BuildContext context){
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children:[
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
                          Text("Profile",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
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
                    width: width*0.5,
                    height: width*0.5,
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
            SizedBox(height: 20,),
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              itemCount: 5,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return Card(
                    color:  Color.fromRGBO(241, 241, 241, 1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    margin: EdgeInsets.only(top: 10),
                    child:InkWell(
                      onTap: (){
                     //  String ad= await GeoAddress._getPlace(32.9966944, 73.6548409);
                       //print(ad);
                        var route = MaterialPageRoute(
                            builder: (BuildContext context){
                              return UserProfileScreen();
                            }
                            );
                        Navigator.push(context, route);
                        },
                      child: ListTile(
                        leading: Icon(
                          menuIcons[index],
                          color: Color.fromRGBO(254, 120, 70, 1),
                        ),
                        title: Text(menuTitle[index]),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    )
                );
                },
            ),
            SizedBox(height: 40,)
          ]
        ),
      ),
    );
  }
}


class GeoAddress {

  static  Future<String> _getPlace(double lat,double lng) async {
    List<Placemark> newPlace = await placemarkFromCoordinates(lat,lng);
    // this is all you need
    Placemark placeMark  = newPlace[0];
    String name = placeMark.name;
    String subLocality = placeMark.subLocality;
    String locality = placeMark.locality;
    String administrativeArea = placeMark.administrativeArea;
    String postalCode = placeMark.postalCode;
    String country = placeMark.country;
    String address = "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";

    print("in function"+address);

    return address;
  }
}