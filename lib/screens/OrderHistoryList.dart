import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saraa_kuch/controller/OrderHistoryController.dart';
import 'package:saraa_kuch/models/OrderHistoryCustomer.dart';


import 'package:saraa_kuch/models/Product.dart';
import 'package:saraa_kuch/screens/OrderHistoryDetail.dart';
import 'package:saraa_kuch/services/OrderHistoryService.dart';


import '../constants.dart';



class OrderHistory extends StatefulWidget {
  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  OrderHistoryBloc orderHistoryBloc;

  @override
  void initState() {
    orderHistoryBloc=OrderHistoryBloc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: CustomScrollView(
            shrinkWrap: true,
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                stretch: true,
                onStretchTrigger: () async {
                  print('Load new data!');
                  // await Server.requestNewData();
                },
                backgroundColor: gold,
                expandedHeight: 25.0,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: <StretchMode>[
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                    StretchMode.blurBackground,
                  ],
                  title: Text('Order History'),
                  background: DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(

                    ),
                    child: Image.asset(
                        "assets/images/logo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
         /*     Container(
                height: 200,
                child: StreamBuilder(
                    stream: orderHistoryBloc.orderlistStream,

                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Container()
                          : Container();
                    }),
              ),*/
              StreamBuilder(
                stream: orderHistoryBloc.orderlistStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return SliverPadding(
                      padding: const EdgeInsets.all(2.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                           final Order orderobject = snapshot.data[index];
                           String orderDatecreated=new DateFormat("yyyy,MMM d").format(orderobject.dateCreatedGmt);
                           Ing shipping=orderobject.shipping;
                         //  print("orderlist"+ds.id.toString());
                            return GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Card(

                                  shape: RoundedRectangleBorder(
                                    side: new BorderSide(color: light_grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),

                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Order Code",
                                              style: TextStyle(
                                                  color: font_grey,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            Text(
                                              "Payment Method",
                                              style: TextStyle(
                                                  color: font_grey,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${orderobject.id}",
                                                style: TextStyle(
                                                    color: accent_color,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Spacer(),
                                              Text(
                                                "${orderobject.paymentMethodTitle}",
                                                style: TextStyle(
                                                  color:grey_153,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Order Date",
                                              style: TextStyle(
                                                  color:font_grey,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            Text(
                                              "Payment Method",
                                              style: TextStyle(
                                                  color:font_grey,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${orderDatecreated}",
                                                style: TextStyle(
                                                  color:grey_153,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "${orderobject.status}",
                                                style: TextStyle(
                                                  color:grey_153,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Total items",
                                              style: TextStyle(
                                                  color:font_grey,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            Text(
                                              "Total Amount",
                                              style: TextStyle(
                                                  color:font_grey,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: Text(
                                                  "${orderobject.lineItems.length}",
                                                  style: TextStyle(
                                                    color: grey_153,
                                                  ),
                                                ),
                                              ),
                                              /*   buildPaymentStatusCheckContainer(
                                _orderDetails.payment_status),*/
                                              Spacer(),
                                              Text(
                                                "₨.${orderobject.total}",
                                                style: TextStyle(
                                                  color: grey_153,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        shipping.firstName.isNotEmpty  && shipping.lastName.isNotEmpty
                                            && shipping.address1.isNotEmpty?
                                        Row(
                                          children: [
                                            Text(
                                              "Shipping Address",
                                              style: TextStyle(
                                                  color: font_grey,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),


                                          ],
                                        ):Container(),
                                        shipping.firstName.isNotEmpty  && shipping.lastName.isNotEmpty ?

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [

                                              Text(
                                                "Name: ${shipping.firstName} ${shipping.lastName}",
                                                style: TextStyle(
                                                  color: grey_153,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ):Container(),
                                        shipping.address1.isNotEmpty?
                                        Padding(
                                          padding: shipping.firstName != null && shipping.lastName!=null?
                                          EdgeInsets.symmetric(vertical: 2.0,horizontal: 8.0):EdgeInsets.all(8.0),
                                          child: Wrap(
                                            children: [
                                              Text(
                                                "Address: ${shipping.address1}",
                                                style: TextStyle(
                                                  color: grey_153,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ):Container(),

                                        /*    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Container(
                              width: (MediaQuery.of(context).size.width - (32.0)) / 2,
                              // (total_screen_width - padding)/2
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              //    _orderDetails.shipping_address.name != null
                              //        ?
                              Text(
                                    "Name: {_orderDetails.shipping_address.name}",
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: grey_153,
                                    ),
                                  ),
                                     // : Container(),
                                  //_orderDetails.shipping_address.email != null
            //                      ?
            Text(
                                    "Email: {_orderDetails.shipping_address.email}",
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: grey_153,
                                    ),
                                  ),
                                    //  : Container(),
                                  Text(
                                    "Address: {_orderDetails.shipping_address.address}",
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: grey_153,
                                    ),
                                  ),
                                  Text(
                                    "City: {_orderDetails.shipping_address.city}",
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: grey_153,
                                    ),
                                  ),
                                  Text(
                                    "Country: {_orderDetails.shipping_address.country}",
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: grey_153,
                                    ),
                                  ),
                                  Text(
                                    "Phone: _orderDetails.shipping_address.phone",
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: grey_153,
                                    ),
                                  ),
                                  Text(
                                    "Postal code: _orderDetails.shipping_address.postal_code",
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: grey_153,
                                    ),
                                  ),
                                ],
                              ),
                          ),
                          Spacer(),
                          Text(
                              "_orderDetails.grand_total",
                              style: TextStyle(
                                  color: accent_color,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),*/
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              onTap: (){
                                final  route = MaterialPageRoute(
                                    builder: (BuildContext context){
                                      return OrderHistoryDetail(orderobject: orderobject);
                                    }
                                );
                                Navigator.push(context, route);
                              },
                            );
                          },
                          childCount: snapshot.data.length,
                        ),
                      ),
                    );
                  } else {
                    return SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),

            ],
          ),
        );

  }
}
