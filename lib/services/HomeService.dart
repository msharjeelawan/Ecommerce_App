import 'dart:convert';

import 'package:saraa_kuch/models/Banner.dart';

import '../models/Product.dart';
import 'package:http/http.dart' as http ;

class HomeService{

  String _domain = "https://saraakuch.pk/wp-json/wc/v3/";
  String _ck = "ck_21ea4617b9a14b863492c12025502accbb383d1b";
  String _cS = "cs_7c5b61db6b8270d01fc223c886fb11af7fd8ee0a";

  List<String> productsName = ["Cap","tea","shirt","fruit","shoes"];

  Future<List<Banner>> getBanners() async{

    String url = "https://saraakuch.pk/wp-json/wp/v2/slider-images?slider_id=247641";

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){

      return  Banner.jsonToModel(jsonDecode(response.body));
    }

    return  [];
  }

  Future<List<Banner>> getCategories() async {

    String url = "${_domain}products/categories?consumer_key=$_ck&consumer_secret=$_cS";

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){

     return  Banner.jsonToModel(jsonDecode(response.body));
    }

    return  [];
  }

  Future<List<Product>> getPopularProducts() async {
    String url = "${_domain}products?featured=true&consumer_key=$_ck&consumer_secret=$_cS";
    //call http and get response in json
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      //convert json response to list or map
      return Product.jsonToModel(jsonDecode(response.body));
    }else {
      return [];
    }
  }

  Future<List<Product>> getAllProducts() async {

    String url = "${_domain}products?page=1&consumer_key=$_ck&consumer_secret=$_cS";
    //call http and get response in json
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      //convert json response to list or map
     return Product.jsonToModel(jsonDecode(response.body));
    }else {
      return [];
    }
    // await Future.delayed(const Duration(seconds: 5),(){
    //   print("test5");
    //
    // });
    //return  this.productsName;
  }
}