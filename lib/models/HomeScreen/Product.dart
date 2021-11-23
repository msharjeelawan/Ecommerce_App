
import 'package:flutter/material.dart';
//{
// 			"name":"abc",
// 			"short_description": "<ul>\n<li>Suitable for personal and salon use</li>\n",
// 			"sale_price": "1124",
// 			"regular_price": "1249",
// 			"stock_quantity": -2,
// 			"average_rating": "5.00",
// 			"rating_count": 2,
// 			"images": [
// 				{
// 					"src": "https://saraakuch.pk/wp-content/uploads/2021/09/shampoo_argan.png",
// 					"alt": "Totex shampoo_argan"
// 				}
// 			],
// 			}
class Product {

  String _title;
  String _discription;
  String _rating;
  String _ratingCount;
  String _discount;

  int _id;
  int _stock;
  int _price;
  int _discountPrice;
  int _tempQty=0;

  List<String> _images = [];

  //List<Product> _productList = [];

  Product({int id,String title, int price, int discountPrice, List<String> images, int stock, String rating, String ratingCount, String discription,int qty,String discount}){
    _id = id;
    _title = title;
    _price = price;
    _discountPrice = discountPrice;
    _images = images;
    _stock = stock;
    _rating = rating;
    _ratingCount = ratingCount;
    _discription = discription;
    _discount = discount;
    if(qty!=null)
      _tempQty = qty;
  }

  static List<Product> jsonToModel(List<dynamic> jsonList){
    List<Product> _productList = [];
    //parse json array to model

    if(jsonList.length>0)
      for(int a=0;a<jsonList.length;a++){
        Map<String,dynamic> jsonProduct = jsonList[a];

        //convert string values to int
        int price = int.parse(jsonProduct["regular_price"]);
        int discountPrice = int.parse(jsonProduct["sale_price"]);

        int stock = jsonProduct["stock_quantity"];
        if(stock<0){
          stock = 0;
        }

        //images list
        List<dynamic> imageList = jsonProduct["images"];
        List<String> images = [];

        //iterate over images json list
        for(int a=0;a<imageList.length;a++){
          Map<String,dynamic> image = imageList[a];
          String imgUrl = image["src"];
          images.add(imgUrl);
        }

        String discount="";
        //count discount if available
        if(price>discountPrice){
          double off = ((price-discountPrice)*100)/price;
          discount = off.toInt().toString();
        }

       Product p = new Product(
           id: jsonProduct["id"],
           title:jsonProduct["name"],
           discription: jsonProduct["short_description"],
           rating: jsonProduct["average_rating"],
           ratingCount: jsonProduct["rating_count"].toString(),
           price: price,
           discountPrice: discountPrice,
           stock: stock,
           discount: discount,
           images: images);
        _productList.add(p);
      }

    return _productList;
  }

  int get id => _id;

  String get title => _title;

  String get discription => _discription;

  String get ratingCount => _ratingCount;

  String get rating => _rating;

  int get stock => _stock;

  int get discountPrice => _discountPrice;

  int get price => _price;

  int get tempQty => _tempQty;

  set tempQty(int value) {
    _tempQty = value;
  }

  String get discount => _discount;

  List<String> get Images => _images;

  //static List<Product> get productList => _productList;
}