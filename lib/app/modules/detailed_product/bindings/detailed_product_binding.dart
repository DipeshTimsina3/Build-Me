import 'package:get/get.dart';

import '../controllers/detailed_product_controller.dart';

class DetailedProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailedProductController>(
      () => DetailedProductController(),
    );
  }
}
