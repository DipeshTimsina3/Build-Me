import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();

  updateUserPassword() async {
    try {
      // Check if either old or new password fields are empty
      if (oldPasswordController.text.isEmpty ||
          newPasswordController.text.isEmpty) {
        Get.showSnackbar(
          GetBar(
            message: 'Please fill in both old and new password fields',
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      // Send updated details to API
      var url = Uri.http(ipAddress, 'ecom2_api/changePassword');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'oldPassword': oldPasswordController.text,
        'newPassword': newPasswordController.text,
      });
      var result = jsonDecode(response.body);
      print(result);
      if (result['success']) {
        Get.back(); // Go back to the previous screen or to the list
        Get.showSnackbar(
          GetBar(
            message: 'Password updated successfully',
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        Get.showSnackbar(
          GetBar(
            message: result['message'],
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(
        GetBar(
          message: 'An error occurred',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
