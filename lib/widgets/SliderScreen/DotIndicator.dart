import 'package:flutter/material.dart';
import 'package:saraa_kuch/screens/HomeScreen.dart';

class DotIndicator extends StatefulWidget {
  final int size;
  final int activeIndex;
  final Color color;
  const DotIndicator({Key key,@required int this.size,@required int this.activeIndex,@required this.color}) : super(key: key);

  @override
  _DotIndicatorState createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<DotIndicator> {
  Size activeSize = new Size(20,10);
  Size nonActiveSize = new Size(10,10);
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: widget.size,
      scrollDirection: Axis.horizontal,
      itemBuilder:(context,index){
        if(index == widget.activeIndex){
          return Container(
            margin: EdgeInsets.only(left: 5),
            width: 20,
            height: 10,
            decoration: BoxDecoration(
              color: MyColors.gold,
              borderRadius: BorderRadius.circular(10)
            ),
          );
        }else{
          return Container(
            margin: EdgeInsets.only(left: 5),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: widget.color,
                borderRadius: BorderRadius.circular(10)
            ),
          );
        }
      },
    );
  }
}
