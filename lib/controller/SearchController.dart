import 'dart:async';

import 'package:saraa_kuch/models/HomeScreen/Product.dart';
import '../services/SearchService.dart';
class SearchController{

  StreamController<List<Product>> inputSearchController = new StreamController<List<Product>>();
  static StreamController<int> cartCountController;


  SearchController(){

  }

  void searchInput(String value) async {
    SearchService searchService = new SearchService();
    List<Product> productList = await searchService.search(keyword: value);
    inputSearchController.sink.add(productList);
  }


}