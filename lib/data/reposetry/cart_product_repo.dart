import 'dart:convert';

import 'package:foodapp/models/cart_model.dart';
import 'package:foodapp/utiles/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';



class CartProductRepo
{
    SharedPreferences sharedPreferences;
    CartProductRepo({required this.sharedPreferences});


    List<String> cart=[];
    List<String> Historycart=[];


    void addToCartList(List<CartModel> cartList)
    {
       sharedPreferences.remove(AppConstant.List_cart_share);
       sharedPreferences.remove(AppConstant.List_history_cart_share);
      var time=DateTime.now();
      cart=[];
      cartList.forEach((element) {
        element.time=time.toString();
        return cart.add(jsonEncode(element));
      });
      sharedPreferences.setStringList(AppConstant.List_cart_share,cart );
      // getCartList();

    }
    List<CartModel> getCartList()
    {
      List<String> carts=[];
      if(sharedPreferences.containsKey(AppConstant.List_cart_share))
        {
          carts=sharedPreferences.getStringList(AppConstant.List_cart_share)!;
          // print(carts.toString());

        }
      List<CartModel> cartList=[];

      // carts.forEach((element) {
      //   return cartList.add(CartModel.fromJson(jsonDecode(element)));
      // });
      carts.forEach((element) =>cartList.add(CartModel.fromJson(jsonDecode(element))));

      return cartList;
    }

    List<CartModel> getCartHistory()
    {
      List<CartModel> historyCartNew=[];
      if(sharedPreferences.containsKey(AppConstant.List_history_cart_share))
        {
          Historycart=[];
          Historycart=sharedPreferences.getStringList(AppConstant.List_history_cart_share)!;
        }
      Historycart.forEach((element) {
        return historyCartNew.add(CartModel.fromJson(jsonDecode(element)));

      });
      return historyCartNew;
    }

    void addToCartHistory()
    {
      if(sharedPreferences.containsKey(AppConstant.List_history_cart_share))
        {
          Historycart=sharedPreferences.getStringList(AppConstant.List_history_cart_share)!;
        }
      for (int i=0;i<cart.length;i++)
        {
          print(cart[i]);
          Historycart.add(cart[i]);
        }

      print(Historycart.length.toString());
      removeCart();
      sharedPreferences.setStringList(AppConstant.List_history_cart_share, Historycart);
    }

    void removeCart()
    {
      cart=[];
      sharedPreferences.remove(AppConstant.List_cart_share);
      // print("the time of this order is 1 :  " + getCartHistory()[0].time.toString());
      // print("the time of this order is  2:  " + getCartHistory()[1].time.toString());

      // for(int j=0;j<getCartHistory().length;j++)
      //   {
      //     print(getCartHistory().length.toString());
      //     print("the time of this order is  :  " + getCartHistory()[j].time.toString());
      //   }
    }

    bool clearHistory()
    {
      cart=[];
      Historycart=[];
      sharedPreferences.remove(AppConstant.List_history_cart_share);
      return true;
    }

}