import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constants.dart';
import '../controllers/favourite_controller.dart';

class FavouriteView extends GetView<FavouriteController> {
  const FavouriteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favourites'),
          centerTitle: true,
          backgroundColor: Colors.indigo,
        ),
        body: GetBuilder<FavouriteController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 660,
                  child: ListView.builder(
                      itemCount: controller.userFav.length,
                      itemBuilder: (context, index) => UserFavCard(
                          favItem: controller.userFav[index], index: index)),
                )
              ],
            ),
          ),
        ));
  }
}

class UserFavCard extends StatelessWidget {
  final FavItem favItem;
  final int index;
  const UserFavCard({super.key, required this.favItem, required this.index});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FavouriteController>();
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ]),
          margin: const EdgeInsets.only(bottom: 20),
          height: 110,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  getImageUrl(favItem.product.imageUrl),
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        favItem.product.title ?? '',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Price: ${favItem.product.price}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () {
              controller.removeUserFav(index);
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}

