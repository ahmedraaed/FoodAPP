import 'package:flutter/material.dart';
import 'package:foodapp/controllers/cart_product_controller.dart';
import 'package:foodapp/routes/routes.dart';
import 'package:foodapp/utiles/app_constant.dart';
import 'package:foodapp/utiles/dimansions.dart';
import 'package:foodapp/widgets/app-icons.dart';
import 'package:foodapp/widgets/app_column.dart';
import 'package:foodapp/widgets/expanded_text.dart';
import 'package:get/get.dart';

import '../controllers/popular_product_controller.dart';
import '../utiles/app_colors.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_small.dart';

class PopularFoodDetails extends StatelessWidget {
  int PageId;
  String page;
   PopularFoodDetails({Key? key,required this.PageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product=Get.find<PopulerProductController>().PopuerProductList[PageId];
    Get.find<PopulerProductController>().initProduct(product,Get.find<CartProductController>());
    Get.find<PopulerProductController>().getItems;



    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
              right: 0,
              child:Container(
                height: Dimensions.ImageDetailssize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstant.Base_Url+AppConstant.Upload_url+product.img),
                  ),
                ),

              )
          ),
          Positioned(
            top: Dimensions.height50,
            left: Dimensions.width35,
              right: Dimensions.width35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector
                    (
                      onTap: ()
                      {
                        if(page=="cartpage")
                          {
                            Get.toNamed(RoutesHelper.getCartFood());
                          }
                        else
                            {
                              Get.toNamed(RoutesHelper.getHomeFood());
                            }
                    },
                      child: AppIcons(
                          icon: Icons.arrow_back_ios_new,
                          sizeicon: Dimensions.iconSize15,
                          sizebackground: Dimensions.height35)
                  ),
                  GetBuilder<PopulerProductController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: (){
                          if(controller.totalItems >= 1)
                          {
                            Get.toNamed(RoutesHelper.getCartFood());
                          }
                        },
                        child: Stack(
                          children: [
                            AppIcons(icon: Icons.add_shopping_cart, sizeicon:Dimensions.iconSize15, sizebackground: Dimensions.height35),
                            controller.totalItems >= 1?
                            Positioned(
                              right: 0, top: 0,
                              child: AppIcons(
                              icon: Icons.circle,
                              sizeicon: 17,
                              sizebackground: 17,
                              backgroundColor: Colors.blueAccent,
                              iconColor: Colors.blueAccent,
                              ),
                            )
                                :
                                Container(),


                            Get.find<PopulerProductController>().totalItems >= 1?
                            Positioned(
                              right: 2,top:-3,
                              child:CustomText(text:Get.find<PopulerProductController>().totalItems.toString(),textColor: Colors.white,sizetext: 13, ),
                            )
                                :
                                Container(),

                          ]
                        ),
                      );
                    },

                  ),
                ],
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.ImageDetailssize-20,
            child: Container(
              padding: EdgeInsets.all(Dimensions.height30 ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name),
                  SizedBox(height: Dimensions.height20,),
                  CustomText(text: "introduce"),
                  SizedBox(height: Dimensions.height20,),
                  Expanded(child: SingleChildScrollView(child: ExpandedText(text: product.description),))

                ],
              ),

          ),),
        ],
      ),
      bottomNavigationBar:  GetBuilder<PopulerProductController>(builder: (popularProduct) => Container(
        height: Dimensions.bottomcontainer,
        padding: EdgeInsets.only(bottom: Dimensions.height20,top: Dimensions.height20,right: Dimensions.width15,left: Dimensions.width15,),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.radius20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: Dimensions.height15,top: Dimensions.height15,right: Dimensions.width15,left: Dimensions.width15,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
              child: Row(

                children: [
                  GestureDetector(onTap: (){
                    popularProduct.setQuantity(false);
                  },child: Icon(Icons.remove)),
                  SizedBox(width: Dimensions.width10,),
                  CustomTextSmall(text: popularProduct.incrementItems.toString(),Size: Dimensions.font20,textColor: Colors.black),
                  SizedBox(width: Dimensions.width10,),
                  GestureDetector(
                    onTap: (){
                      popularProduct.setQuantity(true);
                    },
                      child: Icon(Icons.add)),
                ],

              ),
            ),
        GestureDetector(onTap: (){
          popularProduct.AddItems(product);
        },
          child: Container(
              padding: EdgeInsets.only(bottom: Dimensions.height15,top: Dimensions.height15,right: Dimensions.width15,left: Dimensions.width15,),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
              child: CustomText(text: "\$ ${product.price} | Add to cart",sizetext: Dimensions.font15),
            ),),
          ],
        ),
      ),),

    );
  }
}
