import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/data/repo/product_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class product_controller extends GetxController with StateMixin {
  RxList<productModel> productList = (List<productModel>.of([])).obs;
  final product_repo = productRepo();

  @override
  void onInit() async {
    // TODO: implement onInit
    await fetchProducts();
    super.onInit();
  }

  Future fetchProducts() async {
    try {
      change(productList, status: RxStatus.loading());
      var category = await product_repo.fetchProduct();
      productList.assignAll(category);
      print("leght of ${productList.length} ");
      print("last of ${productList.last} ");
      // print("title of ${categoryList[0].sId} ");

      change(productList, status: RxStatus.success());
    } catch (ex) {
      change(productList, status: RxStatus.error(ex.toString()));
    }
  }
}
