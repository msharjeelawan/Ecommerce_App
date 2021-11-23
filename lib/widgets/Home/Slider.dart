
import 'package:flutter/material.dart';
import 'package:saraa_kuch/models/HomeScreen/Banner.dart' as banner;
import '../SliderScreen/DotIndicator.dart';

class Slider extends StatefulWidget{

  final List<banner.Banner> result;

  const Slider({Key key,this.result}):super(key: key);

  @override
  _SliderState createState() {
     return _SliderState();
  }
}


class _SliderState extends State<Slider>{
  //banner controller
  PageController _pageController;
  int banerIndex=0;
  List<Widget> images = [];
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {

      setState(() {
        banerIndex = _pageController.page.toInt();
      });
    });

  }

  @override
  Widget build(BuildContext context){
    if(widget.result!=null)
      widget.result.forEach((value) {
        images.add(Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              //widget.result[index].url
              image: DecorationImage(image: Image.network(value.url).image,fit: BoxFit.fill)
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15),

        ));
      });
    var size = MediaQuery.of(context).size;
    if(widget.result!=null) {
      return Stack(
        children: [
          PageView(
             // itemCount: widget.result.length,
              controller: _pageController,
              children: images,
              // itemBuilder: (context, index) {
              //   return ;
              // }\
         ),
          Positioned(
              width: size.width,
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.07 +
                        size.width * 0.03 * widget.result.length,
                    height: 6,
                    child: DotIndicator(
                        size: widget.result.length, activeIndex: banerIndex,color: Colors.white,),
                  ),
                ],
              )
          ),
        ],
      );
    }else {
     return Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          Positioned(
              width: size.width,
              bottom: 10,
              child: Center(
                  child: Container(
                    width: size.width * 0.07 + size.width * 0.03 * 5,
                    height: 8,
                    child: DotIndicator(size: 5, activeIndex: -1,color: Colors.black12,),
                  )
              )
          ),
        ],
      );
    }
  }

}