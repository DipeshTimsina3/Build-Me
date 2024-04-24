import 'package:get/get.dart';

import '../controllers/my_detail_thrift_product_controller.dart';

class MyDetailThriftProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyDetailThriftProductController>(
      () => MyDetailThriftProductController(),
    );
  }
}
