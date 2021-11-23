import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saraa_kuch/helper/DataManager.dart';
import 'package:saraa_kuch/models/ProductScreen/ProductArgument.dart';
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
    FavoriteArgument fa = ModalRoute.of(context).settings.arguments as FavoriteArgument;
    bool isFullScreen = false;
    if(fa!=null){
      //call from home screen
      isFullScreen = fa.isFullScreen;
    }

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    List<int> keys = DataManager.favorite.keys.toList();
    int key;
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
                    child: isFullScreen?IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 17,
                        color: Color.fromRGBO(25, 25, 25, 1),
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ):SizedBox(),
                  ),
                  Container(
                    width: width*0.6,
                    child:  Column(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Favorites",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        Text("${DataManager.favorite.length} items")
                      ],
                    ),
                  ),
                ],
              ),
              GridView.builder(
                padding: EdgeInsets.all(15),
                itemCount: DataManager.favorite.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.6
                ),
                itemBuilder: (context,index){
                  int price = DataManager.favorite[keys[index]].price;
                  int discountPrice = DataManager.favorite[keys[index]].discountPrice;
                  key = keys[index];
                  if(price>discountPrice && discountPrice>0){
                    //discount available
                    price = DataManager.favorite[keys[index]].discountPrice;
                  }
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
                           height: 120,
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
                                   image: Image.network(DataManager.favorite[key].Images[0]).image
                               )
                           ),
                         ),
                         SizedBox(height: 10,),
                         Padding(
                           padding: const EdgeInsets.only(left: 5.0),
                           child: Text(DataManager.favorite[key].title,maxLines: 2,),
                         ),
                         Row(
                           children: [
                             SizedBox(width: 5,),
                             Text("Rs ${price}"),
                              Expanded(child: SizedBox()),

                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: SizedBox(width:30,height: 30,child: Icon(Icons.favorite,color: Colors.red,)),
                              ),
                             SizedBox(width: 5,),
                           ],
                         )
                       ],
                     ),
                     onTap: (){
                       Navigator.pushNamed(context, "/product",arguments: ProductArgument(id: key,type: "favorite"));


                       var route = MaterialPageRoute(
                         builder: (BuildContext context){
                           return ProfileScreen();
                         }
                       );
                      // Navigator.push(context, route);
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

class FavoriteArgument{
  bool isFullScreen=true;

  FavoriteArgument({this.isFullScreen});
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