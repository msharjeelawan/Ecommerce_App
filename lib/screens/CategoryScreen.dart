import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/controller/CategoryController.dart';
import 'package:saraa_kuch/controller/SearchController.dart';
import 'package:saraa_kuch/helper/DataManager.dart';
import 'package:saraa_kuch/models/HomeScreen/Product.dart';
import 'package:saraa_kuch/models/ProductScreen/ProductArgument.dart';
import 'package:saraa_kuch/screens/HomeScreen.dart';
import 'package:saraa_kuch/screens/SliderScreen.dart';

class CategoryScreen extends StatefulWidget{

  final int id;
  static CategoryController categoryController;
  const CategoryScreen({this.id});

  @override
  _CategoryScreenState createState(){
    return _CategoryScreenState();
  }
}

class _CategoryScreenState extends State<CategoryScreen>{

   CategoryController _categoryController;
  @override
  void initState(){
    super.initState();
    _categoryController = new CategoryController(id:widget.id);
    CategoryScreen.categoryController = _categoryController;
   // SearchController.cartCountController = new StreamController<int>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Category"),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark
        ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0,right: 8),
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "/cart");
            },
            child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    child:  Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          color:Color.fromRGBO(241, 241, 241, 1),
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                      child: IconButton(
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
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: MyColors.gold),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Center(child: StreamBuilder<int>(
                            initialData: DataManager.cart.length,
                            stream: _categoryController.categoryCartStream,
                            builder: (context, snapshot) {
                              int data = snapshot.data;
                              return Text(data.toString(),style: TextStyle(color: Colors.white,fontSize: 10),);
                            }
                        )),
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ],
      //  toolbarHeight: 63,
      //   bottom: PreferredSize(
      //     preferredSize: Size(0,0),
      //     child:  Container(
      //       color: Colors.white,
      //       padding: EdgeInsets.only(bottom: 5),
      //       child: Row(
      //         // mainAxisAlignment: MainAxisAlignment.start,
      //         crossAxisAlignment: CrossAxisAlignment.end,
      //         children: [
      //           IconButton(
      //               onPressed: (){
      //                 Navigator.pop(context);
      //               },
      //               icon: Icon(Icons.arrow_back_ios_outlined,size: 20,)),
      //           Flexible(
      //               child: Padding(
      //                 padding: const EdgeInsets.fromLTRB(0,10,15,0),
      //                 child: Text("Category"),
      //               )
      //           ),
      //
      //           SizedBox(width: 10,),
      //         ],),
      //     ),
      //   )    ,
        elevation: 0,
      ),
      body: SafeArea(
        child: StreamBuilder<List<Product>>(
          // initialData: [],
            stream: _categoryController.categoryStream,
            builder: (context, snapshot) {
              var list = snapshot.data;
              //  if(snapshot.hasData) {
              //    list = ;
              // }

              if(list==null) {
                return Center(child: CircularProgressIndicator(),);
              }else if(list.length>0){
                return GridView.builder(
                    itemCount: list.length,
                    //physics: NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 0, childAspectRatio: 0.58),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          DataManager.searchProduct = list[index];
                          Navigator.pushNamed(context, "/product",arguments: ProductArgument(id: index,type: "search"));
                        },
                        child: Card(
                          color: Color.fromRGBO(241, 241, 241, 1),
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  style: BorderStyle.none)),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(list[index].Images[0],
                                  height: 140,
                                  fit: BoxFit.fill,),
                                SizedBox(
                                  height: 35,
                                  child: Text(list[index].title,
                                    style: TextStyle(fontSize: 15,),textAlign: TextAlign.start,),
                                ),
                                SizedBox(height: 5,),
                                Text("Rs. ${list[index].price>list[index].discountPrice? list[index].discountPrice:list[index].price}", style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.deepOrange),),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    list[index].price>list[index].discountPrice?
                                    Text(list[index].price.toString(), style: TextStyle(decoration: TextDecoration.lineThrough),):SizedBox(),
                                    SizedBox(width: 3,),
                                    list[index].price>list[index].discountPrice? Text("-${list[index].discount}%", style: TextStyle(
                                        color: Color.fromRGBO(
                                            158, 158, 170, 1)),):SizedBox(),
                                  ],
                                ),
                                SizedBox(height: 6,),
                                Row(
                                    children: List.generate(6, (ind)  {
                                      if((ind+1)==6){
                                        return Text(list[index].ratingCount);
                                      }
                                      //example if rating is 4.5 then 5 is our require number
                                      int valueAfterDot =int.parse(list[index].rating.substring(2));
                                      if((ind+1)<=double.parse(list[index].rating).toInt()){
                                        return Icon(Icons.star, color: Colors.yellow, size: 20,);
                                      }else{
                                        if(valueAfterDot>0){
                                          return  Icon(Icons.star_half_outlined, color: Colors.yellow, size: 20,);
                                        }else{
                                          return Icon(Icons.star_border,
                                            color: Colors.yellow, size: 20,);
                                        }
                                      }
                                    })
                                  // Icon(Icons.star, color: Colors.yellow, size: 20,),
                                  // Icon(Icons.star, color: Colors.yellow,
                                  //   size: 20,),
                                  // Icon(Icons.star, color: Colors.yellow,
                                  //   size: 20,),
                                  // Icon(Icons.star_half_outlined, color: Colors.yellow, size: 20,),
                                  // Icon(Icons.star_border,
                                  //   color: Colors.yellow, size: 20,),

                                  //],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                );
              }else{

                return Center(child: CircularProgressIndicator(),);
              }
            }
        ),
      ),
    );
  }
}