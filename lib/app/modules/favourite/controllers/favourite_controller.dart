import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../../model/product.dart';
import '../../../utils/memoryManagement.dart';
import 'package:http/http.dart' as http;

class FavouriteController extends GetxController {
  List<FavItem> userFav = [];
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getUserFav();
  }

  void getUserFav() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getUserFavourites');
      var response = await http.post(url, body: {'token': MemoryManagement.getAccessToken()});
      
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['success']) {
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.green,
            message: result['message'],
            duration: const Duration(seconds: 3),
          ));
          MemoryManagement.setFavourite(result['favourite_list']);
          mapUserFav();
          update();
        } else {
          handleError("Failed to fetch favourites: ${result['message']}");
        }
      } else {
        handleError("Failed to fetch favourites: ${response.reasonPhrase}");
      }
    } catch (e) {
      handleError("Failed to fetch favourites: $e");
    }
  }

  Future<void> addUserfav({required Product product}) async {
    if (userFav.any((element) => element.product.productId == product.productId)) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Product already in Favourites!',
        duration: Duration(seconds: 3),
      ));
      return;
    }

    userFav.add(FavItem(product: product));
    updateLocal();

    try {
      var url = Uri.http(ipAddress, 'ecom2_api/updateUserFavourites');
      var response = await http.post(url, body: {
        'favourite_list': MemoryManagement.getFavourite(),
        'token': MemoryManagement.getAccessToken()
      });

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['success']) {
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.green,
            message: result['message'],
            duration: const Duration(seconds: 3),
          ));
          update();
        } else {
          handleError("Failed to update favourites: ${result['message']}");
        }
      } else {
        handleError("Failed to update favourites: ${response.reasonPhrase}");
      }
    } catch (e) {
      handleError("Failed to update favourites: $e");
    }
  }

  void mapUserFav() {
    var userFavJson = jsonDecode(MemoryManagement.getFavourite() ?? '[]') as List<dynamic>;
    userFav = userFavJson.map((e) => FavItem(product: Product.fromJson(e['product']))).toList();
  }

  void updateLocal() {
    var updatedFavouriteList = jsonEncode(userFav.map((e) => {'product': e.product.toJson()}).toList());
    MemoryManagement.setFavourite(updatedFavouriteList);
  }

void removeUserFav(int index) async {
  userFav.removeAt(index);
  updateLocal();
  update();
  
  try {
    var url = Uri.http(ipAddress, 'ecom2_api/updateUserFavourites');
    var response = await http.post(url, body: {
      'favourite_list': MemoryManagement.getFavourite(),
      'token': MemoryManagement.getAccessToken()
    });

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['success']) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: 'Favorite deleted successfully',
          duration: const Duration(seconds: 3),
        ));
        update();
      } else {
        handleError("Failed to update favourites: ${result['message']}");
      }
    } else {
      handleError("Failed to update favourites: ${response.reasonPhrase}");
    }
  } catch (e) {
    handleError("Failed to update favourites: $e");
  }
}
  void handleError(String errorMessage) {
    print(errorMessage);
    Get.showSnackbar(const GetSnackBar(
      backgroundColor: Colors.red,
      message: 'Something went wrong',
      duration: Duration(seconds: 3),
    ));
  }
}

class FavItem {
  final Product product;
  FavItem({required this.product});
}
