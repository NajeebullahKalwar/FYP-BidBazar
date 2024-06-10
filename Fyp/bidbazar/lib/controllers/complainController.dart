import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/core/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:get/get.dart';

class ComplaintController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final complaintController = TextEditingController();

  Api api=Api();



  Future complaint({required String reason}) async {
    try {
     

 Response response = await api.sendRequest
          .post("/complaint/add", data: {"buyerid": AuthenticateController.userdata.first.sId,"reason":reason,"complaintExplanation":complaintController.text });
          

      ApiResponse complaintResponse = ApiResponse.fromResponse(response);
      // print(response.data);
      if (!complaintResponse.success) {
        throw complaintResponse.message.toString();
      }
    
    } catch (ex) {
      rethrow;
    }
  }

  // List<DropdownMenuItem>? reas = [
  //   const DropdownMenuItem(
  //     value: 'Product not as described',
  //     child: Text('Product not as described'),
  //   ),
  //   const DropdownMenuItem(
  //     value: 'Late delivery',
  //     child: Text('Late delivery'),
  //   ),
  //   const DropdownMenuItem(
  //     value: 'Late delivery',
  //     child: Text('Late delivery'),
  //   ),
  //   const DropdownMenuItem(
  //     value: 'Wrong item delivered',
  //     child: Text('Wrong item delivered'),
  //   ),
  //   const DropdownMenuItem(
  //     value: 'Other',
  //     child: Text('Other'),
  //   ),
  // ];

  // void submitComplaint({required String reason}) async{
   
  // }
}
