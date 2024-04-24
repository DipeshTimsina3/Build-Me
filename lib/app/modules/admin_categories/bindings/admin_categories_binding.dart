import 'package:get/get.dart';

import '../controllers/admin_categories_controller.dart';

class AdminCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminCategoriesController>(
      () => AdminCategoriesController(),
    );
  }
}
