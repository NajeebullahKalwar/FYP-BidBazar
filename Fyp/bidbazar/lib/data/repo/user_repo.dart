import 'dart:convert';

import 'package:bidbazar/core/api.dart';
import 'package:bidbazar/data/models/user_model.dart';
import 'package:dio/dio.dart';

class UserRepository {
  // get data from repo/api and set to user model
  final Api api = Api();

  Future<userModel?> createAccount(String name, String email, String phone,
      String cnic, String address, String password, String usertype) async {
    try {
      Response response = await api.sendRequest.post('/user/createAccount',
          data: jsonEncode({
            "fullname": name,
            "email": email,
            "mobile": phone,
            "cnic": cnic,
            "address": address,
            "password": password,
            "usertype": usertype
          }));
      final apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      //if successfull then we convert raw data to user model
      return userModel.fromJson(apiResponse.data); //return object of user
    } catch (ex) {
      rethrow;
    }
  }

  Future<userModel?> signIn(String email, String password) async {
    try {
      Response response = await api.sendRequest.post('/user/signIn',
          data: jsonEncode({"email": email, "password": password}));
      final apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      //if successfull then we convert raw data to user model
      return userModel.fromJson(apiResponse.data); //return object of user
    } on DioException catch (ex) {
      throw ex.message.toString();
    }
  }
}
