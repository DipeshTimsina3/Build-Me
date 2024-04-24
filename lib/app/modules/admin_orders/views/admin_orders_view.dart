import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_orders_controller.dart';

class AdminOrdersView extends GetView<AdminOrdersController> {
  const AdminOrdersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminOrdersView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminOrdersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
