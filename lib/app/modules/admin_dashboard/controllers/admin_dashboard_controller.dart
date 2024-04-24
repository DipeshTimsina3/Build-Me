import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/stats.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminDashboardController extends GetxController {
  Stats? stats;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getStats();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getStats() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getStats');
      // await Future.delayed(const Duration(seconds: 3));

      var response = await http
          .post(url, body: {'token': MemoryManagement.getAccessToken()});

      var result = jsonDecode(response.body);

      if (result['success']) {
        // categories = categoryFromJson(jsonEncode(result['data']));
        stats = statsFromJson(jsonEncode(result['data']));
        update();
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

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
