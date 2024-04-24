// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Thrift> thriftFromJson(String str) =>
    List<Thrift>.from(json.decode(str).map((x) => Thrift.fromJson(x)));

String productToJson(List<Thrift> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Thrift {
  final String? thriftproductId;
  final String? title;
  final String? description;
  final String? images;
  final String? price;
  final String? userId;
  final String? phone;
  final String? fullname;

  Thrift({
    this.thriftproductId,
    this.title,
    this.description,
    this.images,
    this.price,
    this.userId,
    this.fullname,
    this.phone,
  });

  factory Thrift.fromJson(Map<String, dynamic> json) => Thrift(
        thriftproductId: json["thriftproduct_id"],
        title: json["title"],
        description: json["description"],
        images: json["images"],
        price: json["price"],
        userId: json["user_id"],
        fullname: json["full_name"],
        phone :json["Phone"]
        
      );

  Map<String, dynamic> toJson() => {
        "thriftproduct__id": thriftproductId,
        "title": title,
        "description": description,
        "images": images,
        "price": price,
        "user_id":userId,
        "full_name":fullname,
        "Phone":phone
      };
}
