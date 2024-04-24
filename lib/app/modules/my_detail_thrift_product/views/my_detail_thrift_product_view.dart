import 'package:ecom_2/app/model/thrift.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/My_button.dart';
import '../../../constants.dart';
import '../controllers/my_detail_thrift_product_controller.dart';

class MyDetailThriftProductView
    extends GetView<MyDetailThriftProductController> {
  const MyDetailThriftProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var thriftproduct = Get.arguments as Thrift;

    return Scaffold(
      appBar: AppBar(
        title: Text(thriftproduct.title?.toUpperCase() ?? ''),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'product+${thriftproduct.thriftproductId}',
                  child: Image.network(
                    getImageUrl(thriftproduct.images ?? ''),
                    width: double.infinity,
                    height: Get.height * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${thriftproduct.title?.toUpperCase() ?? ''}',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Description: ${thriftproduct.description ?? ''}',
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Price: Rs ${thriftproduct.price.toString()}',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        child: MyButton(
                          tittle: 'Call',
                          onPressed: () {
                            controller.callnumber(thriftproduct);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
