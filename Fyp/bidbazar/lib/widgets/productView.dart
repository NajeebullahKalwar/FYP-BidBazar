import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/cart_controller.dart';
import 'package:bidbazar/controllers/product_controller.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/widgets/gridItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class productView extends GetView<product_controller> {
  productView(
      {super.key, required this.productList, this.cart, this.isProductDelete});
  // product_controller controller;
  RxList<productModel> productList = (List<productModel>.of([])).obs;
  bool? isProductDelete;
  cartController? cart;

  // AuthenticateController user = Get.put(AuthenticateController());

  // String userType =
  //       user.userdata.first.usertype.toString() == "Buyer" ? "Buyer" : "Seller";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return controller.obx(
      (state) => GridView.builder(
        itemCount: productList.length,
        // padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: size.width / size.height / .65,
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 30.0,
        ),
        itemBuilder: (context, index) {
          productModel product = productList[index];

          return CupertinoButton(
            onPressed: () {
              print("working");
              print(productList);
              Get.toNamed(
                "productDetailScreen",
                arguments: [
                  productList[index],
                  AuthenticateController.userdata.first.usertype,
                  // controller,
                  // index
                ],
              );
            },
            child: gridItem(
              cart: cart,
              isProductDelete: isProductDelete,
              product: product,
              index: index,
              userType: AuthenticateController.userdata.first.usertype,
            ),
          );
        },
      ),
      // onLoading: ,
      onEmpty: Text("There is no product to display"),
      onError: (error) => Center(child: Text("${error}")),
    );
  }
}
