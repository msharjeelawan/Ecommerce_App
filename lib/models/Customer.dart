// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer({
    this.id,

    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.username,
    this.billing,
    this.shipping,
    this.isPayingCustomer,
    this.avatarUrl,

  });

  int id;

  String email;
  String firstName;
  String lastName;
  String role;
  String username;
  Ing billing;
  Ing shipping;
  bool isPayingCustomer;
  String avatarUrl;


  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],

    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    role: json["role"],
    username: json["username"],
    billing: json["billing"]!=null?Ing.fromJson(json["billing"]):Ing(),
    shipping:json["shipping"]!=null? Ing.fromJson(json["shipping"]):Ing(),
    isPayingCustomer: json["is_paying_customer"],
    avatarUrl: json["avatar_url"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,

    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "role": role,
    "username": username,
    "billing": billing?.toJson(),
    "shipping": shipping?.toJson(),
    "is_paying_customer": isPayingCustomer,
    "avatar_url": avatarUrl,

  };
  static List<Customer> fromJsonList(jsonList) {
    return jsonList.map<Customer>((obj) => Customer.fromJson(obj)).toList();
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
    this.postcode,
    this.country,
    this.state,
    this.email,
    this.phone,
  });

  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String postcode;
  String country;
  String state;
  String email;
  String phone;

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
    firstName: json["first_name"],
    lastName: json["last_name"],
    company: json["company"],
    address1: json["address_1"],
    address2: json["address_2"],
    city: json["city"],
    postcode: json["postcode"],
    country: json["country"],
    state: json["state"],
    email: json["email"] ,
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "company": company,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "postcode": postcode,
    "country": country,
    "state": state,
    "email": email ,
    "phone": phone,
  };
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
