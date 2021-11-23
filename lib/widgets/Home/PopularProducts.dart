import 'package:flutter/material.dart';
import 'package:saraa_kuch/models/ProductScreen/ProductArgument.dart';
import 'package:saraa_kuch/models/HomeScreen/Product.dart';


class PopularProducts extends StatefulWidget {

  final List<Product> result;
  const PopularProducts({Key key,this.result}) : super(key: key);

  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  Widget build(BuildContext context) {
    if (widget.result != null)
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.result.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return SizedBox(width: 15,);
            } else {
              return
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "/product",arguments: ProductArgument(id: index-1,type: "category"));
                    },
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
                                  image: Image
                                      .network(widget.result[index - 1]
                                      .Images[0],)
                                      .image
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
                            child: Center(child: Text(widget.result[index - 1]
                                .title, style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10))),
                          ),
                        )

                      ],
                    ),
                  ),
                );
            }
          });
    else{
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            if (index == 0) {
              return SizedBox(width: 15,);
            } else
              return Container(
                padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                child: Column(
                  children: [
                    Container(
                      width: 130,
                      height: 90,
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
                      child: Text(""),
                    ),
                    SizedBox(height: 4,),
                    Expanded(
                      child: Container(
                        // height: 50,
                        width: 125,
                        // color: Colors.red,
                        // padding: const EdgeInsets.only(left: 20.0,right: 15),
                        child: Center(child: Container(
                          color: Colors.black12, width: 50, height: 15,)),
                      ),
                    )

                  ],
                ),
              );
          });
    }
  }
}
