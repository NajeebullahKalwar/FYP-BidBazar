import 'dart:ui';

import 'package:bidbazar/data/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key});

  static const routeName = "/productDetailScreen";
  final productModel product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("back button pressed");

        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black87),
            title: Text(
              product.name.toString(),
              style: TextStyle(color: Colors.black87),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Container(
            child: ListView(
              children: [
                Hero(
                  tag: product.sId.toString(),
                  child: PageStorage(
                    bucket: PageStorageBucket(),
                    child: CarouselSlider.builder(
                      itemCount: product.images?.length,
                      itemBuilder: (context, index, realIndex) {
                        return CachedNetworkImage(
                          fit: BoxFit.cover,
                          // width: Get.width * .9,
                          imageUrl: product.images!.elementAt(index),
                        );
                      },
                      options: CarouselOptions(
                        aspectRatio: 16 / 10,
                        enlargeCenterPage: true,
                        autoPlay: true,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 5,
                  thickness: 2,
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        product.name.toString(),
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Text("Rs "),
                        Text(
                          product.price.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Specification"),
                    subtitle: Text(
                      product.specs.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        wordSpacing: 2,
                        leadingDistribution:
                            TextLeadingDistribution.proportional,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          persistentFooterButtons:
              // isUserBuyer && (firebaseAuth.currentUser!.uid != product.ownerId)?
              [
            Row(
              children: [
                // Container(
                //   width: 45,
                //   height: 45,
                //   color: Colors.amber[900],
                //   child: Center(
                //     child: Text(
                //       "1",
                //       style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.w700,
                //           color: Colors.white),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   width: 4,
                // ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[900]),
                    onPressed: () {},
                    child: Text("Add to Cart"),
                  ),
                ),
              ],
            ),
          ]
          // : null,
          ),
    );
  }
}
