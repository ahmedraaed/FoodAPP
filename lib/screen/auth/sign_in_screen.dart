
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screen/auth/sign_up_screen.dart';
import 'package:foodapp/utiles/app_colors.dart';
import 'package:foodapp/utiles/dimansions.dart';
import 'package:foodapp/widgets/email_field_widget.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snakbar.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/routes.dart';
import '../../utiles/app_constant.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  TextEditingController emailControl=TextEditingController();
  TextEditingController passwordControl=TextEditingController();

  void Login(AuthController authController)
  {
    String phone=emailControl.text.trim();
    String password=passwordControl.text.trim();

    var authControllrt = Get.find<AuthController>();
    if(phone.isEmpty)
    {
      ShowSnakBar("Email must Not Empty",title: "phone");

    }
    else if(password.isEmpty)
    {
      ShowSnakBar("Password must Not Empty",title: "password");

    }else if(password.length<6)
    {
      ShowSnakBar("Password is\'t valid",title: "Password validate");

    }else
    {

      authControllrt.login(phone,password).then((value){
        if(value.isSuccsessed)
        {
          print("the data will upload ");
          print(AppConstant.Token);
          Get.toNamed(RoutesHelper.getHomeFood());
        }else
        {
          ShowSnakBar(value.message);
          print(value.message);
        }
      });
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authcontroller) =>
      !authcontroller.isload?
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: Dimensions.height45),
              child: Center(
                child: CircleAvatar(radius: Dimensions.height30*3,
                  backgroundImage:AssetImage("assats/image/logo part 1.png"),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height20,),

            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(left: Dimensions.width20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello",style: TextStyle(fontSize: Dimensions.font20*4,fontWeight: FontWeight.bold),),
                  Text("Sign into your account",style: TextStyle(fontSize: Dimensions.font20,color: AppColors.mainColor),),
                ],
              ),
            ),

            SizedBox(height: Dimensions.height20,),
            TextFromField(textControll:emailControl , text: "phone", icon: Icons.email),

            SizedBox(height: Dimensions.height20),
            TextFromField(textControll:passwordControl , text: "password", icon: Icons.password,isObscure: true),

            SizedBox(height: Dimensions.height35 ,),
            GestureDetector(
              onTap: (){
                Login(authcontroller);
              },
              child: Container(
                width: Dimensions.widthScreen/2,
                height: Dimensions.height70,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                ),
                child: Center(
                    child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.font20*2))),
              ),
            ),

            SizedBox(height: Dimensions.height35,),
            RichText(text: TextSpan(
              text: "Don't an Account ?",
              style: TextStyle(color: AppColors.mainColor,fontSize: Dimensions.font10*2),
              children:[
                TextSpan(
                  text: "Create",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpScreen()),
                ),
              ],
            ),),

          ],
        ),
      )
          :Center(child: CircularProgressIndicator(),), )


    );
  }
}
