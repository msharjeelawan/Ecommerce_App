import 'package:flutter/material.dart';

import 'config.dart';

const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const Color NBPrimaryColor = Color(0xFFFD5530);
const Color NBFacebookColor = Color(0xFF4265b0);
const db2_textColorPrimary = Color(0xFF212121);
const db1_colorPrimary = Color(0xFFeb4b51);
const db1_white = Color(0xFFffffff);
const db1_textColorPrimary = Color(0xFF212121);
const db1_textColorSecondary = Color(0xFF757575);
const db1_grey = Color(0xFFB9B9B9);
const db1_yellow = Color(0xFFFBC02D);
const db1_purple = Color(0xFFB88DDD);
const db1_green = Color(0xFFC2DB77);
const db1_orange = Color(0xFFF5D270);
const db1_dark_blue = Color(0xFF5FACC9);
const kAnimationDuration = Duration(milliseconds: 200);
const t14_btn_checkBoxColor = Color(0xFF4CD692);
const t14_colorBlue = Color(0xFF002551);
const whitedueColor=Color(0xFFFFFF0);
const sh_more_infoHeading_background = Color(0xFFDDDDDD);
const sh_more_infoValue_background = Color(0xFFF3F3F3);
const sh_item_background = Color(0xFFEFF3F6);
const sh_light_grey = Color(0xFFFAFAFA);
const sh_checkbox_color = Color(0xFFDFDFDF);
const sh_itemText_background = Color(0xFFF8F8F8);
const sh_textColorPrimary = Color(0xFF212121);
const applicationMaxWidth = 500.0;
const BHAppTextColorPrimary = Color(0xFF212121);
const BHAppTextColorSecondary = Color(0xFF5A5C5E);
const BHAppDividerColor = Color(0xFFDADADA);
const BHGreyColor = Color(0xFF808080);
const Color light_grey = Color.fromRGBO(239,239,239, 1);
Color shadowColorGlobal = Colors.grey.withOpacity(0.2);

/*If you are not a developer, do not change the bottom colors*/
const Color white = Color.fromRGBO(255,255,255, 1);
const Color dark_grey = Color.fromRGBO(112,112,112, 1);
const Color medium_grey = Color.fromRGBO(132,132,132, 1);
const Color grey_153 = Color.fromRGBO(153,153,153, 1);
const Color font_grey = Color.fromRGBO(73,73,73, 1);
const Color textfield_grey = Color.fromRGBO(209,209,209, 1);
const Color golden = Color.fromRGBO(248, 181, 91, 1);
const Color accent_color = Color.fromRGBO(230,46,4, 1);
const Color soft_accent_color = Color.fromRGBO(247,189,168, 1);
const Color splash_screen_color = Color.fromRGBO(230,46,4, 1); // if not sure , use the same color as accent color
/*configurable colors ends*/

///
const MaterialColor kPrimaryColor = const MaterialColor(
  0xFFDADADA,
  const <int, Color>{
    50: const Color(0xFFDADADA),
    100: const Color(0xFFDADADA),
    200: const Color(0xFFDADADA),
    300: const Color(0xFFDADADA),
    400: const Color(0xFFDADADA),
    500: const Color(0xFFDADADA),
    600: const Color(0xFFDADADA),
    700: const Color(0xFFDADADA),
    800: const Color(0xFFDADADA),
    900: const Color(0xFFDADADA),
  },
);


 const Color gold = const Color.fromRGBO(224, 153, 0, 1);

const defaultDuration = Duration(milliseconds: 250);
// haider supper mart app
//address
//https://www.google.com/maps/place/Haider+super+Mart/@32.7916946,73.5855678,10z/data=!4m19!1m13!4m12!1m4!2m2!1d73.6653824!2d32.988334!4e1!1m6!1m2!1s0x391f1ba884830903:0xdce0f4e5be9dbc14!2shaidert+mart!2m2!1d74.0668!2d32.5885165!3m4!1s0x391f1ba884830903:0xdce0f4e5be9dbc14!8m2!3d32.5885165!4d74.0668
// Form Error
final subheadingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(17),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);





final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const   String splitvalue="£!/£{=!=£}/!";
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kPassNullError2 = "Please Enter your confirm password";
const String kShortPassError = "Password is too short";
const String kShortPassError2 = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String notvalidateEmailorPassword="Incorrect email or password";
const String messagealreadyexist="An account is already registered.";
const String firstnameEnter="Please enter first name";
const String lastnameEnter="Please enter last name";
const String phoneEnter="Please enter phone number";
const String addressEnter="Please enter shipping address";
const String resentOtpMessage="we resent otp code please wait for a mint to resend OTP code";

const String conectivityConnection="please check internet connect, try again";
const String consumerKey="ck_21ea4617b9a14b863492c12025502accbb383d1b";
const String secreteKey="cs_7c5b61db6b8270d01fc223c886fb11af7fd8ee0a";
const String weburl="https://saraakuch.pk";
const String grantpermssion="Grant Permission";
const String permssionrequest="Permission Request";
const String permssiondescription="SaraaKuch App needs permission to acces \n "
    "device location to provide required services. \n Please allow the permission";
