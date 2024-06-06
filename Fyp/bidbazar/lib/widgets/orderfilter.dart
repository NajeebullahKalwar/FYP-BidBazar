
import 'package:bidbazar/widgets/orderTile.dart';
import 'package:flutter/material.dart';
import 'package:bidbazar/controllers/order_controller.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class OrderFilter extends GetView<OrderController> {
  OrderFilter({super.key});
  OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Pending Orders"),
      ),
      body: 
        RefreshIndicator(
          onRefresh: () async {
          },
          child: controller.obx (
            (state) =>  ListView.builder(
              itemCount:orderController. OrdersFilters.length,
              itemBuilder: (context, index) {
                var order =orderController. OrdersFilters[index];
                var date = order.createdat!.split("/").getRange(0, 3).toList();
                return OrderTile(order: order, date: date, index: index, orderController: orderController);
              },
            ),
          ),
        ),
      
    );
  }

 
}
