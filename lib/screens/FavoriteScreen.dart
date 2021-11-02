import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saraa_kuch/screens/ProfileScreen.dart';

class FavoriteScreen extends StatefulWidget{

  @override
  _FavoriteScreenState createState(){
    return _FavoriteScreenState();
  }


}

class _FavoriteScreenState extends State<FavoriteScreen>{


  @override
  Widget build(BuildContext context){
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
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
                        Text("Favorites",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        Text("4 items")
                      ],
                    ),
                  ),
                ],
              ),
              GridView.builder(
                padding: EdgeInsets.all(15),
                itemCount: 20,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.6
                ),
                itemBuilder: (context,index){
                  var height = 0.0;
                  var h1 = 0.0;
                  var temp =0.0;
                  if(index%2==0){
                     height = 0;
                     h1 = 25;
                     temp = 0;
                  }else{
                    height =25;
                    h1 = 0;
                    temp=15;
                  }
                 return Container(
                   margin: EdgeInsets.only(top: height,bottom: h1),
                   child: GestureDetector(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Container(
                           width: width*0.42,
                           height: 130,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
                               color: Colors.white,
                               boxShadow: [
                                 BoxShadow(
                                     color: Colors.black12,
                                     spreadRadius: 0,
                                     blurRadius: 4)
                               ],
                               image: DecorationImage(
                                   image: Image.asset("assets/images/shirt.jpg").image
                               )
                           ),
                         ),
                         SizedBox(height: 10,),
                         Padding(
                           padding: const EdgeInsets.only(left: 5.0),
                           child: Text("Wireless Controller for ps4",),
                         ),
                         Row(
                           children: [
                             SizedBox(width: 5,),
                             Text("Rs 2000"),
                              Expanded(child: SizedBox()),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Icon(Icons.bedtime_sharp),
                              ),
                             SizedBox(width: 5,),
                           ],
                         )
                       ],
                     ),
                     onTap: (){
                      // print("favorite screen");
                       var route = MaterialPageRoute(
                         builder: (BuildContext context){
                           return ProfileScreen();
                         }
                       );
                       Navigator.push(context, route);
                     },
                   ),
                 );
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }

}


// return Container(
// //padding: EdgeInsets.only(left: 15,top: 10),
// width: width*0.4,
// height: 200,
// child: GestureDetector(
// child: Column(
// //mainAxisSize: MainAxisSize.min,
// children: [
// Container(
// //     margin: EdgeInsets.only(top: height),
// //   padding: EdgeInsets.only(top: height),
// width: width*0.4,
// height: 130,
// //height: height,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(20),
// color: Colors.white,
// boxShadow: [
// BoxShadow(
// color: Colors.black12,
// spreadRadius: 0,
// blurRadius: 4
// )
// ],
// image: DecorationImage(
// image: Image.asset("assets/images/shirt.jpg").image
// )
// ),
// ),
// SizedBox(height: 2,),
// Text("test"),
// SizedBox(height: 10,),
//
// ],
// ),
// ),
// );