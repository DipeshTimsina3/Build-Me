// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  final String? productId;
  final String? title;
  final String? description;
  final String? categoryId;
  final String? imageUrl;
  final String? isAvailable;
  final String? price;
  final String? categoryTitle;

  Product({
    this.productId,
    this.title,
    this.description,
    this.categoryId,
    this.imageUrl,
    this.isAvailable,
    this.price,
    this.categoryTitle,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        title: json["title"],
        description: json["description"],
        categoryId: json["category_id"],
        imageUrl: json["image_url"],
        isAvailable: json["is_available"],
        price: json["price"],
        categoryTitle: json["category_title"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "title": title,
        "description": description,
        "category_id": categoryId,
        "image_url": imageUrl,
        "is_available": isAvailable,
        "price": price,
        "category_title": categoryTitle,
      };
}
