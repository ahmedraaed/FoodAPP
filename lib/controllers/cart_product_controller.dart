import 'package:flutter/material.dart';
import 'package:foodapp/models/products_model.dart';
import 'package:get/get.dart';

import '../data/reposetry/cart_product_repo.dart';
import '../models/cart_model.dart';
import '../utiles/app_colors.dart';

class CartProductController extends GetxController
{
  final CartProductRepo cartRepo;
  CartProductController({required this.cartRepo});

  Map<int ,CartModel> _items={};
  Map<int ,CartModel> get items=>_items;

  List<CartModel> storageItems=[];

  void addItems(Productmodel productmodel,int quantity)
  {
    var totalquantity=0;
    if(_items.containsKey(productmodel.id!))
      {

        _items.update(productmodel.id!, (value) {
          totalquantity=value.quantity!+quantity;
          return CartModel(
              id: value.id,
              img: value.img,
              name: value.name,
              price: value.price,
              quantity: value.quantity!+quantity,
              time: DateTime.now().toString(),
              isExist: true,
              product: productmodel,
          );
        });

        if(totalquantity<=0)
          {
            _items.remove(productmodel.id);
          }
      }else
        {
        if(quantity>0)  {
        _items.putIfAbsent(productmodel.id!, () {
          // print("items id is " + productmodel.id.toString() + "quantity is " +
          //     quantity.toString());
          return CartModel(
              id: productmodel.id,
              img: productmodel.img,
              name: productmodel.name,
              price: productmodel.price,
              quantity: quantity,
              time: DateTime.now().toString(),
              isExist: true,
            product: productmodel,

          );
        });
      }else
        {
          Get.snackbar("HINT", "you can't add zero",backgroundColor: AppColors.mainColor,colorText: Colors.white);

        }
    }

          cartRepo.addToCartList(getItems);
          update();
  }

  bool ExistInCart(Productmodel product)
  {
    if(_items.containsKey(product.id))
      {
        return true;
      }
    return false;
  }


  int getQuantity(Productmodel product)
  {
    var quantity=0;
    if(_items.containsKey(product.id))
      {
        _items.forEach((key, value) {
          if(key==product.id)
            {
              quantity=value.quantity!;
            }
        });
      }
    return quantity;
  }

  int get totalItems
  {
    var totalQuantity=0;
    _items.forEach((key, value) {
      totalQuantity  += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems
  {
    return _items.entries.map((e){
      return e.value;
    }).toList();
    }

    int get totalAmount
    {
      var total=0;
      _items.forEach((key, value) {
        total += value.price! * value.quantity!;
      });

      return total;
    }

    List<CartModel> getCartdata()
    {

      setCart=cartRepo.getCartList();
      return storageItems;
    }

    set setCart(List<CartModel> items)
    {
      storageItems=items;
      print("the length is ${storageItems.length}");

      for(int i = 0 ; i<storageItems.length;i++)
      {
        _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
          
      }

    }

    void addToHistory()
    {
      cartRepo.addToCartHistory();
      Clear();
    }
    void Clear()
    {
      _items={};
      update();
    }

    List<CartModel> getCartHistoryList()
    {
      return cartRepo.getCartHistory();
    }
    set setItemsCart(Map<int,CartModel> ItemsCart)
    {
      _items={};
      _items=ItemsCart;
    }


    void addItemsCartList()
    {
      cartRepo.addToCartList(getItems);
      update();
    }

    clearhistory()
    {
      cartRepo.removeCart();
      cartRepo.clearHistory();
    }
  }

