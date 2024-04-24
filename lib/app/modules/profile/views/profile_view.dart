import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/My_button.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/memoryManagement.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Circular Avatar
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        (controller.user?.fullName?[0].toUpperCase() ?? '') +
                            (controller.user?.fullName?[1].toUpperCase() ?? ''),
                        style: const TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildProfileDetail(
                    title: 'Full Name:',
                    value: controller.user?.fullName?.toUpperCase() ?? '',
                    color: Colors.black ,
                  ),
                  _buildProfileDetail(
                    title: 'Phone Number:',
                    value: controller.user?.phone ?? '',
                    color: Colors.black,
                  ),
                  _buildProfileDetail(
                    title: 'Email:',
                    value: controller.user?.email ?? '',
                    color: Colors.black,
                  ),
                  _buildProfileDetail(
                    title: 'Role:',
                    value: MemoryManagement.getAccessRole()?.toUpperCase() ?? '',
                    color: Colors.black,
                  ),
                  SizedBox(height: 30),
                  MyButton(
                    tittle: 'Edit Profile',
                    onPressed: () {
                      Get.toNamed(Routes.EDIT_USER);
                    },
                  ),
                  SizedBox(height: 10),
                  MyButton(
                    tittle: 'Change Password',
                    onPressed: () {
                      Get.toNamed(Routes.CHANGE_PASSWORD);
                    },
                  ),
                  SizedBox(height: 10),
                  MyButton(
                    tittle: 'Logout',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: const Text(
                            'Are you sure you want to logout?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                MemoryManagement.removeAll();
                                Get.offAllNamed(Routes.LOGIN);
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileDetail({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
