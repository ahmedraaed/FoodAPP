import 'package:flutter/material.dart';
import 'package:foodapp/controllers/cart_product_controller.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/controllers/recommended_product_controller.dart';
import 'package:foodapp/routes/routes.dart';
import 'package:foodapp/screen/auth/sign_in_screen.dart';
import 'package:foodapp/screen/auth/sign_up_screen.dart';
import 'package:foodapp/utiles/app_colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'helper/dependancies.dart' as dep;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Get.find<CartProductController>().getCartdata();
   return GetBuilder<PopulerProductController>(builder: (controller) {
      return GetBuilder<RecommendedProductController>(builder: (controller) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(

              primarySwatch: Colors.blue,
              primaryColor: AppColors.mainColor
            ),
            //home: SignInScreen(),
            // home: SplashScreen(),
             initialRoute: RoutesHelper.getSpalshScreen,
             getPages: RoutesHelper.routes,
          );
      },);
    },);

  }
}


