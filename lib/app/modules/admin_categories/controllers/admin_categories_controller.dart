import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import '../../../utils/memoryManagement.dart';
import '../../home/controllers/home_controller.dart';
import 'package:ecom_2/app/model/category.dart';

class AdminCategoriesController extends GetxController {
  List <Category>?categories;
  //TODO: Implement AdminCategoriesController
void getCategories() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getCategory');
      // await Future.delayed(const Duration(seconds: 3));

      var response = await http.get(
        url,
      );

      var result = jsonDecode(response.body);

      if (result['success']) {

        categories = categoryFromJson(jsonEncode(result['categories']));
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
 void onDeleteClicked({ String? categoryId}) async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/deleteCategory');

      var response = await http.post(url, body: {
        'category_id': categoryId,
        'token': MemoryManagement.getAccessToken()
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
   
        update();
     
        getCategories();
        
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3),
           
        ));
           Get.back();

        var homeController = Get.put(HomeController());
        homeController.getCategories();
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

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

  void increment() => count.value++;
}
