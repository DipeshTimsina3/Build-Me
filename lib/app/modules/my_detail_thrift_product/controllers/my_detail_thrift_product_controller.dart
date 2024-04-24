import 'package:ecom_2/app/model/thrift.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDetailThriftProductController extends GetxController {

  //TODO: Implement MyDetailThriftProductController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  callnumber(Thrift thrift)async{
    if (thrift.phone != null) {
      // Check if user and phone number are available
      String phoneNumber =
          thrift.phone!; // Accessing user's phone number
      String url = 'tel:$phoneNumber'; // Creating tel URL
      await launch(url); // Launching phone app with the provided phone number
    } else {
      // Handle case where user or phone number is not available
      // You can show a snackbar or toast to inform the user
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Phone number not available',
        duration: Duration(seconds: 3),
      ));
    }

  }

  void increment() => count.value++;
}
