
class HomeService{

  List<String> productsName = ["Cap","tea","shirt","fruit","shoes"];

  Future<List<String>> getBanners() async{

    await Future.delayed(const Duration(seconds: 5),(){
      print("test5");

    });
    return  this.productsName;
   // return [];
  }

  Future<List<String>> getCategories() async {

    await Future.delayed(const Duration(seconds: 5),(){
      print("test5");

    });
    return  this.productsName;
  }

  Future<List<String>> getPopularProducts() async {

    await Future.delayed(const Duration(seconds: 5),(){
      print("test5");

    });
    return  this.productsName;
  }

  Future<List<String>> getAllProducts() async {

    await Future.delayed(const Duration(seconds: 5),(){
      print("test5");

    });
    return  this.productsName;
  }
}