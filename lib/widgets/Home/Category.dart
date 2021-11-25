import 'package:flutter/material.dart';
import 'package:saraa_kuch/models/HomeScreen/Category.dart' as category;
import 'package:saraa_kuch/screens/CategoryScreen.dart';

class Category extends StatefulWidget {
  final List<category.Category> result;

  const Category({Key key,this.result}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    if (widget.result != null) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.result.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return SizedBox(width: 15,);
          } else {
            return
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: GestureDetector(
                      onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return CategoryScreen(id:  widget.result[index].id,);
                            }));
                      },
                      child: Container(
                        width: 200,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.7),
                                  BlendMode.dstATop),
                              image: Image.network(
                                widget.result[index].imageUrl,
                                fit: BoxFit.fill,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.65,
                                height: 100,)
                                  .image
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( widget.result[index].name, style: TextStyle(fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),),
                          Text( widget.result[index].totalItems+" Items", style: TextStyle(
                            fontSize: 18, color: Colors.white,),),
                        ],
                      )
                  ),
                ],
              );
          }
        },
      );
    } else {
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            if (index == 0) {
              return SizedBox(width: 15,);
            } else {
              return Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            }
          });
    }
  }


}