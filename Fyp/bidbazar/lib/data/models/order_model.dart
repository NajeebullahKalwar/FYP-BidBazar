// import 'package:bidbazar/data/models/user_model.dart';

class OrderModel {
  String? buyer;
  List<OrderItem>? items;
  String? sId;

  OrderModel({this.buyer, this.items, this.sId});

  OrderModel.fromJson(Map<String, dynamic> json) {
    buyer = json['buyer'];
    if (json['items'] != null) {
      items = <OrderItem>[];
      json['items'].forEach((v) {
        items!.add( OrderItem.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['buyer'] = this.buyer;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class OrderItem {
  List<OrderedProduct>? orderedProduct;
  int? totalquantity;
  double? totalprice;
  String? status;
  String? sId;
  String? createdat;

  OrderItem(
      {this.orderedProduct,
      this.totalquantity,
      this.totalprice,
      this.status,
      this.sId,
      this.createdat
      });

  //  OrderItem.partial({
  //   this.orderedProduct,
  //   this.totalquantity,
  //   this.totalprice,
  // });
  

  OrderItem.fromJson(Map<String, dynamic> json) {
    if (json['orderedProduct'] != null) {
      orderedProduct = <OrderedProduct>[];
      json['orderedProduct'].forEach((v) {
        orderedProduct!.add(new OrderedProduct.fromJson(v));
      });
    }
    totalquantity = json['totalquantity'];
    totalprice = json['totalprice'];
    status = json['status'];
    sId = json['_id'];
    // createdat = json['createdat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderedProduct != null) {
      data['orderedProduct'] =
          this.orderedProduct!.map((v) => v.toJson()).toList();
    }
    data['totalquantity'] = this.totalquantity;
    data['totalprice'] = this.totalprice;
    this.status=="" ? data['status'] = this.status:null;
      this.sId==""? data['_id'] = this.sId:null;
    this.createdat==""?
    data['createdat'] = this.createdat:null;
    return data;
  }
}

class OrderedProduct {
  String? productid;
  int? quantity;
  String? sId;

  OrderedProduct({this.productid, this.quantity, this.sId});
  // OrderedProduct({this.productid, this.quantity, this.sId});


  OrderedProduct.fromJson(Map<String, dynamic> json) {
    productid = json['productid'];
    quantity = json['quantity'];
    // sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productid'] = this.productid;
    data['quantity'] = this.quantity;
    this.sId==""? data['_id'] = this.sId:null;
    return data;
  }

}