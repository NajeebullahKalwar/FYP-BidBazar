import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/cart_controller.dart';
import 'package:bidbazar/controllers/product_controller.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class productView extends GetView<product_controller> {
  productView({super.key});

  product_controller controller = Get.put(product_controller());
  cartController cart = Get.put(cartController());
  // AuthenticateController user = Get.put(AuthenticateController());

  // String userType =
  //       user.userdata.first.usertype.toString() == "Buyer" ? "Buyer" : "Seller";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return controller.obx(
      (state) => GridView.builder(
        itemCount: controller.productList.length,
        // padding: EdgeInsets.fromLTRB(10.0, 10, 10.0, 0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: size.width / size.height / .65,
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 30.0,
        ),
        itemBuilder: (context, index) {
          productModel product = controller.productList[index];

          return CupertinoButton(
            onPressed: () {
              controller.usertypes == "Buyer"
                  ? Get.toNamed(
                      "productDetailScreen",
                      arguments: controller.productList[index],
                    )
                  : print("Seller");
            },
            child: Container(
              // width: size.width * .4,
              // height: 100.0,
              // color: Colors.amber,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: const BoxDecoration(
                        // color: Colors.grey[200],
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                            bottom: Radius.circular(15)),
                      ),
                      child: Hero(
                        tag: product.sId.toString(),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                              bottom: Radius.circular(15)),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            // width: size.width * .9,
                            imageUrl: controller.productList[index].images!
                                .elementAt(0),
                          ),
                          // "https://i.postimg.cc/nzdgXrFC/anh-nhat-Pd-ALQmf-Eqv-E-unsplash.jpg"
                        ),
                      ),
                      // height: size.height * 1,
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 3,
                  ),
                  // ListTile(
                  //   // leading: ,

                  //   // title: Text("Samung s21 ultra"),
                  //   trailing: Icon(Icons.shopping_cart),
                  // ),
                  // Card(),
                  // Padding(padding: padding)
                  Expanded(
                    child: Container(
                      width: size.width * 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 6, 0, 5),
                            child: Text(
                              maxLines: 1,
                              controller.productList[index].name.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Rs " +
                                      controller.productList[index].price
                                          .toString(),
                                  style: const TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    // color: Colors.orange[900],
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  //Please ensure that the item is in your cart before adding it. => not implemented

                                  cart.addToCart(product, 1);
                                  Get.snackbar("Add to cart",
                                      "Product added to your cart");
                                },
                                child: controller.usertypes == "Buyer"
                                    ? Icon(
                                        Icons.shopping_cart,
                                        color: Colors.grey[500],
                                      )
                                    : SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // onLoading: ,
      onEmpty: Text("There is no product to display"),
      onError: (error) => Text("${error}"),
    );
  }
}
