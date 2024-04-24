import 'package:get/get.dart';

import '../controllers/admin_orders_controller.dart';

class AdminOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminOrdersController>(
      () => AdminOrdersController(),
    );
  }
}
