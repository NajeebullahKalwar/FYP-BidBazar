
import 'package:bidbazar/controllers/cart_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:input_quantity/input_quantity.dart';

class Cart extends GetView<cartController> {
  Cart({super.key});

  cartController controller = Get.put(cartController());
  // double totalAmount = 0;
  @override
  Widget build(BuildContext context) {
    // controller.amount.value = 0;
    return Column(
      children: [
        AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          foregroundColor: Colors.black,
          title: Text("Cart"),
          centerTitle: true,
        ),
        Expanded(
          flex: 9,
          child: controller.obx(
            (state) => Obx(
              () => ListView.builder(
                itemCount: controller.cartlist.length,
                itemBuilder: (context, index) {
                  // print(
                  //   "${index} " + controller.amount.toString(),
                  // );
                  return Card(
                    child: ListTile(
                      visualDensity: VisualDensity(vertical: 4),
                      contentPadding: EdgeInsets.all(5),
                      // dense: true,
                      // autofocus: true,
                      title: Text(
                        // maxLines: 3,
                        controller.cartlist[index].product!.name.toString() +
                            " \n" +
                            "Rs - " +
                            controller.cartlist[index].product!.price
                                .toString(),
                      ),
                      subtitle: Text(
                        maxLines: 1,
                        controller.cartlist[index].product!.specs.toString(),
                        style: TextStyle(),
                      ),
                      leading: Container(
                        width: Get.width * 0.24,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                              bottom: Radius.circular(15)),
                          child: CachedNetworkImage(
                            // fit: BoxFit.scaleDown,
                            fit: BoxFit.contain,

                            // width: Get.width * .25,
                            imageUrl: "http://192.168.0.164:4000" +
                                controller
                                    .cartlist[index].product!.images!.first
                                    .toString(),
                          ),
                          // "https://i.postimg.cc/nzdgXrFC/anh-nhat-Pd-ALQmf-Eqv-E-unsplash.jpg"
                        ),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: Get.width * .22,
                            decoration: BoxDecoration(
                                border: Border.all(
                              width: 0.1,
                            )),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    // borderRadius: BorderRadius.circular(100),

                                    child: Icon(Icons.remove,
                                        color: Colors.orange[800]),
                                    onTap: () {
                                      controller.qty.value =
                                          controller.cartlist[index].quantity!;
                                      if (controller.qty.value > 1) {
                                        controller.qty.value -= 1;
                                        controller.addToCart(
                                            controller.cartlist[index].product!,
                                            controller.qty.value);
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  style: TextStyle(fontSize: 16),
                                  controller.cartlist[index].quantity
                                      .toString(),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Icon(Icons.add,
                                        color: Colors.orange[800]),
                                    onTap: () {
                                      controller.qty.value =
                                          controller.cartlist[index].quantity!;
                                      controller.qty.value += 1;

                                      controller.addToCart(
                                          controller.cartlist[index].product!,
                                          controller.qty.value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Divider(
                          //   height: 3,
                          // ),
                          SizedBox(
                              // width: Get.width * .1,
                              height: Get.height * 0.05,
                              child: InkWell(
                                onTap: () {
                                  controller.removeItemfromCart(
                                      controller.cartlist[index].product!.sId!);
                                  controller.cartlist.removeAt(index);
                                },
                                child: Icon(Icons.delete),
                              ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // onLoading: CircularProgressIndicator(),
            onEmpty: Text("Cart data not found "),
            onError: (error) => Text("${error}"),
          ),
        ),
        Expanded(
          flex: 1,
          child: Card(
            semanticContainer: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total - ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Chip(
                        backgroundColor: Colors.grey[200],
                        label: Obx(
                          () => Text(
                            controller.amount.value.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(width: Get.width * 0.3),

                ElevatedButton(
                  onPressed: () async {
                    if (true) {
                      Get.snackbar(
                        'Failed!',
                        'Project is not completed .',
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    // padding: EdgeInsetsDirectional.symmetric(vertical: 10),
                    backgroundColor: Colors.amber[900],
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Bid Now ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Obx(
                        () => Text(
                          "- ${controller.cartlist.length} Items",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget Background() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  int? num(dynamic value) {
    if (value is int) {
      print("integer" + value.toString());
      return value;
    }
    if (value is double) {
      print("double" + value.toString());

      return value.toInt();
    }
  }
}


 // BottomAppBar(
        //   height: Get.height * 0.1 / 2.0,
        //   // color: Colors.amber[900],
        //   elevation: 10,
        //   padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        //   child: buildTotalBar(context),
        // ),
        // Expanded(
        //   child: buildTotalBar(context),
        // ),

// InputQty(
//                         qtyFormProps: QtyFormProps(enableTyping: false),
//                         decoration: QtyDecorationProps(
//                           btnColor: const Color.fromARGB(255, 255, 111, 0),
//                         ),
//                         maxVal: double.maxFinite,
//                         initVal: controller.cartlist[index].quantity!.toInt(),
//                         minVal: 1,
//                         steps: 1,
//                         onQtyChanged: (val) {
//                           print("dec" + val.toString());
//                           int value = num(val) ?? 1;

//                           controller.addToCart(
//                               controller.cartlist[index].product!, value);
//                         },
//                       ),

// Widget buildTotalBar(double totalamount) {
//   // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       SizedBox(
//         width: 10,
//       ),
//       Expanded(
//         flex: 3,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'Total - ',
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//             Chip(
//               backgroundColor: Colors.grey[200],
//               label: Text(
//                 '${totalamount}',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//       // SizedBox(width: Get.width * 0.3),

//       ElevatedButton(
//         onPressed: () async {
//           // if (controller.cartItems.isNotEmpty) {
//           if (true) {
//             // Utils.showLoading(context);
//             // await orderController.placeOrder(
//             //     controller.cartItems, controller.total);
//             // controller.clear();
//           } else {
//             Get.snackbar(
//               'Failed!',
//               'Add items first to place an order.',
//             );
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           // padding: EdgeInsetsDirectional.symmetric(vertical: 10),
//           backgroundColor: Colors.amber[900],
//         ),
//         child: Row(
//           children: [
//             Text(
//               'Bid Now ',
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Divider(
//               height: 5,
//               thickness: 2,
//             ),
//             Text(
//               "- 5 Items",
//               style: TextStyle(fontSize: 15),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
