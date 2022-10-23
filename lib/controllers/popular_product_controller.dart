

import 'package:flutter/material.dart';
import 'package:foodapp/controllers/cart_product_controller.dart';
import 'package:foodapp/data/reposetry/popular_product_repo.dart';
import 'package:foodapp/utiles/app_colors.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../models/products_model.dart';

class PopulerProductController extends GetxController
{
  final PopularProductRpo popularProductRpo;

  PopulerProductController({required this.popularProductRpo});

  List<dynamic> _PopuerProductList=[];
  List<dynamic> get PopuerProductList=>_PopuerProductList;

  bool _loading=false;
  bool get  loading=>_loading;

  int _quantity=0;
  int get quantity=>_quantity;

  int _incrementItems=0;
  int get incrementItems=>_incrementItems+_quantity;

  late CartProductController _cart;


  Future<void> getPoplerProductListcontrollrt()async
  {
    Response response =await popularProductRpo.getPopularProductListRepo();
    //print("you get in here ");

    if(response.statusCode==200)
      {
       // print("you get in here ");
        _PopuerProductList=[];
        _PopuerProductList.addAll(Product.fromJson(response.body).products);
        _loading=true;
        update();
      }else
        {

          print("you get in errrrrrorrrrrre ,${response.statusCode.toString()}");
        }
  }

  void setQuantity(bool increment)
  {
    if(increment)
      {
        _quantity=checkQuantity(_quantity+1);
      }else
        {
          _quantity=checkQuantity(_quantity-1);
        }
    update();
  }
  int checkQuantity(int quantity)
  {
    if((_incrementItems+quantity)<0)
      {
        Get.snackbar("HINT", "you can't decrease more",backgroundColor: AppColors.mainColor,colorText: Colors.white);

        if(_incrementItems>0)
          {
            _quantity=-_incrementItems;
            return _quantity;
          }
        return 0;
      }else if((_incrementItems+quantity)>20)
        {
          Get.snackbar("HINT", "you can't increase more",backgroundColor: AppColors.mainColor,colorText: Colors.white);

          return 20;
        }else
          {
            return quantity;
          }
  }


  void initProduct(Productmodel product,CartProductController cart)
  {
    _quantity=0;
    _incrementItems=0;
    _cart=cart;
    var exist=false;
    exist=_cart.ExistInCart(product);
    print(" is  exist or not the result is :  $exist");

    if(exist)
      {
        _incrementItems=_cart.getQuantity(product);
      }
    //print()
  }

  void AddItems(Productmodel product)
  {
        _cart.addItems(product, _quantity);
        _quantity=0;
        _incrementItems=_cart.getQuantity(product);
        _cart.items.forEach((key, value) {
          print(value.quantity);
        });
        update();
  }

  int get totalItems
  {
    return _cart.totalItems;

  }


  List<CartModel> get getItems
  {
    return _cart.getItems;
  }
}