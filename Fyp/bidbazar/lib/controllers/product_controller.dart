import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/image_controller.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/data/repo/product_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class product_controller extends GetxController with StateMixin {
  RxList<productModel> productList = (List<productModel>.of([])).obs;
  final product_repo = productRepo();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController specController = TextEditingController();

  ImageController imagecontroller = Get.put(ImageController());

  AuthenticateController user = Get.put(AuthenticateController());

  String usertypes = "";
  @override
  void onInit() async {
    // TODO: implement onInit
    usertypes = await user.userdata.first.usertype!;
    print("najeeb " + usertypes);
    await usertypes == "Buyer" ? fetchProducts() : fetchProductByUser();

    // Future.delayed(Duration(milliseconds: 5000), () {
    //   addProduct();
    //   // Do something
    // });
    super.onInit();
  }

  Future fetchProducts() async {
    try {
      change(productList, status: RxStatus.loading());

      // user.userdata.first.usertype=="Buyer"?

      var products = await product_repo.fetchProduct();
      productList.assignAll(products);
      print("leght of ${productList.length} ");
      print("last of ${productList.last} ");
      // print("title of ${categoryList[0].sId} ");

      change(productList, status: RxStatus.success());
    } catch (ex) {
      change(productList, status: RxStatus.error(ex.toString()));
    }
  }

  Future fetchProductByUser() async {
    try {
      change(productList, status: RxStatus.loading());
      // user.usertypes
      var products =
          await product_repo.fetchProductByUserId(user.userdata.first.sId!);
      productList.assignAll(products);

      change(productList, status: RxStatus.success());
    } catch (ex) {
      change(productList, status: RxStatus.error(ex.toString()));
    }
  }

  Future addProduct({
    required String name,
    required String specs,
    required String price,
    required List<String> images,
    required String category,
  }) async {
    try {
      change(productList, status: RxStatus.loading());

      // await imagecontroller.getImage();

      print("lisyt image");
      // print(stringList);

      var product = await product_repo.createProduct(
        UserId: user.userdata.first.sId!,
        name: name,
        specs: specs,
        price: 380000,
        image: images,
        // image: ["https://i.postimg.cc/G267pKHS/front.png"],
        category: category,
      );

      productList.add(product);
      change(productList, status: RxStatus.success());
    } catch (ex) {
      change(productList, status: RxStatus.error(ex.toString()));
    }
  }

  void clearfields() {
    nameController.clear();
    priceController.clear();
    specController.clear();
  }
}
