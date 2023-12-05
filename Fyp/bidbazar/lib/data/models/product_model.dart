class productModel {
  String? sId;
  String? name;
  String? specs;
  int? price;
  List<String>? images;
  String? category;

  productModel(
      {this.sId,
      this.name,
      this.specs,
      this.price,
      this.images,
      this.category});

  productModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    specs = json['specs'];
    price = json['price'];
    images = json['images'].cast<String>();
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['specs'] = this.specs;
    data['price'] = this.price;
    data['images'] = this.images;
    data['category'] = this.category;
    return data;
  }
}
