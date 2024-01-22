import 'dart:ui';

import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/cart_controller.dart';
import 'package:bidbazar/controllers/product_controller.dart';
import 'package:bidbazar/controllers/wishList_controller.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/data/models/wishListModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key, this.type});
  String? type;
  static const routeName = "/productDetailScreen";

  cartController controller = Get.put(cartController());
  productModel product = Get.arguments[0];
  String userType = Get.arguments[1];

  // WishListController wishlistController;

  // product_controller productController =
  // Get.arguments[2] ?? product_controller();
  // int? index = Get.arguments[3];

  @override
  Widget build(BuildContext context) {
    // print("data");
    // productController.isWishListed.value = product.wishlist!;
    return WillPopScope(
      onWillPop: () async {
        print("back button pressed");

        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black87),
            // title: Text(
            //   product.name.toString(),
            //   style: TextStyle(color: Colors.black87),
            // ),
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
                    child: Container(
                      height: Get.height * 0.3 / 1.1,
                      child: CarouselSlider.builder(
                        // image slider widget
                        itemCount: product.images?.length,
                        itemBuilder: (context, index, realIndex) {
                          return CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "http://192.168.43.7:4000${product.images!.elementAt(index)}",
                          );
                        },

                        options: CarouselOptions(
                          // aspectRatio: 16 / 9,

                          // enlargeCenterPage: true,
                          // enlargeFactor: 1,
                          autoPlay: true,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 5,
                  thickness: 10,
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    titleTextStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                    title: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        product.name!.toUpperCase(),
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
                    trailing: Icon(
                      Icons.favorite_outlined,
                      size: 30,
                      color: Colors.amber[900],
                      fill: 1,
                    ),
                    // trailing: Obx(
                    //   () => productController.isWishListed.value == false
                    //       ? Icon(
                    //           Icons.favorite_outline_rounded,
                    //           size: 30,
                    //         )
                    //       : Icon(
                    //           Icons.favorite_outlined,
                    //           size: 30,
                    //           color: Colors.amber[900],
                    //           fill: 1,
                    //         ),
                    // ),
                  ),
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          "Specification",
                          style: TextStyle(
                            fontSize: 20,
                            wordSpacing: 2,
                            leadingDistribution:
                                TextLeadingDistribution.proportional,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.specs.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            wordSpacing: 2,
                            leadingDistribution:
                                TextLeadingDistribution.proportional,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          persistentFooterButtons: [
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
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(Get.width * 0.8, Get.height * 0.1 / 2),
                          backgroundColor: Colors.amber[900],
                        ),
                        onPressed: () {
                          userType == "Buyer"
                              ? {
                                  controller.addToCart(product, 1),
                                  Get.snackbar("Add to cart",
                                      "Product added to your cart")
                                }
                              : null;
                        },
                        child: userType == "Buyer"
                            ? Text(
                                "Add to Cart",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : Text(
                                "Edit Product",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                      SizedBox(
                        width: Get.width * 0.001,
                      ),
                      Container(
                        // color: Colors.amber[900],
                        width: Get.width * 0.2 / 1.5,
                        child: Center(
                          child: IconButton(
                            onPressed: () async {
                              WishListController wishListController =
                                  Get.put(WishListController());

                              wishListController.Favourite(
                                // add and delete functionality
                                product,
                                product.sId.toString(),
                              );
                              // wishListController.wishlist.add(wishListModel(
                              //   product: product,
                              //   user: AuthenticateController.userdata.first.sId,
                              // ));
                              // wishListController.fetchWishListItems();
                              // productController.productList[index].wishlist =
                              //     await productController.wishlistProduct(
                              //         productId: product.sId!);

                              // productController.isWishListed.value;
                              // print(productController.isWishListed.value);
                            },
                            icon: Icon(
                              Icons.favorite_border_rounded,
                              // fill: 10,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ],
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
