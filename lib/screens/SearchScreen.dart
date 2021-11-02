import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/screens/SliderScreen.dart';

class SearchScreen extends StatefulWidget{

  @override
  _SearchScreenState createState(){
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
     ///   title: Text("Search"),
      ///  centerTitle: true,
       toolbarHeight: 65,
       bottom: PreferredSize(
         child:  Container(
           padding: EdgeInsets.only(bottom: 5),
           child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [
               IconButton(
                   onPressed: (){

                   },
                   icon: Icon(Icons.arrow_back_ios_outlined,size: 20,)),
               Flexible(
                   child: Padding(
                     padding: const EdgeInsets.fromLTRB(0,10,15,0),
                     child: TextField(
                       textAlignVertical: TextAlignVertical.center,
                       decoration: InputDecoration(
                           contentPadding: const EdgeInsets.all(10),
                           prefixIcon: Icon(Icons.search,color: Color.fromRGBO(120, 119, 136, 1),),
                           hintText: "Search Product",
                           hintStyle: TextStyle(
                               color: Color.fromRGBO(117, 117, 117, 1)
                           ),
                           fillColor: Color.fromRGBO(241, 241, 241, 1.0),
                           filled: true,
                           border:OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20.0),
                               borderSide: BorderSide.none
                           )
                       ),
                     ),
                   )
               ),
               Stack(
                   clipBehavior: Clip.none,
                   children: [
                     Positioned(
                       child:  Container(
                         decoration: BoxDecoration(
                             color:Color.fromRGBO(241, 241, 241, 1),
                             borderRadius: BorderRadius.circular(30.0)
                         ),
                         child: IconButton(onPressed: (){

                         },
                             icon: Icon(
                               Icons.shopping_cart,
                               size: 26.0,
                               color: Color.fromRGBO(142, 142, 142, 1),
                             )
                         ),
                       ),
                     ),
                     Positioned(
                       right: -3,
                       top: -3,
                       child: Container(
                         // width: 15,
                         height: 19,
                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.red),
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 4.0),
                           child: Center(child: Text('10',style: TextStyle(color: Colors.white,fontSize: 10),)),
                         ),
                       ),
                     )
                   ]),
               SizedBox(width: 10,),
             ],),
         ),
       )    ,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              GridView.builder(
                  itemCount: 50,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 0,childAspectRatio: 0.58),
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        var route = MaterialPageRoute(builder: (BuildContext context){
                          return SliderScreen();
                        });
                        Navigator.push(context, route);
                      },
                      child: Card(
                        color:Color.fromRGBO(241, 241, 241, 1),
                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(style: BorderStyle.none)),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset("assets/images/shampoo_argan.png",fit: BoxFit.fill,),
                              Text("Totex Argan Shampoo 750ml",style: TextStyle(fontSize: 15),),
                              SizedBox(height: 5,),
                              Text("Rs. 999",style: TextStyle(fontSize: 18,color: Colors.deepOrange),),
                              SizedBox(height: 8,),
                              Row(
                                children: [
                                  Text("Rs. 1250",style: TextStyle(decoration: TextDecoration.lineThrough),),
                                  SizedBox(width: 3,),
                                  Text("-5%",style: TextStyle(color: Color.fromRGBO(158, 158, 170, 1)),),
                                ],
                              ),
                              SizedBox(height: 6,),
                              Row(
                                children: [
                                  Icon(Icons.star,color: Colors.yellow,size: 20,),
                                  Icon(Icons.star,color: Colors.yellow,size: 20,),
                                  Icon(Icons.star,color: Colors.yellow,size: 20,),
                                  Icon(Icons.star_half_outlined,color: Colors.yellow,size: 20,),
                                  Icon(Icons.star_border,color: Colors.yellow,size: 20,),
                                  Text("(15)"),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}