const String productDetailed="Product Detail";
const String loginResponse='loginresponse';
const String password='pass';
const String customerResponse='customerresponse';
const String currentlocation="currentlocation";
const String customerEmail="customeremail";
const String addToCart="Add To Cart";
const String updateCart="Update Cart";
const String items="Items";
const String couponDialog="Please check coupon code";
const String cartItems="Cart Items";
const BHTxtForgotPwd = 'Forgot Password';
const ChangePassword = 'Change Password';
const nouserFound="No user found with this email address";
const BHForgotPasswordSubTitle = "Please enter your Email so we can help you recover your password";
const changepasswordsubtitle = "we send you a verification code on email to keep your account secure. please enter that code and new password";
const otp="please enter valid OTP";
const validateattempt="The reset code provided is not valid. You have 2 attempts remaining.";
const facebookLogin="Facebook login has been failed. please try again or use other login method";
const facebookLoginemail="Facebook's email is not public. please set public email or use other login method";
const plaformlogin="for Login, Please Select android or Facebook platform";

const BHBtnSend = 'Send';



//Fonts string
const fontMedium = 'Medium';




//images
const NBNewsImage1 = 'assets/images/splash1.png';
const NBNewsImage2 = 'assets/images/splash2.png';
const NBNewsImage3 = 'assets/images/splash3.png';
const b1 = "assets/images/b1.jpg";
const b2 = "assets/images/b2.jpg";
const b3 = "assets/images/b3.jpg";
const b4 = "assets/images/b4.jpg";
const b5 = "assets/images/b5.jpg";
const b6 = "assets/images/b6.jpg";
const db1_ic_burger = "images/dashboard/db1_ic_burger.svg";
const db1_ic_cake = "images/dashboard/db1_ic_cake.svg";
const db1_ic_chicken = "images/dashboard/db1_ic_chicken.svg";
const db1_ic_pizza = "images/dashboard/db1_ic_pizza.svg";
const db1_ic_coffee = "images/dashboard/db1_ic_coffee.svg";

const db_restau_1 = "assets/images/db_restau_1.jpeg";
const db_restau_3 = "assets/images/db_restau_3.jpeg";
const db_restau_2 = "assets/images/db_restau_2.jpeg";
const db_restau_4 = "assets/images/db_restau_4.jpeg";


const db2_decor1 = "assets/images/db2_decor1.jpeg";
const db2_decor = "assets/images/db2_decor.jpg";
const db2_item1 = "assets/images/db2_item1.jpg";
const db2_item2 = "assets/images/db2_item2.jpg";
const db2_item5 = "assets/images/db2_item5.jpg";
const db2_item4 = "assets/images/db2_item4.jpg";
const db2_mens = "assets/images/db2_mens.jpg";
const db2_item3 = "assets/images/db2_item3.jpg";
const db2_kids = "assets/images/db2_kids.jpg";
const db2_women = "assets/images/db2_women.jpg";
bool onSearchFlag=false;


const spacing_standard = 8.0;
const spacing_control = 4.0;
const spacing_control_half = 2.0;
const spacing_standard_new = 16.0;
const textSizeLargeMedium = 18.0;
double defaultBlurRadius = 4.0;
double defaultSpreadRadius = 1.0;
double defaultRadius = 8.0;


//Decoration Box
/// rounded box decoration with shadow
Decoration boxDecorationRoundedWithShadow(
    int radiusAll, {
      Color backgroundColor = white,
      Color shadowColor,
      double blurRadius,
      double spreadRadius,
      Offset offset = const Offset(0.0, 0.0),
      LinearGradient gradient,
    }) {
  return BoxDecoration(
    boxShadow: defaultBoxShadow(
      shadowColor: shadowColor ?? shadowColorGlobal,
      blurRadius: blurRadius ?? defaultBlurRadius,
      spreadRadius: spreadRadius ?? defaultSpreadRadius,
      offset: offset,
    ),
    color: backgroundColor,
    gradient: gradient,
    borderRadius: radius(radiusAll.toDouble()),
  );
}
/// default box shadow
List<BoxShadow> defaultBoxShadow({
  Color shadowColor,
  double blurRadius,
  double spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
}) {
  return [
    BoxShadow(
      color: shadowColor ?? shadowColorGlobal,
      blurRadius: blurRadius ?? defaultBlurRadius,
      spreadRadius: spreadRadius ?? defaultSpreadRadius,
      offset: offset,
    )
  ];
}
/// returns Radius
BorderRadius radius([double radius]) {
  return BorderRadius.all(radiusCircular(radius ?? defaultRadius));
}

/// returns Radius
Radius radiusCircular([double radius]) {
  return Radius.circular(radius ?? defaultRadius);
}