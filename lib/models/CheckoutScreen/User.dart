

class User{

  int id;
  String fname="";
  String lname="";
  String address="";
  String phoneNo="";
  String email="";
  bool isLogin=false;

  User._User();

  static final User instance = User._User();

  factory User(){
    return instance;
  }

}