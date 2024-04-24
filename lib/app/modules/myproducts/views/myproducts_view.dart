import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/myproducts_controller.dart';

class MyproductsView extends GetView<MyproductsController> {
  const MyproductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyproductsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MyproductsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
