import 'package:flutter/material.dart';
import 'package:saraa_kuch/models/ProductScreen/ProductArgument.dart';
import 'package:saraa_kuch/models/HomeScreen/Product.dart';


class AllProducts extends StatefulWidget {
  final List<Product> result;
  const AllProducts({Key key,this.result}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if(widget.result!=null)
      return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics:NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.result.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.82),
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/product",arguments: ProductArgument(id: index,type: "all"));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width*0.4,
                    height: size.height*0.20,
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
                            image: Image.network(widget.result[index].Images[0]).image
                        )
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    height: 38,
                    // color: Colors.red,
                    padding: const EdgeInsets.only(left: 20.0,right: 15),
                    child: Center(child: Text(widget.result[index].title,style:TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.fade))),
                  )
                ],
              ),
            ),
          );
        },
      );
      else
        return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics:NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.80),
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width*0.4,
                  height: size.height*0.22,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      // boxShadow: <BoxShadow>[
                      //   BoxShadow(
                      //       color: Colors.black12,
                      //       spreadRadius: 1,
                      //       blurRadius: 6
                      //   )
                      // ],
                      borderRadius: BorderRadius.circular(20),

                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  height: 30,
                  // color: Colors.red,
                  padding: const EdgeInsets.only(left: 20.0,right: 15),
                  child: Center(child:Container(color: Colors.black12,width: 50,height: 15,)),
                )
              ],
            ),
          );
        },
      );

  }
}
