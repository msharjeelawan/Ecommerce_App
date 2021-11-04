
import 'dart:async';
import 'package:saraa_kuch/models/Banner.dart';

import '../services/HomeService.dart';
import '../models/Product.dart';

class HomeController{

   //Banner silder controller
   StreamController<List<Banner>> _bannerController = new StreamController<List<Banner>>();
   StreamSink _bannerSink;
   Stream bannerStream;

   //Specialforyou controller
   StreamController<List<Banner>> _specialController = new StreamController<List<Banner>>();
   StreamSink _specialSink;
   Stream specialStream;

   //popular controller
   StreamController<List<Product>> _popularController = new StreamController<List<Product>>();
   StreamSink _popularSink;
   Stream popularStream;

   //allproducts controller
   StreamController<List<Product>> _allProductController = new StreamController<List<Product>>();
   StreamSink _allProductSink;
   Stream allProductStream;

   HomeController(){
     //Banner silder stream & sink
     _bannerSink = _bannerController.sink;
     bannerStream = _bannerController.stream;

     //Specialforyou controller
     _specialSink = _specialController.sink;
     specialStream = _specialController.stream;

     //popular controller
     _popularSink = _popularController.sink;
     popularStream = _popularController.stream;

     //allproducts controller
     _allProductSink = _allProductController.sink;
     allProductStream = _allProductController.stream;

     //this method will get products from api as json
     getProductsFromApi();


     // stream = controller.stream;
     // sink = controller.sink;
     // stream.listen((event) { p(event);});
     //
     // stream1 = controller1.stream;
     // sink1 = controller1.sink;

   }

    void getProductsFromApi() async{
      HomeService _homeService = new HomeService();
      List<Banner> bannerList = await _homeService.getBanners();
      List<Banner> categoryList = await _homeService.getCategories();
      List<Product> popularProductsList = await _homeService.getPopularProducts();
      List<Product> allProductsList = await _homeService.getAllProducts();
      _bannerSink.add(bannerList);
      _specialSink.add(categoryList);
      _popularSink.add(popularProductsList);
      _allProductSink.add(allProductsList);

   }

   // void getProductsFromApi() async{
   //   List<String> names = await getProducts1() as List<String>;
   //    sink1.add(names);
   //  print("test1");
   // }
   //
   // Future<List<String>> getProducts1() async{
   //   print("test2");
   //   HomeService _homeService = new HomeService();
   //   return await _homeService.getProducts();
   // }


}