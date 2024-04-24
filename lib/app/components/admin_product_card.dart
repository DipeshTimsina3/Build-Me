import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/admin_products/controllers/admin_products_controller.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminProductCard extends StatelessWidget {
  final Product product;
  const AdminProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Image.network(
            getImageUrl(product.imageUrl),
            width: 75,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            product.title ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Spacer(),
          MemoryManagement.getAccessRole() == 'admin'
              ? IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => DeleteProductDialog(
                              productId: product.productId ?? '',
                            ));
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}

class DeleteProductDialog extends StatelessWidget {
  final String productId;
  const DeleteProductDialog({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AdminProductsController>();
    // var controller = Get.put(AdminProductsController());
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to delete it?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      controller.onDeleteClicked(productId: productId);
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('No'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
