import 'package:flutter/material.dart';
import 'package:foodapp/base/empty_container_image.dart';
import 'package:foodapp/controllers/cart_product_controller.dart';
import 'package:foodapp/controllers/location_controller.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/controllers/recommended_product_controller.dart';
import 'package:foodapp/routes/routes.dart';
import 'package:foodapp/utiles/app_colors.dart';
import 'package:foodapp/utiles/app_constant.dart';
import 'package:foodapp/utiles/dimansions.dart';
import 'package:foodapp/widgets/app-icons.dart';
import 'package:foodapp/widgets/custom_text.dart';
import 'package:foodapp/widgets/custom_text_small.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/user_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Stack(
        children: [
          Positioned(
            top: Dimensions.height20*3,
          right: Dimensions.width20,
          left: Dimensions.width20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIcons(
                  icon: Icons.arrow_back_ios_new,
                  sizeicon: Dimensions.iconSize15,
                  sizebackground: Dimensions.iconSize30,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              ),
              SizedBox(
                width: Dimensions.width20*3,
              ),
              GestureDetector(
                onTap: (){
                  Get.toNamed(RoutesHelper.getHomeFood());
                },
                child: AppIcons(
                    icon: Icons.home_outlined,
                    sizeicon: Dimensions.iconSize15,
                    sizebackground: Dimensions.iconSize30,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                ),
              ),
              AppIcons(
                  icon: Icons.shopping_cart_outlined,
                  sizeicon: Dimensions.iconSize15,
                  sizebackground: Dimensions.iconSize30,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              ),
            ],
          )
          ),
          Positioned(
            top: Dimensions.height20*5,
            right: Dimensions.height20,
            left: Dimensions.height20,
            bottom: 0,
            child: GetBuilder<CartProductController>(
              builder: (controller) =>controller.getItems.length>0?Container(
                  child:
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartProductController>(builder: (cartProduct) {
                      var _cartList=cartProduct.getItems;
                      return ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder:(context, index) {

                          return Container(
                            margin: EdgeInsets.only(bottom: Dimensions.height20),
                            height: Dimensions.height20*5,
                            width: double.infinity,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    var popularIndex=Get.find<PopulerProductController>().PopuerProductList.indexOf(_cartList[index].product!);
                                    if(popularIndex>=0)
                                    {
                                      Get.toNamed(RoutesHelper.getPopluarFood(popularIndex,"cartpage"));
                                    }
                                    else
                                    {
                                      var recommendedIndex=Get.find<RecommendedProductController>().recommendedProductList.indexOf(_cartList[index].product);
                                      if(recommendedIndex<0)
                                      {
                                        Get.snackbar("Product History", "the description of history product is't Allow  ",backgroundColor: AppColors.mainColor,colorText: Colors.white);

                                      }else
                                      {
                                        Get.toNamed(RoutesHelper.getRecommendedFood(recommendedIndex,'cartpage'));

                                      }
                                    }
                                  },
                                  child: Container(
                                    height: Dimensions.height20*5,
                                    width: Dimensions.height20*5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                      image: DecorationImage(image: NetworkImage(AppConstant.Base_Url+AppConstant.Upload_url+cartProduct.getItems[index].img!),fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.width5,),
                                Expanded(child:Container(
                                  height: Dimensions.height20*5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(text: cartProduct.getItems[index].name!),
                                      SizedBox(height: Dimensions.height4,),
                                      CustomTextSmall(text: "scrom",textColor: AppColors.mainColor),
                                      SizedBox(height: Dimensions.height4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(text: "\$ ${cartProduct.getItems[index].price}"),
                                          Container(
                                            // padding: EdgeInsets.only(bottom: Dimensions.height15,top: Dimensions.height15,right: Dimensions.width15,left: Dimensions.width15,),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                                            ),
                                            child: Row(

                                              children: [
                                                GestureDetector(onTap: (){
                                                  cartProduct.addItems(_cartList[index].product!, -1);
                                                },child: Icon(Icons.remove)),
                                                SizedBox(width: Dimensions.width10,),
                                                //popularProduct.incrementItems.toString()
                                                CustomTextSmall(text: _cartList[index].quantity.toString(),Size: Dimensions.font20,textColor: Colors.black),
                                                SizedBox(width: Dimensions.width10,),
                                                GestureDetector(
                                                    onTap: (){
                                                      cartProduct.addItems(_cartList[index].product!, 1);
                                                    },
                                                    child: Icon(Icons.add)),
                                              ],

                                            ),
                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                ) ),

                              ],
                            ),
                          );
                        },
                      );
                    },),
                  )
              )
             :
              EmptyScreen(text: "cart is Empty"),
          )
          ),
        ],
      ),
      bottomNavigationBar:  GetBuilder<CartProductController>(builder: (cartcontroller) =>
          Container(
        height: Dimensions.bottomcontainer,
        padding: EdgeInsets.only(bottom: Dimensions.height20,top: Dimensions.height20,right: Dimensions.width15,left: Dimensions.width15,),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.radius20),
        ),
        child:cartcontroller.getItems.length>0?
        Row(
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

                  SizedBox(width: Dimensions.width10,),
                  CustomTextSmall(text: "\$ "+cartcontroller.totalAmount.toString(),Size: Dimensions.font20,textColor: Colors.black),
                  SizedBox(width: Dimensions.width10,),

                ],

              ),
            ),
            GestureDetector(onTap: (){
              //print("you taped heerr");
              if(Get.find<AuthController>().checkToken())
                {
                  cartcontroller.addToHistory();
                 Get.find<UserController>().getDataInfo();
                  if(Get.find<LocationController>().addressList.isEmpty)
                    {
                      if(Get.find<UserController>().isloading)
                        {
                          Get.offNamed(RoutesHelper.getAddAddress());
                        }else
                          {
                            Center(child: CircularProgressIndicator());
                          }
                    }else
                      {
                        cartcontroller.addToHistory();
                        Get.offNamed(RoutesHelper.getHomeFood());
                      }
                }else
                  {
                    Get.toNamed(RoutesHelper.getSignIn());
                  }

            },
              child: Container(
                padding: EdgeInsets.only(bottom: Dimensions.height15,top: Dimensions.height15,right: Dimensions.width15,left: Dimensions.width15,),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                child: CustomText(text: "CheckOut",sizetext: Dimensions.font15),
              ),),
          ],
        ):Container(),
      ),),

    );
  }
}
