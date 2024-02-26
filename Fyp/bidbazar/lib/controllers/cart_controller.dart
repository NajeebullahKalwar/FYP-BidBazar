import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/data/models/cart_model.dart';
import 'package:bidbazar/data/models/product_model.dart';
// import 'package:bidbazar/data/models/user_model.dart';
import 'package:bidbazar/data/repo/cart_repo.dart';
import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

class cartController extends GetxController with StateMixin {
  RxList<cartModel> cartlist = (List<cartModel>.of([])).obs;
  cartRepo cart = cartRepo();
  RxDouble amount = 0.0.obs;
  RxInt qty = 0.obs;
  AuthenticateController user = Get.put(AuthenticateController());

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    fetchCartItems();
  }

  Future fetchCartItems() async {
    try {
      change(cartlist, status: RxStatus.loading());
      // String id = user.userdata.first.sId.toString();

      var cartItems =
          await cart.fetchCart(AuthenticateController.userdata.first.sId!);
      // print("cart all Items");
      // print(cartItems);
      cartlist.assignAll(cartItems);
      cartTotalAmount();

      change(cartlist, status: RxStatus.success());
    } on DioException catch (ex) {
      change(cartlist, status: RxStatus.error(ex.toString()));
    }
  }

  cartTotalAmount() {
    amount.value = 0.0;
    cartlist.forEach(
      // ignore: unnecessary_set_literal
      (element) => {
        // print("price " + cartlist.first.product!.price.toString()),
        amount.value +=
            element.product!.price!.toDouble() * element.quantity!.toDouble(),
      },
    );

    // ignore: prefer_interpolation_to_compose_strings
    print("price " + amount.value.toString());
  }

  void addToCart(productModel product, int Quantity) async {
    try {
      cartModel item = cartModel(
          product: product, quantity: Quantity); // object id will generate auto

      var cartItems = await cart.addToCart(
          item, AuthenticateController.userdata.first.sId!);

      cartlist.assignAll(cartItems);
      cartTotalAmount();
      // ignore: unused_catch_clause
    } on DioException catch (ex) {
      rethrow;
    }
  }

  void removeItemfromCart(String productId) async {
    try {
      await cart.removeFromCartItem(
          productId, AuthenticateController.userdata.first.sId!);

      // cartlist.assignAll(cartItems);

      cartTotalAmount();

      Get.snackbar("Add to cart", "Cart item delete successfully");
      // ignore: unused_catch_clause
    } on DioException catch (ex) {
      rethrow;
    }
  }
}
