import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saraa_kuch/controller/OrderHistoryController.dart';
import 'package:saraa_kuch/models/OrderHistoryCustomer.dart';


import 'package:saraa_kuch/models/Product.dart';
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
                           Order orderobject = snapshot.data[index];
                           String orderDatecreated=new DateFormat("yyyy,MMM d").format(orderobject.dateCreatedGmt);
                           Ing shipping=orderobject.shipping;
                         //  print("orderlist"+ds.id.toString());
                            return Padding(
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

class orderList extends StatelessWidget {
  List<Order> listdata;
  orderList({Key key,this.listdata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   //var orderlist=OrderApi.getCustomerOrderHistory("24");

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {

          return Padding(
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
                           "${listdata[index].id}",
                            style: TextStyle(
                                color: accent_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          Text(
                            "Bank Transfer",
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
                           "_orderDetails.date",
                            style: TextStyle(
                              color:grey_153,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "_orderDetails",
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
                          "Payment Status",
                          style: TextStyle(
                              color:font_grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text(
                          "Delivery Status",
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
                              "_orderDetails",
                              style: TextStyle(
                                color: grey_153,
                              ),
                            ),
                          ),
                       /*   buildPaymentStatusCheckContainer(
                              _orderDetails.payment_status),*/
                          Spacer(),
                          Text(
                            "_orderDetails",
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
                          "Shipping Address",
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
          );
        },
        childCount: 1,
      ),
    );
  }
}

// --------------------------------------------
// Below this line are helper classes and data.

const String baseAssetURL = 'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/';
const String headerImage = '${baseAssetURL}assets/header.jpeg';

const Map<int, DailyForecast> _kDummyData = {
  0 : DailyForecast(
    id: 0,
    imageId: '${baseAssetURL}assets/day_0.jpeg',
    highTemp: 73,
    lowTemp: 52,
    description: 'Partly cloudy in the morning, with sun appearing in the afternoon.',
  ),
  1 : DailyForecast(
    id: 1,
    imageId: '${baseAssetURL}assets/day_1.jpeg',
    highTemp: 70,
    lowTemp: 50,
    description: 'Partly sunny.',
  ),
  2 : DailyForecast(
    id: 2,
    imageId: '${baseAssetURL}assets/day_2.jpeg',
    highTemp: 71,
    lowTemp: 55,
    description: 'Party cloudy.',
  ),
  3 : DailyForecast(
    id: 3,
    imageId: '${baseAssetURL}assets/day_3.jpeg',
    highTemp: 74,
    lowTemp: 60,
    description: 'Thunderstorms in the evening.',
  ),
  4 : DailyForecast(
    id: 4,
    imageId: '${baseAssetURL}assets/day_4.jpeg',
    highTemp: 67,
    lowTemp: 60,
    description: 'Severe thunderstorm warning.',
  ),
  5 : DailyForecast(
    id: 5,
    imageId: '${baseAssetURL}assets/day_5.jpeg',
    highTemp: 73,
    lowTemp: 57,
    description: 'Cloudy with showers in the morning.',
  ),
  6 : DailyForecast(
    id: 6,
    imageId: '${baseAssetURL}assets/day_6.jpeg',
    highTemp: 75,
    lowTemp: 58,
    description: 'Sun throughout the day.',
  ),
};

class Server {
  static List<DailyForecast> getDailyForecastList() => _kDummyData.values.toList();

  static DailyForecast getDailyForecastByID(int id) {
    assert(id >= 0 && id <= 6);
    return _kDummyData[id];
  }
}

class DailyForecast {
  const DailyForecast({
    this.id,
     this.imageId,
     this.highTemp,
     this.lowTemp,
     this.description,
  });
  final int id;
  final String imageId;
  final int highTemp;
  final int lowTemp;
  final String description;

  static const List<String> _weekdays = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String getWeekday(int today) {
    final int offset = today + id;
    final int day = offset >= 7 ? offset - 7 : offset;
    return _weekdays[day];
  }

  int getDate(int today) => today + id;
}

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) => child;

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) => child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.macOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
