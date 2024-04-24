import 'package:get/get.dart';

import '../controllers/thrift_controller.dart';

class ThriftBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThriftController>(
      () => ThriftController(),
    );
  }
}
