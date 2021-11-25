

import 'dart:async';

import 'package:saraa_kuch/helper/DataManager.dart';
import 'package:saraa_kuch/helper/MyDatabase.dart';
import 'package:saraa_kuch/models/Coupon.dart';

import 'package:saraa_kuch/models/HomeScreen/Product.dart';

class CartController{

  StreamController<double> _totalPriceController = StreamController<double>();
  StreamSink totalPriceSink;
  Stream totalPriceStream;

  StreamController<Map<int,Product>> _updateCartController = StreamController<Map<int,Product>>();
  StreamSink updateCartSink;
  Stream updateCartStream;

  StreamController<int> cartCountController = new StreamController<int>();



  CartController(){
    totalPriceSink = _totalPriceController.sink;
    totalPriceStream = _totalPriceController.stream;

    updateCartSink = _updateCartController.sink;
    updateCartStream = _updateCartController.stream;
  }


  void updateTotalPrice(double price){
    Coupon coupon = Coupon.instance();
    DataManager.tempTotalPrice = price;
    if(price<5000){
      price +=199;
      print("update price");
    }
    if(DataManager.cart.length==0){
      price =0;
    }
    DataManager.totalPrice = price-coupon.discount;
    totalPriceSink.add(DataManager.totalPrice);

  }

  void changeQuantity({String action,int id}) {
    Product p = DataManager.cart[id];
    int stock = p.stock;
    int qty = p.tempQty;
    MyDatabase myDatabase = new MyDatabase();
      if (action == "plus") {
        if (qty < stock) {
          //print("plus");
          p.tempQty++;
        }
      } else {
        if (qty > 1) {
         // print("minus");
          p.tempQty--;
        }
      }

    myDatabase.updateCartItems(qty: p.tempQty,id:id);
    _updateCartController.sink.add(DataManager.cart);
  }

  void deleteCartItem({int id}){
    MyDatabase().deleteCartItems(id: id);
  }

}