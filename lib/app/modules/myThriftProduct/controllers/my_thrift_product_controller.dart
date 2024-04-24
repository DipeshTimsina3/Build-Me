import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../model/thrift.dart';
import '../../../utils/memoryManagement.dart';

class MyThriftProductController extends GetxController {
  //TODO: Implement MyThriftProductController
   List<Thrift> thrifts = [];
    @override
  void onInit() {
    super.onInit();
    getThrift();
  }
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  
  XFile? thriftImage;
  Uint8List? imageBytes;

    void pickImage() async {
    try {
      thriftImage = await picker.pickImage(source: ImageSource.gallery);
      imageBytes = await thriftImage!.readAsBytes();
      update();
    } catch (e) {}
  }

  var categoryNameController = TextEditingController();
  void getThrift() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getMyThriftProduct');
      var response = await http.post(url, body:{
        'token': MemoryManagement.getAccessToken()
      } );
      print(response.body);

      if (response.statusCode == 200) {

        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success']) {
          getThrift();
          var thriftsData = jsonResponse['data'] as List<dynamic>;
          thrifts.clear();
          
          thrifts = thriftsData.map((data) => Thrift.fromJson(data)).toList();
          update(); // Notify listeners about changes
        } else {
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.red,
            message: jsonResponse['message'],
            duration: const Duration(seconds: 3),
          ));
        }
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: 'Failed to load Thrift products',
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: const Duration(seconds: 3),
      ));
    }
  }
  
  //   void getThrifts() async {
  //   try {
  //     var url = Uri.http(ipAddress, 'ecom2_api/getMyThriftProduct');
  //     // await Future.delayed(const Duration(seconds: 3));

  //     var response = await http.get(
  //       url,
  //     );

  //     var result = jsonDecode(response.body);

  //     if (result['success']) {
  //       getThrifts();
  //       Get.showSnackbar(GetSnackBar(
  //         backgroundColor: Colors.green,
  //         message: result['message'],
  //         duration: const Duration(seconds: 3),
  //       ));
  //       thrifts = thriftFromJson(jsonEncode(result['data']));
  //       // getThrift();
  //       update();
  //     } else {
  //       Get.showSnackbar(GetSnackBar(
  //         backgroundColor: Colors.red,
  //         message: result['message'],
  //         duration: const Duration(seconds: 3),
  //       ));
  //     }
  //   } catch (e) {
  //     print(e);
  //     Get.showSnackbar(const GetSnackBar(
  //       backgroundColor: Colors.red,
  //       message: 'Something went wrong',
  //       duration: Duration(seconds: 3),
  //     ));
  //   }
  // }

  void deleteThrift(String? thriftproductId) async {
    try {
      final url = Uri.http(ipAddress, 'ecom2_api/deleteThrift');
      final response = await http.post(url,body: {
        'token': MemoryManagement.getAccessToken(),
        'thriftproduct_id' : thriftproductId
      });

      final result = jsonDecode(response.body);

      if (result['success']) {
       Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3)
      ));
      getThrift();
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
      
    }
  }
  final count = 0.obs;
 
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