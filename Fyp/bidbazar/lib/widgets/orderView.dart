import 'package:bidbazar/controllers/order_controller.dart';
import 'package:bidbazar/core/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class OrderView extends GetView<OrderController>  {
   OrderView({super.key});
  OrderController orderController=Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(  elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Order Logs"),),
      body: controller.obx(
        (state) => RefreshIndicator(
          onRefresh: () async {
            controller.update();
          },
          child:ListView.builder(
            itemCount: orderController.orderList.length,
            itemBuilder: (context, index) {
              var order =orderController.orderList[index];
            var date=order.createdat!.split("/").getRange(0, 3).toList();

            return Container(
              margin: const EdgeInsets.all(5),
              width: Get.width*0.9,
              height: 120,
              decoration:BoxDecoration(
                border: Border.all(color: Colors.grey , width: 1 , ),
                borderRadius: BorderRadius.circular( 5)

              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Center(child: Image.network( fit: BoxFit.contain, "${Api.BASE_URL}/images/${order.orderedProduct!.first.productid!.images!.first}" ))),
                  ),
                      const SizedBox(width: 5,),
                      
                  SizedBox(
                    width: 205,
                    child: Stack(
                      
                      children: [
                         Positioned(
                          top: 11,
                           child: Text(
                                order.orderedProduct!.first.productid!.name!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  
                                  color: Colors.black, // Set text color
                                ),
                              ),
                         ),
                        // const SizedBox(height: 5,),
                        Positioned(
                          top: 20,
                          child: SizedBox(
                            // width: 250,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                  
                                children: [
                                 
                                
                                Text(
                                  "Actual price ${order.orderedProduct!.first.productid!.price}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                     
                                    color: Colors.grey, 
                                  ),
                                ),
                                Text(
                                  "Bid price ${order.orderedProduct!.first.bidprice.toString()}", 
                                  style: const TextStyle(
                                    fontSize: 15,
                                           color: Colors.grey, 
                                    fontWeight: FontWeight.w600,
                                                  
                                  ),
                                ),
                                Text(
                                  "Total price ${order.totalprice}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey, 
                                    fontWeight: FontWeight.w600,
                                                  
                                  ),
                                ),
                                 Text(
                                 "Date ${date[0]}/${date[1]}/${date[2]}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15, 
                                    color: Colors.grey, 
                                  ),
                                ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      
                      // order.status=="order succefully placed"?
                      
                      // :const SizedBox.shrink(),
                     
                   Positioned(
                        right: 0,
                        bottom: 5,
                        child: Text(
                          "Total Qty ${order.totalquantity}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14, 
                            color: Colors.grey, 
                          ),
                        ),
                      ),
                  
                      ],
                    ),
                  )
                ],
              ),
            );
          },)
        ),
        // onLoading: ,
        onEmpty: const Center(child: Text("There is no product to display", )),
        onError: (error) => Center(child: Text("$error")),
      ),
    );
  }
}



