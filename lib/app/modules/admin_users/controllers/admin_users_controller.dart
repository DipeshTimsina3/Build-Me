import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/user.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminUsersController extends GetxController {
  List<User>? users;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  void addUser() async {
    try {
      if (formKey.currentState!.validate()) {
        try {
          var url = Uri.http(ipAddress, 'ecom2_api/auth/addAdmin');

          var response = await http.post(url, body: {
            'fullname': nameController.text,
            'email': emailController.text,
            'password': passwordController.text,
            'token': MemoryManagement.getAccessToken(),
          });

          var result = jsonDecode(response.body);

          if (result['success']) {
            Get.back();
            resetForm();
            getUsers();
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
          print(e);
          Get.showSnackbar(const GetSnackBar(
            backgroundColor: Colors.red,
            message: 'Something went wrong',
            duration: Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void resetForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getUsers() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getUsers');
      // await Future.delayed(const Duration(seconds: 3));

      var response = await http
          .post(url, body: {'token': MemoryManagement.getAccessToken()});

      var result = jsonDecode(response.body);

      if (result['success']) {
        users = userFromJson(jsonEncode(result['data']));
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

  void deleteUser(String? userID) async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/deleteUsers');
      // await Future.delayed(const Duration(seconds: 3));

      var response = await http.post(url,
          body: {'token': MemoryManagement.getAccessToken(), 'userId': userID});

      var result = jsonDecode(response.body);
      print(result);

      if (result['success']) {
        update();
        getUsers();
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
      print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  void increment() => count.value++;
}