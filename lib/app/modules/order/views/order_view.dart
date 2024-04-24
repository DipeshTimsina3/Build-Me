import 'package:ecom_2/app/components/order_card.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(MemoryManagement.getAccessRole() == 'admin'
              ? 'Orders'
              : 'My Orders'),
          centerTitle: true,
          backgroundColor: Colors.indigo,
        ),
        body: GetBuilder<OrderController>(
            init: OrderController(),
            builder: (controller) {
              if (controller.orders == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  padding: const EdgeInsets.all(20.0),
                  itemCount: controller.orders!.length,
                  itemBuilder: (context, index) =>
                      OrderCard(order: controller.orders![index]));
            }));
  }
}
