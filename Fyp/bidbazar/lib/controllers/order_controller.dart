import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/controllers/cart_controller.dart';
import 'package:bidbazar/data/models/order_model.dart';
import 'package:bidbazar/data/repo/order_repo.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class OrderController extends GetxController with StateMixin {
  Rx<OrderModel> order=OrderModel().obs;
  OrderRepo orderRepo=OrderRepo();
  List<OrderedProduct> orderProducts=[];
  @override
  void onClose() {
    // TODO: implement onClose   
    super.onClose();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    }

   Future placeOrder({required double totalprice, required int totalquantity}) async {
    try {
      change(order.value, status: RxStatus.loading());
      
      cartController controller =Get.put(cartController());
      for (var element in controller.cartlist) {
       print("Start working");
        orderProducts.add(
          OrderedProduct(productid: element.product!.sId!, quantity: element.quantity!)
        );
      }
        print("order product works ");
   print(orderProducts.length);

        // convert order item into json format
        // List<Map<String, dynamic>> orderedProductsJson = orderProducts.map((product) => product.toJson()).toList();
    print("complete order product works ");
      order.value =
          await orderRepo.createOrder(
            items:
             [OrderItem(orderedProduct: orderProducts,totalquantity: totalquantity,totalprice: totalprice,)],
             buyerId: AuthenticateController.userdata.first.sId!,
            //  sellerId: sellerId
             );    
      if(!order.value.isBlank!){
      change(order, status: RxStatus.error("There is no item to bid"));
        }
      change(order.value, status: RxStatus.success());
    } on DioException catch (ex) {
      change(order.value, status: RxStatus.error(ex.toString()));
    }
  }

  //   Future updateBidStatus({required String buyerId,required String productId,required String status}) async {
  //         await bid.updateBidStatus(buyerId:buyerId , productId: productId, status: status) ;
  // }
}
