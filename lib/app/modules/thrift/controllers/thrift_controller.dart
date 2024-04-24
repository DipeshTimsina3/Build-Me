import 'dart:convert';
import 'dart:typed_data';
import 'package:ecom_2/app/components/addthriftpopup.dart';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/modules/myThriftProduct/controllers/my_thrift_product_controller.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../model/thrift.dart';

class ThriftController extends GetxController {
   List<Thrift> thrifts = [];
    @override
  void onInit() {
    super.onInit();
    getThrift();
  }

  var addthriftFormKey = GlobalKey<FormState>();
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
      var url = Uri.http(ipAddress, 'ecom2_api/getThrift');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success']) {
          var thriftsData = jsonResponse['data'] as List<dynamic>;
          thrifts.clear();
          thrifts = thriftsData.map((data) => Thrift.fromJson(data)).toList();
          getThrift();
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
      Get.showSnackbar(GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: const Duration(seconds: 3),
      ));
    }
  }
  void onAdd() {
    showDialog(
        context: Get.context!, builder: (context) => const AddThriftpopup());
  }

  
  //   void getThrifts() async {
  //   try {
  //     var url = Uri.http(ipAddress, 'ecom2_api/getThrift');
  //     // await Future.delayed(const Duration(seconds: 3));

  //     var response = await http.get(
  //       url,
  //     );

  //     var result = jsonDecode(response.body);

  //     if (result['success']) {
  //       Get.showSnackbar(GetSnackBar(
  //         backgroundColor: Colors.green,
  //         message: result['message'],
  //         duration: const Duration(seconds: 3),
  //       ));
  //       thrifts = thriftFromJson(jsonEncode(result['data']));
  //       getThrifts();
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

  void addthrift() async {
    try {
      if (addthriftFormKey.currentState!.validate()) {
        try {
          var url = Uri.http(ipAddress, 'ecom2_api/addThrift');

          var request = http.MultipartRequest('POST', url);

          request.fields['title'] = titleController.text;
          request.fields['description'] = descriptionController.text;
          request.fields['price'] = priceController.text;
          request.fields['token'] = MemoryManagement.getAccessToken()!;

          request.files.add(
            http.MultipartFile.fromBytes(
              'image',
              imageBytes!,
              filename: thriftImage!.name,
            ),
          );

          var responseData = await request.send();

          var response = await http.Response.fromStream(responseData);

          // var response = await http.post(url, body: {
          //   'title': titleController.text,
          //   'description': descriptionController.text,
          //   'price': priceController.text,
          //   'category': selectedCategory,
          //   'token': MemoryManagement.getAccessToken()
          //   // 'token':prefs.getString('token')
          // });

          var result = jsonDecode(response.body);

          if (result['success']) {
            Get.back();
            getThrift();
            try {
              Get.find<MyThriftProductController>().getThrift();
              
            } catch (e) {
              
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
          Get.showSnackbar(const GetSnackBar(
            backgroundColor: Colors.red,
            message: 'Something went wrong',
            duration: Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {}
  }
}
