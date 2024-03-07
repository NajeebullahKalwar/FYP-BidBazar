import 'package:bidbazar/controllers/auth_controllers.dart';
import 'package:bidbazar/data/models/bid_model.dart';
// import 'package:bidbazar/data/models/cart_model.dart';
// import 'package:bidbazar/data/models/product_model.dart';
import 'package:bidbazar/data/repo/bid.dart';
// import 'package:bidbazar/data/models/user_model.dart';
import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BidController extends GetxController with StateMixin {
  // RxList<BidModel> bidlist = (List<BidModel>.of([])).obs;
  Rx<BidModel> biditems=BidModel().obs;
  BidRepo bid = BidRepo();

  @override
  void onClose() {
    // TODO: implement onClose
    
    super.onClose();
  
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
   AuthenticateController.userdata.first.usertype=='Seller'?   
  await  fetchBidItems():null;
  // await  fetchBidItems();

  }

  Future fetchBidItems() async {
    try {
      change(biditems.value, status: RxStatus.loading());
      // String id = user.userdata.first.sId.toString();

      biditems.value =
          await bid.fetchBidByUserID(AuthenticateController.userdata.first.sId!);
        if(!biditems.value.isBlank!){
      change(biditems, status: RxStatus.error("There is no item to bid"));
    }

      change(biditems.value, status: RxStatus.success());
    } on DioException catch (ex) {
      change(biditems.value, status: RxStatus.error(ex.toString()));
    }
  }

   Future addBid(String productId,String sellerId,int bidprice) async {
    try {
      change(biditems.value, status: RxStatus.loading());
      // String id = user.userdata.first.sId.toString();

      biditems.value =
          await bid.createBid(productId: productId, buyerId: AuthenticateController.userdata.first.sId!, sellerId: sellerId, bidprice: bidprice) ;
        if(!biditems.value.isBlank!){
      change(biditems, status: RxStatus.error("There is no item to bid"));
    }

      change(biditems.value, status: RxStatus.success());
    } on DioException catch (ex) {
      change(biditems.value, status: RxStatus.error(ex.toString()));
    }
  }



}
