import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/widgets/productView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterProduct extends StatelessWidget {
  FilterProduct({super.key, this.productList});
  static const String routeName = '/filterScreen';
  RxList<productModel>? productList = (List<productModel>.of([])).obs;
  // productModel product = Get.arguments[0];
  // var productList = ;

  @override
  Widget build(BuildContext context) {
    // print(product);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black54,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            productList?.clear();
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        width: Get.width * 1,
        height: Get.height * 1,
        child: productView(productList: productList!),
      ),
    );
  }
}
