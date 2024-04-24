import 'package:get/get.dart';

import '../controllers/my_thrift_product_controller.dart';

class MyThriftProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyThriftProductController>(
      () => MyThriftProductController(),
    );
  }
}
