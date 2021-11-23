import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/controller/ProductController.dart';
import 'package:saraa_kuch/helper/DataManager.dart';
import 'package:saraa_kuch/models/HomeScreen/Product.dart';
import 'package:saraa_kuch/models/ProductScreen/ProductArgument.dart';
import 'package:saraa_kuch/screens/CartScreen.dart';

import 'HomeScreen.dart';

class ProductScreen extends StatefulWidget{

  @override
  _ProductScreenState createState(){
    return new _ProductScreenState();
  }
}

class _ProductScreenState extends State<ProductScreen>{

  ProductController _productController;
  @override
  void initState(){
    super.initState();
    _productController = new ProductController();
  }

  @override
  Widget build(BuildContext context){
    //get product id from arguments object
    ProductArgument pa = ModalRoute.of(context).settings.arguments as ProductArgument;
    int index = pa.id;
    Product product;
    if(pa.type == "all"){
      product = DataManager.allProducts[index];
    }else if(pa.type == "search"){
      product = DataManager.searchProduct;
    }else if(pa.type == "favorite"){
      product = DataManager.favorite[index];
    }else{
      product = DataManager.specialProducts[index];
    }

    // if(DataManager.favorite[index]!=null)
    //   _productController.favorite=true;

    _productController.productListener(product);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var h1 = height*0.29;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 49,
        backgroundColor: Color.fromRGBO(241, 241, 241, 1.0),
        leading: Padding(
          padding: const EdgeInsets.only(left:15,top:10,right:0,bottom:0),
          child: TextButton(
            onPressed: (){
                Navigator.pop(context);
                },
            child: Icon(Icons.arrow_back_ios,
                size: 17,
                color: Color.fromRGBO(25, 25, 25, 1),
            ),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(20, 20)),
              alignment: Alignment.centerRight,
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                  )
              )
            ),
          ),
        ),
        actions: [
          InkWell(
            child: Container(
              margin: EdgeInsets.only(top: 15),
              width: 60,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(product.rating,style: TextStyle(color: Color.fromRGBO(103, 103, 103, 1)),),

                  Icon(Icons.star_rate,color: Color.fromRGBO(255, 213, 37, 1),size: 12,)
                ],
              ),
            ),
            onTap: (){
            },
          ),
          SizedBox(width: 15,)
        ],
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color.fromRGBO(241, 241, 241, 1.0)
        ),
      ),
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
                top: 0,
                width: width,
                height: height,
                child: Container(
                  color: Color.fromRGBO(241, 241, 241, 1.0),
                 // height: 200,
                  child: Column(
                   // mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Image.network(product.Images.first,width: 200,height: h1/1,fit: BoxFit.fill,),
                      // Container(
                      //   width: width*0.8,
                      //   height: 50,
                      //   child: ListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: 4,
                      //       itemBuilder: (context,index){
                      //         return Container(
                      //           width: 50,
                      //           height: 50,
                      //           margin: EdgeInsets.symmetric(horizontal: 5),
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(15),
                      //               color: Colors.white
                      //           ),
                      //           child: GestureDetector(
                      //             child: Image.asset("assets/images/Saraakuch_logo.png"),
                      //             onTap: (){},
                      //           ),
                      //         );
                      //       }
                      //   ),
                      // ),
                    ],
                  ),
                )
            ),
            Positioned(
              width: width,
               top: h1,
              height: height,
                child: Container(
                  padding: EdgeInsets.only(left: 15,top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(product.title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          product.price>product.discountPrice?  Align(
                            alignment: Alignment.centerLeft,
                            child: Text(product.price.toString()+"Rs",style: TextStyle(decoration: TextDecoration.lineThrough),),
                          ):Align(
                            alignment: Alignment.centerLeft,
                            child: Text(product.price.toString()+"Rs",style: TextStyle(color: MyColors.gold)),
                          ),
                          SizedBox(width: 2,),
                          product.price>product.discountPrice?  Text(product.discountPrice.toString()+"Rs",style: TextStyle(color: MyColors.gold),):Text(""),
                          Expanded(child: SizedBox()),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: (){
                                _productController.changeFavoriteColorAndInsertInDb(product);
                              },
                              child: Container(
                                width: 60,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(241, 241, 241, 1.0),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
                                ),
                                child: StreamBuilder<bool>(
                                  initialData: DataManager.favorite[product.id]!=null? true:false,
                                  stream: _productController.favoriteStream,
                                  builder: (context, snapshot) {
                                   // Color c = Color.fromRGBO(219, 222, 228, 2);
                                      if(snapshot.data){
                                        return Icon(Icons.favorite,color: Color.fromRGBO(
                                            255, 72, 72, 1.0),);
                                      }else{
                                        return Icon(Icons.favorite,color: Color.fromRGBO(219, 222, 228, 1),);
                                      }
                                  }
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 3,),
                      Padding(
                        padding: const EdgeInsets.only(right: 60.0),
                        child: Text(product.discription,maxLines: 6,overflow: TextOverflow.ellipsis,textAlign: TextAlign.justify,),
                      ),
                      //SizedBox(height: 5,),
                      // TextButton(
                      //   onPressed: (){
                      //
                      //   },
                      //   style: ButtonStyle(
                      //     padding: MaterialStateProperty.all(EdgeInsets.zero)
                      //   ),
                      //     child: Text("See More Detail >")
                      // )
                    ],
                  ),
                )
            ),
            Positioned(
              top: h1*2.19,
                height: height,
                width: width,
                child: Container(
                  padding: EdgeInsets.only(top: height*0.015),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                      color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //TextButton(onPressed: onPressed, child: child)
                          TextButton(
                            onPressed: product.stock>0?(){_productController.changeQuantity("minus");}:null,
                            child: Icon(Icons.remove,color: Colors.black54),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromRGBO(241, 241, 241, 1.0)

                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                              )
                            ),
                          ),
                          SizedBox(width: 7,),
                          StreamBuilder<int>(
                            stream: _productController.quantityStream,
                            builder: (context, snapshot) {
                              int qty=0;
                              if(snapshot.hasData){
                                qty = snapshot.data;
                              }
                              return Text(qty.toString());
                            }
                          ),
                          SizedBox(width: 7,),
                          TextButton(
                            onPressed: product.stock>0?(){_productController.changeQuantity("plus");}:null,
                            child: Icon(Icons.add,color: Colors.black54,),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromRGBO(241, 241, 241, 1.0)

                                ),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                                )
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            ),
            Positioned(
                top: height*0.73,
                height: height,
                width: width,
                child: Container(
                  padding: EdgeInsets.only(top: height*0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: product.stock>0? (){
                          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(duration:Duration(seconds: 1),content: Text("Product added")));
                          _productController.addToCart(product); }:null,
                        child: Text(product.stock>0? "Add to Cart":" Out of stock",style: TextStyle(fontSize: 17),),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(product.stock>0?MyColors.gold:Colors.black26),
                          textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
                          minimumSize: MaterialStateProperty.all(Size(width*0.7, height*0.08)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(18)))
                        ),
                      )

                    ]
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

}

