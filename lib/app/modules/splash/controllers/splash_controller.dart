import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      var token = MemoryManagement.getAccessToken();
      var role = MemoryManagement.getAccessRole();
      if (token != null && role != null) {
        if (role == 'admin') {
          Get.offAllNamed(Routes.ADMIN_MAIN);
        } else {
          Get.offAllNamed(Routes.MAIN);
        }
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
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
