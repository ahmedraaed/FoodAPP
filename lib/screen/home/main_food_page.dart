import 'package:flutter/material.dart';
import 'package:foodapp/utiles/app_colors.dart';
import 'package:foodapp/utiles/dimansions.dart';
import 'package:foodapp/widgets/custom_text.dart';
import 'package:foodapp/widgets/custom_text_small.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _State();
}

class _State extends State<MainFoodPage> {
  Future<void> _loadResource()async{
    await Get.find<PopulerProductController>().getPoplerProductListcontrollrt();
    await Get.find<RecommendedProductController>().getRecommendedProductListcontrollrt();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: Column(children: [
      Container(
        child: Container(
          margin: EdgeInsets.only(
            top: Dimensions.height50,
            bottom: Dimensions.height30,
          ),
          padding: EdgeInsets.only(
            left: Dimensions.width15,
            right: Dimensions.width15,
          ),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(children: [
              CustomText(text: "Egypt", textColor: AppColors.mainColor),
              Row(children: [
                CustomTextSmall(
                  text: "Banha",
                  textColor: Colors.black45,
                ),
                Icon(Icons.arrow_drop_down_outlined,size: Dimensions.iconSize30,),
              ]),
            ]),
            Container(
              width: Dimensions.height45,
              height: Dimensions.height45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                color: AppColors.mainColor,
              ),
              child: Icon(Icons.search, color: Colors.white,size: Dimensions.iconSize30,),
            ),
          ]),
        ),
      ),
      Expanded(child: SingleChildScrollView(child: FoodPageBody())),

    ]),
      onRefresh:_loadResource,
      color: AppColors.mainColor, );
  }
}
