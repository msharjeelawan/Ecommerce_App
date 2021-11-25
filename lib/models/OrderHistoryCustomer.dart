import 'dart:convert';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    this.id,
    this.parentId,
    this.status,
    this.currency,
    this.version,
    this.pricesIncludeTax,
    this.dateCreated,
    this.dateModified,
    this.discountTotal,
    this.discountTax,
    this.shippingTotal,
    this.shippingTax,
    this.cartTax,
    this.total,
    this.totalTax,
    this.customerId,
    this.orderKey,
    this.billing,
    this.shipping,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.transactionId,
    this.customerIpAddress,
    this.customerUserAgent,
    this.createdVia,
    this.customerNote,
    this.dateCompleted,
    this.datePaid,
    this.cartHash,
    this.number,
    //this.metaData,
    this.lineItems,
    this.taxLines,
    this.shippingLines,
    this.feeLines,
    //this.couponLines,
    this.refunds,
    this.dateCreatedGmt,
    this.dateModifiedGmt,
    this.dateCompletedGmt,
    this.datePaidGmt,
    this.currencySymbol,
    // this.links,
  });

  int id;
  int parentId;
  String status;
  String currency;
  String version;
  bool pricesIncludeTax;
  DateTime dateCreated;
  DateTime dateModified;
  String discountTotal;
  String discountTax;
  String shippingTotal;
  String shippingTax;
  String cartTax;
  String total;
  String totalTax;
  int customerId;
  String orderKey;
  Ing billing;
  Ing shipping;
  String paymentMethod;
  String paymentMethodTitle;
  String transactionId;
  String customerIpAddress;
  String customerUserAgent;
  String createdVia;
  String customerNote;
  dynamic dateCompleted;
  dynamic datePaid;
  String cartHash;
  String number;
//  List<OrderMetaDatum> metaData;
  List<dynamic> lineItems;
  List<dynamic> taxLines;
  List<ShippingLine> shippingLines;
  List<dynamic> feeLines;
  // List<dynamic> ?couponLines;
  List<dynamic> refunds;
  DateTime dateCreatedGmt;
  DateTime dateModifiedGmt;
  dynamic dateCompletedGmt;
  dynamic datePaidGmt;
  String currencySymbol;
  // Links links;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    // parentId: json["parent_id"],
    status: json["status"],
    currency: json["currency"],
    version: json["version"],
    pricesIncludeTax: json["prices_include_tax"],
    dateCreated: DateTime.parse(json["date_created"]),
    dateModified: DateTime.parse(json["date_modified"]),
    discountTotal: json["discount_total"],
    discountTax: json["discount_tax"],
    shippingTotal: json["shipping_total"],
    shippingTax: json["shipping_tax"],
    cartTax: json["cart_tax"],
    total: json["total"],
    totalTax: json["total_tax"],
    customerId: json["customer_id"],
    orderKey: json["order_key"],
    billing: Ing.fromJson(json["billing"]),
    shipping: Ing.fromJson(json["shipping"]),
    paymentMethod: json["payment_method"],
    paymentMethodTitle: json["payment_method_title"],
    transactionId: json["transaction_id"],
    customerIpAddress: json["customer_ip_address"],
    customerUserAgent: json["customer_user_agent"],
    createdVia: json["created_via"],
    customerNote: json["customer_note"],
    dateCompleted: json["date_completed"],
    datePaid: json["date_paid"],
    cartHash: json["cart_hash"],
    number: json["number"],
    // metaData: List<OrderMetaDatum>.from(json["meta_data"].map((x) => OrderMetaDatum.fromJson(x))),
    lineItems: List<dynamic>.from(json["line_items"].map((x) => (x))),
    taxLines: List<dynamic>.from(json["tax_lines"].map((x) => x)),
    shippingLines: List<ShippingLine>.from(json["shipping_lines"].map((x) => ShippingLine.fromJson(x))),
    feeLines: List<dynamic>.from(json["fee_lines"].map((x) => x)),
    //  couponLines: List<dynamic>.from(json["coupon_lines"].map((x) => x)),
    refunds: List<dynamic>.from(json["refunds"].map((x) => x)),
    dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
    dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
    dateCompletedGmt: json["date_completed_gmt"],
    datePaidGmt: json["date_paid_gmt"],
    currencySymbol: json["currency_symbol"],
    // links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    //"parent_id": parentId,
    "status": status,
    "currency": currency,
    "version": version,
    "prices_include_tax": pricesIncludeTax,
    "date_created": dateCreated.toIso8601String(),
    "date_modified": dateModified.toIso8601String(),
    "discount_total": discountTotal,
    "discount_tax": discountTax,
    "shipping_total": shippingTotal,
    "shipping_tax": shippingTax,
    "cart_tax": cartTax,
    "total": total,
    "total_tax": totalTax,
    "customer_id": customerId,
    "order_key": orderKey,
    "billing": billing.toJson(),
    "shipping": shipping.toJson(),
    "payment_method": paymentMethod,
    "payment_method_title": paymentMethodTitle,
    "transaction_id": transactionId,
    "customer_ip_address": customerIpAddress,
    "customer_user_agent": customerUserAgent,
    "created_via": createdVia,
    "customer_note": customerNote,
    "date_completed": dateCompleted,
    "date_paid": datePaid,
    "cart_hash": cartHash,
    "number": number,
    // "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
    "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
    "tax_lines": List<dynamic>.from(taxLines.map((x) => x)),
    "shipping_lines": List<dynamic>.from(shippingLines.map((x) => x.toJson())),
    "fee_lines": List<dynamic>.from(feeLines.map((x) => x)),
    //  "coupon_lines": List<dynamic>.from(couponLines!.map((x) => x)),
    "refunds": List<dynamic>.from(refunds.map((x) => x)),
    "date_created_gmt": dateCreatedGmt.toIso8601String(),
    "date_modified_gmt": dateModifiedGmt.toIso8601String(),
    "date_completed_gmt": dateCompletedGmt,
    "date_paid_gmt": datePaidGmt,
    "currency_symbol": currencySymbol,
    //"_links": links.toJson(),
  };
  static List<Order> fromJsonList(jsonList) {
    return jsonList.map<Order>((obj) => Order.fromJson(obj)).toList();
  }
}

