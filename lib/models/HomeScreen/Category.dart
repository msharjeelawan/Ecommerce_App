

class Category{
  int _id;
  String _name;
  String _imageUrl;
  String _totalItems;
  //static List<Category> _list = [];

  Category({int id,String name,String image,String items}){
    _id = id;
    _name = name;
    _imageUrl = image;
    _totalItems = items;
  }

  static List<Category> jsonToModel(List<dynamic> jsonList){
    List<Category> list = [];
    if(jsonList.length>0){
      for(int a=0;a<jsonList.length;a++){
        Map<String,dynamic> map = jsonList[a];
        //image map
        Map<String,dynamic> image = map['image'];
        String tempImg;
       // print("hjbjehbjw"+image['src'].toString());

        if(image!=null) {
          var src = image['src'];
          if (src != null) {
            if (src is bool)
              tempImg =
              "https://saraakuch.pk/wp-content/uploads/2021/06/shampoo-6-min.png";
            else if (src is String) {
              if (src.isNotEmpty) {
                tempImg = image['src'];
              }
            }
          }
        }else{
          tempImg =
          "https://saraakuch.pk/wp-content/uploads/2021/06/shampoo-6-min.png";
        }

        Category category = Category(id:map['id'],name: map['name'],image: tempImg,items: map['count'].toString());
        list.add(category);
      }
      return list;
    }else
      return [];
  }

  String get totalItems => _totalItems;

  String get imageUrl => _imageUrl;

  String get name => _name;

  int get id => _id;

  //static List<Category> get categoryList => _list;
}