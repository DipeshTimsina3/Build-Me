import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/MyThriftProduct.dart';
import '../../../components/thrift_card.dart';
import '../controllers/my_thrift_product_controller.dart';

class MyThriftProductView extends GetView<MyThriftProductController> {
  const MyThriftProductView({Key? key}) : super(key: key);
 @override
  Widget build(BuildContext context) {
    var controller = Get.put(MyThriftProductController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thrift Products'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: GetBuilder<MyThriftProductController>(
          init: MyThriftProductController(),
          builder: (controller) {

            return ListView.builder(
                itemCount: controller.thrifts.length,
                itemBuilder: (context, index) {
                  return MyThriftProduct(
                    thrift: controller.thrifts[index], 
                      
                      
                  );
                });
          }),
    );
  }
}
