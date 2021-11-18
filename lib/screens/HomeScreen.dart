import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/controller/HomeController.dart';
import 'package:saraa_kuch/models/Product.dart';
import 'package:saraa_kuch/screens/ProductScreen.dart';
import 'package:saraa_kuch/widgets/SliderScreen/DotIndicator.dart';
import '../services/HomeService.dart';
import 'package:saraa_kuch/models/Banner.dart' as banner;

class HomeScreen extends StatefulWidget{

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  // HomeService _homeService;
  HomeController _controller;
  //banner controller
  PageController _pageController;
  int banerIndex=0;
  int _pageIndex=0;
  @override
  void initState(){
    super.initState();
    //_homeService = new HomeService();
    _controller = new HomeController();

    _pageController = PageController();
    _pageController.addListener(() {
      banerIndex++;
      if(banerIndex==4){
        banerIndex=0;
      }
      print("index:${banerIndex}");
      setState(() {
        banerIndex = _pageController.page.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
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
          body: SingleChildScrollView(
            child: Container(
              //height: MediaQuery.of(context).size.height,
              color: Color.fromRGBO(255, 255, 255, 1),
              //  color: Colors.black45,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15,10,15,0),
                            child: TextField(
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
                          )
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
                                child: IconButton(onPressed: (){},
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
                                // width: 15,
                                height: 19,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: MyColors.gold),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Center(child: Text('10',style: TextStyle(color: Colors.white,fontSize: 10),)),
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
                    child: StreamBuilder(
                        stream: _controller.bannerStream,
                        builder: (context,snapshot){
                          if(snapshot.connectionState == ConnectionState.active){
                            if(snapshot.hasData){
                            List<banner.Banner> result = snapshot.data ;
                              return  Stack(
                                children: [
                                  PageView.builder(
                                      itemCount: result.length,
                                      controller: _pageController,
                                      itemBuilder: (context,index){
                                        return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child:  Image.network(result[index].url,fit: BoxFit.fill,)
                                        );
                                      }),
                                  Positioned(
                                      width: size.width,
                                      bottom: 10,
                                      child: Center(
                                          child: Container(

                                            width: size.width*0.07+size.width*0.05*result.length,
                                            height: 8,
                                            child:DotIndicator(size: result.length, activeIndex: banerIndex),
                                          )
                                      )
                                  ),
                                  ],
                              );
                            }else{
                              //if no data exist
                              return Text("no data");
                            }
                          }else{
                            return Center(child: CircularProgressIndicator(),);
                          }
                        }
                        ),
                  ),
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: 90,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: 6,
                  //     itemBuilder: (context,index){
                  //       if(index==0){
                  //         return SizedBox(width: 15,);
                  //       }else {
                  //         return Column(
                  //           children: [
                  //             GestureDetector(
                  //               onTap:(){
                  //                 var route = MaterialPageRoute(builder: (BuildContext context){return ProductScreen();});
                  //                 Navigator.push(context, route);
                  //               },
                  //               child: Card(
                  //                 shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(20.0),
                  //                 ),
                  //                 elevation: 0,
                  //                 color: Color.fromRGBO(247, 247, 247, 1.0),
                  //                 child: SizedBox(
                  //                   child: Icon(Icons.add, size: MediaQuery.of(context).size.width * 0.15,
                  //                     color: Color.fromRGBO(0, 0, 0, 0.5),),
                  //                   width: MediaQuery.of(context).size.width * 0.20,
                  //                   height: 60,
                  //                 ),
                  //               ),
                  //             ),
                  //             Text("Test", style: TextStyle(fontSize: 18),),
                  //           ],
                  //         );
                  //       }
                  //
                  //     },),
                  // ),
                 // SizedBox(height: 1,),
                  Row(
                    children: [
                      SizedBox(width: 20,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Special for you",style: TextStyle(fontSize: 20.0,color: MyColors.gold),),
                      ),
                      Expanded(child: SizedBox(),),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: (){}, child: Text("See More",style: TextStyle(color: Color.fromRGBO(187, 189, 195, 1)),)),
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
                           //   List<Banner> result = snapshot.data;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                itemBuilder: (context,index){
                                  if(index==0){
                                    return SizedBox(width: 15,);
                                  } else {
                                    return
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0,0,10,0),
                                            child: GestureDetector(
                                              child: Container(
                                                width: 200,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.black12,
                                                  borderRadius: BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                                                      image: Image.network("https://saraakuch.pk/wp-content/uploads/2021/06/shampoo-6-min.png",
                                                        fit: BoxFit.fill,
                                                        width: MediaQuery.of(context).size.width * 0.65,
                                                        height: 100,).image
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              margin:EdgeInsets.fromLTRB(15, 15, 0, 0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Smart Phone", style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                                                  Text("18 Brands", style: TextStyle(fontSize: 18,color: Colors.white,),),
                                                ],
                                              )
                                          ),
                                        ],
                                      );
                                  }
                                },
                              );
                            }else{
                              return Text("no data");
                            }
                          }else{
                            //show widget before server response
                            return Center(child: CircularProgressIndicator(),);
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
                        child: TextButton(onPressed: (){}, child: Text("See More",style: TextStyle(color: Color.fromRGBO(187, 189, 195, 1)),)),
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

                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: list.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return SizedBox(width: 15,);
                                  } else {
                                    return
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                                        child: GestureDetector(
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 130,
                                                height: 90,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(
                                                          color: Colors.black12,
                                                          spreadRadius: 1,
                                                          blurRadius: 6
                                                      )
                                                    ],
                                                    borderRadius: BorderRadius.circular(20),
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: Image.network(list[index-1].Images[0],).image
                                                    )
                                                ),
                                              ),
                                              SizedBox(height: 4,),
                                              Expanded(
                                                child: Container(
                                                  // height: 50,
                                                   width: 125,
                                                  // color: Colors.red,
                                                 // padding: const EdgeInsets.only(left: 20.0,right: 15),
                                                  child: Center(child: Text(list[index - 1].title,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 12))),
                                                ),
                                              )

                                            ],
                                          ),
                                        ),
                                      );
                                  }
                                });
                          }
                        }else {
                          // return Text("Loading");
                          return Center(child: CircularProgressIndicator());
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
                        child: TextButton(onPressed: (){}, child: Text("See More",style: TextStyle(color: Color.fromRGBO(187, 189, 195, 1)),)),
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
                              print("size of array${result.length}");
                              //show data
                              return GridView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                physics:NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: result.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.88),
                                itemBuilder: (context,index){
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: GestureDetector(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: size.width*0.4,
                                            height: size.height*0.22,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      spreadRadius: 1,
                                                      blurRadius: 6
                                                  )
                                                ],
                                                borderRadius: BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: Image.network(result[index].Images[0]).image
                                                )
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                            height: 30,
                                           // color: Colors.red,
                                            padding: const EdgeInsets.only(left: 20.0,right: 15),
                                            child: Center(child: Text(result[index].title,style:TextStyle(fontWeight: FontWeight.bold))),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                  // return Card(
                                  //   elevation: 3,
                                  //   shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(20)
                                  //   ),
                                  //   child: Center(
                                  //       child:Text("test")
                                  //   ),
                                  // );
                                },
                              );
                            }else{
                              //if no data exist
                              return Text("No Data");
                            }
                          }else{
                            //show shimmer placeholder
                            return Center(child: CircularProgressIndicator());
                          }

                        }
                    ),
                  ),

                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
          // color: Colors.black26,
            height: 60,
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
                currentIndex: _pageIndex,
                elevation: 0,
                // iconSize: 15,
                // selectedFontSize: 10,
                // unselectedFontSize: 8,
                onTap: (index){
                  setState(() {
                    _pageIndex = index;
                  });
                },
                backgroundColor: Color.fromRGBO(255, 255, 255, 0),
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: "Home"),
                 // BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: "Favorite"),
                  BottomNavigationBarItem(icon: Icon(Icons.person_outline),label: "Profile"),
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
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}



class MyColors{
  static const Color gold = const Color.fromRGBO(224, 153, 0, 1);
}