import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapp/base/empty_container_image.dart';
import 'package:foodapp/controllers/cart_product_controller.dart';
import 'package:foodapp/utiles/app_colors.dart';
import 'package:foodapp/utiles/dimansions.dart';
import 'package:foodapp/widgets/app-icons.dart';
import 'package:foodapp/widgets/custom_text.dart';
import 'package:foodapp/widgets/custom_text_small.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/cart_model.dart';
import '../../routes/routes.dart';
import '../../utiles/app_constant.dart';

class CartHistoryScreen extends StatelessWidget {
  const CartHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var getCartHistoryList=Get.find<CartProductController>().getCartHistoryList().reversed.toList();

    Map<String,int> cartItemsPerorder = Map();

    for(int i=0;i<getCartHistoryList.length;i++)
    {

      if(cartItemsPerorder.containsKey(getCartHistoryList[i].time))
      {
        cartItemsPerorder.update(getCartHistoryList[i].time!,(value)=>++value);
      }else
      {
        cartItemsPerorder.putIfAbsent(getCartHistoryList[i].time!,()=>1);
      }

    }
    //Time as value
    List<int> cartItemsPerOrder()
    {
      return cartItemsPerorder.entries.map((e)=>e.value).toList();
    }
    //Time as key
    List<String> cartTimesPerOrder()
    {
      return cartItemsPerorder.entries.map((e)=>e.key).toList();
    }
    //get value (order)
    List<int> itemsPerOrder=cartItemsPerOrder();

    //get key (time)
    List<String> TimePerOrder=cartTimesPerOrder();
    var ListCounter=0;

    Widget timeWidget(int index)
    {
      var outStringFormate=DateTime.now().toString();
      if(index<getCartHistoryList.length)
        {
          DateTime pares=DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[ListCounter].time!);
          var inputdate=DateTime.parse(pares.toString());
          var outDataFormate=DateFormat("MM/dd/yyyy  hh:mm a");
          outStringFormate=outDataFormate.format(inputdate);
        }

      return CustomText(text: outStringFormate);
    }
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: AppColors.mainColor,
              padding: EdgeInsets.only(
                  left: Dimensions.width35*5,
                  right: Dimensions.width15,
                  top: Dimensions.height10,
              bottom: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "History Cart",textColor: Colors.white,sizetext: Dimensions.iconSize20),
                  AppIcons(icon: Icons.shopping_cart_outlined,
                      sizeicon: Dimensions.iconSize30*1.1,
                      sizebackground: Dimensions.iconSize30*1.5),
                ],
              ),
            ),
            GetBuilder<CartProductController>(builder: (controller) {
              return controller.getCartHistoryList().length>0?
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: Dimensions.width15,right: Dimensions.width15,top: Dimensions.height20,),
                  child:ListView(
                    children: [

                      for(int i=0;i<cartItemsPerorder.length;i++)

                        Container(
                          height:Dimensions.height10*13,
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWidget(ListCounter),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                      direction: Axis.horizontal,
                                      children:List.generate(itemsPerOrder[i], (index) {
                                        if(ListCounter<getCartHistoryList.length)
                                        {
                                          ListCounter++;
                                        }
                                        return  index<=2?Container(
                                          margin: EdgeInsets.only(top: Dimensions.height4,right: Dimensions.width10),
                                          width: Dimensions.width35*2.4,
                                          height: Dimensions.height35*2.4,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:NetworkImage(AppConstant.Base_Url+AppConstant.Upload_url+getCartHistoryList[ListCounter-1].img!,),

                                              )
                                          ),
                                        ):Container();
                                      })


                                  ),
                                  Container(
                                    height: Dimensions.height10*10,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        CustomTextSmall(text: "Total",textColor: Colors.black,fontWeighttext: FontWeight.normal),
                                        Row(
                                          children:[
                                            CustomText(text: "${itemsPerOrder[i]} " ,sizetext: 20,fontWeighttext: FontWeight.bold,),
                                            CustomTextSmall(text: " Items",fontWeighttext: FontWeight.bold,textColor: Colors.black54),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            var timeCheck=TimePerOrder;
                                            Map<int,CartModel> OneMore={};
                                            for(int x=0;x<getCartHistoryList.length;x++)
                                            {
                                              if(timeCheck[i]==getCartHistoryList[x].time)
                                              {
                                                // print(getCartHistoryList[x].name);
                                                // print(jsonDecode(jsonEncode(getCartHistoryList[x])));
                                                // print("______________________________________");
                                                // print(jsonEncode(getCartHistoryList[x]));
                                                // print("______________________________________");
                                                // print(getCartHistoryList[x]);
                                                OneMore.putIfAbsent(getCartHistoryList[x].id!, () =>
                                                    CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[x])))
                                                  //getCartHistoryList[x]
                                                );

                                              }

                                            }

                                            Get.find<CartProductController>().setItemsCart=OneMore;
                                            Get.find<CartProductController>().addItemsCartList();
                                            Get.toNamed(RoutesHelper.getCartFood());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: Dimensions.height4,horizontal: Dimensions.width10),
                                            decoration:BoxDecoration(
                                                border: Border.all(width: 1,color:AppColors.mainColor )
                                            ),
                                            child: CustomTextSmall(text: "One More",Size: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ) ,
                ),
              )
                  :
              Container(
                  child: EmptyScreen(text: "cartHistory is Empty",pathImae: "assats/image/empty_box.png",));
            },)
          ],
        ),
      ),
    );
  }
}