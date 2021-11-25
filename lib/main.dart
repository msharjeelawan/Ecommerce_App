import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/screens/FavoriteScreen.dart';
import 'package:saraa_kuch/screens/ForgotPasswordScreen.dart';
import 'package:saraa_kuch/screens/HomeScreen.dart';
import 'package:saraa_kuch/screens/LoginScreen.dart';
import 'package:saraa_kuch/screens/OrderHistoryDetail.dart';
import 'package:saraa_kuch/screens/OrderHistoryList.dart';
import 'package:saraa_kuch/screens/OtpScreen.dart';
import 'package:saraa_kuch/screens/ProductScreen.dart';
import 'package:saraa_kuch/screens/ProfileScreen.dart';
import 'package:saraa_kuch/screens/RatingScreen.dart';
import 'package:saraa_kuch/screens/RegisterScreen.dart';
import 'package:saraa_kuch/screens/SearchScreen.dart';
import 'package:saraa_kuch/screens/UserProfileScreen.dart';
import 'screens/CartScreen.dart';
import 'screens/CheckOutScreen.dart';
import 'constants.dart';
import 'screens/CompleteProfileScreen.dart';
import 'screens/ConfirmPassword.dart';
import 'screens/SliderScreen.dart';
import 'screens/SplashScreen.dart';
import 'screens/help_screen.dart';
import 'screens/invite_friend_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Map<String,WidgetBuilder> routes = {
    '/splash': (context) => SplashScreen(),
    '/home': (context) => HomeScreen(),
    '/cart':(context) => CartScreen(),
    "/checkout":(context) => CheckOutScreen(),
    "/completeProfile":(context) => CompleteProfileScreen(),
    "/confirmPassword":(context) => ConfirmPassword(),
    "/favorite":(context) => FavoriteScreen(),
    "/forgot":(context) => ForgotPasswordScreen(),
    "/login":(context) => LoginScreen(),
    "/otp":(context) => OtpScreen(),
    "/product":(context) => ProductScreen(),
    "/option":(context) => ProfileScreen(),
    "/rating":(context) => RatingScreen(),
    "/register":(context) => RegisterScreen(),
    "/search":(context) => SearchScreen(),
    "/profile":(context) => UserProfileScreen(),
    "/history":(context) => OrderHistory(),
    "/invite":(context) => InviteFriend(),
    "/contact":(context) => HelpScreen(),
    "/slider":(context) => SliderScreen(),
  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saraa Kuch app',
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
        appBarTheme: AppBarTheme(

          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
     // home:SplashScreen(),
      initialRoute: '/splash',
      routes: routes,
      debugShowCheckedModeBanner:false
    );
  }

  Widget  initView(){

  }


}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
