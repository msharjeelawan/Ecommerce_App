
import 'dart:async';
import 'package:saraa_kuch/helper/DataManager.dart';
import 'package:saraa_kuch/models/HomeScreen/Banner.dart';
import 'package:saraa_kuch/models/HomeScreen/Category.dart';

import '../services/HomeService.dart';
import '../models/HomeScreen/Product.dart';

class HomeController{

    //controller refresh state
    int _pageNo=2;
    bool previousResponse= true;
   //Banner silder controller
   StreamController<List<Banner>> _bannerController = new StreamController<List<Banner>>();
   StreamSink _bannerSink;
   Stream bannerStream;

   //Specialforyou controller
   StreamController<List<Category>> _specialController = new StreamController<List<Category>>();
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

    //drawer controller
    StreamController<int> drawerController = new StreamController<int>();
    StreamSink drawerSink;
    Stream drawerStream;

    //cart counter controller
    static StreamController<int> cartCountController;

   HomeController(){
     print("controller ");
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

     //drawer controller
     drawerSink = drawerController.sink;
     drawerStream = drawerController.stream;

     //this method will get products from api as json
     //this method will call only one time untill user refresh using swipe refresh


     if(DataManager.bannerList==null) {
       getProductsFromApi();

     }else {
       getProductsFromArray();
     }

     // stream = controller.stream;
     // sink = controller.sink;
     // stream.listen((event) { p(event);});
     //
     // stream1 = controller1.stream;
     // sink1 = controller1.sink;

   }

    void getProductsFromApi() async{
     //print("data from api");
      HomeService _homeService = new HomeService();
      List<Banner> bannerList = await _homeService.getBanners();
      List<Category> categoryList = await _homeService.getCategories();
      List<Product> popularProductsList = await _homeService.getPopularProducts();
      List<Product> allProductsList = await _homeService.getAllProducts(pageIndex: 0);

      //save data in data manager class for later use in app
      DataManager.bannerList = bannerList;
      DataManager.categoryList = categoryList;
      DataManager.specialProducts = popularProductsList;
      DataManager.allProducts = allProductsList;

      //assign data to controller sink for showing
      _bannerSink.add(bannerList);
      _specialSink.add(categoryList);
      _popularSink.add(popularProductsList);
      _allProductSink.add(allProductsList);

   }

   void getProductsFromArray(){
     //print("data from array");
     _bannerSink.add(DataManager.bannerList);
     _specialSink.add(DataManager.categoryList);
     _popularSink.add(DataManager.specialProducts);
     _allProductSink.add(DataManager.allProducts);

   }


   void scrollListener() async{
    // print("page index $_pageNo");
     if(previousResponse){
       HomeService _homeService = new HomeService();
       List<Product> productsList =  await _homeService.getAllProducts(pageIndex: _pageNo);
       if(productsList.length==0){
         previousResponse=false;
       }else if(productsList.length>0){
         _pageNo++;
       }

       for(Product p in productsList){
         DataManager.allProducts.add(p);
       }
       _allProductSink.add(DataManager.allProducts);
     }

     // print("page index $_pageNo");
     // print("product list size ${DataManager.allProducts.length}");

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