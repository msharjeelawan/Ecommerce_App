import 'package:flutter/material.dart';
import 'package:saraa_kuch/screens/LoginScreen.dart';

class RatingScreen extends StatefulWidget {

  @override
  _RatingScreenState createState(){
    return _RatingScreenState();
  }
}

class _RatingScreenState extends State<RatingScreen>{

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
                          Text("Feedback",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
            SizedBox(height: 10,),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  width: width*0.45,
                  height: width*0.45,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(241, 241, 241, 1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Container(
                  width: width*0.4,
                  height: width*0.4,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    // boxShadow: <BoxShadow>[
                    //   BoxShadow(
                    //       color: Colors.black12,
                    //       spreadRadius: 1,
                    //       blurRadius: 4
                    //   )
                    // ],
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          image: Image.asset("assets/images/shampoo_argan.png",).image,
                          fit: BoxFit.fill
                      )
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 0,
                  color: Color.fromRGBO(241, 241, 241, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: SizedBox(width:width*0.15,height:40,child: Icon(Icons.star_rate,color: Colors.yellow,)),
                ),
                Card(
                  elevation: 0,
                  color: Color.fromRGBO(241, 241, 241, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: SizedBox(width:width*0.15,height:40,child: Icon(Icons.star_rate,color: Colors.yellow,)),
                ),
                Card(
                  elevation: 0,
                  color: Color.fromRGBO(241, 241, 241, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: SizedBox(width:width*0.15,height:40,child: Icon(Icons.star_rate,color: Colors.yellow,)),
                ),
                Card(
                  elevation: 0,
                  color: Color.fromRGBO(241, 241, 241, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: SizedBox(width:width*0.15,height:40,child: Icon(Icons.star_rate,color: Colors.yellow,)),
                ),
                Card(
                  elevation: 0,
                  color: Color.fromRGBO(241, 241, 241, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: SizedBox(width:width*0.15,height:40,child: Icon(Icons.star_rate,color: Colors.black12,)),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
              child: TextField(
                //textAlignVertical: TextAlignVertical.top,
                // keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.all(20),
                    labelText: "Comment",
                    hintText: Text("Add your comment",textAlign: TextAlign.start,).data,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    )
                ),
                maxLines: 5,
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  var route = MaterialPageRoute(
                      builder: (BuildContext context){
                        return LoginScreen();
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
          ],
        ),
      ),
    );
  }
}