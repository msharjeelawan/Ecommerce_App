import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/SharedPref/SharedPrefren.dart';

import 'package:saraa_kuch/controller/HomeController.dart';
import 'package:saraa_kuch/helper/DataManager.dart';
import 'package:saraa_kuch/models/CheckoutScreen/User.dart';
import 'package:saraa_kuch/screens/FavoriteScreen.dart';
import 'package:saraa_kuch/screens/UserProfileScreen.dart';

import 'package:saraa_kuch/widgets/Home/AllProducts.dart';
import 'package:saraa_kuch/widgets/Home/Category.dart' as category;
import 'package:saraa_kuch/widgets/Home/PopularProducts.dart';
import 'package:saraa_kuch/widgets/Home/Slider.dart' as slider;

import 'package:saraa_kuch/models/HomeScreen/Category.dart' as categoryModel;
import 'package:saraa_kuch/models/HomeScreen/Product.dart';
import 'package:saraa_kuch/models/HomeScreen/Banner.dart' as banner;

import '../constants.dart';

class HomeScreen extends StatefulWidget{

 static HomeController controller;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  HomeController _controller;
  int banerIndex=0;
  int _pageIndex=0;
  List<Widget> _pages = [];
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  void initState(){
    super.initState();
    if(_controller==null) {
      _controller = new HomeController();
    }else{
      _controller = HomeScreen.controller;
    }

    _pages.add(HomeBody());
    _pages.add(FavoriteScreen());
  }

  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return Scaffold(
        key: _key,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0.0,
          backgroundColor: Colors.white,
          backwardsCompatibility: false,
          systemOverlayStyle:SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark
          ),
          // flexibleSpace:

        ),
        body: _pages[_pageIndex],
        endDrawer: Container(
          width: size.width*0.9,
          //height: size.height,

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),)
          ),
          child: Column(
            children: [
              Container(
                height: 130,
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color:MyColors.gold),
                  accountName: Text(User().fname.isNotEmpty? User().fname+User().lname:""),
                  accountEmail:User().email.isNotEmpty? Text(User().email):GestureDetector(onTap:()
                  async{ await Navigator.pushNamed(context, "/login");
                  setState(() {

                  });},child: Text("Login",style:TextStyle(fontSize:20,fontWeight: FontWeight.bold),)) ,
                  // currentAccountPicture: Image.asset("assets/images/logo.png"),

                ),
              ),
             // ListTile(leading:Icon(Icons.home_outlined),title: Text("Home"),onTap: (){},selected: true,selectedTileColor:MyColors.gold,),
              User().isLogin?ListTile(leading:Icon(Icons.person_outline),title: Text("Profile"),onTap: (){Navigator.pop(context);Navigator.pushNamed(context, "/profile");},):SizedBox(),
              User().isLogin?ListTile(leading:Icon(Icons.shopping_cart),title: Text("Order History"),onTap: (){Navigator.pop(context);Navigator.pushNamed(context, "/history");},):SizedBox(),
              //ListTile(leading:Icon(Icons.favorite_border),title: Text("Favorite"),onTap: (){Navigator.pop(context);Navigator.pushNamed(context, "/favorite",arguments: FavoriteArgument(isFullScreen:true));},),
              //User().isLogin?ListTile(leading:Icon(Icons.settings),title: Text("Settings"),onTap: (){Navigator.pop(context);Navigator.pushNamed(context, "/option");},):SizedBox(),
              ListTile(leading:Icon(Icons.insert_invitation),title: Text("Invite Friends"),onTap: (){Navigator.pop(context);Navigator.pushNamed(context, "/invite");},),
              ListTile(leading:Icon(Icons.help_outline),title: Text("Contact US"),onTap: (){Navigator.pop(context);Navigator.pushNamed(context, "/contact");},),
              Expanded(child: SizedBox(height: 1,width: 1,),),
              Divider(),
              ListTile(leading:Icon(User().isLogin? Icons.logout: Icons.login),title: Text(User().isLogin? "Logout":"Login"),onTap: () async{
                if(User().isLogin){
                  showAlertDialog();

                }else{
                  Navigator.pop(context);
                  final result =await Navigator.pushNamed(context, "/login");
                  setState(() {
                    print("result"+result.toString());

                  });
                  setState(() {
                    print("result"+result.toString());

                  });
                }

              },),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          // color: Colors.black26,
        //  height: 60,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 4.0,
                    spreadRadius: 1,
                    color: Colors.black12
                )],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
          ),
          child: BottomNavigationBar(
            selectedItemColor: MyColors.gold,
              currentIndex: _pageIndex,
              elevation: 0,
              // iconSize: 15,
              // selectedFontSize: 10,
              // unselectedFontSize: 8,
              onTap: (index){
                if (index==2){
                  print("drawer");
                  _key.currentState.openEndDrawer();
                 // Scaffold.of(context).openEndDrawer();
                }else{
                  setState(() {
                    _pageIndex = index;
                  });
                }

              },
              backgroundColor: Color.fromRGBO(255, 255, 255, 0),
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: "Home"),
                // BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: "Favorite"),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: "Favorite"),
                BottomNavigationBarItem(icon: Icon(Icons.arrow_left_outlined),label: "More")
              ]
          ),
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     IconButton(onPressed: (){}, icon: Icon(Icons.home_outlined)),
          //     IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border)),
          //     IconButton(onPressed: (){}, icon: Icon(Icons.person_outline)),
          //     IconButton(onPressed: (){}, icon: Icon(Icons.arrow_left_outlined))
          //   ],
          // ),
        )
    );
    // return MaterialApp(
    //   theme: ThemeData(
    //     primaryColor: Colors.white,
    //   ),
    //   home: ,
    //   debugShowCheckedModeBanner: false,
    // );
  }

  void showAlertDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alert',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Do you want to log out ?'),
        actions: <Widget>[
          TextButton(
            onPressed: (){


              Navigator.pop(context, 'No');

            },

            child: const Text('Cancel',
              style: TextStyle(fontWeight: FontWeight.bold,color: gold),
            ),
          ),
          TextButton(
            onPressed: () async{
              final result=await SharedPref.removeLoginDetail();
              final result2=await SharedPref.removeCustomerDetail();
              User _user = User.instance;
              _user.isLogin=false;
              _user.email="";
              _user.fname="";
              _user.lname="";

              setState(() {

              });
              Navigator.pop(context, 'Yes');


            },
            child: const Text('OK',
              style: TextStyle(fontWeight: FontWeight.bold,color: gold),
            ),
          ),
        ],
      ),
    );
    print('Doing Something...'); // Print to console.
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {


  HomeController _controller;
  ScrollController _scrollController;
  bool isScrollCompleted = false,futureDelayed=false,firstTimeLoad=true;
  @override
  void initState(){
    super.initState();
    _controller = new HomeController();
    _scrollController = new ScrollController();
    //reinit controller because static controller will remain same reference
    HomeController.cartCountController = new StreamController<int>();
    _scrollController.addListener(() {
      double _maxLength = _scrollController.position.maxScrollExtent*0.8;
      if(_scrollController.position.pixels >_maxLength){
        if(isScrollCompleted==false && futureDelayed==false ) {
          changeScrollingStatus();
          _controller.scrollListener();

         // print(isScrollCompleted);

          //send request to api through service
          Future.delayed(
              const Duration(seconds:5),(){
                futureDelayed=true;
            setState(() {
              isScrollCompleted = false;
              print(isScrollCompleted);
            });
          });
        }
      }else{
        if(isScrollCompleted)
          changeScrollingStatus();
        else{
          if(futureDelayed==true)
            Future.delayed(
                const Duration(milliseconds:500),(){
              setState(() {
                futureDelayed=false;
              });
            });
        }
      }
    });
  }

  void changeScrollingStatus(){
    setState(() {
      if(isScrollCompleted)
        isScrollCompleted=false;
      else
        isScrollCompleted=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return  SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        //height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(255, 255, 255, 1),
        //  color: Colors.black45,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: size.width*0.8,
                  height: 50,
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.fromLTRB(15,0,15,0),
                  child: Stack(
                     // fit: StackFit.passthrough,
                      children: [
                        TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            prefixIcon: Icon(Icons.search,color: Color.fromRGBO(120, 119, 136, 1),),
                            hintText: "Search Product",
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(117, 117, 117, 1)
                            ),
                            fillColor: Color.fromRGBO(241, 241, 241, 1.0),
                            filled: true,
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none
                            )
                        ),
                      ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, "/search");
                          },
                        )
                      ]
                  ),
                ),
                Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        child:  Container(
                          decoration: BoxDecoration(
                              color:Color.fromRGBO(241, 241, 241, 1),
                              borderRadius: BorderRadius.circular(30.0)
                          ),
                          child: IconButton(
                              onPressed: (){
                                Navigator.pushNamed(context, "/cart");
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                size: 26.0,
                                color: Color.fromRGBO(142, 142, 142, 1),
                              )
                          ),
                        ),
                      ),
                      Positioned(
                        right: -3,
                        top: -3,
                        child: Container(
                           width: 20,
                          height: 20,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: MyColors.gold),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Center(child: StreamBuilder<int>(
                              initialData: DataManager.cart.length,
                              stream: HomeController.cartCountController.stream,
                              builder: (context, snapshot) {
                                int items = snapshot.data;
                                //print("cart counter");
                                return Text(items.toString(),style: TextStyle(color: Colors.white,fontSize: 10),);
                              }
                            )),
                          ),
                        ),
                      )
                    ]),
                SizedBox(width: 10,),
              ],),
            SizedBox(height: 20,),
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 15),
              height: size.height*0.15,
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: StreamBuilder(
                  stream: _controller.bannerStream,
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.active){
                      if(snapshot.hasData){
                        //at this call we know that response has been received then show loader
                        firstTimeLoad = false;
                        List<banner.Banner> result = snapshot.data ;
                        return slider.Slider(result: result,);
                      }else{
                        //if no data exist
                        return Text("no data");
                      }
                    }else{

                      return slider.Slider();
                      // return Center(child: CircularProgressIndicator(),);
                    }
                  }
              ),
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Special for you",style: TextStyle(fontSize: 20.0,color: MyColors.gold),),
                ),
                Expanded(child: SizedBox(),),
                Expanded(child: SizedBox(),),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton( child: Text("",style: TextStyle(color: Color.fromRGBO(187, 189, 195, 1)),)),
                ),
                SizedBox(width: 15,)
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: StreamBuilder(
                  stream: _controller.specialStream,
                  builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot){
                    if(snapshot.connectionState == ConnectionState.active){
                      //show widget after server response
                      if(snapshot.hasData){
                        List<categoryModel.Category> result = snapshot.data;
                        return category.Category(result: result,);
                      }else{
                        return Text("no data");
                      }
                    }else{
                      //show widget before server response
                      return category.Category();
                      // return Center(child: CircularProgressIndicator(),);
                    }
                  }
              ),
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                SizedBox(width: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Popular Product",style: TextStyle(fontSize: 20.0,color: MyColors.gold),),
                ),
                Expanded(child: SizedBox(),),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton( child: Text("",style: TextStyle(color: Color.fromRGBO(187, 189, 195, 1)),)),
                ),
                SizedBox(width: 15,)
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 125,
              child: StreamBuilder(
                stream: _controller.popularStream,
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                  if(snapshot.connectionState == ConnectionState.active) {
                    if(snapshot.data == null){
                      return Text("No Data");
                    }else {
                      List<Product> list = snapshot.data;

                      return PopularProducts(result: list);
                    }
                  }else {
                    // return Text("Loading");
                    return PopularProducts();
                    // return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("All Products",style: TextStyle(fontSize: 20.0,color: MyColors.gold),),
                ),
                Expanded(child: SizedBox(),),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton( child: Text("",style: TextStyle(color: Color.fromRGBO(187, 189, 195, 1)),)),
                ),
                SizedBox(width: 15,)
              ],
            ),
            Container(
              child:  StreamBuilder(
                  stream: _controller.allProductStream,
                  builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot){
                    if(snapshot.connectionState == ConnectionState.active){
                      if(snapshot.hasData){
                        List<Product> result = snapshot.data;
                        //print("size of array${result.length}");
                        //show data
                        return AllProducts(result: result);
                      }else{
                        //if no data exist
                        return Text("No Data");
                      }
                    }else{
                      //show shimmer placeholder
                      //return Center(child: CircularProgressIndicator());
                      return AllProducts();
                    }

                  }
              ),
            ),
            getLoader(),


          ],
        ),
      ),
    );
  }

  Widget getLoader(){

    //if scrollcompleted is above 80% then it will true
    //if previous response is true then show loader next time
    //if page load first time then no need to show loader

    if(isScrollCompleted==true && _controller.previousResponse==true && firstTimeLoad==false){
      return Center(
        child: CircularProgressIndicator(),
      );
    }else{
      return SizedBox();
    }

  }
}


class MyColors{
  static const Color gold = const Color.fromRGBO(224, 153, 0, 1);
}