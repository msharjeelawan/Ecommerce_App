
import 'dart:async';

import 'package:saraa_kuch/controller/HomeController.dart';
import 'package:saraa_kuch/controller/SearchController.dart';
import 'package:saraa_kuch/helper/DataManager.dart';
import 'package:saraa_kuch/helper/MyDatabase.dart';
import 'package:saraa_kuch/models/HomeScreen/Product.dart';
import 'package:saraa_kuch/screens/CategoryScreen.dart';
import 'package:sqflite/sqflite.dart';

class ProductController {

  bool favorite=false;
  int _quantity=1;
  int _stock=0;
  MyDatabase myDatabase = MyDatabase();
  StreamController<bool> _favoriteController = StreamController<bool>();
  StreamSink _favoriteSink;
  Stream favoriteStream;

  StreamController<int> _quantityController = StreamController<int>();
  StreamSink _quantitySink;
  Stream quantityStream;


  ProductController(){

    //for sending event result of favorite button to interface
    _favoriteSink = _favoriteController.sink; //input
    favoriteStream = _favoriteController.stream; //output

    //for sending event result of quantity to interface
    _quantitySink = _quantityController.sink;
    quantityStream = _quantityController.stream;

  }

  void productListener(Product product){
    //set product stock and favorite
    _stock = product.stock;
    if(_stock>0)
      _quantityController.sink.add(1);
  }

  void changeFavoriteColorAndInsertInDb(Product product){

    int id = product.id;

    if(DataManager.favorite.length>0){
      Product p = DataManager.favorite[id];

      if(p==null){
        DataManager.favorite[id] = product;
        myDatabase.insertInFavorite(product);
      }else{
        favorite=true;
        DataManager.favorite.remove(id);
        myDatabase.deleteFavoriteItems(id: id);
        //show alert dialog  for checkout or buy more product because product is
        //already in table
      }
    }else{
      // print("products in cart ${DataManager.cart.length} ");
      DataManager.favorite[id] = product;
      myDatabase.insertInFavorite(product);
    }


    print("favorite $favorite");

    if(favorite)
      favorite=false;
    else
      favorite=true;

    _favoriteSink.add(favorite);

  }


  void changeQuantity(String action) {
    if (_stock > 0){
      if (action == "plus") {
        if (_quantity < _stock) {
          //print("plus");
          _quantity++;
        }
      } else {
        if (_quantity > 1) {
        //  print("minus");
          _quantity--;
        }
      }
    }else{
      _quantity = 0;
    }
    _quantityController.sink.add(_quantity);
  }

  void addToCart(Product product){
    int id = product.id;
    product.tempQty = _quantity;

    if(DataManager.cart.length>0){
      Product p = DataManager.cart[id];

     if(p==null){
       //print("product null");
       DataManager.cart[id] = product;
       addCartProductInDB(product);
     }else{
       //show alert dialog  for checkout or buy more product because product is
       //already in cart

      // print("product not null");
       //DataManager.cart[id] = product;
     }
    }else{
     // print("products in cart ${DataManager.cart.length} ");
      DataManager.cart[id] = product;
      addCartProductInDB(product);
    }

    //update home and search screen cart no using controller
    HomeController.cartCountController.sink.add(DataManager.cart.length);
    if( SearchController.cartCountController!=null)
    SearchController.cartCountController.sink.add(DataManager.cart.length);
    if(  CategoryScreen.categoryController!=null)
    CategoryScreen.categoryController.categoryCartSink.add(DataManager.cart.length);
   // print(DataManager.cart);
  }

  void addCartProductInDB(Product product){
    //first init db
    MyDatabase myDatabase = MyDatabase();

    Future.delayed(Duration(seconds: 5),(){
      myDatabase.insert(product);
    });


  }


}