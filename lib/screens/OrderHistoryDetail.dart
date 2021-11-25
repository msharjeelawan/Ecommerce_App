import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:saraa_kuch/controller/OrderHistoryController.dart';
import 'package:saraa_kuch/models/OrderHistoryCustomer.dart';

import 'package:saraa_kuch/models/HomeScreen/Product.dart';
import 'package:saraa_kuch/services/OrderHistoryService.dart';

import '../constants.dart';

class OrderHistoryDetail extends StatefulWidget {
  Order orderobject;

  OrderHistoryDetail({Key key, this.orderobject}) : super(key: key);

  @override
  State<OrderHistoryDetail> createState() => _OrderHistoryDetailState();
}

class _OrderHistoryDetailState extends State<OrderHistoryDetail> {
  OrderHistoryBloc orderHistoryBloc;
  Order orderobject;
  var lineitemsample;
  List<LineItem> lineItem;
  String orderDatecreated = "";
  double subtotal = 0.0;

  @override
  void initState() {
    orderHistoryBloc = OrderHistoryBloc();
    orderobject = widget.orderobject;
    lineItem = LineItem.fromJsonList(orderobject.lineItems);
    orderDatecreated =
        new DateFormat("yyyy,MMM d").format(orderobject.dateCreatedGmt);
    subtotal = double.parse(orderobject.total) +
        double.parse(orderobject.discountTotal) -
        double.parse(orderobject.shippingTotal) +
        double.parse(orderobject.totalTax);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              //  statusBarBrightness: Brightness.dark
            ),
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
              title: Text('Order\'s Detail'),
              background: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(),
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(2.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  Ing shipping = orderobject.shipping;
                  //  print("orderlist"+ds.id.toString());
                  return Column(
                    children: [
                      Padding(
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
                                          color: grey_153,
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
                                        "${orderDatecreated}",
                                        style: TextStyle(
                                          color: grey_153,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${orderobject.status}",
                                        style: TextStyle(
                                          color: grey_153,
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
                                          color: font_grey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Total Amount",
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
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
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
                                shipping.firstName.isNotEmpty &&
                                        shipping.lastName.isNotEmpty &&
                                        shipping.address1.isNotEmpty
                                    ? Row(
                                        children: [
                                          Text(
                                            "Shipping Address",
                                            style: TextStyle(
                                                color: font_grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                shipping.firstName.isNotEmpty &&
                                        shipping.lastName.isNotEmpty
                                    ? Padding(
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
                                      )
                                    : Container(),
                                shipping.address1.isNotEmpty
                                    ? Padding(
                                        padding: shipping.firstName != null &&
                                                shipping.lastName != null
                                            ? EdgeInsets.symmetric(
                                                vertical: 2.0, horizontal: 8.0)
                                            : EdgeInsets.all(8.0),
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
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Center(
              child: Text(
                "Product List",
                style: TextStyle(
                    color: gold, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: orderobject.lineItems.length != 0
                  ? buildOrderdProductList()
                  : Container(
                      height: 100,
                      child: Text(
                        "No items are ordered",
                        style: TextStyle(color: font_grey),
                      ),
                    ),
            )
          ])),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 75,
                  ),
                  buildBottomSection()
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }

  buildOrderdProductList() {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: orderobject.lineItems.length,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: buildOrderedProductItemsCard(index),
          );
        },
      ),
    );
  }

  Card buildOrderedProductItemsCard(index) {
    return Card(
      shape: RoundedRectangleBorder(
        side: new BorderSide(color: light_grey, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                lineItem[index].name,
                maxLines: 2,
                style: TextStyle(
                  color: font_grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    lineItem[index].quantity.toString() + " x ",
                    style: TextStyle(
                        color: font_grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "item",
                    style: TextStyle(
                        color: font_grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Text(
                    lineItem[index].total,
                    style: TextStyle(
                        color: accent_color,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildBottomSection() {
    return Expanded(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    child: Text(
                      "SUB TOTAL",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: font_grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Spacer(),
                  Text(
                    subtotal.toStringAsFixed(2).toString(),
                    style: TextStyle(
                        color: font_grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    child: Text(
                      "TAX",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: font_grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Spacer(),
                  Text(
                    orderobject.totalTax,
                    style: TextStyle(
                        color: font_grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    child: Text(
                      "SHIPPING COST",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: font_grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Spacer(),
                  Text(
                    orderobject.shippingTotal,
                    style: TextStyle(
                        color: font_grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    child: Text(
                      "DISCOUNT",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: font_grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Spacer(),
                  Text(
                    orderobject.discountTotal,
                    style: TextStyle(
                        color: font_grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )),
          Divider(
            color: font_grey,
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    child: Text(
                      "GRAND TOTAL",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: font_grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Spacer(),
                  Text(
                    orderobject.total,
                    style: TextStyle(
                        color: accent_color,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
