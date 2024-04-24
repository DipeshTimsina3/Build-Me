import 'package:ecom_2/app/modules/cart/views/cart_view.dart';
import 'package:ecom_2/app/modules/favourite/views/favourite_view.dart';
import 'package:ecom_2/app/modules/home/views/home_view.dart';
import 'package:ecom_2/app/modules/order/views/order_view.dart';
import 'package:ecom_2/app/modules/thrift/views/thrift_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  List<Widget> screens = [
     HomeView(),
    const OrderView(),
    const CartView(),
    const FavouriteView(),
    const ThriftView()
  ];

  var currentIndex = 0.obs;

  final count = 0.obs;

  void increment() => count.value++;
}
