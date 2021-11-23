import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/SharedPref/SharedPrefren.dart';
import 'package:saraa_kuch/screens/HomeScreen.dart';
import 'package:saraa_kuch/widgets/SliderScreen/DotIndicator.dart';

class SliderScreen extends StatefulWidget{

  @override
  _SliderScreenState createState(){
    return _SliderScreenState();
  }
}

class _SliderScreenState extends State<SliderScreen>{
  int activeIndex = 0;
  PageController _controller;
  @override
  void initState(){
    super.initState();
    _controller = PageController(initialPage: activeIndex);
    _controller.addListener(() {
      setState(() {
        activeIndex = _controller.page.toInt();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: height*0.05,),
          Container(
            height: height*0.65,
            child: PageView(
              controller: _controller,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Text("SaraaKuch",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: MyColors.gold),),
                      SizedBox(height: 10,),
                      Text("Welcome to SaraaKuch, Let’s shop!"),
                      SizedBox(height: 20,),
                      Image.asset("assets/images/splash_1.png",fit: BoxFit.fill,),
                    ],),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Text("SaraaKuch",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: MyColors.gold),),
                      SizedBox(height: 10,),
                      Text("We help people conect with store around Pakistan"),
                      SizedBox(height: 20,),
                      Image.asset("assets/images/splash_2.png",fit: BoxFit.fill,),
                    ],),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Text("SaraaKuch",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: MyColors.gold),),
                      SizedBox(height: 10,),
                      Text("We show the easy way to shop. Just stay at home with us"),
                      SizedBox(height: 20,),
                      Image.asset("assets/images/splash_3.png",fit: BoxFit.fill,),
                    ],),
                )
              ],
            ),
          ),
          SizedBox(height: height*0.03,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width:MediaQuery.of(context).size.width*0.2,
                  height: 10,
                  child: Center(child: DotIndicator(size: 3, activeIndex: activeIndex,color: Colors.black54,))),
            ],
          ),
          Expanded(child: SizedBox()),
          ElevatedButton(
            child: Text("Continue"),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(width*0.8, 40)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              backgroundColor: MaterialStateProperty.all(MyColors.gold)
            ),
            onPressed: (){
              ++activeIndex;
              //print("page${activeIndex.toString()}");
              setState(() {
                if(activeIndex>2){
                  storeUserRecord();
                  activeIndex=2;
                }else{
                  activeIndex = activeIndex;
                }
              //  _controller = PageController(initialPage: activeIndex);
                _controller.animateToPage(activeIndex, duration: Duration(microseconds: 100), curve: Curves.ease);
              //  _controller.nextPage(duration: Duration(seconds: 1), curve: Curves.ease);
                //_controller
                //_controller.animateToPage(page, duration: duration, curve: curve)
                //_controller.jumpToPage(activeIndex);
              });
            },
          ),
          SizedBox(height: height*0.02,),
        ],
      ),
    );
  }


  void storeUserRecord() async{
    Navigator.pushReplacementNamed(context, '/home');
    SharedPref.addFirstTimeUser();
  }

}