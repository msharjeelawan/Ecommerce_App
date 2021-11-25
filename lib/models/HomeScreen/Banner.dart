
class Banner{

  String _url;
  //static List<Banner> _list = [];
  Banner({String url}){
    _url = url;
  }

  static List<Banner> jsonToModel(List<dynamic> jsonList) {
    List<Banner> _bannerList = [];
    //parse json array to model

    if (jsonList.length > 0)
      for (int a = 0; a < jsonList.length; a++) {
        Map<String, dynamic> jsonBanner = jsonList[a];
        String url = jsonBanner["url"];

        _bannerList.add(Banner(url: url));
      }
    return _bannerList;
  }

  String get url => _url;

  //static List<Banner> get bannerList => _list;

}