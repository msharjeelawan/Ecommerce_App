
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saraa_kuch/helper/DataManager.dart';
import 'package:saraa_kuch/models/HomeScreen/Product.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase{

  MyDatabase._MyDatabase();


  static final MyDatabase _instance = MyDatabase._MyDatabase();
  Database _db;

  factory MyDatabase(){

    return _instance;
  }


  Future<String> _getPath() async{
    String dbPath  = await getDatabasesPath();
    String path = join(dbPath,"saraakuchtest2.db");
    //print("path is $path");
    return path ;
  }

  Future<Database> _openDB() async{
    Database db;
    try{
      String path = await _getPath();
      print("path"+path);
      db = await openDatabase(path);
      print("this is db"+db.isOpen.toString());
     // db = await openDatabase(path);

    }catch(e){
      print("Error in opening database: $e");
    }
    return db;
  }

  void initDB() async{
    Database  db = await _openDB();
   // print("db version${db.getVersion()}");

    if(db==null){
       Directory documentDirectory = await getApplicationDocumentsDirectory();
       String path = join(documentDirectory.path,"saraakuchtest1.db");
       db = await openDatabase(path,version: 1,onCreate: (Database db,int version){
        db.execute("CREATE TABLE IF NOT EXISTS cart ("+
            "id INTEGER PRIMARY KEY AUTOINCREMENT"+
            ", title TEXT"+
            ", productId INTEGER"+
            ", price INTEGER"+
            ", discountPrice INTEGER"+
            ", rating TEXT"+
            ", stock INTEGER"+
            ", quantity INTEGER"+
            ", image TEXT"+
            ", description TEXT"+
            ")"
        );
        print("db created");
      });

    }else{
      db.execute("CREATE TABLE IF NOT EXISTS cart ("+
          "id INTEGER PRIMARY KEY AUTOINCREMENT"+
          ", title TEXT"+
          ", productId INTEGER"+
          ", price INTEGER"+
          ", discountPrice INTEGER"+
          ", rating TEXT"+
          ", stock INTEGER"+
          ", quantity INTEGER"+
          ", image TEXT"+
          ", description TEXT"+
          ")"
      );

      //query for favorite table
      db.execute("CREATE TABLE IF NOT EXISTS favorite ("+
          "id INTEGER PRIMARY KEY AUTOINCREMENT"+
          ", title TEXT"+
          ", productId INTEGER"+
          ", price INTEGER"+
          ", discountPrice INTEGER"+
          ", rating TEXT"+
          ", stock INTEGER"+
          ", quantity INTEGER"+
          ", image TEXT"+
          ", description TEXT"+
          ")"
      );
    }
   _db =  db ;
    //db.then((value) => _db = value);

    // if(_db==null)
    //   print("db db null");
    // else
    //   print("db db not null");
  }


  void insert(Product p) async{
    //insert query

    if(_db!=null){
      //print("db is not null");
      var result = await _db.rawInsert("INSERT INTO cart ('title','productId','price','discountPrice','rating','stock','quantity','image','description')"
          +" VALUES (?,?,?,?,?,?,?,?,?)",
          [p.title,p.id,p.price,p.discountPrice,p.rating,p.stock,p.tempQty,p.Images[0],p.discription]);

      //print("insert result $result");
    }else{
    //  print("db is null");
    }

  }

  void readCartProducts() async{
    if(_db!=null){
      try {
        List<Map<String, dynamic>> result = await _db.query("cart");
        result.forEach((jsonProduct) {
          int id = jsonProduct['productId'];
          Product p = new Product(
              id: jsonProduct["productId"],
              title:jsonProduct["title"],
              discription: jsonProduct["description"],
              rating: jsonProduct["rating"],
              price: jsonProduct["price"],
              discountPrice: jsonProduct["discountPrice"],
              stock: jsonProduct["stock"],
              qty: jsonProduct["quantity"],
              images: [jsonProduct["image"]]);
          DataManager.cart[id] =  p;
        });
      }catch(e){
        print("error in query: $e ");
      }



      print("value read");
     // print("select result$result");
    }else{
      print("value not read");
    }

  }

  void updateCartItems({int qty,int id}) async{

    if(_db!=null){
      _db.update("cart", <String,Object>{"quantity":qty},where: "productId=?",whereArgs: [id]);
    }

  }

  void deleteCartItems({int id}) async{
    if(_db!=null){
      _db.delete("cart",where: "productId=?",whereArgs: [id]);
    }
  }

  void clearCart() async{
    if(_db!=null){
      _db.delete("cart");
    }
  }

  void insertInFavorite(Product p) async{
    //insert query

    if(_db!=null){
      //print("db is not null");
      var result = await _db.rawInsert("INSERT INTO favorite ('title','productId','price','discountPrice','rating','stock','quantity','image','description')"
          +" VALUES (?,?,?,?,?,?,?,?,?)",
          [p.title,p.id,p.price,p.discountPrice,p.rating,p.stock,p.tempQty,p.Images[0],p.discription]);

      //print("insert result $result");
    }else{
      //  print("db is null");
    }

  }

  void deleteFavoriteItems({int id}) async{
    if(_db!=null){
      _db.delete("favorite",where: "productId=?",whereArgs: [id]);
    }
  }

  void readFavoriteProducts() async{
    if(_db!=null){
      try {
        List<Map<String, dynamic>> result = await _db.query("favorite");
        print("product available in db"+result.length.toString());
        result.forEach((jsonProduct) {
          int id = jsonProduct['productId'];
          Product p = new Product(
              id: jsonProduct["productId"],
              title:jsonProduct["title"],
              discription: jsonProduct["description"],
              rating: jsonProduct["rating"],
              price: jsonProduct["price"],
              discountPrice: jsonProduct["discountPrice"],
              stock: jsonProduct["stock"],
              qty: jsonProduct["quantity"],
              images: [jsonProduct["image"]]);
          DataManager.favorite[id] =  p;
        });
      }catch(e){
        print("error in query: $e ");
      }



      print("value read");
      // print("select result$result");
    }else{
      print("value not read");
    }

  }

}