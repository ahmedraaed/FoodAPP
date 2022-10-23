

import 'package:foodapp/models/products_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  String? time;
  bool? isExist;
  Productmodel? product;

  CartModel(
      {this.id,
        this.name,
        this.price,
        this.img,
        this.quantity,
        this.isExist,
        this.time,
        this.product,
        });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    time = json['time'];
    isExist = json['exist'];
    product=Productmodel.fromJson(json['product']);
  }

  Map<String,dynamic> toJson()
  {
    return {
    "id":id,
    "name":name,
    "price":price,
    "img":img,
    "quantity":quantity,
    "time":time,
    "isExist":isExist,
    "product" : product?.toJson(),
  };
}

}