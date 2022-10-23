import 'package:flutter/material.dart';
import 'package:foodapp/controllers/cart_product_controller.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/controllers/recommended_product_controller.dart';
import 'package:foodapp/routes/routes.dart';
import 'package:foodapp/utiles/app_colors.dart';
import 'package:foodapp/utiles/app_constant.dart';
import 'package:foodapp/utiles/dimansions.dart';
import 'package:foodapp/widgets/app-icons.dart';
import 'package:foodapp/widgets/custom_text.dart';
import 'package:foodapp/widgets/expanded_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RecomendedFoodDetailes extends StatelessWidget {
  int pageId;
  var page;
   RecomendedFoodDetailes({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product=Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopulerProductController>().initProduct(product,Get.find<CartProductController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(

        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.height70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector
                  (
                    onTap: ()
                    {
                      if(page=="cartpage")
                        {
                          Get.toNamed(RoutesHelper.getCartFood());
                        }else
                          {
                            Get.toNamed( RoutesHelper.getHomeFood());

                          }
                      },child: AppIcons
                  (icon: Icons.clear,
                    sizeicon: Dimensions.iconSize15,
                    sizebackground: Dimensions.iconSize30)
                ),
               // AppIcons(icon: Icons.shopping_cart_outlined, sizeicon: Dimensions.iconSize15, sizebackground: Dimensions.iconSize30),
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
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height20),
              child:Container(
                padding: EdgeInsets.only(top: Dimensions.height4,bottom: Dimensions.height10),
                width: double.infinity,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.height20),
                    topLeft: Radius.circular(Dimensions.height20),
                  ),
                  color: Colors.white,

                ),
                child: Center(child: CustomText(text: product.name,)),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: Dimensions.ImageDetailssize-50,
            flexibleSpace: FlexibleSpaceBar(
               background: Image.network(AppConstant.Base_Url+AppConstant.Upload_url+product.img,width: double.infinity,fit: BoxFit.cover,),
            ),

          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(


                    child: ExpandedText(text: product.description),
                  margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),


                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar:GetBuilder<PopulerProductController>(builder: (controller) {
        return  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(left: Dimensions.width35*2.5,right: Dimensions.width35*2.5,top: Dimensions.height20,bottom: Dimensions.height20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  GestureDetector(
                onTap: (){
                  controller.setQuantity(false);
                },
                    child: AppIcons(
                        icon: Icons.remove, sizeicon: Dimensions.iconSize15, sizebackground: Dimensions.iconSize30,iconColor: Colors.white,backgroundColor: AppColors.mainColor),
                  ),
                  CustomText(text: "\$ ${product.price}"+"X"+"${controller.incrementItems.toString()}"),
                  GestureDetector(onTap: (){
                    controller.setQuantity(true);
                  },
                    child: AppIcons(
                        icon: Icons.add, sizeicon: Dimensions.iconSize15, sizebackground: Dimensions.iconSize30,iconColor: Colors.white,backgroundColor: AppColors.mainColor),
                  ),
                ],
              ),
            ),
            Container(
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
                    child:Icon(Icons.favorite,color:AppColors.mainColor),
                  ),
                  GestureDetector(onTap: (){
                    controller.AddItems(product);
                  },
                    child: Container(
                      padding: EdgeInsets.only(bottom: Dimensions.height15,top: Dimensions.height15,right: Dimensions.width15,left: Dimensions.width15,),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: CustomText(text: "\$ ${product.price}| Add to cart",sizetext: Dimensions.font15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}
