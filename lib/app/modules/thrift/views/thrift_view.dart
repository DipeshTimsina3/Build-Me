import 'package:ecom_2/app/components/thrift_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/thrift_controller.dart';

class ThriftView extends GetView<ThriftController> {
  const ThriftView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ThriftController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thrift Products'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: GetBuilder<ThriftController>(
          init: ThriftController(),
          builder: (controller) {

            return ListView.builder(
                itemCount: controller.thrifts.length,
                itemBuilder: (context, index) {
                  return ThriftCard(
                    thrift: controller.thrifts[index],
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onAdd,
        child: const Icon(Icons.add),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
