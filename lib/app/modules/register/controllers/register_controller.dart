import 'dart:convert';
import 'package:ecom_2/app/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullNameController = TextEditingController();
  var phoneController = TextEditingController();

  var registerFormKey = GlobalKey<FormState>();

  final count = 0.obs;

  void onRegister() async {
    if (registerFormKey.currentState!.validate()) {
      try {
        var url = Uri.http(ipAddress, 'ecom2_api/auth/register');

        var response = await http.post(url, body: {
          'fullname': fullNameController.text,
          'Phone' : phoneController.text,
          'email': emailController.text,
          'password': passwordController.text,
          
        });

        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.back();
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
    }
  }

  void increment() => count.value++;
}
