

import 'dart:async';

import 'package:saraa_kuch/helper/DataManager.dart';
import 'package:saraa_kuch/models/HomeScreen/Product.dart';
import 'package:saraa_kuch/services/CategoryService.dart';

class CategoryController{

  StreamController<List<Product>> _categoryController = StreamController<List<Product>>();
  StreamSink categorySink;
  Stream categoryStream;

  StreamController<int> _categoryCartController = StreamController<int>();
  StreamSink categoryCartSink;
  Stream categoryCartStream;

  CategoryController({int id}){
    categorySink = _categoryController.sink;
    categoryStream = _categoryController.stream;
    categoryCartSink = _categoryCartController.sink;
    categoryCartStream = _categoryCartController.stream;
    listener(id);
  }

  void listener(id) async{

    CategoryService categoryService = CategoryService();
    List<Product> productList = await categoryService.getCategoryProducts(id);
    DataManager.categoryProducts = productList;
    categorySink.add(productList);

  }

}