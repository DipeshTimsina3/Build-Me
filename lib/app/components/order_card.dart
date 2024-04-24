import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/order.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
            )
          ]),
      height: MemoryManagement.getAccessRole() == 'admin' ? 125 : 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.orderId.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                formatDate(order.orderDate),
                style: TextStyle(fontSize: 15, color: Colors.blue),
              ),
              if (MemoryManagement.getAccessRole() == 'admin')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.fullName ?? '',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    Text(
                      order.email ?? '',
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                  ],
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                order.status == 'paid' ? 'Paid' : 'Failed',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: order.status == 'paid' ? Colors.green : Colors.red),
              ),
              Text(
                'Rs.' + order.total.toString(),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
