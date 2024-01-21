import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/widgets/gridItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class customSearch extends StatelessWidget {
  customSearch(
      {super.key,
      this.controller,
      this.onChanged,
      this.OnTap,
      this.searchProducts,
      this.userType,
      this.onlySearch});
  // var data = Get.arguments;

  TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  String? userType;
  bool? onlySearch;
  List<productModel>? searchProducts;
  void Function()? OnTap;

  // onlySearch = data[1]["onlySearch"];

  static const String routeName = '/customSearch';

  @override
  Widget build(BuildContext context) {
    return onlySearch == true
        ? Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black45),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Icon(Icons.search_rounded),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back),
              ),
              elevation: 0,
              backgroundColor: Colors.white60,
              foregroundColor: Colors.black54,
            ),
            body: Container(
              height: Get.height * 1,
              width: Get.width * 1,
              child: GridView.builder(
                itemCount: searchProducts!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: Get.width / Get.height / .65,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 30.0,
                ),
                itemBuilder: (context, index) {
                  productModel product = searchProducts![index];
                  return CupertinoButton(
                    onPressed: () {
                      Get.toNamed(
                        "productDetailScreen",
                        arguments: [product, userType],
                      );
                    },
                    child: gridItem(product: product, index: index),
                  );
                },
              ),
            ),
          );
  }

  // Widget searchProducts(product){
  //   return
  // }
}
