import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class Category extends GetView<categoryController> {
  Category({super.key});
  // AuthenticateController categoryController = Get.put(AuthenticateController());
  categoryController controller = Get.put(categoryController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      width: size.width * 1,
      height: size.height * 1,
      child: Column(
        children: [
          Expanded(
            child: controller.obx(
              (state) {
                return ListView.builder(
                  itemCount: controller.categoryList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        controller.fetchCategories();
                      },
                      leading: Icon(Icons.smartphone_outlined),
                      title:
                          Text(controller.categoryList[index].title.toString()),
                      trailing: Icon(Icons.arrow_right),
                    );
                  },
                );
              },
              onLoading: Center(child: CircularProgressIndicator()),
              onEmpty: Text("empty"),
              onError: (error) => Text(
                error.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
