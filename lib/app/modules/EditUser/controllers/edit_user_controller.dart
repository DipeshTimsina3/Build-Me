import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/user.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditUserController extends GetxController {
  User? user;

  var fullNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  fetchUserProfile() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/editUsers');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
      });
      var result = jsonDecode(response.body);
      print(result);
      if (result['success']) {
        user = User.fromJson(result['data']);
        fullNameController.text = user!.fullName!;
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(GetSnackBar(
        backgroundColor: Colors.red,
        message: 'An error occurred',
        duration: const Duration(seconds: 3),
      ));
    }
  }

  updateUserDetail() async {
    try {
      // Check if full name field is empty
      if (fullNameController.text.isEmpty) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: 'Please fill in the full name field',
          duration: const Duration(seconds: 3),
        ));
        return;
      }

      var url = Uri.http(ipAddress, 'ecom2_api/editUsers');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'full_name': fullNameController.text,
      });
      var result = jsonDecode(response.body);
      if (result['success']) {

        Get.back();
        update();
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: 'Profile updated successfully',
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
      print(e);
      Get.showSnackbar(GetSnackBar(
        backgroundColor: Colors.red,
        message: 'An error occurred',
        duration: const Duration(seconds: 3),
      ));
    }
  }
}
