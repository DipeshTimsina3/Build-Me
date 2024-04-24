import 'package:ecom_2/app/modules/admin_categories/views/admin_categories_view.dart';
import 'package:ecom_2/app/modules/admin_dashboard/views/admin_dashboard_view.dart';
import 'package:ecom_2/app/modules/admin_products/views/admin_products_view.dart';
import 'package:ecom_2/app/modules/admin_users/views/admin_users_view.dart';
import 'package:ecom_2/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminMainController extends GetxController {
  //TODO: Implement AdminMainController
  List<Widget> screens = [
    const AdminDashboardView(),
    const AdminUsersView(),
    const AdminCategoriesView(),
    const AdminProductsView(),
    const ProfileView()
  ];

  var currentIndex = 0.obs;
  final count = 0.obs;

  void increment() => count.value++;
}
