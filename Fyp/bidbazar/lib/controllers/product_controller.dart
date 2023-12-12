import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/image_controller.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/data/repo/product_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class product_controller extends GetxController with StateMixin {
  RxList<productModel> productList = (List<productModel>.of([])).obs;
  final product_repo = productRepo();
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

  Future addProduct() async {
    try {
      change(productList, status: RxStatus.loading());

      // await imagecontroller.getImage();

      print("lisyt image");
      // print(stringList);

      var product = await product_repo.createProduct(
          UserId: "655bc3739287689f923902f5",
          name: "Google Pixel 8",
          specs: "24MP camera 4000mah battery ",
          price: 380000,
          image: imagecontroller.uploadImageList,
          // image: ["https://i.postimg.cc/G267pKHS/front.png"],
          category: "6556628c382b1a3cca976166");

      productList.add(product);
      change(productList, status: RxStatus.success());
    } catch (ex) {
      change(productList, status: RxStatus.error(ex.toString()));
    }
  }
}
