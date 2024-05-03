

import 'dart:convert';

import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/order_model.dart';
import 'package:dio/dio.dart';

class OrderRepo {
  Api api = Api();

 
   Future<OrderModel> createOrder({required List<OrderItem> items, required String buyerId,}) async {
    // Map<String, dynamic> data = cart.toJson();
    // data["user"] = userId;
    // // print("newCart");
    // // print(data);
    
    try {
      Response response = await api.sendRequest.post(
        "/order/create",
        data: jsonEncode({       
      // "seller": sellerId,
      "buyer": buyerId,
      "items":items
        }),
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return OrderModel.fromJson(apiResponse.data);
    } on DioException catch (_) {
      rethrow;
    }
  }

   


}
