// To parse this JSON data, do
//
//     final placedOrder = placedOrderFromJson(jsonString);

import 'dart:convert';


PlacedOrder orderFromJson(String str) => PlacedOrder.fromJson(json.decode(str));

String orderToJson(PlacedOrder data) => json.encode(data.toJson());

class PlacedOrder {
  PlacedOrder({
    this.paymentMethod,
    this.paymentMethodTitle,
    this.setPaid,
    this.billing,
    this.shipping,
    this.lineItems,
    this.shippingLines,
    this.customerid,
    this.couponCode,
  });

  String paymentMethod;
  String paymentMethodTitle;
  bool setPaid;
  Ing2 billing;
  Ing2 shipping;
  List<LineItem> lineItems;
  List<ShippingLine2> shippingLines;
  int customerid;
  List<CouponCode> couponCode;


  factory PlacedOrder.fromJson(Map<String, dynamic> json) => PlacedOrder(
    paymentMethod: json["payment_method"],
    paymentMethodTitle: json["payment_method_title"],
    setPaid: json["set_paid"],
    billing: Ing2.fromJson(json["billing"]),
    shipping: Ing2.fromJson(json["shipping"]),
    lineItems: List<LineItem>.from(json["line_items"].map((x) => LineItem.fromJson(x))),
    shippingLines: List<ShippingLine2>.from(json["shipping_lines"].map((x) => ShippingLine2.fromJson(x))),
    customerid: json["customer_id"],
    couponCode: List<CouponCode>.from(json["coupon_lines"].map((x) => CouponCode.fromJson(x))),


  );

  Map<String, dynamic> toJson() => {
    "payment_method": paymentMethod,
    "payment_method_title": paymentMethodTitle,
    "set_paid": setPaid,
    "billing": billing.toJson(),
    "shipping": shipping.toJson(),
    "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
    "shipping_lines": List<dynamic>.from(shippingLines.map((x) => x.toJson())),
    "customer_id":customerid,
    if(couponCode!=null)
      if(couponCode.isNotEmpty)
        "coupon_lines":List<dynamic>.from(couponCode.map((x) => x.toJson())),

  };
}

class Ing2 {
  Ing2({
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  String firstName;
  String lastName;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;
  String email;
  String phone;

  factory Ing2.fromJson(Map<String, dynamic> json) => Ing2(
    firstName: json["first_name"],
    lastName: json["last_name"],
    address1: json["address_1"],
    address2: json["address_2"],
    city: json["city"],
    state: json["state"],
    postcode: json["postcode"],
    country: json["country"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "state": state,
    "postcode": postcode,
    "country": country,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
  };
}

class LineItem {
  LineItem({
    this.productId,
    this.quantity,
  //  this.variationId,
  });

  int productId;
  int quantity;
 // int variationId;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
    productId: json["product_id"],
    quantity: json["quantity"],
  //  variationId: json["variation_id"] == null ? null : json["variation_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "quantity": quantity,
   // "variation_id": variationId == null ? null : variationId,
  };
}

class ShippingLine2 {
  ShippingLine2({
    this.methodId,
    this.methodTitle,
    this.total,
  });

  String methodId;
  String methodTitle;
  String total;

  factory ShippingLine2.fromJson(Map<String, dynamic> json) => ShippingLine2(
    methodId: json["method_id"],
    methodTitle: json["method_title"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "method_id": methodId,
    "method_title": methodTitle,
    "total": total,
  };
}
class CouponCode {
  CouponCode({
    this.code,

  });
  String code;

  factory CouponCode.fromJson(Map<String, dynamic> json) => CouponCode(
    code: json["code"],


  );

  Map<String, dynamic> toJson() => {
    if(code!=null)
      "code": code,

  };
}