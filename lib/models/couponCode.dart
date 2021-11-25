// To parse this JSON data, do
//
//     final couponCode = couponCodeFromJson(jsonString);

import 'dart:convert';

List<CouponCode> couponCodeFromJson(String str) => List<CouponCode>.from(json.decode(str).map((x) => CouponCode.fromJson(x)));

String couponCodeToJson(List<CouponCode> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CouponCode {
  CouponCode({
    this.id,
    this.code,
    this.amount,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.discountType,
    this.description,
    this.dateExpires,
    this.dateExpiresGmt,
    this.usageCount,
    this.individualUse,
    this.productIds,
    this.excludedProductIds,
    this.usageLimit,
    this.usageLimitPerUser,
    this.limitUsageToXItems,
    this.freeShipping,
    this.productCategories,
    this.excludedProductCategories,
    this.excludeSaleItems,
    this.minimumAmount,
    this.maximumAmount,
    this.emailRestrictions,
    this.usedBy,
    //  this.metaData,
    this.links,
  });

  int id;
  String code;
  String amount;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String discountType;
  String description;
  DateTime dateExpires;
  DateTime dateExpiresGmt;
  int usageCount;
  bool individualUse;
  List<dynamic> productIds;
  List<dynamic> excludedProductIds;
  dynamic usageLimit;
  int usageLimitPerUser;
  dynamic limitUsageToXItems;
  bool freeShipping;
  List<dynamic> productCategories;
  List<dynamic> excludedProductCategories;
  bool excludeSaleItems;
  String minimumAmount;
  String maximumAmount;
  List<dynamic> emailRestrictions;
  List<dynamic> usedBy;
  // List<MetaDatum> metaData;
  Links links;

  factory CouponCode.fromJson(Map<String, dynamic> json) => CouponCode(
    id: json["id"],
    code: json["code"],
    amount: json["amount"],
    dateCreated: DateTime.parse(json["date_created"]),
    dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
    dateModified: DateTime.parse(json["date_modified"]),
    dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
    discountType: json["discount_type"],
    description: json["description"],
    dateExpires:json["date_expires"]!=null? DateTime.parse(json["date_expires"]):null,
    dateExpiresGmt:json["date_expires_gmt"]!=null? DateTime.parse(json["date_expires_gmt"]):null,
    usageCount: json["usage_count"],
    individualUse: json["individual_use"],
    productIds: List<dynamic>.from(json["product_ids"].map((x) => x)),
    excludedProductIds: List<dynamic>.from(json["excluded_product_ids"].map((x) => x)),
    usageLimit: json["usage_limit"],
    usageLimitPerUser: json["usage_limit_per_user"],
    limitUsageToXItems: json["limit_usage_to_x_items"],
    freeShipping: json["free_shipping"],
    productCategories: List<dynamic>.from(json["product_categories"].map((x) => x)),
    excludedProductCategories: List<dynamic>.from(json["excluded_product_categories"].map((x) => x)),
    excludeSaleItems: json["exclude_sale_items"],
    minimumAmount: json["minimum_amount"],
    maximumAmount: json["maximum_amount"],
    emailRestrictions: List<dynamic>.from(json["email_restrictions"].map((x) => x)),
    usedBy: List<dynamic>.from(json["used_by"].map((x) => x)),
    //   metaData: List<MetaDatum>.from(json["meta_data"].map((x) => MetaDatum.fromJson(x))),
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "amount": amount,
    "date_created": dateCreated.toIso8601String(),
    "date_created_gmt": dateCreatedGmt.toIso8601String(),
    "date_modified": dateModified.toIso8601String(),
    "date_modified_gmt": dateModifiedGmt.toIso8601String(),
    "discount_type": discountType,
    "description": description,
    if(dateExpires!=null)"date_expires": dateExpires.toIso8601String(),
    if(dateExpiresGmt!=null)"date_expires_gmt": dateExpiresGmt.toIso8601String(),
    "usage_count": usageCount,
    "individual_use": individualUse,
    "product_ids": List<dynamic>.from(productIds.map((x) => x)),
    "excluded_product_ids": List<dynamic>.from(excludedProductIds.map((x) => x)),
    "usage_limit": usageLimit,
    "usage_limit_per_user": usageLimitPerUser,
    "limit_usage_to_x_items": limitUsageToXItems,
    "free_shipping": freeShipping,
    "product_categories": List<dynamic>.from(productCategories.map((x) => x)),
    "excluded_product_categories": List<dynamic>.from(excludedProductCategories.map((x) => x)),
    "exclude_sale_items": excludeSaleItems,
    "minimum_amount": minimumAmount,
    "maximum_amount": maximumAmount,
    "email_restrictions": List<dynamic>.from(emailRestrictions.map((x) => x)),
    "used_by": List<dynamic>.from(usedBy.map((x) => x)),
    //  "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
    "_links": links.toJson(),
  };
  static List<CouponCode> fromJsonList(jsonList) {
    return jsonList.map<CouponCode>((obj) => CouponCode.fromJson(obj)).toList();
  }
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection> self;
  List<Collection> collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
    collection: List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
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

class MetaDatum {
  MetaDatum({
    this.id,
    this.key,
    this.value,
  });

  int id;
  String key;
  String value;

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
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
