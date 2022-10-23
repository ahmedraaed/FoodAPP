import 'package:flutter/material.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/controllers/recommended_product_controller.dart';
import 'package:foodapp/models/products_model.dart';
import 'package:foodapp/routes/routes.dart';
import 'package:foodapp/utiles/app_colors.dart';
import 'package:foodapp/utiles/app_constant.dart';
import 'package:foodapp/widgets/custom_text.dart';
import 'package:foodapp/widgets/custom_text_small.dart';
import 'package:foodapp/widgets/icon_text.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utiles/dimansions.dart';
import '../../widgets/app_column.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);

  var _currentPage = 0.0;
  double _scalefactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page!;
       // print(Dimensions.widthScreen);
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopulerProductController>(
          builder: (popularproducts) =>  popularproducts.loading ? Container(
            // color: Colors.deepOrangeAccent,
            height: Dimensions.pageView,
            child: PageView.builder(
              controller: pageController,
              itemCount: popularproducts.PopuerProductList.length,
              itemBuilder: (context, index) {
                return _buildpageItem(index,popularproducts.PopuerProductList[index]);
              },
            ),
          ):CircularProgressIndicator(color: AppColors.mainColor,),
        ),
       GetBuilder<PopulerProductController>(builder: (popularproducts) =>  SmoothPageIndicator(
         controller: pageController, // PageController
         count: popularproducts.PopuerProductList.isEmpty?1:popularproducts.PopuerProductList.length,
         effect: WormEffect(
           activeDotColor: AppColors.mainColor,
           dotHeight: 16,
           dotWidth: 16,

         ),
       ),),

        Container(
          margin: EdgeInsets.only(top: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20,),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(text: "Recommended"),
              SizedBox(width: Dimensions.width10,),
              Container(margin:EdgeInsets.only(bottom: Dimensions.height4),child: CustomTextSmall(text: "."),),
              SizedBox(width: Dimensions.width10,),
              Container(margin:EdgeInsets.only(bottom: Dimensions.height4),child: CustomTextSmall(text: "Food pairing"),),

            ],
          ),
        ),

       GetBuilder<RecommendedProductController>(builder: (recommended) => recommended.loading? ListView.builder(
         physics: NeverScrollableScrollPhysics(),
         shrinkWrap: true,
         itemCount: recommended.recommendedProductList.length,
         itemBuilder: (context, index) =>
             GestureDetector(
               onTap: ()
               {
                 Get.toNamed(RoutesHelper.getRecommendedFood(index,'home'));
               },
               child: Container(
                 margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,bottom: Dimensions.height15),
                 child:Row(
                   children: [
                     Container(
                       width: Dimensions.listViewIamgesize,
                       height: Dimensions.listViewIamgesize,
                       decoration: BoxDecoration(
                           color: Colors.white54,
                           borderRadius: BorderRadius.circular(Dimensions.radius20),
                           image: DecorationImage(
                             fit: BoxFit.cover,
                             image:NetworkImage(AppConstant.Base_Url+AppConstant.Upload_url+recommended.recommendedProductList[index].img),
                           )

                       ),
                     ),
                     Expanded(
                       child: Container(
                         height: Dimensions.listViewTextsize,

                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.only(
                             topRight:Radius.circular(Dimensions.width10) ,
                             bottomRight: Radius.circular(Dimensions.width10) ,
                           ),
                           color: Colors.white,
                         ),
                         child: Padding(
                           padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               CustomText(text:recommended.recommendedProductList[index].name,),
                               SizedBox(height: Dimensions.height10,),
                               CustomTextSmall(text: "here you will eat",Size: Dimensions.font10,),
                               SizedBox(height: Dimensions.height10,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   IconAndText(
                                       icon: Icons.circle,
                                       IconColor: AppColors.iconColor1,
                                       text: "Normal"),

                                   IconAndText(
                                       icon: Icons.location_on,
                                       IconColor: AppColors.mainColor,
                                       text: "1.5km"),

                                   IconAndText(
                                       icon: Icons.access_time_rounded,
                                       IconColor: AppColors.iconColor2,
                                       text: "2.30min"),
                                 ],
                               ),


                             ],
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ),):CircularProgressIndicator(color: AppColors.mainColor,),),
      ],
    );
  }

  Widget _buildpageItem(int index,Productmodel popuerProductList) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPage.floor()) {
      var scale = 1 - (_currentPage - index) * (1 - _scalefactor);
      var currentTransf = _height * (1 - scale) / 2;
      matrix = Matrix4.diagonal3Values(1, scale, 1)
        ..setTranslationRaw(0, currentTransf, 0);
    } else if (index == _currentPage.floor() + 1) {
      var scale =
          _scalefactor + (_currentPage - index + 1) * (1 - _scalefactor);
      var currentTransf = _height * (1 - scale) / 2;
      matrix = Matrix4.diagonal3Values(1, scale, 1)
        ..setTranslationRaw(0, currentTransf, 0);
    } else if (index == _currentPage.floor() - 1) {
      var scale = 1 - (_currentPage - index) * (1 - _scalefactor);
      var currentTransf = _height * (1 - scale) / 2;
      matrix = Matrix4.diagonal3Values(1, scale, 1)
        ..setTranslationRaw(0, currentTransf, 0);
    } else {
      var scale = 0.8;
      matrix = Matrix4.diagonal3Values(1, scale, 1)
        ..setTranslationRaw(0, _height * (1 - _scalefactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: ()
            {
                Get.toNamed(RoutesHelper.getPopluarFood(index,"home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven
                    ? const Color(0xFFcc5135)
                    : const Color(0x0FFc1057),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstant.Base_Url+"/uploads/"+popuerProductList.img!,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width35, right: Dimensions.width35, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                ],
              ),
              child: Container(
                padding:
                    EdgeInsets.only(top: Dimensions.height15, left: Dimensions.width15, right: Dimensions.width15, bottom: Dimensions.height15),
                child: AppColumn(text: popuerProductList.name!)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
