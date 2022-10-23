import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/controllers/cart_product_controller.dart';
import 'package:foodapp/controllers/location_controller.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/controllers/recommended_product_controller.dart';
import 'package:foodapp/controllers/user_controller.dart';
import 'package:foodapp/data/api/api_client.dart';
import 'package:foodapp/data/reposetry/auth_repo.dart';
import 'package:foodapp/data/reposetry/cart_product_repo.dart';
import 'package:foodapp/data/reposetry/location_repo.dart';
import 'package:foodapp/data/reposetry/popular_product_repo.dart';
import 'package:foodapp/data/reposetry/recommended_product_repo.dart';
import 'package:foodapp/data/reposetry/user_repo.dart';
import 'package:foodapp/utiles/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init()async
{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(()=>sharedPreferences);
  Get.lazyPut(() => ApiClient(appBasseutl: AppConstant.Base_Url,sharedPreferences: Get.find()));


  Get.lazyPut(() => AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find()),);
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => PopularProductRpo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRpo(apiClient: Get.find()));
  Get.lazyPut(() => CartProductRepo(sharedPreferences:Get.find()));
  Get.lazyPut(() => LocationRepo(sharedPreferences:Get.find(), apiClient: Get.find()));


  Get.lazyPut(() => AuthController(authRepo: Get.find()),);
  Get.lazyPut(() => UserController(userRepo: Get.find()),);
  Get.lazyPut(() => PopulerProductController(popularProductRpo:  Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRpo:  Get.find()));
  Get.lazyPut(() => CartProductController(cartRepo:  Get.find()));
  Get.lazyPut(() => LocationController(locationRepo:  Get.find()));

}