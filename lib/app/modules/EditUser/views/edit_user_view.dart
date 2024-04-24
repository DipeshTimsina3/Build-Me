import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/My_button.dart';
import '../../../routes/app_pages.dart';
import '../controllers/edit_user_controller.dart';

class EditUserView extends GetView<EditUserController> {
  const EditUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo, // Changed app bar color to blue
      ),
      body: GetBuilder<EditUserController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Full Name',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Changed text color to blue
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: controller.fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Added border radius
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue), // Added focused border color
                  ),
                ),
                style: TextStyle(color: Colors.black), // Changed text color to black
              ),
              const SizedBox(height: 30),
               MyButton(
                    tittle: 'Update',
                  onPressed: () async {
                    await controller.updateUserDetail();
                  },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
