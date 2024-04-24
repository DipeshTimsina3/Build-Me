import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  // late final SharedPreferences prefs;
  final count = 0.obs;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void increment() {
    count.value++;
  }

  void onLogin() async {
    if (loginFormKey.currentState!.validate()) {
      try {
        var url = Uri.http(ipAddress, 'ecom2_api/auth/login');
        print(url);
        var response = await http.post(url, body: {
          'email': emailController.text,
          'password': passwordController.text,
        });

        print(response.body);

        var result = jsonDecode(response.body);

        if (result['success']) {
          MemoryManagement.setAccessRole(result['role']);
          MemoryManagement.setAccessToken(result['token']);
          // await prefs.setString('token', result['token']);
          // await prefs.setString('role', result['role']);

          if (result['role'] == 'admin') {
            Get.offAllNamed(Routes.ADMIN_MAIN);
          } else {
            Get.offAllNamed(Routes.MAIN);
          }
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
        print(e.toString());
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.red,
          message: 'Something went wrong',
          duration: Duration(seconds: 3),
        ));
      }
    }
  }
}
