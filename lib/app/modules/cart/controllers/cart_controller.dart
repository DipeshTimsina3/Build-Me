import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  List<CartItem> cart = [];

  var total = 0.0.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    mapCart();
  }

  void increaseQuantity(int index) {
    cart[index].quantity++;
    updateLocal();
    updateTotal();
    update();
  }

  void decreaseQuantity(int index) {
    if (cart[index].quantity <= 1) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Quantity can\'t be less than 1',
        duration: Duration(seconds: 3),
      ));
      return;
    }
    cart[index].quantity--;
    updateLocal();
    updateTotal();
    update();
  }

  Future<int?> makeOrder() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/createOrder');

      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'total': total.value.toString(),
        'cart': MemoryManagement.getMyCart(),
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
        return result['order_id'];
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
    return null;
  }

  void makePayment(
      {required String total,
      required String orderId,
      required String otherData}) async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/makePayment');

      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'total': total,
        'order_id': orderId,
        'other_data': otherData,
      });

      print(response.body);

      var result = jsonDecode(response.body);

      if (result['success']) {
        cart.clear();
        MemoryManagement.setMyCart('[]');
        updateTotal();
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
    return null;
  }

  void updateTotal() {
    total.value = 0;
    cart.forEach((element) {
      total.value =
          total.value + double.parse(element.product.price!) * element.quantity;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void mapCart() {
    var cart =
        jsonDecode(MemoryManagement.getMyCart() ?? '[]') as List<dynamic>;
    this.cart = cart
        .map((e) => CartItem(
            product: Product.fromJson(e['product']), quantity: e['quantity']))
        .toList();
    updateTotal();
  }

  void addProduct({required Product product, int? quantity}) {
    if (cart.any((element) => element.product.productId == product.productId)) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Product already in cart!',
        duration: Duration(seconds: 3),
      ));
      return;
    }

    cart.add(CartItem(product: product, quantity: quantity ?? 1));
    updateTotal();
    updateLocal();
    update();
    Get.showSnackbar(const GetSnackBar(
      backgroundColor: Colors.green,
      message: 'Product added successfully!',
      duration: Duration(seconds: 3),
    ));
  }

  void removeProduct(int index) {
    cart.removeAt(index);
    updateLocal();
    update();
    updateTotal();

    Get.showSnackbar(GetSnackBar(
    backgroundColor: Colors.red,
    message: 'Product removed from cart successfully!',
    duration: const Duration(seconds: 3),
  ));
  }

  void updateLocal() {
    MemoryManagement.setMyCart(jsonEncode(cart
        .map((e) => {
              'product': e.product.toJson(),
              'quantity': e.quantity,
            })
        .toList()));
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
