import 'dart:convert';

import 'package:http/http.dart' as http ;
import 'package:saraa_kuch/models/HomeScreen/Product.dart';

class CategoryService{


  String _domain = "https://saraakuch.pk/wp-json/wc/v3/";
  String _ck = "ck_21ea4617b9a14b863492c12025502accbb383d1b";
  String _cS = "cs_7c5b61db6b8270d01fc223c886fb11af7fd8ee0a";



  Future<List<Product>> getCategoryProducts(int id) async{

    String url = "${_domain}products?category=$id&consumer_key=$_ck&consumer_secret=$_cS";

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){

      return Product.jsonToModel(jsonDecode(response.body));
    }

    return  [];
  }

}