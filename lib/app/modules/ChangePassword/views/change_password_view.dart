
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/My_button.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'Change Password',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ChangePasswordController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: controller.oldPasswordController,
                decoration: InputDecoration(
                  labelText: 'Old Password',
                  border: OutlineInputBorder(),
                  prefixIcon:
                      Icon(Icons.lock), // Icon before old password field
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: controller.newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                  prefixIcon:
                      Icon(Icons.lock), // Icon before new password field
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
               MyButton(
                    tittle: 'Update Password',
                  onPressed: () async {
                    await controller.updateUserPassword();
                  },
                  ),
              
            ],
          ),
        ),
      ),
    );
  }
}