import 'dart:convert';
// import 'dart:html';

import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/bid_model.dart';
import 'package:bidbazar/data/models/cart_model.dart';
import 'package:dio/dio.dart';

class BidRepo {
  Api api = Api();

  // UserRepository user= UserRepository();

  // Future<List<cartModel>> addToCart(cartModel cart, String userId) async {
  //   Map<String, dynamic> data = cart.toJson();
  //   data["user"] = userId;
  //   // print("newCart");
  //   // print(data);
  //   try {
  //     Response response = await api.sendRequest.post(
  //       "/cart",
  //       data: jsonEncode(data),
  //     );
  //     ApiResponse apiResponse = ApiResponse.fromResponse(response);
  //     if (!apiResponse.success) {
  //       throw apiResponse.message.toString();
  //     }
  //     // print("newdata " + apiResponse.data.toString());
  //     // return [];
  //     return (apiResponse.data["items"] as List<dynamic>)
  //         .map((json) => cartModel.fromJson(json))
  //         .toList();
  //   } on DioException catch (ex) {
  //     rethrow;
  //   }
  // }
  // Future removeFromCartItem(String productId, String userId) async {
  //   Map<String, dynamic> data = {
  //     "product": productId,
  //     "user": userId,
  //   };
  //   try {
  //     Response response = await api.sendRequest.delete(
  //       "/cart",
  //       data: jsonEncode(data),
  //     );
  //     ApiResponse apiResponse = ApiResponse.fromResponse(response);
  //     if (!apiResponse.success) {
  //       throw apiResponse.message.toString();
  //     }
  //     // return (apiResponse.data["items"] as List<dynamic>)
  //     //     .map((json) => cartModel.fromJson(json))
  //     //     .toList();
  //     // return [];
  //   } on DioException catch (ex) {
  //     rethrow ;
  //   }
  // }

// userId = 655bc3739287689f923902f5
  Future<BidModel> fetchBidByUserID(String userId) async {
    try {

      Response response = await api.sendRequest.get("/bid/fetchAllBidsForSeller/${userId}");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      // if (!apiResponse.success) {
      //   throw apiResponse.message.toString();
      // }
     
      // print(BidModel.fromJson(apiResponse.data));
      
      // if (apiResponse.data != null) {

      //   return   
      //   (apiResponse.data as List<dynamic>)
      //       .map((json) => BidModel.fromJson(json))
      //       .toList();
      // } else
        
        // if(!apiResponse.success){
        //   throw Error();
        // }else{
        // List<BidModel> item=[];
        // item.add(BidModel.fromJson(apiResponse.data));
        // return item;
        // }
        // print();
        if(!apiResponse.success){
          throw Exception("There is no item in your bid");
        }else
        return BidModel.fromJson(apiResponse.data);

    } catch (ex) {
      rethrow;
    }
  }
}
