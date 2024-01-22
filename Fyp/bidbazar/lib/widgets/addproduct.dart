import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/category_controller.dart';
import 'package:bidbazar/controllers/image_controller.dart';
import 'package:bidbazar/controllers/product_controller.dart';
import 'package:bidbazar/widgets/customTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class addProduct extends GetView<ImageController> {
  addProduct({super.key});

  static const String routeName = '/addProduct';
  ImageController imgcontroller = Get.put(ImageController());
  product_controller productController = Get.put(product_controller());
  categoryController catController = Get.put(categoryController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        productController.clearfields();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black87),
            title: Text(
              "Bidbazar",
              style: TextStyle(color: Colors.black87),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Container(
            child: Form(
              key: imgcontroller.productKey,
              child: ListView(
                children: [
                  Card(
                    semanticContainer: true,
                    child: Container(
                      width: Get.width * 0.9,
                      height: Get.height * 0.4 / 1.2,
                      child: Center(
                        child: TextButton.icon(
                          onPressed: () {
                            imgcontroller.getImage();
                          },
                          icon: Icon(
                            Icons.upload_file,
                            color: Colors.black38,
                          ),
                          label: Obx(
                            () => Text(
                              "Images ${imgcontroller.imageList.length}",
                              style: TextStyle(
                                fontSize: 20,
                                wordSpacing: 2,
                                color: Colors.black38,
                                leadingDistribution:
                                    TextLeadingDistribution.proportional,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 5,
                    thickness: 10,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 5,
                          // margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: customTextFormField(
                              controller: productController.nameController,
                              labelText: 'Product Name',
                              // hintText: 'Email Address',
                              prefixIconData: Icons.phone_android,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autofocus: false,
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Name can not be empty"
                                    : null;

                                // return controller.validateEmail(value!);
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 5,
                          // margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: customTextFormField(
                              controller: productController.priceController,
                              labelText: 'Product Price',
                              prefixIconData: Icons.payment,
                              // hintText: 'Email Address',
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              autofocus: false,
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Price can not be empty"
                                    : null;
                                // return controller.validateEmail(value!);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
                          child: TextFormField(
                            controller: productController.specController,
                            minLines: 5,
                            maxLines: 20,
                            // inputFormatters: [],
                            validator: (value) {
                              return value!.isEmpty
                                  ? "Name can not be empty"
                                  : null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Category",
                          style: TextStyle(
                            fontSize: 20,
                            wordSpacing: 2,
                            leadingDistribution:
                                TextLeadingDistribution.proportional,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Obx(
                          () => DropdownButton(
                            enableFeedback: true,
                            value: catController.category.value,
                            items: catController.categoryItems,
                            onChanged: (value) {
                              catController.category.value = value!;
                              // print(value);
                              // catController.update();
                            },
                          ),
                        ),
                        Spacer(
                          flex: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(Get.width * 0.9, Get.height * 0.1 / 2),
                        backgroundColor: Colors.amber[900]),
                    onPressed: () async {
                      if (controller.productKey.currentState!.validate()) {
                        await imgcontroller.upload(); //upload image to server
                        print("Product uploading started ");

                        print(productController.nameController.text);
                        print(productController.specController.text);
                        print(catController.category.value);

                        await productController.addProduct(
                          name: productController.nameController.text,
                          specs: productController.specController.text,
                          price: productController.priceController.text,
                          images: imgcontroller.uploadImageList,
                          category: catController.category.value,
                        );
                        imgcontroller.imageList.clear();
                        imgcontroller.uploadImageList.clear();
                        productController.clearfields();
                        Get.snackbar("Product", "Product added successfully ");

                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Add Product",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
