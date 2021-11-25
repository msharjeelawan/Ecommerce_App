import 'package:saraa_kuch/models/HomeScreen/Banner.dart';
import 'package:saraa_kuch/models/HomeScreen/Category.dart';
import 'package:saraa_kuch/models/HomeScreen/Product.dart';

class DataManager{

  DataManager._DataManager();

  static final DataManager _dataManager = new DataManager._DataManager();

  static List<Banner> bannerList;
  static List<Category> categoryList = [];
  static List<Product> specialProducts = [];
  static List<Product> allProducts = [];
  static List<Product> categoryProducts = [];
  static Product searchProduct;
  static Map<int,Product> cart = <int,Product>{};
  static Map<int,Product> favorite = <int,Product>{};
  static double totalPrice=0;
  static double tempTotalPrice=0;
  static double discount=0;//this is coupon discount same value that is stores in coupon model class
  //static double shipping=0;
  factory DataManager(){
    return _dataManager;
  }









  //static final DataManager _dataManager2 = DataManager()

  // factory DataManager.instance(){
  //   return _dataManager;
  // }

 static DataManager get instance => _dataManager;
}