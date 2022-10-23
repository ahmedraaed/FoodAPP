
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/base/show_custom_snakbar.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/models/sgin_up_model.dart';
import 'package:foodapp/utiles/app_colors.dart';
import 'package:foodapp/utiles/app_constant.dart';
import 'package:foodapp/utiles/dimansions.dart';
import 'package:foodapp/widgets/email_field_widget.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({Key? key}) : super(key: key);

  TextEditingController emailControl=TextEditingController();
  TextEditingController passwordControl=TextEditingController();
  TextEditingController phoneControl=TextEditingController();
  TextEditingController nameControl=TextEditingController();

  List<String> otherSign=[
    "assats/image/g.png",
    "assats/image/f.png",
    "assats/image/t.png",
  ];

   void regestarition(AuthController authController)
   {
     String email=emailControl.text.trim();
     String name=nameControl.text.trim();
     String phone=phoneControl.text.trim();
     String password=passwordControl.text.trim();

     var authControllrt = Get.find<AuthController>();
     if(email.isEmpty)
       {
         ShowSnakBar("Email must Not Empty",title: "Email");

       }else if(!GetUtils.isEmail(email))
         {
           ShowSnakBar("Email is't valid",title: "Email validate");

         }else if(name.isEmpty)
           {
             ShowSnakBar("Name must Not Empty",title: "Name");

           }else if(phone.isEmpty)
             {
               ShowSnakBar("Phone must Not Empty",title: "Phone");

             }else if(password.isEmpty)
               {
                 ShowSnakBar("Password must Not Empty",title: "password");

               }else if(password.length<6)
                 {
                   ShowSnakBar("Password is\'t valid",title: "Password validate");

                 }else
                   {
                     SignUpBody signUpBody=SignUpBody(name: name,
                         phone: phone,
                         email: email,
                         password: password);
                     authControllrt.Regestration(signUpBody).then((value){
                       if(value.isSuccsessed)
                         {
                           print("the data will upload ");
                           print(AppConstant.Token);
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
        body:GetBuilder<AuthController>(
          builder: (authcontroller) =>!authcontroller.isload? SingleChildScrollView(
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
              TextFromField(textControll:emailControl , text: "Email", icon: Icons.email),

              SizedBox(height: Dimensions.height20),
              TextFromField(textControll:passwordControl , text: "password", icon: Icons.password,isObscure: true),

              SizedBox(height: Dimensions.height20),
              TextFromField(textControll:nameControl , text: "name", icon: Icons.person),

              SizedBox(height: Dimensions.height20),
              TextFromField(textControll:phoneControl , text: "phone", icon: Icons.phone_android),

              SizedBox(height: Dimensions.height20,),
              GestureDetector(
                onTap: (){
                  regestarition(authcontroller);
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
                          "Sign UP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.font20*2))),
                ),
              ),

              SizedBox(height: Dimensions.height20,),
              RichText(text: TextSpan(
                text: "Have an account already ?",
                style: TextStyle(color: AppColors.mainColor,fontSize: Dimensions.font10*2.8),
                recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
              ),),

              SizedBox(height: Dimensions.height15,),
              RichText(text: TextSpan(
                text: "Sign up using one of the following methods",
                style: TextStyle(color: AppColors.mainColor,),
              )),


              SizedBox(height: Dimensions.height10,),
              Wrap(
                children: List.generate(otherSign.length, (index) =>
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: Dimensions.radius30,
                        backgroundImage: AssetImage(otherSign[index]),
                      ),
                    ),),
              ),
            ],
          ),
        ) :
          Center(child: CircularProgressIndicator(color: AppColors.mainColor,),),
      )

    );
  }
}
