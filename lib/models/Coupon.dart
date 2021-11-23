
class Coupon{

  String type="";
  double discount=0;
  bool isPercentage=false;
  bool isCouponImplemented=false;
  String name="";


  Coupon._Coupon();
  static final Coupon _instance = Coupon._Coupon();

  factory Coupon.instance(){
    return _instance;
  }

}