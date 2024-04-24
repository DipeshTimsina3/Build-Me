import 'package:get/get.dart';

import '../controllers/myproducts_controller.dart';

class MyproductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyproductsController>(
      () => MyproductsController(),
    );
  }
}
