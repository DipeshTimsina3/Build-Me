import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/My_button.dart';
import '../../../routes/app_pages.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/admin_dashboard_controller.dart';


class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileView()),
              );
            },
            icon: const Icon(Icons.person),
          ),
          
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GetBuilder<AdminDashboardController>(
                init: AdminDashboardController(),
                builder: (controller) {
                  if (controller.stats == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await controller.getStats();
                    },
                    child: GridView(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.2,
                      ),
                      children: [
                        StatsCard(
                          label: 'Total Income',
                          value: controller.stats?.totalIncome.toString() ?? '',
                          icon: Icons.money,
                          isAmount: true,
                        ),
                        StatsCard(
                          label: 'Total Users',
                          value: controller.stats?.totalUsers.toString() ?? '',
                          icon: Icons.person,
                        ),
                        StatsCard(
                          label: 'Total Products',
                          value: controller.stats?.totalProducts.toString() ?? '',
                          icon: Icons.shopping_cart,
                          
                        ),
                        StatsCard(
                          label: 'Total Orders',
                          value: controller.stats?.totalOrders.toString() ?? '',
                          icon: Icons.shopping_bag,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MyButton(
              tittle: 'View Orders',
              onPressed: () {
                Get.toNamed(Routes.ORDER);
              },
            ),
          ),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool isAmount;

  const StatsCard({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
    this.isAmount = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.indigo,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              (isAmount ? 'Rs. ' : '') + value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              
            ),
          ],
        ),
      ),
    );
  }
}
