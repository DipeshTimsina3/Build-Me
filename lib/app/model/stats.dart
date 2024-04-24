// To parse this JSON data, do
//
//     final stats = statsFromJson(jsonString);

import 'dart:convert';

Stats statsFromJson(String str) => Stats.fromJson(json.decode(str));

String statsToJson(Stats data) => json.encode(data.toJson());

class Stats {
  final String? totalIncome;
  final String? totalUsers;
  final String? totalOrders;
  final String? totalProducts;

  Stats({
    this.totalIncome,
    this.totalUsers,
    this.totalOrders,
    this.totalProducts,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        totalIncome: json["total_income"],
        totalUsers: json["total_users"],
        totalOrders: json["total_orders"],
        totalProducts: json["total_products"],
      );

  Map<String, dynamic> toJson() => {
        "total_income": totalIncome,
        "total_users": totalUsers,
        "total_orders": totalOrders,
        "total_products": totalProducts,
      };
}
