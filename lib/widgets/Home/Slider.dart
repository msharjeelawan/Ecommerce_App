
import 'package:flutter/material.dart';
import 'package:saraa_kuch/models/Banner.dart' as banner;

class SliderDotIndicator extends StatefulWidget{

  final List<banner.Banner> result;
  const SliderDotIndicator({Key key,this.result}):super(key: key);

  @override
  _SliderDotIndicatorState createState() {
     return _SliderDotIndicatorState();
  }
}


class _SliderDotIndicatorState extends State<SliderDotIndicator>{

  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return  Positioned(
        width: size.width,
        bottom: 10,
        child: Center(
            child: Container(

              width: size.width*0.07+size.width*0.05*widget.result.length,
              height: 8,
              child:DotIndicator(size: widget.result.length, activeIndex: banerIndex),
            )
        )
    );
  }

}