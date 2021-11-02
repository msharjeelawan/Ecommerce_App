
import 'dart:async';
import '../services/HomeService.dart';

class HomeController{

   //Banner silder controller
   StreamController<List<String>> _bannerController = new StreamController<List<String>>();
   StreamSink _bannerSink;
   Stream bannerStream;

   //Specialforyou controller
   StreamController<List<String>> _specialController = new StreamController<List<String>>();
   StreamSink _specialSink;
   Stream specialStream;

   //popular controller
   StreamController<List<String>> _popularController = new StreamController<List<String>>();
   StreamSink _popularSink;
   Stream popularStream;

   //allproducts controller
   StreamController<List<String>> _allProductController = new StreamController<List<String>>();
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
      List<String> bannerList = await _homeService.getBanners();
      List<String> categoryList = await _homeService.getCategories();
      List<String> popularProductsList = await _homeService.getPopularProducts();
      List<String> allProductsList = await _homeService.getAllProducts();
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