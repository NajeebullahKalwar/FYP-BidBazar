import 'dart:convert';

import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/product_model.dart';
import 'package:dio/dio.dart';

class productRepo {
  Api api = Api();

  Future<productModel> createProduct({
    required String title,
    String? description,
  }) async {
    try {
      Response response =
          await api.sendRequest.post("/product", data: jsonEncode({}));

      final productResponse = ApiResponse.fromResponse(response);

      if (!productResponse.success) {
        throw productResponse.message.toString();
      }

      return productModel.fromJson(productResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<productModel>> fetchProduct() async {
    try {
      Response response = await api.sendRequest.get("/product");

      ApiResponse productResponse = ApiResponse.fromResponse(response);

      if (!productResponse.success) {
        throw productResponse.message.toString();
      }

      return (productResponse.data as List<dynamic>)
          .map((jsonObject) => productModel
              .fromJson(jsonObject)) //jsonObject.key Or jsonObject.value
          .toList(); //add all streams of json object
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<productModel>> fetchProductByCategory(String catId) async {
    try {
      Response response = await api.sendRequest.get("product/category/$catId");

      ApiResponse productResponse = ApiResponse.fromResponse(response);

      if (!productResponse.success) {
        throw productResponse.message.toString();
      }

      return (productResponse.data as List<dynamic>)
          .map((jsonObject) => productModel
              .fromJson(jsonObject)) //jsonObject.key Or jsonObject.value
          .toList(); //add all streams of json object
    } catch (ex) {
      rethrow;
    }
  }
}
