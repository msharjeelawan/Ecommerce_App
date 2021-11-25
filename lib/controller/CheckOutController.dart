
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:saraa_kuch/SharedPref/SharedPrefren.dart';
import 'package:saraa_kuch/controller/placedOrderController.dart';
import 'package:saraa_kuch/helper/DataManager.dart';
import 'package:saraa_kuch/models/CheckoutScreen/User.dart';
import 'package:saraa_kuch/models/Coupon.dart';

import 'package:saraa_kuch/models/placed_order.dart';


class CheckOutController{

  static StreamController<double> cartPriceController = new StreamController<double>();

  static Future<String> getUserAddress() async{

    String loginResponse = await SharedPref.getCustomerDetail();
    Map<String, dynamic> user = jsonDecode(loginResponse);
    Map<String,dynamic> billing = user['shipping'];
    String address = billing['address_1'];

    return address;
  }


  static void createOrder(BuildContext context){


    User _user = new User();
    Coupon _coupon = Coupon.instance();

    Ing2 shipping = Ing2(
        firstName: _user.fname,
        lastName: _user.lname,
        address1: _user.address,
        address2: "same as above shipping address",
        city: "",
        state: "Punjab",
        postcode: "",
        country: "Pakistan",
        email: _user.email,
        phone: _user.phoneNo);

    Ing2 billing = Ing2(
        firstName: _user.fname,
        lastName: _user.lname,
        address1: _user.address,
        address2: "shipping same billing address",
        city: "Same as shipping",
        state: "Punjab",
        postcode: "",
        country: "pakistan",
        email: _user.email,
        phone: _user.phoneNo);

    CouponCode coupon = CouponCode(code: "r94a33vq");
    if(_coupon.isCouponImplemented){
      coupon = CouponCode(code: _coupon.name);
    }

    List<LineItem> _cartList = [];

    DataManager.cart.forEach((key, product) {

      LineItem lineItemwithoutvariation = LineItem(productId: product.id, quantity: product.tempQty);
      _cartList.add(lineItemwithoutvariation);

    });


    ShippingLine2 shippinglines = ShippingLine2(methodId: "0000", methodTitle: "free", total: "199");

    if(DataManager.totalPrice>=5000){
      shippinglines = ShippingLine2(methodId: "0000", methodTitle: "free", total: "0");
    }

    PlacedOrder placeorder = PlacedOrder(
        paymentMethod: "Cash on delivery",
        paymentMethodTitle: "Cash on delivery",
        setPaid: false,
        billing: billing,
        shipping: shipping,
        lineItems: _cartList,
        shippingLines: [shippinglines],
        customerid: _user.id,
        couponCode: [coupon]);


    PlaceOrderController orderController = PlaceOrderController();

    orderController.placeOrder(
        placeorder, context);

  }

}