class Ing {
  Ing({
    this.firstName,
    this.lastName,
    this.company,
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
  String company;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;
  String email;
  String phone;

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
    firstName: json["first_name"],
    lastName: json["last_name"],
    company: json["company"],
    address1: json["address_1"],
    address2: json["address_2"],
    city: json["city"],
    state: json["state"],
    postcode: json["postcode"],
    country: json["country"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "company": company,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "state": state,
    "postcode": postcode,
    "country": country,
    "email": email == null ? null : email,
    "phone": phone,
  };
}

class LineItem {
  LineItem({
    this.id,
    this.name,
    this.productId,
    this.variationId,
    this.quantity,
    this.taxClass,
    this.subtotal,
    this.subtotalTax,
    this.total,
    this.totalTax,
    this.taxes,
    this.metaData,
    this.sku,
    this.price,
    this.parentName,
  });

  int id;
  String name;
  int productId;
  int variationId;
  int quantity;
  String taxClass;
  String subtotal;
  String subtotalTax;
  String total;
  String totalTax;
  List<dynamic> taxes;
  List<dynamic> metaData;
  String sku;
  double price;
  dynamic parentName;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
    id: json["id"],
    name: json["name"],
    productId: json["product_id"],
    variationId: json["variation_id"],
    quantity: json["quantity"],
    taxClass: json["tax_class"],
    subtotal: json["subtotal"],
    subtotalTax: json["subtotal_tax"],
    total: json["total"],
    totalTax: json["total_tax"],
    taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
    metaData: List<dynamic>.from(json["meta_data"].map((x) => x)),
    sku: json["sku"],
    price: json["price"].toDouble(),
    parentName: json["parent_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "product_id": productId,
    "variation_id": variationId,
    "quantity": quantity,
    "tax_class": taxClass,
    "subtotal": subtotal,
    "subtotal_tax": subtotalTax,
    "total": total,
    "total_tax": totalTax,
    "taxes": List<dynamic>.from(taxes.map((x) => x)),
    "meta_data": List<dynamic>.from(metaData.map((x) => x)),
    "sku": sku,
    "price": price,
    "parent_name": parentName,
  };
  static List<LineItem> fromJsonList(jsonList) {
    return jsonList.map<LineItem>((obj) => LineItem.fromJson(obj)).toList();
  }
}

class Links {
  Links({
    this.self,
    this.collection,
    this.customer,
  });

  List<Collection> self;
  List<Collection> collection;
  List<Collection> customer;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
    collection: List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
    customer: List<Collection>.from(json["customer"].map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
    "customer": List<dynamic>.from(customer.map((x) => x.toJson())),
  };
}

class Collection {
  Collection({
    this.href,
  });

  String href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class OrderMetaDatum {
  OrderMetaDatum({
    this.id,
    this.key,
    this.value,
  });

  int id;
  String key;
  String value;

  factory OrderMetaDatum.fromJson(Map<String, dynamic> json) => OrderMetaDatum(
    id: json["id"],
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "value": value,
  };
}

class ShippingLine {
  ShippingLine({
    this.id,
    this.methodTitle,
    this.methodId,
    this.instanceId,
    this.total,
    this.totalTax,
    // this.taxes,
    //  this.metaData,
  });

  int id;
  String methodTitle;
  String methodId;
  String instanceId;
  String total;
  String totalTax;
  // List<dynamic> taxes;
//  List<ShippingLineMetaDatum> metaData;

  factory ShippingLine.fromJson(Map<String, dynamic> json) => ShippingLine(
    id: json["id"],
    methodTitle: json["method_title"],
    methodId: json["method_id"],
    instanceId: json["instance_id"],
    total: json["total"],
    totalTax: json["total_tax"],
    // taxes:json["taxes"]==null || json["taxes"]==[]?[]: List<dynamic>.from(json["taxes"].map((x) => x)),
    // metaData: List<ShippingLineMetaDatum>.from(json["meta_data"].map((x) => ShippingLineMetaDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "method_title": methodTitle,
    "method_id": methodId,
    "instance_id": instanceId,
    "total": total,
    "total_tax": totalTax,
    // "taxes": List<dynamic>.from(taxes.map((x) => x)),
    // "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
  };
}

// To parse this JSON data, do
//
//     final shippingLineMetaDatum = shippingLineMetaDatumFromJson(jsonString);


ShippingLineMetaDatum shippingLineMetaDatumFromJson(String str) => ShippingLineMetaDatum.fromJson(json.decode(str));

String shippingLineMetaDatumToJson(ShippingLineMetaDatum data) => json.encode(data.toJson());

class ShippingLineMetaDatum {
  ShippingLineMetaDatum({
    this.id,
    this.methodTitle,
    this.methodId,
    this.instanceId,
    this.total,
    this.totalTax,
    this.taxes,
    this.metaData,
  });

  int id;
  String methodTitle;
  String methodId;
  String instanceId;
  String total;
  String totalTax;
  List<dynamic> taxes;
  List<MetaDatum> metaData;

  factory ShippingLineMetaDatum.fromJson(Map<String, dynamic> json) => ShippingLineMetaDatum(
      id: json["id"],
      methodTitle: json["method_title"],
      methodId: json["method_id"],
      instanceId: json["instance_id"],
      total: json["total"],
      totalTax: json["total_tax"],
      taxes: json["taxes"]==null || json["taxes"]==[]?[]:List<dynamic>.from(json["taxes"].map((x) => x)),
  metaData: List<MetaDatum>.from(json["meta_data"].map((x) => MetaDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "method_title": methodTitle,
    "method_id": methodId,
    "instance_id": instanceId,
    "total": total,
    "total_tax": totalTax,
    "taxes": List<dynamic>.from(taxes.map((x) => x)),
    "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
  };
}

class MetaDatum {
  MetaDatum({
    this.id,
    this.key,
    this.value,
    this.displayKey,
    this.displayValue,
  });

  int id;
  String key;
  DisplayValueClass value;
  String displayKey;
  DisplayValueClass displayValue;

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
    id: json["id"],
    key: json["key"],
    value: json["value"]=="no"?DisplayValueClass():json["value"].map((x) => DisplayValueClass.fromJson(x)),
    displayKey: json["display_key"],
    displayValue: json["display_value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "value": value,
    "display_key": displayKey,
    "display_value": displayValue,
  };
}

class DisplayValueClass {
  DisplayValueClass({
    this.titleGeneralSettings,
    this.methodTitle,
    this.methodDescription,
    this.taxHeading,
    this.taxStatus,
    this.pricesIncludeTax,
    this.titleFreeShipping,
    this.methodFreeShipping,
    this.methodFreeShippingLabel,
    this.methodFreeShippingCartNotice,
    this.titleCostCalculation,
    this.methodCalculationMethod,
    this.cartCalculation,
    this.titleAdvancedOptions,
    this.methodVisibility,
    this.methodDefault,
    this.methodDebugMode,
    this.methodRules,
    this.idForShipping,
    this.title,
  });

  String titleGeneralSettings;
  String methodTitle;
  String methodDescription;
  String taxHeading;
  String taxStatus;
  String pricesIncludeTax;
  String titleFreeShipping;
  String methodFreeShipping;
  String methodFreeShippingLabel;
  String methodFreeShippingCartNotice;
  String titleCostCalculation;
  String methodCalculationMethod;
  String cartCalculation;
  String titleAdvancedOptions;
  String methodVisibility;
  String methodDefault;
  String methodDebugMode;
  List<MethodRule> methodRules;
  String idForShipping;
  dynamic title;

  factory DisplayValueClass.fromJson(Map<String, dynamic> json) => DisplayValueClass(
    titleGeneralSettings: json["title_general_settings"],
    methodTitle: json["method_title"],
    methodDescription: json["method_description"],
    taxHeading: json["tax_heading"],
    taxStatus: json["tax_status"],
    pricesIncludeTax: json["prices_include_tax"],
    titleFreeShipping: json["title_free_shipping"],
    methodFreeShipping: json["method_free_shipping"],
    methodFreeShippingLabel: json["method_free_shipping_label"],
    methodFreeShippingCartNotice: json["method_free_shipping_cart_notice"],
    titleCostCalculation: json["title_cost_calculation"],
    methodCalculationMethod: json["method_calculation_method"],
    cartCalculation: json["cart_calculation"],
    titleAdvancedOptions: json["title_advanced_options"],
    methodVisibility: json["method_visibility"],
    methodDefault: json["method_default"],
    methodDebugMode: json["method_debug_mode"],
    methodRules: List<MethodRule>.from(json["method_rules"].map((x) => MethodRule.fromJson(x))),
    idForShipping: json["id_for_shipping"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "title_general_settings": titleGeneralSettings,
    "method_title": methodTitle,
    "method_description": methodDescription,
    "tax_heading": taxHeading,
    "tax_status": taxStatus,
    "prices_include_tax": pricesIncludeTax,
    "title_free_shipping": titleFreeShipping,
    "method_free_shipping": methodFreeShipping,
    "method_free_shipping_label": methodFreeShippingLabel,
    "method_free_shipping_cart_notice": methodFreeShippingCartNotice,
    "title_cost_calculation": titleCostCalculation,
    "method_calculation_method": methodCalculationMethod,
    "cart_calculation": cartCalculation,
    "title_advanced_options": titleAdvancedOptions,
    "method_visibility": methodVisibility,
    "method_default": methodDefault,
    "method_debug_mode": methodDebugMode,
    "method_rules": List<dynamic>.from(methodRules.map((x) => x.toJson())),
    "id_for_shipping": idForShipping,
    "title": title,
  };
}

class MethodRule {
  MethodRule({
    this.conditions,
    this.costPerOrder,
    this.additionalCosts,
    this.specialAction,
  });

  List<Condition> conditions;
  String costPerOrder;
  List<dynamic> additionalCosts;
  String specialAction;

  factory MethodRule.fromJson(Map<String, dynamic> json) => MethodRule(
    conditions: List<Condition>.from(json["conditions"].map((x) => Condition.fromJson(x))),
    costPerOrder: json["cost_per_order"],
    additionalCosts: List<dynamic>.from(json["additional_costs"].map((x) => x)),
    specialAction: json["special_action"],
  );

  Map<String, dynamic> toJson() => {
    "conditions": List<dynamic>.from(conditions.map((x) => x.toJson())),
    "cost_per_order": costPerOrder,
    "additional_costs": List<dynamic>.from(additionalCosts.map((x) => x)),
    "special_action": specialAction,
  };
}

class Condition {
  Condition({
    this.conditionId,
    this.min,
    this.max,
  });

  String conditionId;
  String min;
  String max;

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    conditionId: json["condition_id"],
    min: json["min"],
    max: json["max"],
  );

  Map<String, dynamic> toJson() => {
    "condition_id": conditionId,
    "min": min,
    "max": max,
  };
}