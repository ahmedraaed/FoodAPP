import 'package:flutter/material.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/controllers/cart_product_controller.dart';
import 'package:foodapp/controllers/location_controller.dart';
import 'package:foodapp/controllers/user_controller.dart';
import 'package:foodapp/routes/routes.dart';
import 'package:foodapp/utiles/app_colors.dart';
import 'package:foodapp/utiles/dimansions.dart';
import 'package:foodapp/widgets/account_widget.dart';
import 'package:foodapp/widgets/app-icons.dart';
import 'package:foodapp/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isLogginig=Get.find<AuthController>().checkToken();

    if(_isLogginig)
      {
        Get.find<AuthController>().login("010007557028", "123456789");
        print("your are login innininninini");
        Get.find<UserController>().getDataInfo();
        // print("user model"+Get.find<UserController>().usermodel.name);
        // print("user model"+Get.find<UserController>().usermodel.toString());

      }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title:Title(
          child: Center(
              child: CustomText(
                text: "Profile",
                sizetext: Dimensions.height30,
                textColor: Colors.white,
              ),
          ),
          color: AppColors.mainColor,

        ),
      ),
      body:GetBuilder<UserController>(builder: (controller) {
        return _isLogginig?
        (controller.isloading?
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20,),
          child: Column(
            children: [
              AppIcons(
                  icon: Icons.person,
                  sizeicon:Dimensions.height30*2.5,
                  sizebackground: Dimensions.height30*5,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor),
              SizedBox(height: Dimensions.height30,),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: Dimensions.height30),
                  child: Column(
                    children: [
                      AccountWidget(appIcons:  AppIcons(icon:Icons.person,
                          sizeicon:Dimensions.height30,
                          sizebackground: Dimensions.height30*2,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor
                      ),
                          customText: CustomText(text: controller.usermodel.name,)),

                      SizedBox(height: Dimensions.height20,),
                      AccountWidget(appIcons:  AppIcons(icon:Icons.phone_android,
                          sizeicon:Dimensions.height30,
                          sizebackground: Dimensions.height30*2,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.yellowColor
                      ),
                          customText: CustomText(text: controller.usermodel.phone,)),

                      SizedBox(height: Dimensions.height20,),
                      AccountWidget(appIcons:  AppIcons(icon:Icons.email,
                          sizeicon:Dimensions.height30,
                          sizebackground: Dimensions.height30*2,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.yellowColor
                      ),
                          customText: CustomText(text: controller.usermodel.email,)),

                      SizedBox(height: Dimensions.height20,),
                      GetBuilder<LocationController>(builder: (locationController) {

                        return GestureDetector(
                          onTap: (){
                            Get.toNamed(RoutesHelper.getAddAddress());
                          },
                          child: AccountWidget(appIcons:  AppIcons(icon:Icons.location_on,
                              sizeicon:Dimensions.height30,
                              sizebackground: Dimensions.height30*2,
                              iconColor: Colors.white,
                              backgroundColor: AppColors.yellowColor
                          ),
                              customText: CustomText(text: locationController.placemark==null?"Address":"your address",)),
                        );
                      },),

                      SizedBox(height: Dimensions.height20,),
                      AccountWidget(appIcons:  AppIcons(icon:Icons.message,
                          sizeicon:Dimensions.height30,
                          sizebackground: Dimensions.height30*2,
                          iconColor: Colors.white,
                          backgroundColor: Colors.red
                      ),
                          customText: CustomText(text: "message",)),
                      SizedBox(height: Dimensions.height20,),
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().checkToken())
                          {
                            Get.find<AuthController>().clear();
                            Get.find<CartProductController>().Clear();
                            Get.find<CartProductController>().clearhistory();
                            Get.find<LocationController>().cleardata();
                            Get.offNamed(RoutesHelper.getSignIn());
                          }
                        },
                        child: AccountWidget(appIcons:  AppIcons(icon:Icons.logout,
                            sizeicon:Dimensions.height30,
                            sizebackground: Dimensions.height30*2,
                            iconColor: Colors.white,
                            backgroundColor: Colors.red
                        ),
                            customText: CustomText(text: "Log out",)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
            :Center(
          child: CircularProgressIndicator(color: AppColors.mainColor,),))
            :Container(
          child: Center(
            child: Column(
                children:[
                  Image.asset("assats/image/signintocontinue.png"),
                SizedBox(height: Dimensions.height15,),
                Container(
                  width: Dimensions.width20*5,
                  height: Dimensions.height70,
                  decoration: BoxDecoration(
                  color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                  child: CustomText(text: "Sign Up / Sign In"),
                ),
                ]
            ),),);
      },),
    );
  }
}
